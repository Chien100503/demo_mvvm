import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/student_repository.dart';
import '../../domain/entities/student.dart';
import 'package:demo_restful_api/core/network/api_services.dart';
import '../../data/datasources/student_remote_datasource.dart';
import '../../data/repositories/student_repository_impl.dart';
import '../../data/services/student_api_service.dart';

final apiServiceProvider = Provider(
  (ref) => ApiService(baseUrl: 'https://690b09d41a446bb9cc24f0d5.mockapi.io'),
);
final studentApiServiceProvider = Provider(
  (ref) => StudentApiService(ref.read(apiServiceProvider)),
);
final studentRemoteDatasourceProvider = Provider(
  (ref) => StudentRemoteDatasource(ref.read(studentApiServiceProvider)),
);

final studentRepoProvider = Provider<StudentRepository>(
  (ref) =>
      StudentRepositoryImpl(remote: ref.read(studentRemoteDatasourceProvider)),
);

final studentListProvider =
    AsyncNotifierProvider<StudentListNotifierProvider, List<Student>>(
      () => StudentListNotifierProvider(),
    );

class StudentListNotifierProvider extends AsyncNotifier<List<Student>> {
  StudentRepository get repo => ref.read(studentRepoProvider);

  @override
  Future<List<Student>> build() async {
    return repo.getAll();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => repo.getAll());
  }

  Future<void> add(Student student) async {
    state = await AsyncValue.guard(() async {
      final newStudent = await repo.add(student);
      final currentList = state.value ?? [];
      return [...currentList, newStudent];
    });
  }
  Future<void> updateStudent(Student student) async {
    state = await AsyncValue.guard(() async {
      final updatedStudent = await repo.update(student);
      final currentList = state.value ?? [];
      return currentList
          .map((s) => s.id == updatedStudent.id ? updatedStudent : s)
          .toList();
    });
  }

  Future<void> delete(String id) async {
    state = await AsyncValue.guard(() async {
      await repo.delete(id);
      final currentList = state.value ?? [];
      return currentList.where((s) => s.id != id).toList();
    });
  }
}
