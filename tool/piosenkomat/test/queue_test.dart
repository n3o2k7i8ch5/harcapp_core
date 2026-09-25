import 'package:piosenkomat/classify.dart';
import 'package:test/test.dart';

/// Kolejka od najstarszego: (id wiadomości, wątek).
List<({String id, String threadId})> _queue(List<(String, String)> items) =>
    [for (final (id, thread) in items) (id: id, threadId: thread)];

void main() {
  group('takeThreads: -n liczy wątki, każdy w całości', () {
    // Barka: v1 na początku kolejki, poprawiona v2 daleko za nią.
    final queue = _queue([
      ('barka-v1', 'barka'),
      ('ognisko', 'ognisko'),
      ('stokrotka', 'stokrotka'),
      ('barka-v2', 'barka'),
    ]);

    test('wątek wchodzi z nowszą wersją, choćby leżała za granicą limitu', () {
      expect(takeThreads(queue, 1), ['barka-v1', 'barka-v2']);
    });

    test('-n 2 przy trzech wątkach → dwa pełne wątki', () {
      expect(takeThreads(queue, 2), ['barka-v1', 'ognisko', 'barka-v2']);
    });

    test('--newest: wątek stoi na miejscu najnowszej wiadomości', () {
      expect(takeThreads(queue, 1, newest: true), ['barka-v1', 'barka-v2']);
      expect(takeThreads(queue, 2, newest: true), ['barka-v1', 'stokrotka', 'barka-v2']);
    });

    test('bez -n cała kolejka', () {
      expect(takeThreads(queue, null), [for (final m in queue) m.id]);
    });
  });

  group('unlabeledQueue: odpowiedzi w otagowanych wątkach nie są zgłoszeniami', () {
    // „dzięki!” w wątku, który ma już `song/added`, siedzi w kolejce na zawsze.
    final queue = _queue([
      ('dzieki', 'stary'),
      ('barka', 'barka'),
      ('dzieki2', 'stary2'),
      ('ognisko', 'ognisko'),
    ]);
    final alive = unlabeledQueue(queue, {'stary', 'stary2'});

    test('odsiane przed pobieraniem', () {
      expect(alive.map((m) => m.id), ['barka', 'ognisko']);
    });

    test('-n liczy dopiero żywe wątki', () {
      expect(takeThreads(alive, 2), ['barka', 'ognisko'],
          reason: 'bez odsiania -n 2 wzięłoby dwa martwe wątki i zero zgłoszeń');
    });
  });
}
