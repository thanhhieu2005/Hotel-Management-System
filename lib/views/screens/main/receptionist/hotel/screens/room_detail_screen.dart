import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import 'package:hotel_management_system/constrants/appColors.dart';
import 'package:hotel_management_system/constrants/format_date.dart';
import 'package:hotel_management_system/models/enum/paid_status.dart';
import 'package:hotel_management_system/models/hotel/room.dart';
import 'package:hotel_management_system/view_models/receptionist/hotel_provider.dart';
import 'package:hotel_management_system/view_models/receptionist/room_provider.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/add_new_booking_screen.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/screens/booking_payment_detail_screen.dart';
import 'package:hotel_management_system/views/screens/main/receptionist/hotel/widgets/booking_card.dart';
import 'package:hotel_management_system/widgets/custom_back_button.dart';

class RoomDetail extends StatefulWidget {
  static const String nameRoute = '/room_detail';
  static Route route(RouteSettings settings) {
    final agrument = settings.arguments as RoomDetailArgument;
    return MaterialPageRoute(
      builder: (context) =>
          // lazy: false,
          MultiProvider(providers: [
        ChangeNotifierProvider<RoomProvider>(
          create: (_) => RoomProvider(agrument.room),
        ),
        ChangeNotifierProvider<HotelProvider>.value(
          value: agrument.hotelProvider,
        )
      ], child: RoomDetail()),
      settings: settings,
    );
  }

  const RoomDetail({Key? key}) : super(key: key);

  @override
  State<RoomDetail> createState() => _RoomDetailState();
}

class RoomDetailArgument {
  final Room room;
  final HotelProvider hotelProvider;
  RoomDetailArgument({
    required this.room,
    required this.hotelProvider,
  });
}

class _RoomDetailState extends State<RoomDetail> {
  DateTime checkInDate = DateTime.now();
  DateTime checkOutDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // provider for selected each room
    final roomDetail = context.read<RoomProvider>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Room ' + roomDetail.selectedRoom.roomName,
          style: TextStyle(
              color: startLinearColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        backgroundColor: Colors.white,
        leading: CustomBackButton(),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.pushNamed(context, AddBookingScreen.nameRoute,
                  arguments: roomDetail);
              roomDetail.loadRoomDetail();
            },
            icon: Icon(
              CupertinoIcons.add,
              color: kPrimaryColor,
              size: 35,
            ),
          ),
        ],
        elevation: 1,
      ),
      body: Consumer<RoomProvider>(builder: (context, provider, child) {
        return ModalProgressHUD(
          progressIndicator: SpinKitFoldingCube(
            color: kPrimaryColor,
            size: 40.0,
          ),
          inAsyncCall: provider.isLoad,
          child: Container(
            padding: EdgeInsets.all(
              size.height * 0.02,
            ),
            child: RefreshIndicator(
              onRefresh: () => provider.loadRoomDetail(),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return BookingCard(
                    customerName: provider.listRoomDetal[index].customerName,
                    customerPhone: provider.listRoomDetal[index].customerPhone,
                    checkIn: FormatDateTime.formatterDay
                        .format(provider.listRoomDetal[index].checkIn),
                    checkOut: FormatDateTime.formatterDay
                        .format(provider.listRoomDetal[index].checkOut),
                    dateCreate: FormatDateTime.formatterDay
                        .format(provider.listRoomDetal[index].dateCreate),
                    timeCreate: FormatDateTime.formatterTime
                        .format(provider.listRoomDetal[index].dateCreate),
                    paidStatus: provider.listRoomDetal[index].paidStatus
                        .toString()
                        .replaceAll("PaidStatus.", ""),
                    color: provider.listRoomDetal[index].paidStatus ==
                            PaidStatus.Paid
                        ? Colors.green
                        : Colors.yellow,
                    press: () {
                      Navigator.pushNamed(
                        context,
                        BookingPaymentDetail.nameRoute,
                        arguments: BookingPaymentArgument(
                          reservationRoom: provider.listRoomDetal[index],
                        ),
                      );
                    },
                    icPaid: provider.listRoomDetal[index].paidStatus ==
                            PaidStatus.Paid
                        ? 'ic_paid.png'
                        : 'ic_pending.png',
                  );
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: size.height * 0.01,
                ),
                itemCount: provider.listRoomDetal.length,
              ),
            ),
          ),
        );
      }),
    );
  }
}
