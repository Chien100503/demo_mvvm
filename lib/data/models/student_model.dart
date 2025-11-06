import 'package:demo_restful_api/domain/entities/student.dart';

class StudentModel extends Student {
  StudentModel({
    required super.id,
    required super.fullName,
    required super.age,
    required super.address,
    required super.major,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      age: json['age'] as int,
      address: json['address'] as String,
      major: json['major'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'age': age,
        'address': address,
        'major': major,
      };
}