import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model/question_model.dart';

String URL = "https://contactkro.com/demo/craftbox/service/";

///Get Questions
//https://contactkro.com/demo/craftbox/service/service_genral.php?key=1226&s=112

final String KEY = "1226";

Future<List<QuestionModel>> getQuestion() async {
  List<QuestionModel> questions = [];

  var uri = Uri.parse(URL + "service_genral.php?key=$KEY&s=112");
  var response =
      await http.get(uri).timeout(Duration(seconds: 30), onTimeout: () {
    return http.Response("Something Went Wrong", 400);
  });

  if (response.statusCode == 200) {
    String data = response.body;
    var extractData = jsonDecode(data);
    if (extractData["ack"] == 1) {
      for (var result in extractData["result"]) {
        questions.add(QuestionModel.fromJson(result));
      }
    } else {
      questions.add(QuestionModel(
          category: "No Data Found",
          department: "No Data Found",
          noPoint: "No Data Found",
          yesPoint: "No Data Found",
          question: "No Data Found"));
    }
  } else {
    questions.add(QuestionModel(
        category: "No Data Found",
        department: "No Data Found",
        noPoint: "No Data Found",
        yesPoint: "No Data Found",
        question: "No Data Found"));
  }
  return questions;
}

///Post Feedback API
//http://contactkro.com/demo/craftbox/service/service_genral.php?key=1226&s=113&uid=1&que_id=1&ans=2&remark=test1

Future<int> postFeedback(String queID, String ans, String remark) async {
  var uri = Uri.parse(URL +
      "service_genral.php?key=$KEY&s=113&uid=2&que_id=$queID&ans=$ans&remark=$remark");
  var response =
      await http.post(uri).timeout(Duration(seconds: 30), onTimeout: () {
    return http.Response("Something Went Wrong", 400);
  });

  if (response.statusCode == 200) {
    String data = response.body;
    var extractData = jsonDecode(data);
    if (extractData["ack"] == 1) {
      return 1;
    } else {
      return 0;
    }
  } else {
    return 0;
  }
}
