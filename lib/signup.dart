import 'package:cadastro_de_usuario/components/contact_tile.dart';
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
  DateTime? selectedBirthDate;
  bool obscureText = true;
  bool emailChecked = true;
  bool phoneChecked = true;
  bool acceptedTerms = false;

  final birthDateFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  final birthDateController = TextEditingController();

  void showBirthDatePicker() {
    final now = DateTime.now();
    final olderAge = DateTime(now.year - 18, now.month, now.day);
    showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      initialDate: selectedBirthDate ?? olderAge,
      lastDate: olderAge,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.year,
    ).then((selectedDate) {
      if (selectedDate != null) {
        selectedBirthDate = selectedDate;
        birthDateController.text =
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
        phoneFocusNode.requestFocus();
      }
    });
    birthDateFocusNode.unfocus();
  }

  void showSignUpDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(Strings.appName),
          content: const Text(Strings.confirmationMessage),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
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
            buildHeader(Strings.accessData),
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
                  suffixIcon: ExcludeFocus(
                child: IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () => setState(() {
                    obscureText = !obscureText;
                  }),
                ),
              )),
              textInputAction: TextInputAction.next,
              obscureText: obscureText,
            ),
            const SizedBox(height: 18.0),
            buildHeader(Strings.personalInformation),
            TextField(
              decoration: buildInputDecoration(Strings.fullName),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: Focus(
                    focusNode: birthDateFocusNode,
                    descendantsAreFocusable: false,
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        showBirthDatePicker();
                      }
                    },
                    child: TextField(
                      controller: birthDateController,
                      readOnly: true,
                      decoration: buildInputDecoration(Strings.birthDate),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onTap: showBirthDatePicker,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  flex: 5,
                  child: TextField(
                    focusNode: phoneFocusNode,
                    decoration: buildInputDecoration(Strings.phone),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            buildHeader(Strings.contactMessage),
            ContactTile(
              value: emailChecked,
              onChanged: (value) => setState(() {
                emailChecked = value!;
              }),
              contactTile: Strings.email,
              contactIcon: Icons.email,
            ),
            ContactTile(
              value: phoneChecked,
              onChanged: (value) => setState(() {
                phoneChecked = value!;
              }),
              contactTile: Strings.phone,
              contactIcon: Icons.phone,
            ),
            SwitchListTile(
                title: Text(
                  Strings.termsMessage,
                  style: theme.textTheme.subtitle2,
                ),
                contentPadding: const EdgeInsets.only(right: 8.0),
                value: acceptedTerms,
                onChanged: (value) => setState(() {
                      acceptedTerms = value;
                    })),
            ElevatedButton(
              onPressed: showSignUpDialog,
              child: const Text(Strings.signUp),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    birthDateController.dispose();
    birthDateFocusNode.dispose();
    super.dispose();
  }

  Padding buildHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Text(text, style: Theme.of(context).textTheme.subtitle1),
    );
  }

  InputDecoration buildInputDecoration(String label) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      labelText: label,
    );
  }
}
