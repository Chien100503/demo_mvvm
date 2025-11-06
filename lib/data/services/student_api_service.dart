import 'package:demo_restful_api/data/models/student_model.dart';
import 'package:dio/dio.dart';

import '../../core/network/api_services.dart';
import '../../core/network/network_exceptions.dart';

class StudentApiService {
  final ApiService apiService;
  StudentApiService(this.apiService);

  Future<StudentModel> fetchStudentById(String id) async {
    try {
      final response = await apiService.dio.get('/students/$id');
      return StudentModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw NetworkException('Failed to fetch student: ${e.message}');
    }
  }

  Future<List<StudentModel>> fetchStudents() async {
    try {
      final response = await apiService.dio.get('/students');
      final data = response.data as List<dynamic>;
      return data.map((json) => StudentModel.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      print(e.message);
      throw NetworkException('Failed to fetch students: ${e.message}');

    }
  }

  Future<StudentModel> createStudent(StudentModel student) async {
    try {
      final data = Map<String, dynamic>.from(student.toJson());
      // If id is empty (new resource), don't send it to the API
      if (data['id'] == null || (data['id'] is String && (data['id'] as String).isEmpty)) {
        data.remove('id');
      }
      final response = await apiService.dio.post('/students', data: data);
      return StudentModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw NetworkException('Failed to create student: ${e.message}');
    }
  }

  Future<StudentModel> updateStudent(StudentModel student) async {
    try {
      if (student.id.isEmpty) {
        throw NetworkException('Cannot update student: missing id');
      }
      final data = Map<String, dynamic>.from(student.toJson());
      // For update, id is sent in path; remove from body to avoid conflicts
      data.remove('id');
      final response = await apiService.dio.put('/students/${student.id}', data: data);
      return StudentModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw NetworkException('Failed to update student: ${e.message}');
    }
  }

  Future<void> deleteStudent(String id) async {
    try {
      await apiService.dio.delete('/students/$id');
    } on DioException catch (e) {
      throw NetworkException('Failed to delete student: ${e.message}');
    }
  }
}