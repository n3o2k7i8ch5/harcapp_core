# Sprawności (Scout Proficiency Badges)

This module manages sprawności (scout proficiency badges) data for HarcApp. It provides a hierarchical database structure for storing and querying badge information across different scouting organizations and versions.

## Data Structure

The sprawności data is organized in a hierarchical structure:

```
SprawBook (e.g., "ZHR Harcerze 2023")
  └── SprawGroup (e.g., "Obozownictwo i przyroda")
      └── SprawFamily (e.g., "Rozpalanie ognia")
          └── Spraw (e.g., "Płomień - Level 1")
              └── SprawTask (individual requirements)
```

### Models

- **`SprawBook`** - A collection of badges from a specific organization and version (e.g., ZHR, ZHP)
- **`SprawGroup`** - A thematic grouping of badge families (e.g., camping, sports, arts)
- **`SprawFamily`** - A family of related badges at different difficulty levels
- **`Spraw`** - A specific badge at a particular level with its requirements
- **`SprawTask`** - An individual requirement/task for earning a badge

### Key Fields

- **`slug`** - A URL-friendly identifier (not globally unique, can repeat across books)
- **`uniqName`** - A globally unique identifier combining the full hierarchy path
  - Format: `book_slug$group_slug$family_slug$spraw_slug`
  - Example: `zhr_harc_c_sim_2023$obozownictwo$rozpalanie_ognia$plomien_1`

## Source Data

Sprawności data is stored in YAML files under `assets/sprawnosci/`:

```
assets/sprawnosci/
├── zhp_harc_sim_2022/          # Book directory
│   ├── _data.yaml              # Book metadata
│   └── group1@wyrobienie/      # Group directory
│       ├── _data.yaml          # Group metadata
│       └── family1@harcerz/    # Family directory
│           ├── _data.yaml      # Family metadata
│           └── 1@harcerz$1/    # Spraw directory (level 1)
│               └── _data.yaml  # Spraw data with tasks
└── common/                     # Shared resources (excluded from import)
```

## Importing Data

### Quick Start

To import all sprawności books into the database:

```bash
make import_spraw_books
```

This will:
1. Clear existing data from the database
2. Load all book directories from `assets/sprawnosci/`
3. Import the complete hierarchy into Isar
4. Display statistics about imported data

### Manual Import

You can also run the generator directly:

```bash
# Use default database path (assets/sprawnosci_db.isar)
dart run lib/sprawnosci/generator.dart

# Specify custom database path
dart run lib/sprawnosci/generator.dart path/to/custom.isar
```

### Import Process

The import process uses the **importer pattern** for clean separation of concerns:

1. **`SprawBookDBImporter.fromDir()`** - Loads a book and its hierarchy from filesystem
2. **`importer.import(isar)`** - Saves the entire hierarchy to the Isar database

Each importer class (`SprawBookDBImporter`, `SprawGroupDBImporter`, etc.) handles:
- Loading data from YAML files
- Building parent-child relationships
- Computing unique names
- Saving to the database

### After Import

The generator displays statistics:

```
=== Database Statistics ===
Books:    7
Groups:   81
Families: 635
Spraws:   1960
Tasks:    8634
```

## Code Organization

- **`models.dart`** - Clean Isar data models (no loading logic)
- **`data_importer.dart`** - Importer classes that load from filesystem and save to database
- **`generator.dart`** - CLI tool for importing sprawności data
- **`utils.dart`** - Shared utilities (YAML reading, text processing)

## Querying Data

### By Unique Name

```dart
final spraw = await isar.spraws
    .where()
    .uniqNameEqualTo('zhr_harc_c_sim_2023\$obozownictwo\$rozpalanie_ognia\$plomien_1')
    .findFirst();
```

### By Hierarchy

```dart
// Get all spraws in a book
final book = await isar.sprawBooks
    .where()
    .slugEqualTo('zhp_harc_sim_2022')
    .findFirst();
    
await book.groups.load();
for (final group in book.groups) {
  await group.families.load();
  for (final family in group.families) {
    await family.spraws.load();
    // Process spraws...
  }
}
```

### By Level

```dart
// Find all level 1 spraws
final level1Spraws = await isar.spraws
    .where()
    .levelEqualTo(1)
    .findAll();
```

### Search by Name

```dart
// Case-insensitive search using nameRaw field
final results = await isar.spraws
    .where()
    .nameRawContains('plomien')
    .findAll();
```

## Development

### Regenerate Isar Schema

After modifying models, regenerate the Isar schema:

```bash
make generate
```

### Add New Book

1. Create a new directory under `assets/sprawnosci/`
2. Add `_data.yaml` with book metadata (slug, name, male, female)
3. Organize groups, families, and spraws in subdirectories
4. Follow the naming convention: `groupN@slug`, `familyN@slug`, `N@slug$level`
5. Run `make import_spraw_books`

## Important Notes

- The `common/` directory is excluded from imports (used for shared icons/resources)
- Slugs are made unique per family by appending the level (e.g., `plomien_1`, `plomien_2`)
- The same sprawność can appear in multiple books with different requirements
- All text fields have corresponding `*Raw` fields for case-insensitive searching
- The `uniqName` field is the only globally unique identifier across all books