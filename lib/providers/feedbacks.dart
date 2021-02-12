import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Feedbacks with ChangeNotifier {
  final String id;
  final String feedback;

  Feedbacks({
    @required this.id,
    @required this.feedback,
  });

  Future<void> addFeedback(String feedbacks) async {
    final url = 'https://shop-app-5fd1b.firebaseio.com/feedback.json';

    try {
      await http.post(
        url,
        body: json.encode({
          'feedback': feedbacks,
        }),
      );
      // print(feedbacks.feedback);
      // final newfeedback = Feedbacks(
      //   feedback: feedbacks.feedback,
      //   id: json.decode(response.body)['name'],
      // );
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
