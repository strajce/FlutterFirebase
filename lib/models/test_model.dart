class TestModel {
  final int? id;
  final String name;

  TestModel({this.id, required this.name});

  factory TestModel.fromMap(Map<String, dynamic> json) => TestModel(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
