import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harcapp_core/song_book/contributor_identity.dart';
import 'package:harcapp_core/values/common_color_data.dart';
import 'package:yaml/yaml.dart';

import 'apel_ewan.dart';
import 'apel_ewan_persistent_folder.dart';

const String ogolneApelEwansVariantId = 'ogolne';
const String ogolneApelEwansName = 'Ogólne';

const String dekalogApelEwansVariantId = 'dekalog';
const String dekalogApelEwansName = 'Dekalog';

const String hal2026JrApelEwansVariantId = 'hal-2026-jr';
const String hal2026JrApelEwansName = 'Obóz 2026 (7–12 lat)';

const String hal2026SrApelEwansVariantId = 'hal-2026-sr';
const String hal2026SrApelEwansName = 'Obóz 2026 (13+ lat)';

const Map<String, String> apelEwansVariantNameMap = {
  ogolneApelEwansVariantId: ogolneApelEwansName,
  dekalogApelEwansVariantId: dekalogApelEwansName,
  hal2026JrApelEwansVariantId: hal2026JrApelEwansName,
  hal2026SrApelEwansVariantId: hal2026SrApelEwansName,
};

// Palette keys for the persistent folders. Registered with [CommonColorData]
// inside [loadAllApelEwans] and stored as the folder's `colorsKey`. Apps
// shouldn't touch these directly — read the resolved palette via
// `folder.colorsData`.
const String _omegaApelEwanColorsKey = 'omega_apel_ewan';
const String _dekalogApelEwanColorsKey = 'dekalog_apel_ewan';
const String _hal2026ApelEwanColorsKey = 'hal_2026_apel_ewan';

// Folder-membership tag stored under each camp YAML's `folders:` list.
// Distinct from the per-age variant ids (`hal-2026-jr` / `hal-2026-sr`)
// which live under `variants:`.
const String _hal2026FolderId = 'hal-2026';

const String _assetDir = 'packages/harcapp_core/assets/apel_ewan';

// Order of the 10 commandments. The set of dekalog members is discovered from
// each YAML's `folders` field; this list only fixes their display order.
const List<String> dekalogOrder = [
  'Lk_18_9-14',
  'Wj_3_13-15',
  'Wj_20_8-11',
  'Ef_6_1-4',
  'Mt_5_21-26',
  'Mt_5_27-32',
  '2_Tes_3_10-12',
  'Mt_5_33-37',
  'Rz_8_5-13',
  'Koh_5_9',
];

// Camp Sundays 2026 — chronological display order. Membership is discovered
// from each YAML's `folders` field (tagged with [_hal2026FolderId]).
const List<String> hal2026Order = [
  'Mt_10_37-42',
  'Mt_11_25-30',
  'Mt_13_1-9',
  'Mt_13_24-30',
  'Mt_13_44-52',
  'Mt_14_13-21',
  'Mt_14_22-33',
  'Mt_15_21-28',
  'Mt_16_13-20',
  'Mt_16_21-28',
];

late List<ApelEwan> allApelEwans;
late Map<String, ApelEwan> allApelEwanMap;

late ApelEwanPersistentFolder omegaFolder;
late ApelEwanPersistentFolder dekalogFolder;
late ApelEwanPersistentFolder hal2026Folder;

Future<List<String>> _discoverIds() async {
  final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  final ids = <String>[];
  for (final path in manifest.listAssets())
    if (path.startsWith('$_assetDir/') && path.endsWith('.yaml'))
      ids.add(path.substring('$_assetDir/'.length, path.length - '.yaml'.length));

  ids.sort(_compareIds);
  return ids;
}

// Polish Catholic biblical book abbreviations (Biblia Tysiąclecia), in canonical
// order. ID convention: diacritics stripped (Łk→Lk, Kpł→Kpl), spaces replaced
// with underscores (1 Kor → 1_Kor). Matches dirName format used in YAML files.
const List<String> _bookOrder = [
  // Stary Testament — Pięcioksiąg
  'Rdz', 'Wj', 'Kpl', 'Lb', 'Pwt',
  // Stary Testament — Księgi historyczne
  'Joz', 'Sdz', 'Rt',
  '1_Sm', '2_Sm',
  '1_Krl', '2_Krl',
  '1_Krn', '2_Krn',
  'Ezd', 'Ne', 'Tb', 'Jdt', 'Est',
  '1_Mch', '2_Mch',
  // Stary Testament — Księgi mądrościowe
  'Hi', 'Ps', 'Prz', 'Koh', 'Pnp', 'Mdr', 'Syr',
  // Stary Testament — Księgi prorockie
  'Iz', 'Jr', 'Lm', 'Ba', 'Ez', 'Dn',
  'Oz', 'Jl', 'Am', 'Ab', 'Jon', 'Mi', 'Na', 'Ha', 'So', 'Ag', 'Za', 'Ml',
  // Nowy Testament — Ewangelie i Dzieje Apostolskie
  'Mt', 'Mk', 'Lk', 'J', 'Dz',
  // Nowy Testament — Listy św. Pawła
  'Rz',
  '1_Kor', '2_Kor',
  'Ga', 'Ef', 'Flp', 'Kol',
  '1_Tes', '2_Tes',
  '1_Tm', '2_Tm',
  'Tt', 'Flm', 'Hbr',
  // Nowy Testament — Listy katolickie
  'Jk',
  '1_P', '2_P',
  '1_J', '2_J', '3_J',
  'Jud',
  // Nowy Testament — Apokalipsa
  'Ap',
];

(int, int, int) _idSortKey(String id) {
  for (int bookIdx = 0; bookIdx < _bookOrder.length; bookIdx++) {
    final book = _bookOrder[bookIdx];
    if (!id.startsWith('${book}_')) continue;
    final parts = id.substring(book.length + 1).split('_');
    final chapter = int.tryParse(parts[0]) ?? 0;
    final verseDigits = parts.length > 1 ? RegExp(r'^\d+').firstMatch(parts[1])?.group(0) : null;
    final verse = verseDigits == null ? 0 : int.parse(verseDigits);
    return (bookIdx, chapter, verse);
  }
  return (_bookOrder.length, 0, 0);
}

int _compareIds(String a, String b) {
  final keyA = _idSortKey(a);
  final keyB = _idSortKey(b);
  if (keyA.$1 != keyB.$1) return keyA.$1.compareTo(keyB.$1);
  if (keyA.$2 != keyB.$2) return keyA.$2.compareTo(keyB.$2);
  return keyA.$3.compareTo(keyB.$3);
}

ApelEwanVariant _parseApelEwanVariant(YamlMap v) {
  final questions = v['questions'] as YamlList?;
  return ApelEwanVariant(
    title: v['title'] as String,
    shortTitle: v['shortTitle'] as String?,
    questions: questions == null ? const [] : questions.cast<String>().toList(),
    comment: v['comment'] as String?,
  );
}

ContributorIdentity _parseAddedBy(String id, YamlMap addedByYaml) {
  final identity = ContributorIdentity(
    name: addedByYaml['name'] as String?,
    emailRef: addedByYaml['email'] as String?,
    userKeyRef: addedByYaml['userKey'] as String?,
  );
  assert(identity.isNotEmpty,
      'ApelEwan $id: `addedBy` must specify at least one of `name`, `email`, `userKey`');
  return identity;
}

ApelEwan _parseApelEwan(String id, String yamlSource) {
  final doc = loadYaml(yamlSource) as YamlMap;

  final variants = <String, ApelEwanVariant>{};
  final variantsYaml = doc['variants'] as YamlMap;
  for (final entry in variantsYaml.entries)
    variants[entry.key as String] = _parseApelEwanVariant(entry.value as YamlMap);

  if (variants.isEmpty)
    debugPrint('ApelEwan $id has no variants — every apel must define at least one variant');

  final folders = <String>{};
  final foldersYaml = doc['folders'] as YamlList?;
  if (foldersYaml != null)
    for (final f in foldersYaml)
      folders.add(f as String);

  return ApelEwan(
    dirName: id,
    siglum: doc['siglum'] as String,
    edition: doc['edition'] as String,
    text: doc['text'] as String,
    variants: variants,
    folders: folders,
    addedBy: _parseAddedBy(id, doc['addedBy'] as YamlMap),
  );
}

Future<void> loadAllApelEwans() async {
  final ids = await _discoverIds();

  final loaded = await Future.wait(ids.map((id) async {
    final path = '$_assetDir/$id.yaml';
    final raw = await rootBundle.loadString(path);
    try {
      return _parseApelEwan(id, raw);
    } catch (e, st) {
      Error.throwWithStackTrace(
        StateError('Failed to parse $path: $e'),
        st,
      );
    }
  }));

  allApelEwans = loaded;
  allApelEwanMap = {for (final apelEwan in loaded) apelEwan.siglum: apelEwan};

  _registerFolderPalettes();
  _buildPersistentFolders();
  _validatePdfVariantsCoverage();
}

/// Logs a warning for each persistent folder whose [pdfVariantIds] cover
/// variants not present on every apel in that folder. Empty [pdfVariantIds]
/// (e.g. omega) intentionally opts out — its PDFs fall back to the apel's
/// first variant per [buildApelEwanPdf].
void _validatePdfVariantsCoverage() {
  for (final folder in ApelEwanPersistentFolder.all) {
    if (folder.pdfVariantIds.isEmpty) continue;
    for (final variantId in folder.pdfVariantIds) {
      final missing = <String>[
        for (final apel in folder.apelEwans)
          if (!apel.variants.containsKey(variantId)) apel.siglum,
      ];
      if (missing.isEmpty) continue;
      debugPrint(
        '[ApelEwan] Folder "${folder.name}" pdfVariant "$variantId": '
        'missing in ${missing.length} apel(s): ${missing.join(", ")}',
      );
    }
  }
}

void _registerFolderPalettes() {
  CommonColorData.register(_omegaApelEwanColorsKey,
      const CommonColorData(Colors.yellow, Colors.orange, Colors.black));
  CommonColorData.register(_dekalogApelEwanColorsKey,
      const CommonColorData(Colors.greenAccent, Colors.blue, Colors.black));
  CommonColorData.register(_hal2026ApelEwanColorsKey,
      const CommonColorData(Colors.purpleAccent, Colors.deepPurple, Colors.black));
}

List<ApelEwan> _collectOrderedItems({
  required Map<String, ApelEwan> byId,
  required List<String> order,
  required String folderId,
}) {
  final items = <ApelEwan>[];
  for (final id in order) {
    final apelEwan = byId[id];
    assert(apelEwan != null,
        '$folderId: order references "$id" but no asset was discovered');
    if (apelEwan == null) continue;
    assert(apelEwan.folders.contains(folderId),
        '$folderId: $id.yaml is in order but its `folders` list does not contain "$folderId"');
    if (!apelEwan.folders.contains(folderId)) continue;
    items.add(apelEwan);
  }
  return items;
}

void _buildPersistentFolders() {
  final byId = {for (final apelEwan in allApelEwans) apelEwan.dirName: apelEwan};

  final dekalogItems = _collectOrderedItems(
    byId: byId,
    order: dekalogOrder,
    folderId: dekalogApelEwansVariantId,
  );

  final hal2026Items = _collectOrderedItems(
    byId: byId,
    order: hal2026Order,
    folderId: _hal2026FolderId,
  );

  omegaFolder = ApelEwanPersistentFolder(
    id: '__omega__',
    apelEwans: allApelEwans,
    name: 'Wszystkie rozważania',
    colorsKey: _omegaApelEwanColorsKey,
    iconKey: 'bookCross',
    variantId: ogolneApelEwansVariantId,
  );

  dekalogFolder = ApelEwanPersistentFolder(
    id: '__dekalog__',
    apelEwans: dekalogItems,
    name: dekalogApelEwansName,
    colorsKey: _dekalogApelEwanColorsKey,
    iconKey: 'textBoxMultiple',
    variantId: dekalogApelEwansVariantId,
    pdfVariantIds: const [dekalogApelEwansVariantId],
  );

  hal2026Folder = ApelEwanPersistentFolder(
    id: '__hal-2026__',
    apelEwans: hal2026Items,
    name: 'Obóz 2026',
    colorsKey: _hal2026ApelEwanColorsKey,
    iconKey: 'tent',
    variantId: hal2026JrApelEwansVariantId,
    pdfVariantIds: const [
      hal2026JrApelEwansVariantId,
      hal2026SrApelEwansVariantId,
    ],
  );

  ApelEwanPersistentFolder.register(omegaFolder);
  ApelEwanPersistentFolder.register(dekalogFolder);
  ApelEwanPersistentFolder.register(hal2026Folder);
}
