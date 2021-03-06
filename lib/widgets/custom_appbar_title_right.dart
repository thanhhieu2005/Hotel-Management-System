import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/widgets/custom_back_button.dart';

class CustomAppbarTitleRight extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppbarTitleRight({
    Key? key,
    required this.title,
    this.backToMainScreen = false,
  }) : super(key: key);

  final String title;
  final bool backToMainScreen;

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: TextStyle(
              color: startLinearColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
      backgroundColor: Colors.white,
      leading: backToMainScreen
          ? CustomBackButton(
              backToMainScreen: backToMainScreen,
            )
          : CustomBackButton(),
      elevation: 1,
    );
  }
}
