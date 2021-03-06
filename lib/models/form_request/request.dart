import 'package:hotel_management_system/models/enum/enum_status.dart';
import 'package:hotel_management_system/models/enum/enum_type.dart';
import 'package:hotel_management_system/models/form_request/detailsReq.dart';
import 'package:hotel_management_system/models/staff/staff.dart';

class Request {
  late String id;
  late String nameRequest;
  late RequestType type;
  late DateTime date;
  late StatusType status;
  late Staff staff;
  late List<DetailsReq> ingredientDetail;
  late int totalPrice;

  Request(
      {required this.id,
      required this.nameRequest,
      required this.type,
      required this.date,
      required this.status,
      required this.staff,
      required this.ingredientDetail,
      required this.totalPrice});

  Request.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    nameRequest = json['nameRequest'];
    type = RequestTypeExtension.fromInt(json['type']);
    date = DateTime.parse(json['date']).toLocal();
    status = StatusTypeExtension.fromInt(json['status']);

    staff =
        (json['staffId'] != null ? new Staff.fromJson(json['staffId']) : null)!;
    if (json['ingredientDetail'] != null) {
      ingredientDetail = <DetailsReq>[];
      json['ingredientDetail'].forEach((v) {
        ingredientDetail.add(new DetailsReq.fromJson(v));
      });
    }
    totalPrice = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['nameRequest'] = this.nameRequest;
    data['type'] = this.type;
    data['date'] = this.date;
    data['status'] = this.status;
    data['staffId'] = this.staff.toJson();
    data['ingredientDetail'] =
        this.ingredientDetail.map((v) => v.toJson()).toList();
    data['total'] = this.totalPrice;
    return data;
  }
}
