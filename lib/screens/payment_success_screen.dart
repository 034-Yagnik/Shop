import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatelessWidget {
  static const routename = '/payment-success';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/Payment_Successful.gif'),
      ),
    );

    // SafeArea(
    //   child: Scaffold(
    //     body: Center(
    //       child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: <Widget>[
    //             Container(
    //               height: 50,
    //               decoration: BoxDecoration(
    //                 color: Colors.green,
    //                 shape: BoxShape.circle,
    //               ),
    //               child: IconButton(
    //                   icon: Icon(
    //                     Icons.check,
    //                     color: Colors.white,
    //                   ),
    //                   onPressed: () {}),
    //             ),
    //             SizedBox(
    //               height: 25,
    //             ),
    //             Text(
    //               'Your Payment is Successfull...!!',
    //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //             ),
    //           ]),
    //     ),
    //   ),
    // );
  }
}
