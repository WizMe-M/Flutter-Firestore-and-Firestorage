import 'package:file_picker/file_picker.dart';
import 'package:firestore_learning/model/user/user.dart';

class UserModel {
  final User user;
  final PlatformFile? image;

  UserModel({required this.user, this.image});
}
