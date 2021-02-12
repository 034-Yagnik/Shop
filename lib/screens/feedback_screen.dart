import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/feedbacks.dart';
import '../widget/app_drawer.dart';
import '../screens/product_overview_screen.dart';
import 'dart:async';

class FeedbackScreen extends StatefulWidget {
  static const routename = '/feedback';

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  // var _isLoading = false;
  TextEditingController textEditingController = TextEditingController();
  final _form = GlobalKey<FormState>();
  // var _editedFeedback = Feedbacks(
  //   id: null,
  //   feedback: 'AAmit',
  // );

  Future<void> _submitForm(BuildContext context) async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    // setState(() {
    //   _isLoading = true;
    // });
    await Provider.of<Feedbacks>(context, listen: false)
        .addFeedback(textEditingController.text);
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(ProductOverviewScreen.routename);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(
                  labelText: 'Feedback',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter a Feedback';
                  }
                  return null;
                },
              ),
              FlatButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => _submitForm(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
