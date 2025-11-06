import 'package:demo_restful_api/domain/entities/student.dart';

abstract class StudentRepository {
  Future<List<Student>> getAll();
  Future<Student> add(Student student);
  Future<Student> update(Student student);
  Future<void> delete(String id);
  Future<Student> getById(String id);
}