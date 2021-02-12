import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shopp_address.dart';
import './product_overview_screen.dart';

class AddingDetailScreen extends StatefulWidget {
  static const routeName = '/adding-deatil';
  @override
  _AddingDetailScreenState createState() => _AddingDetailScreenState();
}

class _AddingDetailScreenState extends State<AddingDetailScreen> {
  final TextEditingController _citycontroller = TextEditingController();
  final TextEditingController _statecontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _mobilenumbercontroller = TextEditingController();
  TextEditingController _pincodecontroller = TextEditingController();
  TextEditingController _addresscontroller = TextEditingController();

  final _form = GlobalKey<FormState>();
  final _mobilenumber = FocusNode();
  final _pincode = FocusNode();
  final _address = FocusNode();
  final _city = FocusNode();
  final _state = FocusNode();
  var _editedaddress = ShoppAddress(
    id: null,
    name: '',
    mobilenumber: 0,
    pincode: 0,
    address: '',
    city: '',
    state: '',
  );

  Future<void> _submitForm(BuildContext context) async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    // setState(() {
    //   _isLoading = true;
    // });
    await Provider.of<ShoppAddress>(context, listen: false)
        .addaddress(_editedaddress);
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(ProductOverviewScreen.routename);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter a shopping address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _namecontroller,
                  decoration: InputDecoration(
                    hintText: 'Enter Full Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_mobilenumber);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter a Name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _mobilenumbercontroller,
                  decoration: InputDecoration(
                    hintText: 'Enter Mobile Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _mobilenumber,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_pincode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter a Mobile number';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _pincodecontroller,
                  decoration: InputDecoration(
                    hintText: 'Enter PIN code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _pincode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_address);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter a PIN code';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _addresscontroller,
                  decoration: InputDecoration(
                    hintText: 'Enter Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _address,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_city);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter a Address';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _citycontroller,
                  decoration: InputDecoration(
                    suffixIcon: SingleChildScrollView(
                        child: DropdownButton<String>(
                      dropdownColor: Colors.indigo,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      items: <String>[
                        'Surat',
                        'Mumbai',
                        'Ahmedabad',
                        'Rajkot',
                        'Hydrabad',
                        'Delhi',
                        'Banglore',
                        'Panjab',
                      ].map(
                        (String value) {
                          return DropdownMenuItem<String>(
                            child: Text(value),
                            value: value,
                          );
                        },
                      ).toList(),
                      onChanged: (String val) {
                        _citycontroller.text = val;
                      },
                    )),
                    hintText: 'Select City',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  focusNode: _city,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_state);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please select City';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _statecontroller,
                  decoration: InputDecoration(
                    suffixIcon: SingleChildScrollView(
                      child: DropdownButton<String>(
                        dropdownColor: Colors.indigo,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        items: <String>[
                          'Gujarat',
                          'Maharashtra',
                          'Uttar Pradesh',
                          'Bihar',
                          'Daman',
                          'Goa',
                          'Gujarat',
                          'Maharashtra',
                          'Uttar Pradesh',
                          'Bihar',
                          'Daman',
                          'Goa',
                        ].map(
                          (String value) {
                            return DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            );
                          },
                        ).toList(),
                        onChanged: (String val) {
                          _statecontroller.text = val;
                        },
                      ),
                    ),
                    hintText: 'Select State',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  focusNode: _state,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_state);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please select State';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => _submitForm(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
