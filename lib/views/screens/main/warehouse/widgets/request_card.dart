import 'package:flutter/material.dart';
import 'package:hotel_management_system/widgets/right_circular_black_arrow.dart';

class WidgetRequestCard extends StatelessWidget {
  final String nameRequest, nameStaff, date, time, status, icPaid;
  final Color color;
  final VoidCallback press;
  const WidgetRequestCard({
    Key? key,
    required this.nameRequest,
    required this.nameStaff,
    required this.date,
    required this.time,
    required this.status,
    required this.color,
    required this.press,
    required this.icPaid,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: press,
      child: Container(
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
        padding: EdgeInsets.all(
          size.height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/ic_pin_staff.png'),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    Text(
                      nameStaff,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                RightCircularBlackArrow(size: size),
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
                    nameRequest,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Flexible(
                //   child: RichText(
                //     maxLines: 1,
                //     text: TextSpan(
                //       text: 'Quantity: ',
                //       style: TextStyle(
                //         fontSize: 16,
                //         color: Colors.black,
                //       ),
                //       children: <TextSpan>[
                //         TextSpan(
                //           text: '3',
                //           style: TextStyle(
                //             fontSize: 16,
                //             color: Colors.black,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
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
                    date,
                  ),
                ),
                Flexible(
                  child: Text(
                    time,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      status,
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
