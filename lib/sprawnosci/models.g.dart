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
    r'iconsMonochrome': PropertySchema(
      id: 1,
      name: r'iconsMonochrome',
      type: IsarType.bool,
    ),
    r'male': PropertySchema(id: 2, name: r'male', type: IsarType.bool),
    r'name': PropertySchema(id: 3, name: r'name', type: IsarType.string),
    r'slug': PropertySchema(id: 4, name: r'slug', type: IsarType.string),
    r'source': PropertySchema(id: 5, name: r'source', type: IsarType.string),
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
  version: '3.3.0',
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
  writer.writeBool(offsets[1], object.iconsMonochrome);
  writer.writeBool(offsets[2], object.male);
  writer.writeString(offsets[3], object.name);
  writer.writeString(offsets[4], object.slug);
  writer.writeString(offsets[5], object.source);
}

SprawBook _sprawBookDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SprawBook();
  object.female = reader.readBool(offsets[0]);
  object.iconsMonochrome = reader.readBoolOrNull(offsets[1]);
  object.id = id;
  object.male = reader.readBool(offsets[2]);
  object.name = reader.readString(offsets[3]);
  object.slug = reader.readString(offsets[4]);
  object.source = reader.readStringOrNull(offsets[5]);
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
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
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

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition>
  iconsMonochromeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'iconsMonochrome'),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition>
  iconsMonochromeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'iconsMonochrome'),
      );
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterFilterCondition>
  iconsMonochromeEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'iconsMonochrome', value: value),
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

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> sortByIconsMonochrome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconsMonochrome', Sort.asc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> sortByIconsMonochromeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconsMonochrome', Sort.desc);
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

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> thenByIconsMonochrome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconsMonochrome', Sort.asc);
    });
  }

  QueryBuilder<SprawBook, SprawBook, QAfterSortBy> thenByIconsMonochromeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconsMonochrome', Sort.desc);
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

  QueryBuilder<SprawBook, SprawBook, QDistinct> distinctByIconsMonochrome() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconsMonochrome');
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

  QueryBuilder<SprawBook, bool?, QQueryOperations> iconsMonochromeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconsMonochrome');
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
    r'iconsMonochrome': PropertySchema(
      id: 1,
      name: r'iconsMonochrome',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(id: 2, name: r'name', type: IsarType.string),
    r'slug': PropertySchema(id: 3, name: r'slug', type: IsarType.string),
    r'sortIndex': PropertySchema(
      id: 4,
      name: r'sortIndex',
      type: IsarType.long,
    ),
    r'tags': PropertySchema(id: 5, name: r'tags', type: IsarType.stringList),
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
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'slug',
          type: IndexType.hash,
          caseSensitive: false,
        ),
      ],
    ),
    r'sortIndex': IndexSchema(
      id: -1914576846740722168,
      name: r'sortIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'sortIndex',
          type: IndexType.value,
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
  version: '3.3.0',
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
  writer.writeBool(offsets[1], object.iconsMonochrome);
  writer.writeString(offsets[2], object.name);
  writer.writeString(offsets[3], object.slug);
  writer.writeLong(offsets[4], object.sortIndex);
  writer.writeStringList(offsets[5], object.tags);
}

SprawGroup _sprawGroupDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SprawGroup();
  object.description = reader.readStringOrNull(offsets[0]);
  object.iconsMonochrome = reader.readBoolOrNull(offsets[1]);
  object.id = id;
  object.name = reader.readString(offsets[2]);
  object.slug = reader.readString(offsets[3]);
  object.sortIndex = reader.readLong(offsets[4]);
  object.tags = reader.readStringList(offsets[5]) ?? [];
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
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
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

extension SprawGroupQueryWhereSort
    on QueryBuilder<SprawGroup, SprawGroup, QWhere> {
  QueryBuilder<SprawGroup, SprawGroup, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterWhere> anySortIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'sortIndex'),
      );
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

  QueryBuilder<SprawGroup, SprawGroup, QAfterWhereClause> sortIndexEqualTo(
    int sortIndex,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'sortIndex', value: [sortIndex]),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterWhereClause> sortIndexNotEqualTo(
    int sortIndex,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sortIndex',
                lower: [],
                upper: [sortIndex],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sortIndex',
                lower: [sortIndex],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sortIndex',
                lower: [sortIndex],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sortIndex',
                lower: [],
                upper: [sortIndex],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterWhereClause> sortIndexGreaterThan(
    int sortIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'sortIndex',
          lower: [sortIndex],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterWhereClause> sortIndexLessThan(
    int sortIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'sortIndex',
          lower: [],
          upper: [sortIndex],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterWhereClause> sortIndexBetween(
    int lowerSortIndex,
    int upperSortIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'sortIndex',
          lower: [lowerSortIndex],
          includeLower: includeLower,
          upper: [upperSortIndex],
          includeUpper: includeUpper,
        ),
      );
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

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  iconsMonochromeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'iconsMonochrome'),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  iconsMonochromeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'iconsMonochrome'),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  iconsMonochromeEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'iconsMonochrome', value: value),
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

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> sortIndexEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sortIndex', value: value),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition>
  sortIndexGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sortIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> sortIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sortIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterFilterCondition> sortIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sortIndex',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
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

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> sortByIconsMonochrome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconsMonochrome', Sort.asc);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy>
  sortByIconsMonochromeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconsMonochrome', Sort.desc);
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

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> sortBySortIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortIndex', Sort.asc);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> sortBySortIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortIndex', Sort.desc);
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

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> thenByIconsMonochrome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconsMonochrome', Sort.asc);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy>
  thenByIconsMonochromeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconsMonochrome', Sort.desc);
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

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> thenBySortIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortIndex', Sort.asc);
    });
  }

  QueryBuilder<SprawGroup, SprawGroup, QAfterSortBy> thenBySortIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortIndex', Sort.desc);
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

  QueryBuilder<SprawGroup, SprawGroup, QDistinct> distinctByIconsMonochrome() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconsMonochrome');
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

  QueryBuilder<SprawGroup, SprawGroup, QDistinct> distinctBySortIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sortIndex');
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

  QueryBuilder<SprawGroup, bool?, QQueryOperations> iconsMonochromeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconsMonochrome');
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

  QueryBuilder<SprawGroup, int, QQueryOperations> sortIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sortIndex');
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
    r'iconsMonochrome': PropertySchema(
      id: 2,
      name: r'iconsMonochrome',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(id: 3, name: r'name', type: IsarType.string),
    r'notesForLeaders': PropertySchema(
      id: 4,
      name: r'notesForLeaders',
      type: IsarType.stringList,
    ),
    r'requirements': PropertySchema(
      id: 5,
      name: r'requirements',
      type: IsarType.stringList,
    ),
    r'slug': PropertySchema(id: 6, name: r'slug', type: IsarType.string),
    r'sortIndex': PropertySchema(
      id: 7,
      name: r'sortIndex',
      type: IsarType.long,
    ),
    r'tags': PropertySchema(id: 8, name: r'tags', type: IsarType.stringList),
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
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'slug',
          type: IndexType.hash,
          caseSensitive: false,
        ),
      ],
    ),
    r'sortIndex': IndexSchema(
      id: -1914576846740722168,
      name: r'sortIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'sortIndex',
          type: IndexType.value,
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
  version: '3.3.0',
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
  writer.writeBool(offsets[2], object.iconsMonochrome);
  writer.writeString(offsets[3], object.name);
  writer.writeStringList(offsets[4], object.notesForLeaders);
  writer.writeStringList(offsets[5], object.requirements);
  writer.writeString(offsets[6], object.slug);
  writer.writeLong(offsets[7], object.sortIndex);
  writer.writeStringList(offsets[8], object.tags);
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
  object.iconsMonochrome = reader.readBoolOrNull(offsets[2]);
  object.id = id;
  object.name = reader.readString(offsets[3]);
  object.notesForLeaders = reader.readStringList(offsets[4]) ?? [];
  object.requirements = reader.readStringList(offsets[5]) ?? [];
  object.slug = reader.readString(offsets[6]);
  object.sortIndex = reader.readLong(offsets[7]);
  object.tags = reader.readStringList(offsets[8]) ?? [];
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
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringList(offset) ?? []) as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
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

extension SprawFamilyQueryWhereSort
    on QueryBuilder<SprawFamily, SprawFamily, QWhere> {
  QueryBuilder<SprawFamily, SprawFamily, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterWhere> anySortIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'sortIndex'),
      );
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

  QueryBuilder<SprawFamily, SprawFamily, QAfterWhereClause> sortIndexEqualTo(
    int sortIndex,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'sortIndex', value: [sortIndex]),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterWhereClause> sortIndexNotEqualTo(
    int sortIndex,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sortIndex',
                lower: [],
                upper: [sortIndex],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sortIndex',
                lower: [sortIndex],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sortIndex',
                lower: [sortIndex],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sortIndex',
                lower: [],
                upper: [sortIndex],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterWhereClause>
  sortIndexGreaterThan(int sortIndex, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'sortIndex',
          lower: [sortIndex],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterWhereClause> sortIndexLessThan(
    int sortIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'sortIndex',
          lower: [],
          upper: [sortIndex],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterWhereClause> sortIndexBetween(
    int lowerSortIndex,
    int upperSortIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'sortIndex',
          lower: [lowerSortIndex],
          includeLower: includeLower,
          upper: [upperSortIndex],
          includeUpper: includeUpper,
        ),
      );
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

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  iconsMonochromeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'iconsMonochrome'),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  iconsMonochromeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'iconsMonochrome'),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  iconsMonochromeEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'iconsMonochrome', value: value),
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
  sortIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sortIndex', value: value),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  sortIndexGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sortIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  sortIndexLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sortIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterFilterCondition>
  sortIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sortIndex',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
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

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> sortByIconsMonochrome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconsMonochrome', Sort.asc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy>
  sortByIconsMonochromeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconsMonochrome', Sort.desc);
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

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> sortBySortIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortIndex', Sort.asc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> sortBySortIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortIndex', Sort.desc);
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

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> thenByIconsMonochrome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconsMonochrome', Sort.asc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy>
  thenByIconsMonochromeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconsMonochrome', Sort.desc);
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

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> thenBySortIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortIndex', Sort.asc);
    });
  }

  QueryBuilder<SprawFamily, SprawFamily, QAfterSortBy> thenBySortIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortIndex', Sort.desc);
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

  QueryBuilder<SprawFamily, SprawFamily, QDistinct>
  distinctByIconsMonochrome() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconsMonochrome');
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

  QueryBuilder<SprawFamily, SprawFamily, QDistinct> distinctBySortIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sortIndex');
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

  QueryBuilder<SprawFamily, bool?, QQueryOperations> iconsMonochromeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconsMonochrome');
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

  QueryBuilder<SprawFamily, int, QQueryOperations> sortIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sortIndex');
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
    r'commentRaw': PropertySchema(
      id: 1,
      name: r'commentRaw',
      type: IsarType.string,
    ),
    r'hiddenNames': PropertySchema(
      id: 2,
      name: r'hiddenNames',
      type: IsarType.stringList,
    ),
    r'hiddenNamesRaw': PropertySchema(
      id: 3,
      name: r'hiddenNamesRaw',
      type: IsarType.stringList,
    ),
    r'iconMonochrome': PropertySchema(
      id: 4,
      name: r'iconMonochrome',
      type: IsarType.bool,
    ),
    r'iconPath': PropertySchema(
      id: 5,
      name: r'iconPath',
      type: IsarType.string,
    ),
    r'level': PropertySchema(id: 6, name: r'level', type: IsarType.long),
    r'name': PropertySchema(id: 7, name: r'name', type: IsarType.string),
    r'nameRaw': PropertySchema(id: 8, name: r'nameRaw', type: IsarType.string),
    r'slug': PropertySchema(id: 9, name: r'slug', type: IsarType.string),
    r'sortIndex': PropertySchema(
      id: 10,
      name: r'sortIndex',
      type: IsarType.long,
    ),
    r'tasksAreExamples': PropertySchema(
      id: 11,
      name: r'tasksAreExamples',
      type: IsarType.bool,
    ),
    r'uniqName': PropertySchema(
      id: 12,
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
      unique: false,
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
    r'sortIndex': IndexSchema(
      id: -1914576846740722168,
      name: r'sortIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'sortIndex',
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
    r'external': LinkSchema(
      id: 130598467585445867,
      name: r'external',
      target: r'SprawExternal',
      single: true,
    ),
  },
  embeddedSchemas: {},

  getId: _sprawGetId,
  getLinks: _sprawGetLinks,
  attach: _sprawAttach,
  version: '3.3.0',
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
  {
    final value = object.commentRaw;
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
  bytesCount += 3 + object.hiddenNamesRaw.length * 3;
  {
    for (var i = 0; i < object.hiddenNamesRaw.length; i++) {
      final value = object.hiddenNamesRaw[i];
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
  bytesCount += 3 + object.nameRaw.length * 3;
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
  writer.writeString(offsets[1], object.commentRaw);
  writer.writeStringList(offsets[2], object.hiddenNames);
  writer.writeStringList(offsets[3], object.hiddenNamesRaw);
  writer.writeBool(offsets[4], object.iconMonochrome);
  writer.writeString(offsets[5], object.iconPath);
  writer.writeLong(offsets[6], object.level);
  writer.writeString(offsets[7], object.name);
  writer.writeString(offsets[8], object.nameRaw);
  writer.writeString(offsets[9], object.slug);
  writer.writeLong(offsets[10], object.sortIndex);
  writer.writeBool(offsets[11], object.tasksAreExamples);
  writer.writeString(offsets[12], object.uniqName);
}

Spraw _sprawDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Spraw();
  object.comment = reader.readStringOrNull(offsets[0]);
  object.commentRaw = reader.readStringOrNull(offsets[1]);
  object.hiddenNames = reader.readStringList(offsets[2]) ?? [];
  object.hiddenNamesRaw = reader.readStringList(offsets[3]) ?? [];
  object.iconMonochrome = reader.readBool(offsets[4]);
  object.iconPath = reader.readStringOrNull(offsets[5]);
  object.id = id;
  object.level = reader.readLong(offsets[6]);
  object.name = reader.readString(offsets[7]);
  object.nameRaw = reader.readString(offsets[8]);
  object.slug = reader.readString(offsets[9]);
  object.sortIndex = reader.readLong(offsets[10]);
  object.tasksAreExamples = reader.readBool(offsets[11]);
  object.uniqName = reader.readString(offsets[12]);
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
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringList(offset) ?? []) as P;
    case 3:
      return (reader.readStringList(offset) ?? []) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sprawGetId(Spraw object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sprawGetLinks(Spraw object) {
  return [object.family, object.tasks, object.external];
}

void _sprawAttach(IsarCollection<dynamic> col, Id id, Spraw object) {
  object.id = id;
  object.family.attach(col, col.isar.collection<SprawFamily>(), r'family', id);
  object.tasks.attach(col, col.isar.collection<SprawTask>(), r'tasks', id);
  object.external.attach(
    col,
    col.isar.collection<SprawExternal>(),
    r'external',
    id,
  );
}

extension SprawByIndex on IsarCollection<Spraw> {
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

  QueryBuilder<Spraw, Spraw, QAfterWhere> anySortIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'sortIndex'),
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

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> sortIndexEqualTo(
    int sortIndex,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'sortIndex', value: [sortIndex]),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> sortIndexNotEqualTo(
    int sortIndex,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sortIndex',
                lower: [],
                upper: [sortIndex],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sortIndex',
                lower: [sortIndex],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sortIndex',
                lower: [sortIndex],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'sortIndex',
                lower: [],
                upper: [sortIndex],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> sortIndexGreaterThan(
    int sortIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'sortIndex',
          lower: [sortIndex],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> sortIndexLessThan(
    int sortIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'sortIndex',
          lower: [],
          upper: [sortIndex],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterWhereClause> sortIndexBetween(
    int lowerSortIndex,
    int upperSortIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'sortIndex',
          lower: [lowerSortIndex],
          includeLower: includeLower,
          upper: [upperSortIndex],
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

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentRawIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'commentRaw'),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentRawIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'commentRaw'),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentRawEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'commentRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentRawGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'commentRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentRawLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'commentRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentRawBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'commentRaw',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentRawStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'commentRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentRawEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'commentRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentRawContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'commentRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentRawMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'commentRaw',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentRawIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'commentRaw', value: ''),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> commentRawIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'commentRaw', value: ''),
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

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition>
  hiddenNamesRawElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'hiddenNamesRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition>
  hiddenNamesRawElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'hiddenNamesRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition>
  hiddenNamesRawElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'hiddenNamesRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition>
  hiddenNamesRawElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'hiddenNamesRaw',
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
  hiddenNamesRawElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'hiddenNamesRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition>
  hiddenNamesRawElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'hiddenNamesRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition>
  hiddenNamesRawElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'hiddenNamesRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition>
  hiddenNamesRawElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'hiddenNamesRaw',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition>
  hiddenNamesRawElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hiddenNamesRaw', value: ''),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition>
  hiddenNamesRawElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'hiddenNamesRaw', value: ''),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> hiddenNamesRawLengthEqualTo(
    int length,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'hiddenNamesRaw', length, true, length, true);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> hiddenNamesRawIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'hiddenNamesRaw', 0, true, 0, true);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> hiddenNamesRawIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'hiddenNamesRaw', 0, false, 999999, true);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition>
  hiddenNamesRawLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'hiddenNamesRaw', 0, true, length, include);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition>
  hiddenNamesRawLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'hiddenNamesRaw', length, include, 999999, true);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> hiddenNamesRawLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'hiddenNamesRaw',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> iconMonochromeEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'iconMonochrome', value: value),
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

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameRawEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'nameRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameRawGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'nameRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameRawLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'nameRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameRawBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'nameRaw',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameRawStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'nameRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameRawEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'nameRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameRawContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'nameRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameRawMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'nameRaw',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameRawIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nameRaw', value: ''),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> nameRawIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nameRaw', value: ''),
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

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> sortIndexEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sortIndex', value: value),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> sortIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sortIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> sortIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sortIndex',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> sortIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sortIndex',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
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

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> external(
    FilterQuery<SprawExternal> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'external');
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterFilterCondition> externalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'external', 0, true, 0, true);
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

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByCommentRaw() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commentRaw', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByCommentRawDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commentRaw', Sort.desc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByIconMonochrome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconMonochrome', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByIconMonochromeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconMonochrome', Sort.desc);
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

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByNameRaw() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameRaw', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortByNameRawDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameRaw', Sort.desc);
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

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortBySortIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortIndex', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> sortBySortIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortIndex', Sort.desc);
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

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByCommentRaw() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commentRaw', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByCommentRawDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'commentRaw', Sort.desc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByIconMonochrome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconMonochrome', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByIconMonochromeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconMonochrome', Sort.desc);
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

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByNameRaw() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameRaw', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenByNameRawDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nameRaw', Sort.desc);
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

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenBySortIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortIndex', Sort.asc);
    });
  }

  QueryBuilder<Spraw, Spraw, QAfterSortBy> thenBySortIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortIndex', Sort.desc);
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

  QueryBuilder<Spraw, Spraw, QDistinct> distinctByCommentRaw({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'commentRaw', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Spraw, Spraw, QDistinct> distinctByHiddenNames() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hiddenNames');
    });
  }

  QueryBuilder<Spraw, Spraw, QDistinct> distinctByHiddenNamesRaw() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hiddenNamesRaw');
    });
  }

  QueryBuilder<Spraw, Spraw, QDistinct> distinctByIconMonochrome() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconMonochrome');
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

  QueryBuilder<Spraw, Spraw, QDistinct> distinctByNameRaw({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameRaw', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Spraw, Spraw, QDistinct> distinctBySlug({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'slug', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Spraw, Spraw, QDistinct> distinctBySortIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sortIndex');
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

  QueryBuilder<Spraw, String?, QQueryOperations> commentRawProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'commentRaw');
    });
  }

  QueryBuilder<Spraw, List<String>, QQueryOperations> hiddenNamesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hiddenNames');
    });
  }

  QueryBuilder<Spraw, List<String>, QQueryOperations> hiddenNamesRawProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hiddenNamesRaw');
    });
  }

  QueryBuilder<Spraw, bool, QQueryOperations> iconMonochromeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconMonochrome');
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

  QueryBuilder<Spraw, String, QQueryOperations> nameRawProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameRaw');
    });
  }

  QueryBuilder<Spraw, String, QQueryOperations> slugProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'slug');
    });
  }

  QueryBuilder<Spraw, int, QQueryOperations> sortIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sortIndex');
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

extension GetSprawExternalCollection on Isar {
  IsarCollection<SprawExternal> get sprawExternals => this.collection();
}

const SprawExternalSchema = CollectionSchema(
  name: r'SprawExternal',
  id: 8775235713977027227,
  properties: {
    r'yamlContent': PropertySchema(
      id: 0,
      name: r'yamlContent',
      type: IsarType.string,
    ),
  },

  estimateSize: _sprawExternalEstimateSize,
  serialize: _sprawExternalSerialize,
  deserialize: _sprawExternalDeserialize,
  deserializeProp: _sprawExternalDeserializeProp,
  idName: r'id',
  indexes: {
    r'yamlContent': IndexSchema(
      id: 5112290567786559776,
      name: r'yamlContent',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'yamlContent',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {
    r'spraw': LinkSchema(
      id: 49874618957920855,
      name: r'spraw',
      target: r'Spraw',
      single: true,
    ),
  },
  embeddedSchemas: {},

  getId: _sprawExternalGetId,
  getLinks: _sprawExternalGetLinks,
  attach: _sprawExternalAttach,
  version: '3.3.0',
);

int _sprawExternalEstimateSize(
  SprawExternal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.yamlContent.length * 3;
  return bytesCount;
}

void _sprawExternalSerialize(
  SprawExternal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.yamlContent);
}

SprawExternal _sprawExternalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SprawExternal();
  object.id = id;
  object.yamlContent = reader.readString(offsets[0]);
  return object;
}

P _sprawExternalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sprawExternalGetId(SprawExternal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sprawExternalGetLinks(SprawExternal object) {
  return [object.spraw];
}

void _sprawExternalAttach(
  IsarCollection<dynamic> col,
  Id id,
  SprawExternal object,
) {
  object.id = id;
  object.spraw.attach(col, col.isar.collection<Spraw>(), r'spraw', id);
}

extension SprawExternalQueryWhereSort
    on QueryBuilder<SprawExternal, SprawExternal, QWhere> {
  QueryBuilder<SprawExternal, SprawExternal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SprawExternalQueryWhere
    on QueryBuilder<SprawExternal, SprawExternal, QWhereClause> {
  QueryBuilder<SprawExternal, SprawExternal, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<SprawExternal, SprawExternal, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterWhereClause> idBetween(
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

  QueryBuilder<SprawExternal, SprawExternal, QAfterWhereClause>
  yamlContentEqualTo(String yamlContent) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'yamlContent',
          value: [yamlContent],
        ),
      );
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterWhereClause>
  yamlContentNotEqualTo(String yamlContent) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'yamlContent',
                lower: [],
                upper: [yamlContent],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'yamlContent',
                lower: [yamlContent],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'yamlContent',
                lower: [yamlContent],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'yamlContent',
                lower: [],
                upper: [yamlContent],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension SprawExternalQueryFilter
    on QueryBuilder<SprawExternal, SprawExternal, QFilterCondition> {
  QueryBuilder<SprawExternal, SprawExternal, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
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

  QueryBuilder<SprawExternal, SprawExternal, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SprawExternal, SprawExternal, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SprawExternal, SprawExternal, QAfterFilterCondition>
  yamlContentEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'yamlContent',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterFilterCondition>
  yamlContentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'yamlContent',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterFilterCondition>
  yamlContentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'yamlContent',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterFilterCondition>
  yamlContentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'yamlContent',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterFilterCondition>
  yamlContentStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'yamlContent',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterFilterCondition>
  yamlContentEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'yamlContent',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterFilterCondition>
  yamlContentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'yamlContent',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterFilterCondition>
  yamlContentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'yamlContent',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterFilterCondition>
  yamlContentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'yamlContent', value: ''),
      );
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterFilterCondition>
  yamlContentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'yamlContent', value: ''),
      );
    });
  }
}

extension SprawExternalQueryObject
    on QueryBuilder<SprawExternal, SprawExternal, QFilterCondition> {}

extension SprawExternalQueryLinks
    on QueryBuilder<SprawExternal, SprawExternal, QFilterCondition> {
  QueryBuilder<SprawExternal, SprawExternal, QAfterFilterCondition> spraw(
    FilterQuery<Spraw> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'spraw');
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterFilterCondition>
  sprawIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'spraw', 0, true, 0, true);
    });
  }
}

extension SprawExternalQuerySortBy
    on QueryBuilder<SprawExternal, SprawExternal, QSortBy> {
  QueryBuilder<SprawExternal, SprawExternal, QAfterSortBy> sortByYamlContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yamlContent', Sort.asc);
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterSortBy>
  sortByYamlContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yamlContent', Sort.desc);
    });
  }
}

extension SprawExternalQuerySortThenBy
    on QueryBuilder<SprawExternal, SprawExternal, QSortThenBy> {
  QueryBuilder<SprawExternal, SprawExternal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterSortBy> thenByYamlContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yamlContent', Sort.asc);
    });
  }

  QueryBuilder<SprawExternal, SprawExternal, QAfterSortBy>
  thenByYamlContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yamlContent', Sort.desc);
    });
  }
}

extension SprawExternalQueryWhereDistinct
    on QueryBuilder<SprawExternal, SprawExternal, QDistinct> {
  QueryBuilder<SprawExternal, SprawExternal, QDistinct> distinctByYamlContent({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'yamlContent', caseSensitive: caseSensitive);
    });
  }
}

extension SprawExternalQueryProperty
    on QueryBuilder<SprawExternal, SprawExternal, QQueryProperty> {
  QueryBuilder<SprawExternal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SprawExternal, String, QQueryOperations> yamlContentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'yamlContent');
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
    r'textRaw': PropertySchema(id: 2, name: r'textRaw', type: IsarType.string),
    r'uniqName': PropertySchema(
      id: 3,
      name: r'uniqName',
      type: IsarType.string,
    ),
  },

  estimateSize: _sprawTaskEstimateSize,
  serialize: _sprawTaskSerialize,
  deserialize: _sprawTaskDeserialize,
  deserializeProp: _sprawTaskDeserializeProp,
  idName: r'id',
  indexes: {
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
  },
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
  version: '3.3.0',
);

int _sprawTaskEstimateSize(
  SprawTask object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.text.length * 3;
  bytesCount += 3 + object.textRaw.length * 3;
  bytesCount += 3 + object.uniqName.length * 3;
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
  writer.writeString(offsets[2], object.textRaw);
  writer.writeString(offsets[3], object.uniqName);
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
  object.textRaw = reader.readString(offsets[2]);
  object.uniqName = reader.readString(offsets[3]);
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
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
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

extension SprawTaskByIndex on IsarCollection<SprawTask> {
  Future<SprawTask?> getByUniqName(String uniqName) {
    return getByIndex(r'uniqName', [uniqName]);
  }

  SprawTask? getByUniqNameSync(String uniqName) {
    return getByIndexSync(r'uniqName', [uniqName]);
  }

  Future<bool> deleteByUniqName(String uniqName) {
    return deleteByIndex(r'uniqName', [uniqName]);
  }

  bool deleteByUniqNameSync(String uniqName) {
    return deleteByIndexSync(r'uniqName', [uniqName]);
  }

  Future<List<SprawTask?>> getAllByUniqName(List<String> uniqNameValues) {
    final values = uniqNameValues.map((e) => [e]).toList();
    return getAllByIndex(r'uniqName', values);
  }

  List<SprawTask?> getAllByUniqNameSync(List<String> uniqNameValues) {
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

  Future<Id> putByUniqName(SprawTask object) {
    return putByIndex(r'uniqName', object);
  }

  Id putByUniqNameSync(SprawTask object, {bool saveLinks = true}) {
    return putByIndexSync(r'uniqName', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUniqName(List<SprawTask> objects) {
    return putAllByIndex(r'uniqName', objects);
  }

  List<Id> putAllByUniqNameSync(
    List<SprawTask> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'uniqName', objects, saveLinks: saveLinks);
  }
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

  QueryBuilder<SprawTask, SprawTask, QAfterWhereClause> uniqNameEqualTo(
    String uniqName,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uniqName', value: [uniqName]),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterWhereClause> uniqNameNotEqualTo(
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

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textRawEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'textRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textRawGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'textRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textRawLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'textRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textRawBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'textRaw',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textRawStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'textRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textRawEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'textRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textRawContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'textRaw',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textRawMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'textRaw',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> textRawIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'textRaw', value: ''),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition>
  textRawIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'textRaw', value: ''),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> uniqNameEqualTo(
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

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> uniqNameGreaterThan(
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

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> uniqNameLessThan(
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

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> uniqNameBetween(
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

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> uniqNameStartsWith(
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

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> uniqNameEndsWith(
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

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> uniqNameContains(
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

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> uniqNameMatches(
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

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition> uniqNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uniqName', value: ''),
      );
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterFilterCondition>
  uniqNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'uniqName', value: ''),
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

  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> sortByTextRaw() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textRaw', Sort.asc);
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> sortByTextRawDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textRaw', Sort.desc);
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> sortByUniqName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uniqName', Sort.asc);
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> sortByUniqNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uniqName', Sort.desc);
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

  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> thenByTextRaw() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textRaw', Sort.asc);
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> thenByTextRawDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textRaw', Sort.desc);
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> thenByUniqName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uniqName', Sort.asc);
    });
  }

  QueryBuilder<SprawTask, SprawTask, QAfterSortBy> thenByUniqNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uniqName', Sort.desc);
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

  QueryBuilder<SprawTask, SprawTask, QDistinct> distinctByTextRaw({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textRaw', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SprawTask, SprawTask, QDistinct> distinctByUniqName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uniqName', caseSensitive: caseSensitive);
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

  QueryBuilder<SprawTask, String, QQueryOperations> textRawProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textRaw');
    });
  }

  QueryBuilder<SprawTask, String, QQueryOperations> uniqNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uniqName');
    });
  }
}
