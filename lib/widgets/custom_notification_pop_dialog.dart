import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';

class NotificationPopDialog extends StatelessWidget {
  final String content;
  const NotificationPopDialog({Key? key, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        content,
        style: TextStyle(
          color: kPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'OK',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}