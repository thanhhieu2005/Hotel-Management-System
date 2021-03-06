import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/booking_screen.dart';
import 'package:hotel_management_system/widgets/custom_main_card.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';

class HotelPage extends StatelessWidget {
  static const String nameRoute = '/hotel';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => HotelPage(),
      settings: RouteSettings(
        name: nameRoute,
      ),
    );
  }

  const HotelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppbarTitleRight(
        title: 'Hotel',
      ),
      body: SingleChildScrollView(
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
                icon: "ic_room.png",
                title: 'Booking Room',
                subTitle: '.....',
                press: () {
                  Navigator.pushNamed(context, BookingScreen.nameRoute);
                },
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              // View list of restaurant orders
              CustomMainCard(
                icon: "ic_management.png",
                title: 'List of Hotel Bill',
                subTitle: '.....',
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
