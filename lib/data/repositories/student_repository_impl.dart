import 'package:demo_restful_api/data/datasources/student_remote_datasource.dart';
import 'package:demo_restful_api/domain/repositories/student_repository.dart';
import 'package:demo_restful_api/domain/entities/student.dart';
import 'package:demo_restful_api/data/models/student_model.dart';

class StudentRepositoryImpl implements StudentRepository {
  final StudentRemoteDatasource remote;

  StudentRepositoryImpl({required this.remote});

  @override
  Future<List<Student>> getAll() async {
    final remoteList = await remote.getAll();
    try {
      return remoteList
          .map(
            (m) => Student(
              id: m.id,
              fullName: m.fullName,
              age: m.age,
              address: m.address,
              major: m.major,
            ),
          )
          .toList();
    } catch (_) {
      return remoteList
          .map(
            (m) => Student(
              id: m.id,
              fullName: m.fullName,
              age: m.age,
              address: m.address,
              major: m.major,
            ),
          )
          .toList();
    }
  }

  @override
  Future<Student> add(Student student) async {
    try {
      final model = await remote.create(
        StudentModel(
          id: student.id,
          fullName: student.fullName,
          age: student.age,
          address: student.address,
          major: student.major,
        ),
      );
      return Student(
        id: model.id,
        fullName: model.fullName,
        age: model.age,
        address: model.address,
        major: model.major,
      );
    } catch (_) {
      final model = await remote.create(
        StudentModel(
          id: student.id,
          fullName: student.fullName,
          age: student.age,
          address: student.address,
          major: student.major,
        ),
      );
      return Student(
        id: model.id,
        fullName: model.fullName,
        age: model.age,
        address: model.address,
        major: model.major,
      );
    }
  }

  @override
  Future<Student> update(Student student) async {
    try {
      final model = await remote.update(
        StudentModel(
          id: student.id,
          fullName: student.fullName,
          age: student.age,
          address: student.address,
          major: student.major,
        ),
      );
      return Student(
        id: model.id,
        fullName: model.fullName,
        age: model.age,
        address: model.address,
        major: model.major,
      );
    } catch (_) {
      final model = await remote.update(
        StudentModel(
          id: student.id,
          fullName: student.fullName,
          age: student.age,
          address: student.address,
          major: student.major,
        ),
      );
      return Student(
        id: model.id,
        fullName: model.fullName,
        age: model.age,
        address: model.address,
        major: model.major,
      );
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      return remote.delete(id);
    } catch (_) {
      return remote.delete(id);
    }
  }

  @override
  Future<Student> getById(String id) async {
    try {
      final model = await remote.getById(id);
      return Student(
        id: model.id,
        fullName: model.fullName,
        age: model.age,
        address: model.address,
        major: model.major,
      );
    } catch (_) {
      final model = await remote.getById(id);
      return Student(
        id: model.id,
        fullName: model.fullName,
        age: model.age,
        address: model.address,
        major: model.major,
      );
    }
  }
}
