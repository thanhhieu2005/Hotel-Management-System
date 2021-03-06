import 'package:flutter/material.dart';
import 'package:hotel_management_system/constrants/appColors.dart';

class BookingCard extends StatelessWidget {
  final String customerName,
      customerPhone,
      checkIn,
      checkOut,
      dateCreate,
      timeCreate,
      paidStatus,
      icPaid;
  final Color color;
  final VoidCallback press;
  const BookingCard(
      {Key? key,
      required this.customerName,
      required this.customerPhone,
      required this.checkIn,
      required this.checkOut,
      required this.dateCreate,
      required this.timeCreate,
      required this.paidStatus,
      required this.color,
      required this.press,
      required this.icPaid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.015,
          horizontal: size.height * 0.02,
        ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  customerName,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  height: size.height * 0.035,
                  width: size.height * 0.035,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            RichText(
              text: TextSpan(
                text: 'Phone Number: ',
                style: TextStyle(
                  color: blackColor,
                  fontSize: 15,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: customerPhone,
                      style: TextStyle(fontStyle: FontStyle.italic)),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: 'Check-in: ',
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 12,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: checkIn,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: 'Check-out: ',
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 12,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: checkOut,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    dateCreate,
                  ),
                ),
                Flexible(
                  child: Text(
                    timeCreate,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      paidStatus.toUpperCase(),
                      style: TextStyle(
                        color: color,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      'assets/images/' + icPaid,
                      color: color,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
