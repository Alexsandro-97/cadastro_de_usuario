import 'package:flutter/material.dart';
import 'package:cadastro_de_usuario/resources/strings.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    Key? key,
    required this.onThemeModePressed,
  }) : super(key: key);

  final VoidCallback onThemeModePressed;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(Strings.appName),
        actions: [
          IconButton(
            onPressed: widget.onThemeModePressed,
            icon: Icon(
              theme.brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          TextField(
            decoration: buildInputDecoration(Strings.userName),
            textInputAction: TextInputAction.next,
            autofocus: true,
          ),
          const SizedBox(height: 10.0),
          TextField(
            decoration: buildInputDecoration(Strings.email),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10.0),
          TextField(
            decoration: buildInputDecoration(Strings.password).copyWith(
                suffixIcon: IconButton(
              icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () => setState(() {
                obscureText = !obscureText;
              }),
            )),
            textInputAction: TextInputAction.next,
            obscureText: obscureText,
          ),
          const SizedBox(height: 10.0),
          TextField(
            decoration: buildInputDecoration(Strings.fullName),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 10.0),
          TextField(
            decoration: buildInputDecoration(Strings.birthDate),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10.0),
          TextField(
            decoration: buildInputDecoration(Strings.phone),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  InputDecoration buildInputDecoration(String label) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      labelText: label,
    );
  }
}
