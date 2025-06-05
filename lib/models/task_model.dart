class SingleTaskModel {
  int? id;
  String? title;
  String? description;

  SingleTaskModel({
    this.id,
    this.title,
    this.description
  });

  SingleTaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }
}