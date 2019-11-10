import 'package:json_annotation/json_annotation.dart';

part 'own_points.g.dart';

@JsonSerializable()
class OwnPoints extends Object {
  @JsonKey(name: 'coinCount')
  int coinCount;

  @JsonKey(name: 'level')
  int level;

  @JsonKey(name: 'rank')
  int rank;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'username')
  String username;

  OwnPoints(
    this.coinCount,
    this.level,
    this.rank,
    this.userId,
    this.username,
  );

  factory OwnPoints.fromJson(Map<String, dynamic> srcJson) =>
      _$OwnPointsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OwnPointsToJson(this);
}
