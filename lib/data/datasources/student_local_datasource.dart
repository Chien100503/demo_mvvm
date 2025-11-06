import 'package:demo_restful_api/data/models/student_model.dart';
import 'package:demo_restful_api/domain/entities/student.dart';
import 'package:uuid/uuid.dart';

class StudentLocalDatasource {
  final Map<String, StudentModel> _storage = {};
  final _uuid = Uuid();

  Future<List<StudentModel>> getAll() async {
    await Future.delayed(const Duration(microseconds: 150)); // Simulate some delay;
    return _storage.values.toList();
  }

  Future<StudentModel> create(StudentModel student) async {
    final id = _uuid.v4();
    final model = StudentModel(
      id: id,
      fullName: student.fullName,
      age: student.age,
      address: student.address,
      major: student.major,
    );
    _storage[id] = model;
    return model;
  }

  Future<StudentModel> update(StudentModel student) async {
    if (!_storage.containsKey(student.id)) {
      throw Exception('Student not found');
    }
    _storage[student.id] = student;
    return student;
  }

  Future<void> delete(String id) async {
    _storage.remove(id);
  }
}