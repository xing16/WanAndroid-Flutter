// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_points.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPoints _$MyPointsFromJson(Map<String, dynamic> json) {
  return MyPoints(
    json['curPage'] as int,
    (json['datas'] as List)
        ?.map((e) =>
            e == null ? null : UserPoints.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['offset'] as int,
    json['over'] as bool,
    json['pageCount'] as int,
    json['size'] as int,
    json['total'] as int,
  );
}

Map<String, dynamic> _$MyPointsToJson(MyPoints instance) => <String, dynamic>{
      'curPage': instance.curPage,
      'datas': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total,
    };

UserPoints _$UserPointsFromJson(Map<String, dynamic> json) {
  return UserPoints(
    json['coinCount'] as int,
    json['level'] as int,
    json['rank'] as int,
    json['userId'] as int,
    json['username'] as String,
  );
}

Map<String, dynamic> _$UserPointsToJson(UserPoints instance) =>
    <String, dynamic>{
      'coinCount': instance.coinCount,
      'level': instance.level,
      'rank': instance.rank,
      'userId': instance.userId,
      'username': instance.username,
    };
