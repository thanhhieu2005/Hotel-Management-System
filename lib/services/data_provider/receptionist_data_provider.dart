import 'package:hotel_management_system/models/entertainment_service/entertainment.dart';
import 'package:hotel_management_system/models/hotel/reservation_room.dart';
import 'package:hotel_management_system/models/hotel/room.dart';
import 'package:hotel_management_system/models/riskBill.dart';
import 'package:hotel_management_system/services/data_repository/receptionist_data_repository.dart';

class ReceptionistDataProvider {
  /* Receptionist Department - Hotel */
  Future<List<Room>> getAllRoom() async {
    final response = await ReceptionistDataRepository().getAllRoom();
    var listAllRoom =
        (response.data as List).map((e) => Room.fromJson(e)).toList();
    return listAllRoom;
  }

  // find room empty
  Future<List<Room>> findEmptyRoom(
      {required String checkIn, required String checkOut}) async {
    final response = await ReceptionistDataRepository()
        .findEmptyRoom(checkIn: checkIn, checkOut: checkOut);
    var listEmptyRoom =
        (response.data as List).map((e) => Room.fromJson(e)).toList();
    return listEmptyRoom;
  }

  // get a room detail
  Future<List<ReservationRoom>> getRoomDetail({required String roomId}) async {
    final response =
        await ReceptionistDataRepository().getRoomDetail(roomId: roomId);
    var roomDetail = (response.data as List)
        .map((e) => ReservationRoom.fromJson(e))
        .toList();
    return roomDetail;
  }

  // add booking in a room
  Future<void> addBooking({
    required String roomId,
    required String staffId,
    required String dateCreate,
    required String customerName,
    required String customerPhone,
    required String checkIn,
    required String checkOut,
    required int paidStatus,
    required int totalPrice,
  }) async {
    await ReceptionistDataRepository().addBooking(
      roomId: roomId,
      staffId: staffId,
      dateCreate: dateCreate,
      customerName: customerName,
      customerPhone: customerPhone,
      checkIn: checkIn,
      checkOut: checkOut,
      paidStatus: paidStatus,
      totalPrice: totalPrice,
    );
  }

  // update paid status of each booking
  Future<void> updatePaidStatus(
      {required String reservationId,
      required int paidStatus,
      required String dateCreate}) async {
    await ReceptionistDataRepository().updatePaidStatus(
        reservationId: reservationId,
        paidStatus: paidStatus,
        dateCreate: dateCreate);
  }

  Future<void> deleteBooking({required String reservationId}) async {
    await ReceptionistDataRepository()
        .deleteBooking(reservationId: reservationId);
  }

  /* Receptionist Department - Entertainment Service */
  Future<List<Entertainment>> getAllEntertainment() async {
    final response = await ReceptionistDataRepository().getAllEntertainment();
    var listEntertainment =
        (response.data as List).map((e) => Entertainment.fromJson(e)).toList();
    return listEntertainment;
  }

  // add entertainment bill
  Future<void> addEntertainBill({
    required String staff,
    required String dateCreate,
    required List<Map<String, dynamic>> entertainBillDetail,
    required int totalPrice,
  }) async {
    await ReceptionistDataRepository().addEntertainmentBill(
        staff: staff,
        dateCreate: dateCreate,
        entertainBillDetail: entertainBillDetail,
        totalPrice: totalPrice);
  }

  // add entertainment bill
  Future<void> submitRiskBill({required RiskBill riskBill}) async {
    await ReceptionistDataRepository().submitRiskBill(riskBill: riskBill);
  }
}
