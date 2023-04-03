import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firestore_learning/model/entity/user_entity.dart';
import 'package:firestore_learning/model/user/user.dart';
import 'package:firestore_learning/storages/store.dart';
import 'package:firestore_learning/storages/user_store.dart';
import 'package:firestore_learning/widget/util/dynamic_auth_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EditUserPage extends StatefulWidget {
  const EditUserPage({
    required this.id,
    required this.user,
    super.key,
  });

  final String id;
  final User user;

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final Store<UserModel> store = UserStore();

  bool isPasswordHidden = true;
  PlatformFile? avatarFile;

  @override
  void initState() {
    super.initState();
    _email.text = widget.user.email;
    _password.text = widget.user.password;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: avatarFile != null
                    ? Image.file(File(avatarFile!.path!))
                    : const Placeholder(),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setAvatar();
                      },
                      child: const Text('Set avatar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => avatarFile = null);
                      },
                      child: const Text('Clear avatar'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: DynamicInputWidget(
                  controller: _email,
                  prefixIcon: Icons.email,
                  labelText: 'Email',
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: DynamicInputWidget(
                  controller: _password,
                  labelText: 'Password',
                  prefixIcon: Icons.password,
                  isPasswordField: true,
                  obscureText: isPasswordHidden,
                  toggleObscureCallback: togglePassword,
                  textInputAction: TextInputAction.done,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      editUser();
                      context.router.back();
                    },
                    child: const Text('Save changes'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => context.router.back(),
                    child: const Text('Back'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void togglePassword() {
    setState(() => isPasswordHidden = !isPasswordHidden);
  }

  Future setAvatar() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      dialogTitle: 'Select avatar',
      allowMultiple: false,
    );

    if (result != null) {
      setState(() => avatarFile = result.files.first);
    }
  }

  Future<void> editUser() async {
    var user = User(email: _email.text, password: _password.text);
    store.edit(id: widget.id, data: UserModel(user: user, image: avatarFile));
  }
}
