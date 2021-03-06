import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/entertainment_management.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/revenue_report/daily_report_management.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/food_management.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/hotel_management.dart';
import 'package:hotel_management_system/views/screens/main/manager/screens/main_entertainment_managment_screen.dart';
import 'package:hotel_management_system/widgets/custom_main_card.dart';

class ManagerHomePage extends StatelessWidget {
  static const String nameRoute = '/manager';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => ManagerHomePage(),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  const ManagerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: size.height * 0.02,
                top: size.height * 0.03,
              ),
              child: Text(
                'Activities',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            // Create new form import request to warehouse department
            CustomMainCard(
              icon: "ic_statistic.png",
              title: 'Watch Report',
              subTitle: 'Report Daily from Accountant',
              press: () {
                Navigator.pushNamed(context, DailyReportScreen.nameRoute);
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            CustomMainCard(
              icon: "ic_food.png",
              title: 'Food Management',
              subTitle: 'Add, Edit, Delete Food',
              press: () {
                Navigator.pushNamed(context, FoodManagementScreen.nameRoute);
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            CustomMainCard(
              icon: "ic_room.png",
              title: 'Hotel Management',
              subTitle: 'Add, Edit Room',
              press: () {
                Navigator.pushNamed(context, HotelManagementScreen.nameRoute);
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            CustomMainCard(
              icon: "ic_entertainment.png",
              title: 'Entertainment Management',
              subTitle: '.....',
              press: () {
                Navigator.pushNamed(
                    context, MainEntertainemtManagementScreen.nameRoute);
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
