import '../../data/repositories/student_repository.dart';
import '../entities/student.dart';

class GetStudentUsercase {
  final StudentRepository repository;
  GetStudentUsercase({required this.repository});

  Future<List<Student>> call() async {
    return repository.getAll();
  }
}