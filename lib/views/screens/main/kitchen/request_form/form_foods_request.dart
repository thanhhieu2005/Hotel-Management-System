import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_currency.dart';
import 'package:hotel_management_system/models/enum/enum_type.dart';
import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/view_models/auth_provider.dart';
import 'package:hotel_management_system/view_models/kitchen/request_provider.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/request_form/dialog_details_req.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/request_form/widgets/request_detail_card.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:hotel_management_system/widgets/custom_notification_pop_dialog.dart';
import 'package:hotel_management_system/widgets/delete_item_widget.dart';
import 'package:hotel_management_system/widgets/info_form1.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';
import 'package:hotel_management_system/widgets/total_price_widget.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:hotel_management_system/widgets/get_now_dateTime.dart';

class FoodRequest extends StatefulWidget {
  static const String nameRoute = '/foodrequest';
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider<RequestProvider>.value(
        value: RequestProvider(),
        child: FoodRequest(),
      ),
      settings: RouteSettings(name: nameRoute),
    );
  }

  const FoodRequest({Key? key}) : super(key: key);

  @override
  State<FoodRequest> createState() => _FoodRequestState();
}

class _FoodRequestState extends State<FoodRequest> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RequestProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: CustomAppbarTitleRight(
          title: 'Form Request',
        ),
        body: ModalProgressHUD(
          progressIndicator: SpinKitFoldingCube(
            color: kPrimaryColor,
            size: 40.0,
          ),
          inAsyncCall: provider.isLoad,
          child: BodyFormReq(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          heroTag: null,
          backgroundColor: startLinearColor,
          child: IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, AddIngre.nameRoute);
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomDialog.getInstance(provider);
                  });
            },
            icon: Icon(Icons.add),
          ),
        ),
      );
    });
  }
}

class BodyFormReq extends StatefulWidget {
  const BodyFormReq({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyFormReq> createState() => _BodyFormReqState();
}

class _BodyFormReqState extends State<BodyFormReq> {
  // Notify when send request successfully
  void onSuccess() {
    showDialog(
        context: context,
        builder: (context) {
          return NotificationPopDialog(content: 'Submit request successfully');
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    final dateData = (DateTimeExtension.getUtc);
    final dateDisplay = DateFormat('HH:MM dd/MM/yyyy').format(DateTime.now());
    final nameRequest = '#ID' + DateFormat('HHMMddMMyy').format(DateTime.now());
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          left: size.height * 0.02,
          top: size.height * 0.03,
          right: size.height * 0.02,
          bottom: size.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(size.height * 0.01),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Type Request',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: startButtonLinearColor,
                                  spreadRadius: 2),
                            ],
                          ),
                          child: Consumer<RequestProvider>(
                              builder: (context, requestProvider, child) {
                            return DropdownButton<RequestType>(
                              dropdownColor: Colors.white,
                              iconSize: 34,
                              underline: SizedBox(),
                              isExpanded: true,
                              style: TextStyle(
                                color: Colors.black,
                                backgroundColor: Colors.white,
                              ),
                              onChanged: (RequestType? val) {
                                setState(() {
                                  requestProvider.setType(val);
                                });
                              },
                              value: requestProvider.getType(),
                              items: [
                                DropdownMenuItem(
                                    child: Text('Import'),
                                    value: RequestType.Import),
                                DropdownMenuItem(
                                    child: Text('Export'),
                                    value: RequestType.Export),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  InfoForm1(
                    title: 'Staff Name',
                    content: authProvider.currentStaff.fullName,
                    sizeText: 18,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  InfoForm1(
                    title: 'Date Create',
                    content: dateDisplay.toString(),
                    sizeText: 18,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              'Ingredients List',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Consumer<RequestProvider>(
              builder: (context, provider, child) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: provider.detailIngredient.length,
                  itemBuilder: (context, index) {
                    final eachItem = provider.detailIngredient[index];
                    final price =
                        eachItem.ingredient.ingrePrice * eachItem.quantity;
                    return Dismissible(
                      key: ValueKey<int>(
                          provider.detailIngredient[index].hashCode),
                      onDismissed: (DismissDirection direction) {
                        setState(() {
                          {
                            provider.detailIngredient.removeAt(index);
                          }
                        });
                      },
                      background: DeleteItemWidget(),
                      child: ReqDetailCard(
                        ingreName: eachItem.ingredient.ingreName,
                        price: FormatCurrency.currencyFormat.format(price),
                        quantity: eachItem.quantity.toString(),
                        unit: eachItem.ingredient.unit.toString(),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    height: size.height * 0.02,
                  ),
                );
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            TotalPriceWidget(
              totalPrice: context.read<RequestProvider>().totalPrice,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedLinearButton(
              text: 'SEND',
              press: () => context.read<RequestProvider>().sendRequest(dateData,
                  authProvider.currentStaff.staffID, nameRequest, onSuccess),
              textColor: Colors.white,
              startColor: startButtonLinearColor,
              endColor: endButtonLinearColor,
            ),
          ],
        ),
      ),
    );
  }
}
