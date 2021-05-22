import 'package:feedbacks_app/model/question_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../retrofit.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List<QuestionModel> questions = [];
  int currentIndex = 0;
  bool loading = true;
  int selected = 0;
  final TextEditingController _remarkController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getQuestion().then((value) {
        questions = value;
        setState(() {
          loading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    print(screenHeight);
    print(screenWidth);
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backwardsCompatibility: false,
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: Colors.white24),
              brightness: Brightness.light,
              backgroundColor: Colors.black,
              title: Text(
                "FeedBack Form",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: questions.length == currentIndex
                ? Center(
                    child: Text(
                      "Thank You For Giving Review",
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                  )
                : SafeArea(
                    child: kIsWeb
                        ? Center(
                            child: Container(
                              width: screenWidth < 700
                                  ? screenWidth * 0.7
                                  : screenWidth * 0.5,
                              height: screenHeight < 800
                                  ? screenHeight * 0.8
                                  : screenHeight * 0.6,
                              child: Card(
                                elevation: 8.0,
                                child: Container(
                                  padding: EdgeInsets.all(30.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        runSpacing: 10.0,
                                        direction: Axis.horizontal,
                                        spacing: 10.0,
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Department:-",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 2.0,
                                                ),
                                                Text(
                                                  questions[currentIndex]
                                                      .department,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            padding: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Category:-",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 2.0,
                                                ),
                                                Text(
                                                  questions[currentIndex]
                                                      .category,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            padding: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                          )
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 25.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Q-${currentIndex + 1}",
                                                style: TextStyle(
                                                    fontSize: 22.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 8.0,
                                              ),
                                              Text(
                                                questions[currentIndex]
                                                    .question,
                                                style: TextStyle(
                                                    fontSize: 22.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )),
                                      Container(
                                        child: Column(
                                          children: [
                                            RadioListTile(
                                              activeColor: Colors.black,
                                              value: 1,
                                              groupValue: selected == 1 ? 1 : 0,
                                              onChanged: (value) {
                                                print(value);
                                                setState(() {
                                                  selected = value;
                                                });
                                              },
                                              title: Text(
                                                "Yes",
                                                style:
                                                    TextStyle(fontSize: 20.0),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            RadioListTile(
                                                activeColor: Colors.black,
                                                title: Text(
                                                  "No",
                                                  style:
                                                      TextStyle(fontSize: 20.0),
                                                ),
                                                value: 2,
                                                groupValue:
                                                    selected == 2 ? 2 : 0,
                                                onChanged: (value) {
                                                  print(value);
                                                  setState(() {
                                                    selected = value;
                                                  });
                                                })
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: _remarkController,
                                          maxLines: 2,
                                          decoration: InputDecoration(
                                              hintText: "Add Your Opinion",
                                              border: InputBorder.none,
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black))),
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          height: 50.0,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                padding:
                                                    MaterialStateProperty.all(
                                                        EdgeInsets.all(15.0)),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.black)),
                                            onPressed: () async {
                                              if (selected == 0) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            Colors.yellow[700],
                                                        content: Text(
                                                            "Please Select One Answer First")));

                                                return;
                                              }
                                              int success = await postFeedback(
                                                  questions[currentIndex].id,
                                                  selected.toString(),
                                                  _remarkController.text);

                                              if (success == 1) {
                                                _remarkController.clear();
                                                setState(() {
                                                  selected = 0;
                                                  if (questions.length >
                                                      currentIndex) {
                                                    currentIndex++;
                                                  }
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            Colors.green,
                                                        content: Text(
                                                            "Your Answer Submit")));
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            Colors.red,
                                                        content: Text(
                                                            "Your Answer Not Submit")));
                                              }
                                            },
                                            child: Text(
                                              "Submit",
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Wrap(
                                    runSpacing: 10.0,
                                    direction: Axis.horizontal,
                                    spacing: 10.0,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Department:-",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 2.0,
                                            ),
                                            Text(
                                              questions[currentIndex]
                                                  .department,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Category:-",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 2.0,
                                            ),
                                            Text(
                                              questions[currentIndex].category,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 25.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Q-${currentIndex + 1}",
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          questions[currentIndex].question,
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                              ),
                              SliverToBoxAdapter(
                                child: Container(
                                  child: Column(
                                    children: [
                                      RadioListTile(
                                        activeColor: Colors.black,
                                        value: 1,
                                        groupValue: selected == 1 ? 1 : 0,
                                        onChanged: (value) {
                                          print(value);
                                          setState(() {
                                            selected = value;
                                          });
                                        },
                                        title: Text(
                                          "Yes",
                                          style: TextStyle(fontSize: 20.0),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      RadioListTile(
                                          activeColor: Colors.black,
                                          title: Text(
                                            "No",
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                          value: 2,
                                          groupValue: selected == 2 ? 2 : 0,
                                          onChanged: (value) {
                                            print(value);
                                            setState(() {
                                              selected = value;
                                            });
                                          })
                                    ],
                                  ),
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _remarkController,
                                    maxLines: 2,
                                    decoration: InputDecoration(
                                        hintText: "Add Your Opinion",
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black))),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
            bottomNavigationBar: kIsWeb
                ? null
                : questions.length == currentIndex
                    ? null
                    : BottomAppBar(
                        elevation: 0.0,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(15.0)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                            onPressed: () async {
                              if (selected == 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.yellow[700],
                                        content: Text(
                                            "Please Select One Answer First")));

                                return;
                              }
                              int success = await postFeedback(
                                  questions[currentIndex].id,
                                  selected.toString(),
                                  _remarkController.text);

                              if (success == 1) {
                                _remarkController.clear();
                                setState(() {
                                  selected = 0;
                                  if (questions.length > currentIndex) {
                                    currentIndex++;
                                  }
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text("Your Answer Submit")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.red,
                                        content:
                                            Text("Your Answer Not Submit")));
                              }
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                      ),
          );
  }

  fetchQuestions() {}
}
