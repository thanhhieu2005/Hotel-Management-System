import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/models/enum/enum_status.dart';
import 'package:hotel_management_system/models/enum/enum_type.dart';
import 'package:hotel_management_system/view_models/warehouse/warehouse_provider.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/widgets/form_detail_request.dart';
import 'package:hotel_management_system/views/screens/main/warehouse/widgets/request_card.dart';
import 'package:hotel_management_system/widgets/custom_appbar_title_right.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ListRequest extends StatefulWidget {
  static const String nameRoute = '/listrequest';
  static Route route(settings) {
    return MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider<WarehouseProvider>(
        create: (context) => WarehouseProvider(),
        child: ListRequest(),
      ),
      settings: settings,
    );
  }

  const ListRequest({Key? key}) : super(key: key);

  @override
  State<ListRequest> createState() => _ListRequestState();
}

class _ListRequestState extends State<ListRequest> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await context.read<WarehouseProvider>().loadListRequest();
      context.read<WarehouseProvider>().typeofRequest =
          ModalRoute.of(context)!.settings.arguments as RequestType;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final type = ModalRoute.of(context)!.settings.arguments as RequestType;
    return Scaffold(
      appBar: CustomAppbarTitleRight(
        title: type == RequestType.Import ? 'Import Request' : 'Export Request',
      ),
      body: Consumer<WarehouseProvider>(builder: (context, provider, child) {
        return ModalProgressHUD(
          progressIndicator: SpinKitFoldingCube(
            color: kPrimaryColor,
            size: 40.0,
          ),
          inAsyncCall: provider.isLoad,
          child: BodyImportRequest(),
        );
      }),
    );
  }
}

class BodyImportRequest extends StatefulWidget {
  const BodyImportRequest({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyImportRequest> createState() => _BodyImportRequestState();
}

class _BodyImportRequestState extends State<BodyImportRequest> {
  @override
  Widget build(BuildContext context) {
    final type = ModalRoute.of(context)!.settings.arguments as RequestType;
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type == RequestType.Import
                      ? 'List of Import'
                      : 'List of Export',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: size.height * 0.04,
                  width: size.height * 0.18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kPrimaryLightColor,
                  ),
                  padding: EdgeInsets.only(left: 15, right: 10),
                  child: Center(
                    child: Consumer<WarehouseProvider>(
                        builder: (context, statusProvider, child) {
                      return DropdownButton<StatusType>(
                        dropdownColor: kPrimaryLightColor,
                        iconSize: 30,
                        underline: SizedBox(),
                        isExpanded: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        onChanged: (StatusType? value) {
                          setState(() {
                            statusProvider.set(value);
                          });
                        },
                        value: statusProvider.get(),
                        items: [
                          DropdownMenuItem(
                              child: Text('All'), value: StatusType.All),
                          DropdownMenuItem(
                              child: Text('Done'), value: StatusType.Done),
                          DropdownMenuItem(
                              child: Text('Pending'),
                              value: StatusType.Pending),
                          DropdownMenuItem(
                              child: Text('Cancle'), value: StatusType.Cancel),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Consumer<WarehouseProvider>(builder: (context, provider, child) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.listFilterRequest.length,
                itemBuilder: (context, index) {
                  return WidgetRequestCard(
                    nameRequest: provider.listFilterRequest[index].nameRequest,
                    nameStaff: provider.listFilterRequest[index].staff.fullName,
                    date: FormatDateTime.formatterDay
                        .format(provider.listFilterRequest[index].date)
                        .toString(),
                    time: FormatDateTime.formatterTime
                        .format(provider.listFilterRequest[index].date)
                        .toString(),
                    status: provider.listFilterRequest[index].status
                        .toString()
                        .replaceAll("StatusType.", "")
                        .toUpperCase(),
                    color: provider.listFilterRequest[index].status ==
                            StatusType.Done
                        ? Colors.green
                        : provider.listFilterRequest[index].status ==
                                StatusType.Pending
                            ? Colors.yellow
                            : Colors.red,
                    press: () {
                      Navigator.pushNamed(
                        context,
                        DetailRequest.nameRoute,
                        arguments: [provider.listFilterRequest[index]],
                      );
                    },
                    icPaid: provider.listFilterRequest[index].status ==
                            StatusType.Done
                        ? 'ic_paid.png'
                        : provider.listFilterRequest[index].status ==
                                StatusType.Pending
                            ? 'ic_pending.png'
                            : 'ic_canceled.png',
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: size.height * 0.02,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
