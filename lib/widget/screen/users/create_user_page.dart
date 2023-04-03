import 'package:auto_route/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_learning/model/user/user.dart';
import 'package:firestore_learning/widget/util/dynamic_auth_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final fs = FirebaseFirestore.instance;

  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                onPressed: () => addUserToStore(),
                child: const Text('Add user'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addUserToStore() {
    var user = User(email: _email.text, password: _password.text);
    fs.collection('users').add(user.toJson()).then((DocumentReference dr) {
      if (kDebugMode) {
        print('Added document with ID ${dr.id}');
      }
    });
  }

  void togglePassword() {
    setState(() => isPasswordHidden = !isPasswordHidden);
  }
}
