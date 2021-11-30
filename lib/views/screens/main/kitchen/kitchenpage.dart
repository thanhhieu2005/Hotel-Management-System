import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/view_models/request_provider.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/request_form/form_foods_request.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/restaunrant_others_list/res_others_list_page.dart';
import 'package:hotel_management_system/widgets/custom_main_card.dart';
import 'package:provider/provider.dart';

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
            CustomMainCard(
              title: 'New Request',
              subTitle: 'Create a request send to the Warehouse',
              press: () {
                context.read<RequestProvider>().detailIngredient.clear();
                Navigator.pushNamed(context, FoodRequest.nameRoute);
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            // View list of restaurant orders
            CustomMainCard(
              title: 'Restaurant Orders List',
              subTitle: 'List of order requests from the Waiter',
              press: () {
                Navigator.pushNamed(context, ResOthersList.nameRoute);
              },
            ),
          ],
        ),
      ),
    );
  }
}
