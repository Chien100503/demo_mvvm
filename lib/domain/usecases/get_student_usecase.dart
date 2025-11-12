import '../repositories/student_repository.dart';
import '../entities/student.dart';

class GetStudentUsecase {
  final StudentRepository repository;
  GetStudentUsecase({required this.repository});

  Future<List<Student>> call() async {
    return repository.getAll();
  }
}
