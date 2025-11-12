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
      return data
          .map((json) => StudentModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw NetworkException('Failed to fetch students: ${e.message}');
    }
  }

  Future<StudentModel> createStudent(StudentModel student) async {
    try {
      final data = Map<String, dynamic>.from(student.toJson());
      // If id is empty (new resource), don't send it to the API
      if (data['id'] == null ||
          (data['id'] is String && (data['id'] as String).isEmpty)) {
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

      /// vì sao lai dùng Map<String, dynamic>.from(student.toJson()) thay vì student.toJson() trực tiếp
      /// để tạo một bản sao mới của bản đồ JSON được trả về bởi phương thức toJson() của đối tượng student.
      /// Điều này rất quan trọng vì chúng ta cần sửa đổi bản đồ này (bằng cách loại bỏ trường 'id') trước khi
      /// gửi nó trong yêu cầu PUT. Nếu chúng ta sử dụng trực tiếp student.toJson(),
      /// chúng ta sẽ sửa đổi bản đồ gốc được trả về bởi toJson(), điều này có thể dẫn đến các hành vi
      /// không mong muốn nếu bản đồ đó được sử dụng ở nơi khác trong mã của chúng ta.
      final data = Map<String, dynamic>.from(student.toJson());
      data.remove('id');
      final response = await apiService.dio.put(
        '/students/${student.id}',
        data: data,
      );
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
