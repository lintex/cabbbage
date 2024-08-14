// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marathon.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMarathonCollection on Isar {
  IsarCollection<Marathon> get marathons => this.collection();
}

const MarathonSchema = CollectionSchema(
  name: r'Marathon',
  id: 739929299284146862,
  properties: {
    r'bibNumber': PropertySchema(
      id: 0,
      name: r'bibNumber',
      type: IsarType.string,
    ),
    r'finish': PropertySchema(
      id: 1,
      name: r'finish',
      type: IsarType.string,
    ),
    r'hotel': PropertySchema(
      id: 2,
      name: r'hotel',
      type: IsarType.string,
    ),
    r'isChosen': PropertySchema(
      id: 3,
      name: r'isChosen',
      type: IsarType.byte,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'packet': PropertySchema(
      id: 5,
      name: r'packet',
      type: IsarType.string,
    ),
    r'start': PropertySchema(
      id: 6,
      name: r'start',
      type: IsarType.string,
    ),
    r'time': PropertySchema(
      id: 7,
      name: r'time',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _marathonEstimateSize,
  serialize: _marathonSerialize,
  deserialize: _marathonDeserialize,
  deserializeProp: _marathonDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _marathonGetId,
  getLinks: _marathonGetLinks,
  attach: _marathonAttach,
  version: '3.1.0+1',
);

int _marathonEstimateSize(
  Marathon object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.bibNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.finish;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.hotel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.packet;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.start;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _marathonSerialize(
  Marathon object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.bibNumber);
  writer.writeString(offsets[1], object.finish);
  writer.writeString(offsets[2], object.hotel);
  writer.writeByte(offsets[3], object.isChosen);
  writer.writeString(offsets[4], object.name);
  writer.writeString(offsets[5], object.packet);
  writer.writeString(offsets[6], object.start);
  writer.writeDateTime(offsets[7], object.time);
}

Marathon _marathonDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Marathon();
  object.bibNumber = reader.readStringOrNull(offsets[0]);
  object.finish = reader.readStringOrNull(offsets[1]);
  object.hotel = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.isChosen = reader.readByte(offsets[3]);
  object.name = reader.readString(offsets[4]);
  object.packet = reader.readStringOrNull(offsets[5]);
  object.start = reader.readStringOrNull(offsets[6]);
  object.time = reader.readDateTimeOrNull(offsets[7]);
  return object;
}

P _marathonDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readByte(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _marathonGetId(Marathon object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _marathonGetLinks(Marathon object) {
  return [];
}

void _marathonAttach(IsarCollection<dynamic> col, Id id, Marathon object) {
  object.id = id;
}

extension MarathonQueryWhereSort on QueryBuilder<Marathon, Marathon, QWhere> {
  QueryBuilder<Marathon, Marathon, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MarathonQueryWhere on QueryBuilder<Marathon, Marathon, QWhereClause> {
  QueryBuilder<Marathon, Marathon, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Marathon, Marathon, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MarathonQueryFilter
    on QueryBuilder<Marathon, Marathon, QFilterCondition> {
  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> bibNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bibNumber',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> bibNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bibNumber',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> bibNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bibNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> bibNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bibNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> bibNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bibNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> bibNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bibNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> bibNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bibNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> bibNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bibNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> bibNumberContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bibNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> bibNumberMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bibNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> bibNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bibNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition>
      bibNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bibNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> finishIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'finish',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> finishIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'finish',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> finishEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> finishGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'finish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> finishLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'finish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> finishBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'finish',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> finishStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'finish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> finishEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'finish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> finishContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'finish',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> finishMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'finish',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> finishIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finish',
        value: '',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> finishIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'finish',
        value: '',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> hotelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hotel',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> hotelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hotel',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> hotelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hotel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> hotelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hotel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> hotelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hotel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> hotelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hotel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> hotelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hotel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> hotelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hotel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> hotelContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hotel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> hotelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hotel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> hotelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hotel',
        value: '',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> hotelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hotel',
        value: '',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> isChosenEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isChosen',
        value: value,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> isChosenGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isChosen',
        value: value,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> isChosenLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isChosen',
        value: value,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> isChosenBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isChosen',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> packetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'packet',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> packetIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'packet',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> packetEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'packet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> packetGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'packet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> packetLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'packet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> packetBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'packet',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> packetStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'packet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> packetEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'packet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> packetContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'packet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> packetMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'packet',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> packetIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'packet',
        value: '',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> packetIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'packet',
        value: '',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> startIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'start',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> startIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'start',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> startEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'start',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> startGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'start',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> startLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'start',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> startBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'start',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> startStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'start',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> startEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'start',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> startContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'start',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> startMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'start',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> startIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'start',
        value: '',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> startIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'start',
        value: '',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> timeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'time',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> timeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'time',
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> timeEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> timeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> timeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterFilterCondition> timeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'time',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MarathonQueryObject
    on QueryBuilder<Marathon, Marathon, QFilterCondition> {}

extension MarathonQueryLinks
    on QueryBuilder<Marathon, Marathon, QFilterCondition> {}

extension MarathonQuerySortBy on QueryBuilder<Marathon, Marathon, QSortBy> {
  QueryBuilder<Marathon, Marathon, QAfterSortBy> sortByBibNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bibNumber', Sort.asc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> sortByBibNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bibNumber', Sort.desc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> sortByFinish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finish', Sort.asc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> sortByFinishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finish', Sort.desc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> sortByHotel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hotel', Sort.asc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> sortByHotelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hotel', Sort.desc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> sortByIsChosen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isChosen', Sort.asc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> sortByIsChosenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isChosen', Sort.desc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> sortByPacket() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packet', Sort.asc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> sortByPacketDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packet', Sort.desc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> sortByStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start', Sort.asc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> sortByStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start', Sort.desc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> sortByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> sortByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }
}

extension MarathonQuerySortThenBy
    on QueryBuilder<Marathon, Marathon, QSortThenBy> {
  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenByBibNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bibNumber', Sort.asc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenByBibNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bibNumber', Sort.desc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenByFinish() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finish', Sort.asc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenByFinishDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finish', Sort.desc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenByHotel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hotel', Sort.asc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenByHotelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hotel', Sort.desc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenByIsChosen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isChosen', Sort.asc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenByIsChosenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isChosen', Sort.desc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenByPacket() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packet', Sort.asc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenByPacketDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packet', Sort.desc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenByStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start', Sort.asc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenByStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'start', Sort.desc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.asc);
    });
  }

  QueryBuilder<Marathon, Marathon, QAfterSortBy> thenByTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'time', Sort.desc);
    });
  }
}

extension MarathonQueryWhereDistinct
    on QueryBuilder<Marathon, Marathon, QDistinct> {
  QueryBuilder<Marathon, Marathon, QDistinct> distinctByBibNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bibNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Marathon, Marathon, QDistinct> distinctByFinish(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'finish', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Marathon, Marathon, QDistinct> distinctByHotel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hotel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Marathon, Marathon, QDistinct> distinctByIsChosen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isChosen');
    });
  }

  QueryBuilder<Marathon, Marathon, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Marathon, Marathon, QDistinct> distinctByPacket(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'packet', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Marathon, Marathon, QDistinct> distinctByStart(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'start', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Marathon, Marathon, QDistinct> distinctByTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'time');
    });
  }
}

extension MarathonQueryProperty
    on QueryBuilder<Marathon, Marathon, QQueryProperty> {
  QueryBuilder<Marathon, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Marathon, String?, QQueryOperations> bibNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bibNumber');
    });
  }

  QueryBuilder<Marathon, String?, QQueryOperations> finishProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'finish');
    });
  }

  QueryBuilder<Marathon, String?, QQueryOperations> hotelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hotel');
    });
  }

  QueryBuilder<Marathon, int, QQueryOperations> isChosenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isChosen');
    });
  }

  QueryBuilder<Marathon, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Marathon, String?, QQueryOperations> packetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'packet');
    });
  }

  QueryBuilder<Marathon, String?, QQueryOperations> startProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'start');
    });
  }

  QueryBuilder<Marathon, DateTime?, QQueryOperations> timeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'time');
    });
  }
}
