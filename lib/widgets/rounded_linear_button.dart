import 'package:flutter/material.dart';
import '../constrants/appColors.dart';

class RoundedLinearButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor, startColor, endColor;
  const RoundedLinearButton({
    Key? key,
    required this.text,
    required this.press(),
    this.color = kPrimaryColor,
    required this.textColor,
    required this.startColor,
    required this.endColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            endColor,
            startColor,
          ]),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: textColor),
          ),
        ),
      ),
    );
  }
}
