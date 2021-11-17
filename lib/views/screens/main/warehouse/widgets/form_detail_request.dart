import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/models/enum_status.dart';
import 'package:hotel_management_system/models/form_request/request.dart';
import 'package:hotel_management_system/views/screens/main/kitchen/request_form/widgets/request_detail_card.dart';
import 'package:hotel_management_system/widgets/custom_form_appbar.dart';
import 'package:hotel_management_system/widgets/info_form1.dart';
import 'package:hotel_management_system/widgets/rounded_linear_button.dart';

class DetailRequest extends StatelessWidget {
  static const String nameRoute = '/detailrequest';
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => DetailRequest(),
      settings: settings,
    );
  }

  const DetailRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final request =
        (ModalRoute.of(context)!.settings.arguments as List<Request>)[0];
    return Scaffold(
      appBar: CustomFormAppBar(title: "Detail Request " + request.nameRequest),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          color: Colors.white,
          padding: EdgeInsets.only(
            left: size.height * 0.02,
            top: size.height * 0.03,
            right: size.height * 0.02,
            bottom: size.height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    InfoForm1(
                      title: 'Type Request',
                      content: request.type
                          .toString()
                          .replaceAll("RequestType.", ""),
                    ),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    InfoForm1(title: 'Staff', content: request.staff.fullName),
                    SizedBox(
                      height: size.height * 0.015,
                    ),
                    InfoForm1(
                      title: "Date Time",
                      content: FormatDateTime.formatterDateTime
                          .format(request.date)
                          .toString(),
                    )
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
              ReqDetailCard(
                listDetail: request.ingredientDetail,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                child: Visibility(
                  visible: request.status == StatusType.Done ? false : true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundedLinearButton(
                        text: ' Acept ',
                        press: () {},
                        textColor: Colors.white,
                      ),
                      // SizedBox(
                      //   height: size.height * 0.03,
                      // ),
                      RoundedLinearButton(
                        text: 'Cancel',
                        press: () {},
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}