import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_learning/model/user/user.dart';
import 'package:firestore_learning/widget/util/dynamic_auth_widget.dart';
import 'package:flutter/foundation.dart';
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

  final fs = FirebaseFirestore.instance;

  bool isPasswordHidden = true;

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

  Future<void> editUser() async {
    var user = User(email: _email.text, password: _password.text);
    fs.collection('users').doc(widget.id).update(user.toJson()).then((value) {
      if (kDebugMode) {
        print('Doc with ID ${widget.id} was updated');
      }
    });
    var updatedDoc = await fs.collection('users').doc(widget.id).get();
    var updated = User.fromJson(updatedDoc.data()!);
    widget.user
      ..email = updated.email
      ..password = updated.password;
  }
}
