import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/view_models/restaurant/food_provider.dart';
import 'package:hotel_management_system/views/screens/main/waiter/widgets/food_card.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AddDetailDrink extends StatelessWidget {
  static Widget get instance {
    return ChangeNotifierProvider<FoodProvider>(
      create: (_) => FoodProvider(2),
      // lazy: false,
      child: AddDetailDrink(),
    );
  }

  const AddDetailDrink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FoodProvider>(
        builder: (context, provider, child) {
          return ModalProgressHUD(
            progressIndicator: SpinKitFoldingCube(
              color: kPrimaryColor,
              size: 40.0,
            ),
            inAsyncCall: provider.isLoad,
            child: BodyDetailDrink(),
          );
        },
      ),
    );
  }
}

class BodyDetailDrink extends StatefulWidget {
  const BodyDetailDrink({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyDetailDrink> createState() => _BodyDetailDrinkState();
}

class _BodyDetailDrinkState extends State<BodyDetailDrink> {
  final TextEditingController _searchFoodController = TextEditingController();
  String _searchText = "";
  @override
  void initState() {
    _searchFoodController.addListener(() {
      setState(() {
        _searchText = _searchFoodController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchFoodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          left: size.height * 0.02,
          top: size.height * 0.03,
          right: size.height * 0.02,
          bottom: size.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: whiteColor,
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.center,
                child: TextFormField(
                  // ignore: prefer_const_constructors
                  controller: _searchFoodController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    // hintStyle: TextConfigs.kText18w400Grey,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  maxLines: 1,
                  onChanged: (value) {
                    Provider.of<FoodProvider>(context, listen: false)
                        .changeSearchString(value);
                  },
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Consumer<FoodProvider>(builder: (context, provider, child) {
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return FoodCard(
                    food: provider.listFood[index],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: size.height * 0.01,
                ),
                itemCount: provider.listFood.length,
              );
            }),
          ],
        ),
      ),
    );
  }
}
