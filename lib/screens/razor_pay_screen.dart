import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shop_1/screens/payment_success_screen.dart';

class RazorPayScreen extends StatefulWidget {
  static String tag = '/RazorPayScreen';
  static const routeName = 'pay';

  @override
  RazorPayScreenState createState() => RazorPayScreenState();
}

class RazorPayScreenState extends State<RazorPayScreen> {
  Razorpay _razorpay;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': '40.00',
      'name': 'Fashion Street',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'gajera@gajera.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    toast("SUCCESS: " + response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    toast("ERROR: " + response.code.toString() + " - " + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    toast("EXTERNAL_WALLET: " + response.walletName);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    // changeStatusColor(primaryColor);
    return SafeArea(
      child: Scaffold(
        // appBar: getAppBar(context, 'RazorPay Payment checkout'),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 24, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16, bottom: 28),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                                // color: shadowColor,
                                blurRadius: 10,
                                spreadRadius: 2)
                          ],
                          color: whiteColor),
                      child: Image.network(
                        "https://pyxis.nymag.com/v1/imgs/2ea/78d/dc5d70b045366d1fa7fef71fb45cd5beda-best-rated-sweatpants.rsquare.w600.jpg",
                        width: 120,
                        height: 120,
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Onlinepay",
                              // fontSize: textSizeLarge,
                              // fontFamily: fontMedium,
                              // textColor: Colors.lightBlue[600],
                            ),
                            Text(
                              "Order#567880",
                              // fontSize: textSizeMedium,
                              // textColor: Theme.of(context).secondaryHeaderColor,
                            ),
                            Text(
                              "\$40",
                              // fontSize: textSizeXLarge,
                              // fontFamily: fontMedium,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Divider(height: 0.5),
                Text(
                  "Name",
                  // textColor: primaryColor,
                  // fontFamily: fontSemibold,
                  // fontSize: textSizeLargeMedium,
                ).paddingAll(16),
                Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).dividerColor, width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Text('gajera')
                    // TextField(
                    //   controller: controller,
                    //   autofocus: false,
                    // ),
                    ),
                Text(
                  "Email",
                  // textColor: primaryColor,
                  // fontFamily: fontSemibold,
                  // fontSize: textSizeLargeMedium,
                ).paddingAll(16),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).dividerColor, width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Text("gajera@gajera.com"),
                ),
                Text(
                  "Contact",
                  // textColor: primaryColor,
                  // fontFamily: fontSemibold,
                  // fontSize: textSizeLargeMedium,
                ).paddingAll(16),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).dividerColor, width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Text("8885478888"),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 80),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Pay your payment',
                    // aFontFamily: fontMedium,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ).onTap(() {
                  Navigator.of(context)
                      .pushNamed(PaymentSuccessScreen.routename);
                  openCheckout();
                })
              ],
            )

            /*MaterialButton(
              color: primaryColor,
              onPressed: () => openCheckout(),
              child: textPrimary('Pay with RazorPay'),
            )*/
            ,
          ),
        ),
      ),
    );
  }
}
