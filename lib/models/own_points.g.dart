// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'own_points.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnPoints _$OwnPointsFromJson(Map<String, dynamic> json) {
  return OwnPoints(
    json['coinCount'] as int,
    json['level'] as int,
    json['rank'] as int,
    json['userId'] as int,
    json['username'] as String,
  );
}

Map<String, dynamic> _$OwnPointsToJson(OwnPoints instance) => <String, dynamic>{
      'coinCount': instance.coinCount,
      'level': instance.level,
      'rank': instance.rank,
      'userId': instance.userId,
      'username': instance.username,
    };
