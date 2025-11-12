import 'package:demo_restful_api/data/models/student_model.dart';
import 'package:demo_restful_api/data/services/student_api_service.dart';

class StudentRemoteDatasource {
  final StudentApiService apiService;
  StudentRemoteDatasource(this.apiService);
  Future<List<StudentModel>> getAll() async {
    return await apiService.fetchStudents();
  }

  Future<StudentModel> getById(String id) async {
    return await apiService.fetchStudentById(id);
  }

  Future<StudentModel> create(StudentModel student) async {
    return await apiService.createStudent(student);
  }

  Future<StudentModel> update(StudentModel student) async {
    return await apiService.updateStudent(student);
  }

  Future<void> delete(String id) async {
    return await apiService.deleteStudent(id);
  }
}
abstract class Abc {
  void abc();
}
class CDE extends Abc {
  @override
  void abc() {
    // TODO: implement abc
  }
}