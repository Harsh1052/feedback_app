class QuestionModel {
  String department;
  String category;
  String question;
  String yesPoint;
  String noPoint;
  String id;

  QuestionModel(
      {this.category,
      this.department,
      this.noPoint,
      this.question,
      this.yesPoint,
      this.id});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
        id: json["id"],
        category: json["category"],
        department: json["department"],
        noPoint: json["no_point"],
        yesPoint: json["yes_point"],
        question: json["question"]);
  }
}
