import '../repositories/student_repository.dart';
import '../entities/student.dart';

class AddStudentUsercase {
  final StudentRepository repository;
  AddStudentUsercase({required this.repository});

  Future<Student> call(Student student) async {
    return repository.add(student);
  }
}