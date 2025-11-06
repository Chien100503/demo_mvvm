import '../../data/repositories/student_repository.dart';
import '../entities/student.dart';

class UpdateStudentUsercase {
  final StudentRepository repository;
  UpdateStudentUsercase({required this.repository});

  Future<Student> call(Student student) async {
    return repository.update(student);
  }
}