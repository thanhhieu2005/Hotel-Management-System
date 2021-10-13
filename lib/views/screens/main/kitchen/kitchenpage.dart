import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/constrants.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/import_request/form_foods_request.dart';
import 'package:hotel_management_system/views/screens/main/widgets/custom_card.dart';

class KitchenPage extends StatelessWidget {
  static const String nameRoute = '/kitchen';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => KitchenPage(),
      settings: RouteSettings(name: nameRoute),
    );
  }

  const KitchenPage({Key? key}) : super(key: key);

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
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            // Create new form import request to warehouse department
            CustomCard(
              title: 'New Import Request',
              subTitle: 'Create a request sent to the warehouse daily',
              press: () {
                Navigator.pushNamed(context, FoodRequest.nameRoute);
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            // View list of restaurant orders
            CustomCard(
              title: 'List Restaurant Orders',
              subTitle: 'List of restaurant orders',
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}