import 'package:flutter/material.dart';

class ContactTile extends StatefulWidget {
  const ContactTile({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.contactTile,
    required this.contactIcon,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool?> onChanged;
  final String contactTile;
  final IconData contactIcon;

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      dense: true,
      title: Text(widget.contactTile),
      secondary: Icon(widget.contactIcon),
      value: widget.value,
      onChanged: widget.onChanged,
    );
  }
}
