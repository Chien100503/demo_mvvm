import '../repositories/student_repository.dart';

class DeleteStudentUsercase {
  final StudentRepository repository;
  DeleteStudentUsercase({required this.repository});

  Future<void> call(String id) async {
    return repository.delete(id);
  }
}