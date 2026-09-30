import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:harcapp_core/comm_classes/text_utils.dart';
import 'package:path/path.dart' as p;

import '../hrcpsng.dart';
import '../mailbox.dart';
import '../plan.dart';
import '../run_dir.dart';
import '../similarity.dart';

/// Skąd komenda bierze skrzynkę. Domyślnie prawdziwy Gmail z `--credentials`
/// i `--token`; testy podstawiają własną.
typedef MailboxConnector = Future<Mailbox> Function(ArgResults args);

/// Komenda staje, bo coś nie pozwala iść dalej. Jedna droga dla każdej:
/// [message] idzie na stderr po „STOP.”, kod wyjścia 1. Szczegóły (listy
/// braków) komenda wypisuje, zanim rzuci.
class Stop implements Exception {
  const Stop(this.message);
  final String message;
}

/// Wspólne dla komend: opcje, przebieg, dry-run.
abstract class PiosenkomatCommand extends Command<int> {
  PiosenkomatCommand(this.connectMailbox, this.root);

  final MailboxConnector connectMailbox;
  /// Katalog z `out/` i `archive/`.
  final String root;

  ArgResults get args => argResults!;

  /// Ile argumentów pozycyjnych przyjmuje komenda; `null` — dowolnie wiele.
  /// Zbędny argument to błąd, nie cicha „cała kolejka”.
  int? get maxRest => 0;

  @override
  Future<int> run() async {
    final max = maxRest;
    if (max != null && args.rest.length > max) {
      usageException('Nieoczekiwany argument: ${args.rest.skip(max).join(' ')}');
    }
    return execute();
  }

  Future<int> execute();

  Future<Mailbox> connect() => connectMailbox(args);

  /// Jedyny przebieg — `out/run/`.
  RunDir get runDir => RunDir.current(root: root);

  bool get push => args['push'] as bool;
  bool get force => args['force'] as bool;

  /// Tylko komendy, które łączą się z Gmailem.
  void addGmailOptions() => argParser
    ..addOption('credentials', help: 'Domyślnie secrets/credentials.json')
    ..addOption('token', help: 'Domyślnie secrets/gmail_token.json');

  /// `--push` to jedyna flaga, która pozwala cokolwiek zmienić w Gmailu:
  /// „wypchnij to, co widzisz na sucho, do skrzynki”.
  void addPushFlag(String help) => argParser.addFlag('push', negatable: false, help: help);

  void addForceFlag(String help) => argParser.addFlag('force', negatable: false, help: help);

  /// Tylko komendy, które porównują ze śpiewnikiem.
  void addSongsDbOption() => argParser.addOption('songs-db', help: 'Ścieżka do all_songs.hrcpsng');

  /// Bez `--push` komenda kończy na liście: mówi, co zrobiłoby `--push`.
  /// `true` = to był dry-run, dalej nie idziemy.
  bool dryRun(String whatPushDoes) {
    if (push) return false;
    stdout.writeln('\nDry-run: nic nie zmieniono. --push $whatPushDoes.');
    return true;
  }

  /// `-n`: liczba dodatnia albo brak.
  int? limit() {
    final raw = args['limit'] as String?;
    if (raw == null) return null;
    final limit = int.tryParse(raw);
    if (limit == null || limit <= 0) usageException('--limit wymaga liczby dodatniej.');
    return limit;
  }

  SongBook loadSongBook() {
    final path = switch (args['songs-db'] as String?) {
      final db? => userPath(db),
      null => defaultSongsDbPath(),
    };
    final book = loadBook(path);
    stdout.writeln('Śpiewnik: $path (${plural(book.songs.length, 'tytuł', 'tytuły', 'tytułów')})');
    return book;
  }

  /// Plan przebiegu, który jest już w Gmailu — na nim pracują `review`
  /// i `finalize`. Nie ma takiego → [Stop].
  RunPlan pushedRun() {
    if (!runDir.exists) {
      throw Stop('Nie ma otwartego przebiegu (${runDir.path}). Zacznij od: ./piosenkomat scan --push');
    }
    final plan = runDir.readRunPlan();
    if (plan.pushedAt == null) throw Stop(interruptedMessage(plan));
    return plan;
  }
}

/// Przebieg otwarty gdzie indziej: `scan` przez niego staje, `status` go pokazuje.
String openElsewhereMessage(int count) => 'W Gmailu wisi otwarty przebieg, którego tu nie ma: '
    '${plural(count, 'mejl czeka', 'mejle czekają', 'mejli czeka')} na przegląd albo finalize '
    '(inny komputer albo skasowany katalog). Domknij go tam albo cofnij — mejle wrócą do '
    'kolejki: ./piosenkomat unlabel --push';

/// `scan --push` przerwany w połowie — dokończy go następny `scan --push`.
String interruptedMessage(RunPlan plan) => 'scan --push przebiegu ${plan.id} został przerwany w połowie — '
    'dokończy go ./piosenkomat scan --push';

/// Ścieżka podana przez użytkownika. Narzędzie działa w `tool/piosenkomat/`,
/// a względna liczy się od katalogu, w którym wpisał `./piosenkomat` — ten
/// przychodzi w `PIOSENKOMAT_CWD` ([cwd] w testach). Bez niego — jak jest.
/// Domyślne ścieżki (`secrets/`, szukanie `all_songs`) są względem narzędzia
/// i tędy nie idą.
String userPath(String path, {String? cwd}) {
  final base = cwd ?? Platform.environment['PIOSENKOMAT_CWD'];
  return base == null || p.isAbsolute(path) ? path : p.join(base, path);
}
