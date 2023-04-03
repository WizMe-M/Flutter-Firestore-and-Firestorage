import 'package:firestore_learning/model/image/image_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@unfreezed
class User with _$User {
  @JsonSerializable(explicitToJson: true)
  factory User({
    required String email,
    required String password,
    ImageEntity? avatar,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
