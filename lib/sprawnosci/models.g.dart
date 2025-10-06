// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSprawBookCollection on Isar {
  IsarCollection<SprawBook> get sprawBooks => this.collection();
}

const SprawBookSchema = CollectionSchema(
  name: r'SprawBook',
  id: 398851501432896569,
  properties: {
    r'female': PropertySchema(id: 0, name: r'female', type: IsarType.bool),
    r'male': PropertySchema(id: 1, name: r'male', type: IsarType.bool),
    r'name': PropertySchema(id: 2, name: r'name', type: IsarType.string),
    r'slug': PropertySchema(id: 3, name: r'slug', type: IsarType.string),
    r'source': PropertySchema(id: 4, name: r'source', type: IsarType.string),
  },

  estimateSize: _sprawBookEstimateSize,
  serialize: _sprawBookSerialize,
  deserialize: _sprawBookDeserialize,
  deserializeProp: _sprawBookDeserializeProp,
  idName: r'id',
  indexes: {
    r'slug': IndexSchema(
      id: 6169444064746062836,
      name: r'slug',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'slug',
          type: IndexType.hash,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {
    r'groups': LinkSchema(
      id: -2617409701638732846,
      name: r'groups',
      target: r'SprawGroup',
      single: false,
      linkName: r'sprawBook',
    ),
  },
  embeddedSchemas: {},

  getId: _sprawBookGetId,
  getLinks: _sprawBookGetLinks,
  attach: _sprawBookAttach,
  version: '3.3.0-dev.3',
);

int _sprawBookEstimateSize(
  SprawBook object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.slug.length * 3;
  {
    final value = object.source;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _sprawBookSerialize(
  SprawBook object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.female);
  writer.writeBool(offsets[1], object.male);
  writer.writeString(offsets[2], object.name);
  writer.writeString(offsets[3], object.slug);
  writer.writeString(offsets[4], object.source);
}

SprawBook _sprawBookDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SprawBook();
  object.female = reader.readBool(offsets[0]);
  object.id = id;
  object.male = reader.readBool(offsets[1]);
  object.name = reader.readString(offsets[2]);
  object.slug = reader.readString(offsets[3]);
  object.source = reader.readStringOrNull(offsets[4]);
  return object;
}

P _sprawBookDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sprawBookGetId(SprawBook object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sprawBookGetLinks(SprawBook object) {
  return [object.groups];
}

void _sprawBookAttach(IsarCollection<dynamic> col, Id id, SprawBook object) {
  object.id = id;
  object.groups.attach(col, col.isar.collection<SprawGroup>(), r'groups', id);
}

extension SprawBookByIndex on IsarCollection<SprawBook> {
  Future<SprawBook?> getBySlug(String slug) {
    return getByIndex(r'slug', [slug]);
  }

  SprawBook? getBySlugSync(String slug) {
    return getByIndexSync(r'slug', [slug]);
  }

  Future<bool> deleteBySlug(String slug) {
    return deleteByIndex(r'slug', [slug]);
  }

  bool deleteBySlugSync(String slug) {
    return deleteByIndexSync(r'slug', [slug]);
  }

  Future<List<SprawBook?>> getAllBySlug(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return getAllByIndex(r'slug', values);
  }

  List<SprawBook?> getAllBySlugSync(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'slug', values);
  }

  Future<int> deleteAllBySlug(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'slug', values);
  }

  int deleteAllBySlugSync(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'slug', values);
  }

  Future<Id> putBySlug(SprawBook object) {
    return putByIndex(r'slug', object);
  }

  Id putBySlugSync(SprawBook object, {bool saveLinks = true}) {
    return putByIndexSync(r'slug', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySlug(List<SprawBook> objects) {
    return putAllByIndex(r'slug', objects);
  }

  List<Id> putAllBySlugSync(List<SprawBook> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'slug', objects, saveLinks: saveLinks);
  }
}

extension SprawBookQueryWhereSort
    on QueryBuilder<SprawBook, SprawBook, QWhere> {
  QueryBuilder<SprawBook, SprawBook, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SprawBookQueryWhere
    on QueryBuilder<SprawBook, SprawBook, QWhereClause> {
  QueryBuilder<SprawBook, SprawBook, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterWhereClause> slugEqualTo(
    String slug,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'slug', value: [slug]),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterWhereClause> slugNotEqualTo(
    String slug,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [],
                upper: [slug],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [slug],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [slug],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [],
                upper: [slug],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension SprawBookQueryFilter
    on QueryBuilder<SprawBook, SprawBook, QFilterCondition> {
  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> femaleEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'female', value: value),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> maleEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'male', value: value),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> nameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> nameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> slugEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> slugGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> slugLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> slugBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'slug',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> slugStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> slugEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> slugContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> slugMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'slug',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> slugIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'slug', value: ''),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> slugIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'slug', value: ''),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> sourceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'source'),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> sourceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'source'),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> sourceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> sourceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> sourceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> sourceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'source',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> sourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> sourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> sourceContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'source',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> sourceMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'source',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> sourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'source', value: ''),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> sourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'source', value: ''),
      );
    });
  }
}

extension SprawBookQueryObject
    on QueryBuilder<SprawBook, SprawBook, QFilterCondition> {}

extension SprawBookQueryLinks
    on QueryBuilder<SprawBook, SprawBook, QFilterCondition> {
  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> groups(
    FilterQuery<SprawGroup> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'groups');
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> groupsLengthEqualTo(
    int length,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groups', length, true, length, true);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> groupsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groups', 0, true, 0, true);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> groupsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groups', 0, false, 999999, true);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition>
  groupsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groups', 0, true, length, include);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition>
  groupsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'groups', length, include, 999999, true);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition> groupsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
        r'groups',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension SprawBookQuerySortBy on QueryBuilder<SprawBook, SprawBook, QSortBy> {
  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> sortByFemale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'female', Sort.asc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> sortByFemaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'female', Sort.desc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> sortByMale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'male', Sort.asc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> sortByMaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'male', Sort.desc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> sortBySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.asc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> sortBySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.desc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> sortBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> sortBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }
}

extension SprawBookQuerySortThenBy
    on QueryBuilder<SprawBook, SprawBook, QSortThenBy> {
  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> thenByFemale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'female', Sort.asc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> thenByFemaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'female', Sort.desc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> thenByMale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'male', Sort.asc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> thenByMaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'male', Sort.desc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> thenBySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.asc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> thenBySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.desc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> thenBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> thenBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }
}

extension SprawBookQueryWhereDistinct
    on QueryBuilder<SprawBook, SprawBook, QDistinct> {
  QueryBuilder<SprawBook, SprawBook, QDistinct> distinctByFemale() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'female');
    });
  }

  QueryBuilder<SprawBook, SprawBook, QDistinct> distinctByMale() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'male');
    });
  }

  QueryBuilder<SprawBook, SprawBook, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QDistinct> distinctBySlug({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'slug', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QDistinct> distinctBySource({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'source', caseSensitive: caseSensitive);
    });
  }
}

extension SprawBookQueryProperty
    on QueryBuilder<SprawBook, SprawBook, QQueryProperty> {
  QueryBuilder<SprawBook, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SprawBook, bool, QQueryOperations> femaleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'female');
    });
  }

  QueryBuilder<SprawBook, bool, QQueryOperations> maleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'male');
    });
  }

  QueryBuilder<SprawBook, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<SprawBook, String, QQueryOperations> slugProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'slug');
    });
  }

  QueryBuilder<SprawBook, String?, QQueryOperations> sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'source');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSprawGroupCollection on Isar {
  IsarCollection<SprawGroup> get sprawGroups => this.collection();
}

const SprawGroupSchema = CollectionSchema(
  name: r'SprawGroup',
  id: 800708513845433203,
  properties: {
    r'description': PropertySchema(
      id: 0,
      name: r'description',
      type: IsarType.string,
    ),
    r'name': PropertySchema(id: 1, name: r'name', type: IsarType.string),
    r'slug': PropertySchema(id: 2, name: r'slug', type: IsarType.string),
    r'tags': PropertySchema(id: 3, name: r'tags', type: IsarType.stringList),
  },

  estimateSize: _sprawGroupEstimateSize,
  serialize: _sprawGroupSerialize,
  deserialize: _sprawGroupDeserialize,
  deserializeProp: _sprawGroupDeserializeProp,
  idName: r'id',
  indexes: {
    r'slug': IndexSchema(
      id: 6169444064746062836,
      name: r'slug',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'slug',
          type: IndexType.hash,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {
    r'sprawBook': LinkSchema(
      id: 3567274537619130242,
      name: r'sprawBook',
      target: r'SprawBook',
      single: true,
    ),
    r'families': LinkSchema(
      id: -9008381935457288863,
      name: r'families',
      target: r'SprawFamily',
      single: false,
      linkName: r'group',
    ),
  },
  embeddedSchemas: {},

  getId: _sprawGroupGetId,
  getLinks: _sprawGroupGetLinks,
  attach: _sprawGroupAttach,
  version: '3.3.0-dev.3',
);

int _sprawGroupEstimateSize(
  SprawGroup object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.slug.length * 3;
  bytesCount += 3 + object.tags.length * 3;
  {
    for (var i = 0; i < object.tags.length; i++) {
      final value = object.tags[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _sprawGroupSerialize(
  SprawGroup object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.description);
  writer.writeString(offsets[1], object.name);
  writer.writeString(offsets[2], object.slug);
  writer.writeStringList(offsets[3], object.tags);
}

SprawGroup _sprawGroupDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SprawGroup();
  object.description = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.name = reader.readString(offsets[1]);
  object.slug = reader.readString(offsets[2]);
  object.tags = reader.readStringList(offsets[3]) ?? [];
  return object;
}

P _sprawGroupDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sprawGroupGetId(SprawGroup object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sprawGroupGetLinks(SprawGroup object) {
  return [object.sprawBook, object.families];
}

void _sprawGroupAttach(IsarCollection<dynamic> col, Id id, SprawGroup object) {
  object.id = id;
  object.sprawBook.attach(
    col,
    col.isar.collection<SprawBook>(),
    r'sprawBook',
    id,
  );
  object.families.attach(
    col,
    col.isar.collection<SprawFamily>(),
    r'families',
    id,
  );
}

extension SprawGroupByIndex on IsarCollection<SprawGroup> {
  Future<SprawGroup?> getBySlug(String slug) {
    return getByIndex(r'slug', [slug]);
  }

  SprawGroup? getBySlugSync(String slug) {
    return getByIndexSync(r'slug', [slug]);
  }

  Future<bool> deleteBySlug(String slug) {
    return deleteByIndex(r'slug', [slug]);
  }

  bool deleteBySlugSync(String slug) {
    return deleteByIndexSync(r'slug', [slug]);
  }

  Future<List<SprawGroup?>> getAllBySlug(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return getAllByIndex(r'slug', values);
  }

  List<SprawGroup?> getAllBySlugSync(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'slug', values);
  }

  Future<int> deleteAllBySlug(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'slug', values);
  }

  int deleteAllBySlugSync(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'slug', values);
  }

  Future<Id> putBySlug(SprawGroup object) {
    return putByIndex(r'slug', object);
  }

  Id putBySlugSync(SprawGroup object, {bool saveLinks = true}) {
    return putByIndexSync(r'slug', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySlug(List<SprawGroup> objects) {
    return putAllByIndex(r'slug', objects);
  }

  List<Id> putAllBySlugSync(List<SprawGroup> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'slug', objects, saveLinks: saveLinks);
  }
}

extension SprawGroupQueryWhereSort
    on QueryBuilder<SprawGroup, SprawGroup, QWhere> {
  QueryBuilder<SprawGroup, SprawGroup, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SprawGroupQueryWhere
    on QueryBuilder<SprawGroup, SprawGroup, QWhereClause> {
  QueryBuilder<SprawGroup, SprawGroup, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterWhereClause> slugEqualTo(
    String slug,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'slug', value: [slug]),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterWhereClause> slugNotEqualTo(
    String slug,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [],
                upper: [slug],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [slug],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [slug],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [],
                upper: [slug],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension SprawGroupQueryFilter
    on QueryBuilder<SprawGroup, SprawGroup, QFilterCondition> {
  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'description'),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'description'),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  descriptionEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'description',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  descriptionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  descriptionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'description',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> nameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> nameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> slugEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> slugGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> slugLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> slugBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'slug',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> slugStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> slugEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> slugContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> slugMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'slug',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> slugIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'slug', value: ''),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> slugIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'slug', value: ''),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  tagsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  tagsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  tagsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  tagsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tags',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  tagsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  tagsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  tagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  tagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'tags',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tags', value: ''),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'tags', value: ''),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> tagsLengthEqualTo(
    int length,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'tags', length, true, length, true);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'tags', 0, true, 0, true);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'tags', 0, false, 999999, true);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  tagsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'tags', 0, true, length, include);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  tagsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'tags', length, include, 999999, true);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension SprawGroupQueryObject
    on QueryBuilder<SprawGroup, SprawGroup, QFilterCondition> {}

extension SprawGroupQueryLinks
    on QueryBuilder<SprawGroup, SprawGroup, QFilterCondition> {
  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> sprawBook(
    FilterQuery<SprawBook> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'sprawBook');
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  sprawBookIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'sprawBook', 0, true, 0, true);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> families(
    FilterQuery<SprawFamily> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'families');
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  familiesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'families', length, true, length, true);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  familiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'families', 0, true, 0, true);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  familiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'families', 0, false, 999999, true);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  familiesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'families', 0, true, length, include);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  familiesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'families', length, include, 999999, true);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  familiesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
        r'families',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension SprawGroupQuerySortBy
    on QueryBuilder<SprawGroup, SprawGroup, QSortBy> {
  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> sortBySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.asc);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> sortBySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.desc);
    });
  }
}

extension SprawGroupQuerySortThenBy
    on QueryBuilder<SprawGroup, SprawGroup, QSortThenBy> {
  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> thenBySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.asc);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> thenBySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.desc);
    });
  }
}

extension SprawGroupQueryWhereDistinct
    on QueryBuilder<SprawGroup, SprawGroup, QDistinct> {
  QueryBuilder<SprawGroup, SprawGroup, QDistinct> distinctByDescription({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QDistinct> distinctBySlug({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'slug', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QDistinct> distinctByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tags');
    });
  }
}

extension SprawGroupQueryProperty
    on QueryBuilder<SprawGroup, SprawGroup, QQueryProperty> {
  QueryBuilder<SprawGroup, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SprawGroup, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<SprawGroup, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<SprawGroup, String, QQueryOperations> slugProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'slug');
    });
  }

  QueryBuilder<SprawGroup, List<String>, QQueryOperations> tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSprawFamilyCollection on Isar {
  IsarCollection<SprawFamily> get sprawFamilys => this.collection();
}

const SprawFamilySchema = CollectionSchema(
  name: r'SprawFamily',
  id: -8840585411692591998,
  properties: {
    r'fragment': PropertySchema(
      id: 0,
      name: r'fragment',
      type: IsarType.string,
    ),
    r'fragmentAuthor': PropertySchema(
      id: 1,
      name: r'fragmentAuthor',
      type: IsarType.string,
    ),
    r'name': PropertySchema(id: 2, name: r'name', type: IsarType.string),
    r'notesForLeaders': PropertySchema(
      id: 3,
      name: r'notesForLeaders',
      type: IsarType.stringList,
    ),
    r'requirements': PropertySchema(
      id: 4,
      name: r'requirements',
      type: IsarType.stringList,
    ),
    r'slug': PropertySchema(id: 5, name: r'slug', type: IsarType.string),
    r'tags': PropertySchema(id: 6, name: r'tags', type: IsarType.stringList),
  },

  estimateSize: _sprawFamilyEstimateSize,
  serialize: _sprawFamilySerialize,
  deserialize: _sprawFamilyDeserialize,
  deserializeProp: _sprawFamilyDeserializeProp,
  idName: r'id',
  indexes: {
    r'slug': IndexSchema(
      id: 6169444064746062836,
      name: r'slug',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'slug',
          type: IndexType.hash,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {
    r'group': LinkSchema(
      id: 5635091928811788746,
      name: r'group',
      target: r'SprawGroup',
      single: true,
    ),
    r'spraws': LinkSchema(
      id: 6960255956846443902,
      name: r'spraws',
      target: r'Spraw',
      single: false,
      linkName: r'family',
    ),
  },
  embeddedSchemas: {},

  getId: _sprawFamilyGetId,
  getLinks: _sprawFamilyGetLinks,
  attach: _sprawFamilyAttach,
  version: '3.3.0-dev.3',
);

int _sprawFamilyEstimateSize(
  SprawFamily object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.fragment;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fragmentAuthor;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.notesForLeaders.length * 3;
  {
    for (var i = 0; i < object.notesForLeaders.length; i++) {
      final value = object.notesForLeaders[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.requirements.length * 3;
  {
    for (var i = 0; i < object.requirements.length; i++) {
      final value = object.requirements[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.slug.length * 3;
  bytesCount += 3 + object.tags.length * 3;
  {
    for (var i = 0; i < object.tags.length; i++) {
      final value = object.tags[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _sprawFamilySerialize(
  SprawFamily object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.fragment);
  writer.writeString(offsets[1], object.fragmentAuthor);
  writer.writeString(offsets[2], object.name);
  writer.writeStringList(offsets[3], object.notesForLeaders);
  writer.writeStringList(offsets[4], object.requirements);
  writer.writeString(offsets[5], object.slug);
  writer.writeStringList(offsets[6], object.tags);
}

SprawFamily _sprawFamilyDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SprawFamily();
  object.fragment = reader.readStringOrNull(offsets[0]);
  object.fragmentAuthor = reader.readStringOrNull(offsets[1]);
  object.id = id;
  object.name = reader.readString(offsets[2]);
  object.notesForLeaders = reader.readStringList(offsets[3]) ?? [];
  object.requirements = reader.readStringList(offsets[4]) ?? [];
  object.slug = reader.readString(offsets[5]);
  object.tags = reader.readStringList(offsets[6]) ?? [];
  return object;
}

P _sprawFamilyDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringList(offset) ?? []) as P;
    case 4:
      return (reader.readStringList(offset) ?? []) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sprawFamilyGetId(SprawFamily object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sprawFamilyGetLinks(SprawFamily object) {
  return [object.group, object.spraws];
}

void _sprawFamilyAttach(
  IsarCollection<dynamic> col,
  Id id,
  SprawFamily object,
) {
  object.id = id;
  object.group.attach(col, col.isar.collection<SprawGroup>(), r'group', id);
  object.spraws.attach(col, col.isar.collection<Spraw>(), r'spraws', id);
}

extension SprawFamilyByIndex on IsarCollection<SprawFamily> {
  Future<SprawFamily?> getBySlug(String slug) {
    return getByIndex(r'slug', [slug]);
  }

  SprawFamily? getBySlugSync(String slug) {
    return getByIndexSync(r'slug', [slug]);
  }

  Future<bool> deleteBySlug(String slug) {
    return deleteByIndex(r'slug', [slug]);
  }

  bool deleteBySlugSync(String slug) {
    return deleteByIndexSync(r'slug', [slug]);
  }

  Future<List<SprawFamily?>> getAllBySlug(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return getAllByIndex(r'slug', values);
  }

  List<SprawFamily?> getAllBySlugSync(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'slug', values);
  }

  Future<int> deleteAllBySlug(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'slug', values);
  }

  int deleteAllBySlugSync(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'slug', values);
  }

  Future<Id> putBySlug(SprawFamily object) {
    return putByIndex(r'slug', object);
  }

  Id putBySlugSync(SprawFamily object, {bool saveLinks = true}) {
    return putByIndexSync(r'slug', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySlug(List<SprawFamily> objects) {
    return putAllByIndex(r'slug', objects);
  }

  List<Id> putAllBySlugSync(
    List<SprawFamily> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'slug', objects, saveLinks: saveLinks);
  }
}

extension SprawFamilyQueryWhereSort
    on QueryBuilder<SprawFamily, SprawFamily, QWhere> {
  QueryBuilder<SprawFamily, SprawFamily, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SprawFamilyQueryWhere
    on QueryBuilder<SprawFamily, SprawFamily, QWhereClause> {
  QueryBuilder<SprawFamily, SprawFamily, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterWhereClause> slugEqualTo(
    String slug,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'slug', value: [slug]),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterWhereClause> slugNotEqualTo(
    String slug,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [],
                upper: [slug],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [slug],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [slug],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [],
                upper: [slug],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension SprawFamilyQueryFilter
    on QueryBuilder<SprawFamily, SprawFamily, QFilterCondition> {
  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'fragment'),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'fragment'),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> fragmentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fragment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fragment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fragment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> fragmentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fragment',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'fragment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'fragment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'fragment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> fragmentMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'fragment',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fragment', value: ''),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'fragment', value: ''),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentAuthorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'fragmentAuthor'),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentAuthorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'fragmentAuthor'),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentAuthorEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fragmentAuthor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentAuthorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fragmentAuthor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentAuthorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fragmentAuthor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentAuthorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fragmentAuthor',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentAuthorStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'fragmentAuthor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentAuthorEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'fragmentAuthor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentAuthorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'fragmentAuthor',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentAuthorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'fragmentAuthor',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentAuthorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fragmentAuthor', value: ''),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  fragmentAuthorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'fragmentAuthor', value: ''),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> nameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> nameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  notesForLeadersElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'notesForLeaders',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  notesForLeadersElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'notesForLeaders',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  notesForLeadersElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'notesForLeaders',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  notesForLeadersElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'notesForLeaders',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  notesForLeadersElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'notesForLeaders',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  notesForLeadersElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'notesForLeaders',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  notesForLeadersElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'notesForLeaders',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  notesForLeadersElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'notesForLeaders',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  notesForLeadersElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'notesForLeaders', value: ''),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  notesForLeadersElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'notesForLeaders', value: ''),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  notesForLeadersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'notesForLeaders', length, true, length, true);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  notesForLeadersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'notesForLeaders', 0, true, 0, true);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  notesForLeadersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'notesForLeaders', 0, false, 999999, true);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  notesForLeadersLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'notesForLeaders', 0, true, length, include);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  notesForLeadersLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notesForLeaders',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  notesForLeadersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notesForLeaders',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  requirementsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'requirements',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  requirementsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'requirements',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  requirementsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'requirements',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  requirementsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'requirements',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  requirementsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'requirements',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  requirementsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'requirements',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  requirementsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'requirements',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  requirementsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'requirements',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  requirementsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'requirements', value: ''),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  requirementsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'requirements', value: ''),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  requirementsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'requirements', length, true, length, true);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  requirementsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'requirements', 0, true, 0, true);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  requirementsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'requirements', 0, false, 999999, true);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  requirementsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'requirements', 0, true, length, include);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  requirementsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'requirements', length, include, 999999, true);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  requirementsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'requirements',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> slugEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> slugGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> slugLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> slugBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'slug',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> slugStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> slugEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> slugContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> slugMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'slug',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> slugIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'slug', value: ''),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  slugIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'slug', value: ''),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  tagsElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  tagsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  tagsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  tagsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'tags',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  tagsElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  tagsElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  tagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'tags',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  tagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'tags',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tags', value: ''),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'tags', value: ''),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  tagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'tags', length, true, length, true);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'tags', 0, true, 0, true);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'tags', 0, false, 999999, true);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  tagsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'tags', 0, true, length, include);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  tagsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'tags', length, include, 999999, true);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension SprawFamilyQueryObject
    on QueryBuilder<SprawFamily, SprawFamily, QFilterCondition> {}

extension SprawFamilyQueryLinks
    on QueryBuilder<SprawFamily, SprawFamily, QFilterCondition> {
  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> group(
    FilterQuery<SprawGroup> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'group');
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> groupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'group', 0, true, 0, true);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition> spraws(
    FilterQuery<Spraw> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'spraws');
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  sprawsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'spraws', length, true, length, true);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  sprawsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'spraws', 0, true, 0, true);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  sprawsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'spraws', 0, false, 999999, true);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  sprawsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'spraws', 0, true, length, include);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  sprawsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'spraws', length, include, 999999, true);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  sprawsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
        r'spraws',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension SprawFamilyQuerySortBy
    on QueryBuilder<SprawFamily, SprawFamily, QSortBy> {
  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> sortByFragment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fragment', Sort.asc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> sortByFragmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fragment', Sort.desc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> sortByFragmentAuthor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fragmentAuthor', Sort.asc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy>
  sortByFragmentAuthorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fragmentAuthor', Sort.desc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> sortBySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.asc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> sortBySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.desc);
    });
  }
}

extension SprawFamilyQuerySortThenBy
    on QueryBuilder<SprawFamily, SprawFamily, QSortThenBy> {
  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> thenByFragment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fragment', Sort.asc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> thenByFragmentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fragment', Sort.desc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> thenByFragmentAuthor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fragmentAuthor', Sort.asc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy>
  thenByFragmentAuthorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fragmentAuthor', Sort.desc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> thenBySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.asc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> thenBySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.desc);
    });
  }
}

extension SprawFamilyQueryWhereDistinct
    on QueryBuilder<SprawFamily, SprawFamily, QDistinct> {
  QueryBuilder<SprawFamily, SprawFamily, QDistinct> distinctByFragment({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fragment', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QDistinct> distinctByFragmentAuthor({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'fragmentAuthor',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QDistinct>
  distinctByNotesForLeaders() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notesForLeaders');
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QDistinct> distinctByRequirements() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'requirements');
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QDistinct> distinctBySlug({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'slug', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QDistinct> distinctByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tags');
    });
  }
}

extension SprawFamilyQueryProperty
    on QueryBuilder<SprawFamily, SprawFamily, QQueryProperty> {
  QueryBuilder<SprawFamily, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SprawFamily, String?, QQueryOperations> fragmentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fragment');
    });
  }

  QueryBuilder<SprawFamily, String?, QQueryOperations>
  fragmentAuthorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fragmentAuthor');
    });
  }

  QueryBuilder<SprawFamily, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<SprawFamily, List<String>, QQueryOperations>
  notesForLeadersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notesForLeaders');
    });
  }

  QueryBuilder<SprawFamily, List<String>, QQueryOperations>
  requirementsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requirements');
    });
  }

  QueryBuilder<SprawFamily, String, QQueryOperations> slugProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'slug');
    });
  }

  QueryBuilder<SprawFamily, List<String>, QQueryOperations> tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSprawCollection on Isar {
  IsarCollection<Spraw> get spraws => this.collection();
}

const SprawSchema = CollectionSchema(
  name: r'Spraw',
  id: 5364718012575422951,
  properties: {
    r'comment': PropertySchema(id: 0, name: r'comment', type: IsarType.string),
    r'hiddenNames': PropertySchema(
      id: 1,
      name: r'hiddenNames',
      type: IsarType.stringList,
    ),
    r'iconPath': PropertySchema(
      id: 2,
      name: r'iconPath',
      type: IsarType.string,
    ),
    r'level': PropertySchema(id: 3, name: r'level', type: IsarType.long),
    r'name': PropertySchema(id: 4, name: r'name', type: IsarType.string),
    r'slug': PropertySchema(id: 5, name: r'slug', type: IsarType.string),
    r'tasksAreExamples': PropertySchema(
      id: 6,
      name: r'tasksAreExamples',
      type: IsarType.bool,
    ),
    r'uniqName': PropertySchema(
      id: 7,
      name: r'uniqName',
      type: IsarType.string,
    ),
  },

  estimateSize: _sprawEstimateSize,
  serialize: _sprawSerialize,
  deserialize: _sprawDeserialize,
  deserializeProp: _sprawDeserializeProp,
  idName: r'id',
  indexes: {
    r'slug': IndexSchema(
      id: 6169444064746062836,
      name: r'slug',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'slug',
          type: IndexType.hash,
          caseSensitive: false,
        ),
      ],
    ),
    r'uniqName': IndexSchema(
      id: -5359579789865846563,
      name: r'uniqName',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'uniqName',
          type: IndexType.hash,
          caseSensitive: false,
        ),
      ],
    ),
    r'level': IndexSchema(
      id: -730704511986726349,
      name: r'level',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'level',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {
    r'family': LinkSchema(
      id: 8054155273771712438,
      name: r'family',
      target: r'SprawFamily',
      single: true,
    ),
    r'tasks': LinkSchema(
      id: -4356327535830731942,
      name: r'tasks',
      target: r'SprawTask',
      single: false,
      linkName: r'spraw',
    ),
  },
  embeddedSchemas: {},

  getId: _sprawGetId,
  getLinks: _sprawGetLinks,
  attach: _sprawAttach,
  version: '3.3.0-dev.3',
);

int _sprawEstimateSize(
  Spraw object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.comment;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.hiddenNames.length * 3;
  {
    for (var i = 0; i < object.hiddenNames.length; i++) {
      final value = object.hiddenNames[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.iconPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.slug.length * 3;
  bytesCount += 3 + object.uniqName.length * 3;
  return bytesCount;
}

void _sprawSerialize(
  Spraw object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.comment);
  writer.writeStringList(offsets[1], object.hiddenNames);
  writer.writeString(offsets[2], object.iconPath);
  writer.writeLong(offsets[3], object.level);
  writer.writeString(offsets[4], object.name);
  writer.writeString(offsets[5], object.slug);
  writer.writeBool(offsets[6], object.tasksAreExamples);
  writer.writeString(offsets[7], object.uniqName);
}

Spraw _sprawDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Spraw();
  object.comment = reader.readStringOrNull(offsets[0]);
  object.hiddenNames = reader.readStringList(offsets[1]) ?? [];
  object.iconPath = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.level = reader.readLong(offsets[3]);
  object.name = reader.readString(offsets[4]);
  object.slug = reader.readString(offsets[5]);
  object.tasksAreExamples = reader.readBool(offsets[6]);
  object.uniqName = reader.readString(offsets[7]);
  return object;
}

P _sprawDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sprawGetId(Spraw object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sprawGetLinks(Spraw object) {
  return [object.family, object.tasks];
}

void _sprawAttach(IsarCollection<dynamic> col, Id id, Spraw object) {
  object.id = id;
  object.family.attach(col, col.isar.collection<SprawFamily>(), r'family', id);
  object.tasks.attach(col, col.isar.collection<SprawTask>(), r'tasks', id);
}

extension SprawByIndex on IsarCollection<Spraw> {
  Future<Spraw?> getBySlug(String slug) {
    return getByIndex(r'slug', [slug]);
  }

  Spraw? getBySlugSync(String slug) {
    return getByIndexSync(r'slug', [slug]);
  }

  Future<bool> deleteBySlug(String slug) {
    return deleteByIndex(r'slug', [slug]);
  }

  bool deleteBySlugSync(String slug) {
    return deleteByIndexSync(r'slug', [slug]);
  }

  Future<List<Spraw?>> getAllBySlug(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return getAllByIndex(r'slug', values);
  }

  List<Spraw?> getAllBySlugSync(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'slug', values);
  }

  Future<int> deleteAllBySlug(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'slug', values);
  }

  int deleteAllBySlugSync(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'slug', values);
  }

  Future<Id> putBySlug(Spraw object) {
    return putByIndex(r'slug', object);
  }

  Id putBySlugSync(Spraw object, {bool saveLinks = true}) {
    return putByIndexSync(r'slug', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySlug(List<Spraw> objects) {
    return putAllByIndex(r'slug', objects);
  }

  List<Id> putAllBySlugSync(List<Spraw> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'slug', objects, saveLinks: saveLinks);
  }

  Future<Spraw?> getByUniqName(String uniqName) {
    return getByIndex(r'uniqName', [uniqName]);
  }

  Spraw? getByUniqNameSync(String uniqName) {
    return getByIndexSync(r'uniqName', [uniqName]);
  }

  Future<bool> deleteByUniqName(String uniqName) {
    return deleteByIndex(r'uniqName', [uniqName]);
  }

  bool deleteByUniqNameSync(String uniqName) {
    return deleteByIndexSync(r'uniqName', [uniqName]);
  }

  Future<List<Spraw?>> getAllByUniqName(List<String> uniqNameValues) {
    final values = uniqNameValues.map((e) => [e]).toList();
    return getAllByIndex(r'uniqName', values);
  }

  List<Spraw?> getAllByUniqNameSync(List<String> uniqNameValues) {
    final values = uniqNameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uniqName', values);
  }

  Future<int> deleteAllByUniqName(List<String> uniqNameValues) {
    final values = uniqNameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uniqName', values);
  }

  int deleteAllByUniqNameSync(List<String> uniqNameValues) {
    final values = uniqNameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uniqName', values);
  }

  Future<Id> putByUniqName(Spraw object) {
    return putByIndex(r'uniqName', object);
  }

  Id putByUniqNameSync(Spraw object, {bool saveLinks = true}) {
    return putByIndexSync(r'uniqName', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUniqName(List<Spraw> objects) {
    return putAllByIndex(r'uniqName', objects);
  }

  List<Id> putAllByUniqNameSync(List<Spraw> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uniqName', objects, saveLinks: saveLinks);
  }
}

extension SprawQueryWhereSort on QueryBuilder<Spraw, Spraw, QWhere> {
  QueryBuilder<Spraw, Spraw, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhere> anyLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'level'),
      );
    });
  }
}

extension SprawQueryWhere on QueryBuilder<Spraw, Spraw, QWhereClause> {
  QueryBuilder<Spraw, Spraw, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> slugEqualTo(String slug) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'slug', value: [slug]),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> slugNotEqualTo(String slug) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [],
                upper: [slug],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [slug],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [slug],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'slug',
                lower: [],
                upper: [slug],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> uniqNameEqualTo(
    String uniqName,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uniqName', value: [uniqName]),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> uniqNameNotEqualTo(
    String uniqName,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uniqName',
                lower: [],
                upper: [uniqName],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uniqName',
                lower: [uniqName],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uniqName',
                lower: [uniqName],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uniqName',
                lower: [],
                upper: [uniqName],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> levelEqualTo(int level) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'level', value: [level]),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> levelNotEqualTo(int level) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'level',
                lower: [],
                upper: [level],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'level',
                lower: [level],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'level',
                lower: [level],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'level',
                lower: [],
                upper: [level],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> levelGreaterThan(
    int level, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'level',
          lower: [level],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> levelLessThan(
    int level, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'level',
          lower: [],
          upper: [level],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> levelBetween(
    int lowerLevel,
    int upperLevel, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'level',
          lower: [lowerLevel],
          includeLower: includeLower,
          upper: [upperLevel],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension SprawQueryFilter on QueryBuilder<Spraw, Spraw, QFilterCondition> {
  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'comment'),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'comment'),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'comment',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'comment',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'comment',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'comment', value: ''),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'comment', value: ''),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> hiddenNamesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'hiddenNames',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition>
  hiddenNamesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'hiddenNames',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> hiddenNamesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'hiddenNames',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> hiddenNamesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'hiddenNames',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition>
  hiddenNamesElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'hiddenNames',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> hiddenNamesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'hiddenNames',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> hiddenNamesElementContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'hiddenNames',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> hiddenNamesElementMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'hiddenNames',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition>
  hiddenNamesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hiddenNames', value: ''),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition>
  hiddenNamesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'hiddenNames', value: ''),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> hiddenNamesLengthEqualTo(
    int length,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'hiddenNames', length, true, length, true);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> hiddenNamesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'hiddenNames', 0, true, 0, true);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> hiddenNamesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'hiddenNames', 0, false, 999999, true);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> hiddenNamesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'hiddenNames', 0, true, length, include);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition>
  hiddenNamesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'hiddenNames', length, include, 999999, true);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> hiddenNamesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hiddenNames',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> iconPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'iconPath'),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> iconPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'iconPath'),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> iconPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'iconPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> iconPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'iconPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> iconPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'iconPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> iconPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'iconPath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> iconPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'iconPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> iconPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'iconPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> iconPathContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'iconPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> iconPathMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'iconPath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> iconPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'iconPath', value: ''),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> iconPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'iconPath', value: ''),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> levelEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'level', value: value),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> levelGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'level',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> levelLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'level',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> levelBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'level',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> slugEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> slugGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> slugLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> slugBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'slug',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> slugStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> slugEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> slugContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'slug',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> slugMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'slug',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> slugIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'slug', value: ''),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> slugIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'slug', value: ''),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> tasksAreExamplesEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'tasksAreExamples', value: value),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> uniqNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'uniqName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> uniqNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'uniqName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> uniqNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'uniqName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> uniqNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'uniqName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> uniqNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'uniqName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> uniqNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'uniqName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> uniqNameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'uniqName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> uniqNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'uniqName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> uniqNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uniqName', value: ''),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> uniqNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'uniqName', value: ''),
      );
    });
  }
}

extension SprawQueryObject on QueryBuilder<Spraw, Spraw, QFilterCondition> {}

extension SprawQueryLinks on QueryBuilder<Spraw, Spraw, QFilterCondition> {
  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> family(
    FilterQuery<SprawFamily> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'family');
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> familyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'family', 0, true, 0, true);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> tasks(
    FilterQuery<SprawTask> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'tasks');
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> tasksLengthEqualTo(
    int length,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tasks', length, true, length, true);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> tasksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tasks', 0, true, 0, true);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> tasksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tasks', 0, false, 999999, true);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> tasksLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tasks', 0, true, length, include);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> tasksLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tasks', length, include, 999999, true);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> tasksLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
        r'tasks',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension SprawQuerySortBy on QueryBuilder<Spraw, Spraw, QSortBy> {
  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByComment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByCommentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.desc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByIconPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconPath', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByIconPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconPath', Sort.desc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.desc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortBySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortBySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.desc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByTasksAreExamples() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tasksAreExamples', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByTasksAreExamplesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tasksAreExamples', Sort.desc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByUniqName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uniqName', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByUniqNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uniqName', Sort.desc);
    });
  }
}

extension SprawQuerySortThenBy on QueryBuilder<Spraw, Spraw, QSortThenBy> {
  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByComment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByCommentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'comment', Sort.desc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByIconPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconPath', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByIconPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconPath', Sort.desc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.desc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenBySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenBySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.desc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByTasksAreExamples() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tasksAreExamples', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByTasksAreExamplesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tasksAreExamples', Sort.desc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByUniqName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uniqName', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByUniqNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uniqName', Sort.desc);
    });
  }
}

extension SprawQueryWhereDistinct on QueryBuilder<Spraw, Spraw, QDistinct> {
  QueryBuilder<Spraw, Spraw, QDistinct> distinctByComment({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'comment', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Spraw, Spraw, QDistinct> distinctByHiddenNames() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hiddenNames');
    });
  }

  QueryBuilder<Spraw, Spraw, QDistinct> distinctByIconPath({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Spraw, Spraw, QDistinct> distinctByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'level');
    });
  }

  QueryBuilder<Spraw, Spraw, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Spraw, Spraw, QDistinct> distinctBySlug({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'slug', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Spraw, Spraw, QDistinct> distinctByTasksAreExamples() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tasksAreExamples');
    });
  }

  QueryBuilder<Spraw, Spraw, QDistinct> distinctByUniqName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uniqName', caseSensitive: caseSensitive);
    });
  }
}

extension SprawQueryProperty on QueryBuilder<Spraw, Spraw, QQueryProperty> {
  QueryBuilder<Spraw, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Spraw, String?, QQueryOperations> commentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'comment');
    });
  }

  QueryBuilder<Spraw, List<String>, QQueryOperations> hiddenNamesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hiddenNames');
    });
  }

  QueryBuilder<Spraw, String?, QQueryOperations> iconPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconPath');
    });
  }

  QueryBuilder<Spraw, int, QQueryOperations> levelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'level');
    });
  }

  QueryBuilder<Spraw, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Spraw, String, QQueryOperations> slugProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'slug');
    });
  }

  QueryBuilder<Spraw, bool, QQueryOperations> tasksAreExamplesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tasksAreExamples');
    });
  }

  QueryBuilder<Spraw, String, QQueryOperations> uniqNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uniqName');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSprawTaskCollection on Isar {
  IsarCollection<SprawTask> get sprawTasks => this.collection();
}

const SprawTaskSchema = CollectionSchema(
  name: r'SprawTask',
  id: -6715861572136222227,
  properties: {
    r'index': PropertySchema(id: 0, name: r'index', type: IsarType.long),
    r'text': PropertySchema(id: 1, name: r'text', type: IsarType.string),
  },

  estimateSize: _sprawTaskEstimateSize,
  serialize: _sprawTaskSerialize,
  deserialize: _sprawTaskDeserialize,
  deserializeProp: _sprawTaskDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'spraw': LinkSchema(
      id: 3361889398247926251,
      name: r'spraw',
      target: r'Spraw',
      single: true,
    ),
  },
  embeddedSchemas: {},

  getId: _sprawTaskGetId,
  getLinks: _sprawTaskGetLinks,
  attach: _sprawTaskAttach,
  version: '3.3.0-dev.3',
);

int _sprawTaskEstimateSize(
  SprawTask object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _sprawTaskSerialize(
  SprawTask object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.index);
  writer.writeString(offsets[1], object.text);
}

SprawTask _sprawTaskDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SprawTask();
  object.id = id;
  object.index = reader.readLong(offsets[0]);
  object.text = reader.readString(offsets[1]);
  return object;
}

P _sprawTaskDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sprawTaskGetId(SprawTask object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sprawTaskGetLinks(SprawTask object) {
  return [object.spraw];
}

void _sprawTaskAttach(IsarCollection<dynamic> col, Id id, SprawTask object) {
  object.id = id;
  object.spraw.attach(col, col.isar.collection<Spraw>(), r'spraw', id);
}

extension SprawTaskQueryWhereSort
    on QueryBuilder<SprawTask, SprawTask, QWhere> {
  QueryBuilder<SprawTask, SprawTask, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SprawTaskQueryWhere
    on QueryBuilder<SprawTask, SprawTask, QWhereClause> {
  QueryBuilder<SprawTask, SprawTask, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension SprawTaskQueryFilter
    on QueryBuilder<SprawTask, SprawTask, QFilterCondition> {
  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> indexEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'index', value: value),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> indexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'index',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> indexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'index',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> indexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'index',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'text',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'text',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'text', value: ''),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'text', value: ''),
      );
    });
  }
}

extension SprawTaskQueryObject
    on QueryBuilder<SprawTask, SprawTask, QFilterCondition> {}

extension SprawTaskQueryLinks
    on QueryBuilder<SprawTask, SprawTask, QFilterCondition> {
  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> spraw(
    FilterQuery<Spraw> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'spraw');
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> sprawIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'spraw', 0, true, 0, true);
    });
  }
}

extension SprawTaskQuerySortBy on QueryBuilder<SprawTask, SprawTask, QSortBy> {
  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> sortByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.asc);
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> sortByIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.desc);
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension SprawTaskQuerySortThenBy
    on QueryBuilder<SprawTask, SprawTask, QSortThenBy> {
  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> thenByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.asc);
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> thenByIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'index', Sort.desc);
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension SprawTaskQueryWhereDistinct
    on QueryBuilder<SprawTask, SprawTask, QDistinct> {
  QueryBuilder<SprawTask, SprawTask, QDistinct> distinctByIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'index');
    });
  }

  QueryBuilder<SprawTask, SprawTask, QDistinct> distinctByText({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }
}

extension SprawTaskQueryProperty
    on QueryBuilder<SprawTask, SprawTask, QQueryProperty> {
  QueryBuilder<SprawTask, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SprawTask, int, QQueryOperations> indexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'index');
    });
  }

  QueryBuilder<SprawTask, String, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }
}
