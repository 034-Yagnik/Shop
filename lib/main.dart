import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_1/screens/razor_pay_screen.dart';
import './screens/feedback_screen.dart';
import 'screens/adding_detail_screen.dart';
import './screens/splash_screen.dart';
import './screens/orders_screen.dart';
import './screens/cart_screen.dart';
import './providers/cart.dart';
import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/orders.dart';
import './providers/auth.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './providers/feedbacks.dart';
import './providers/shopp_address.dart';
import './screens/payment_success_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ShoppAddress(),
        ),
        ChangeNotifierProvider.value(
          value: Feedbacks(),
        ),
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'My Shop',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.orange,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home:
              // PaymentSuccessScreen(),
              // RazorPayScreen(),
              auth.isAuth
                  ? ProductOverviewScreen()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResultSnapshot) =>
                          authResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashScreen()
                              : AuthScreen(),
                    ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            AddingDetailScreen.routeName: (ctx) => AddingDetailScreen(),
            FeedbackScreen.routename: (ctx) => FeedbackScreen(),
            ProductOverviewScreen.routename: (ctx) => ProductOverviewScreen(),
            RazorPayScreen.routeName: (ctx) => RazorPayScreen(),
            PaymentSuccessScreen.routename: (ctx) => PaymentSuccessScreen(),
          },
        ),
      ),
    );
  }
}
