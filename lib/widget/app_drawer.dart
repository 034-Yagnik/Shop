import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/feedback_screen.dart';
import '../screens/orders_screen.dart';
import '../providers/auth.dart';
import '../screens/user_products_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String data;
  File _image;

  @override
  void initState() {
    Emaildata();
    super.initState();
  }

  Future<void> Emaildata() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      data = sharedPreferences.getString("myemail");
    });
    print("$data");
  }

  Future<void> open_camera() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
    uploadPic(_image);
  }

  Future<void> open_gallery() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    uploadPic(_image);
  }

  Future uploadPic(var _image) async {
    String fileName = basename(_image.path);
    print(fileName);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_image);
    TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => print("Upload Successfullly!"));
    setState(() {
      print('Profile picture uploaded');
      // Scaffold.of(context)
      //     .showSnackBar(SnackBar(content: Text('Profile Picture uploade')));
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Photo Library'),
                      onTap: () {
                        open_gallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      open_camera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: UserAccountsDrawerHeader(
              accountName: Text(
                "$data",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              // accountEmail: Text(data),
              currentAccountPicture: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: CircleAvatar(
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            _image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      // : ClipRRect(
                      //     borderRadius: BorderRadius.circular(50),
                      //     child: Image.asset(
                      //       'assets/images/c1.jpg',
                      //       width: 100,
                      //       height: 100,
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50)),
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                  //  backgroundImage: AssetImage('assets/images/c1.jpg'),
                  backgroundColor: Colors.grey,
                ),
              ),
            ),
          ),
          // AppBar(
          //   title: Text('Hello Friend!'),
          //   automaticallyImplyLeading: false,
          // ),
          // Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
              //   Navigator.of(context).pushReplacement(
              //     CustomRoute(
              //       builder: (ctx) => OrdersScreen(),
              //     ),
              //   );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('Feedback'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(FeedbackScreen.routename);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');

              // Navigator.of(context)
              //     .pushReplacementNamed(UserProductsScreen.routeName);
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
