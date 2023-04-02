import 'package:flutter/material.dart';

class DynamicInputWidget extends StatelessWidget {
  const DynamicInputWidget({
    required this.controller,
    this.labelText,
    this.readonly = false,
    this.isPasswordField = false,
    this.obscureText = false,
    this.toggleObscureCallback,
    this.prefixIcon,
    this.textInputAction,
    super.key,
  });

  final bool readonly;
  final bool obscureText;
  final VoidCallback? toggleObscureCallback;
  final bool isPasswordField;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final String? labelText;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        label: labelText != null ? Text(labelText!) : null,
        hintStyle: TextStyle(color: Colors.grey[800]),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: isPasswordField
            ? IconButton(
                onPressed: toggleObscureCallback,
                icon: obscureText
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off))
            : null,
      ),
      readOnly: readonly,
      textInputAction: textInputAction,
      obscureText: obscureText,
    );
  }
}
