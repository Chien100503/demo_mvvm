import 'dart:async';

import 'package:demo_restful_api/domain/entities/student.dart';
import 'package:demo_restful_api/presentation/viewmodels/student_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/student_repository.dart';

final studentDetailProvider = AsyncNotifierProvider.autoDispose
    .family<StudentDetailNotifier, Student, String>(StudentDetailNotifier.new);

class StudentDetailNotifier extends AsyncNotifier<Student> {
  StudentRepository get repo => ref.read(studentRepoProvider);
  final String id;

  StudentDetailNotifier(this.id);

  @override
  Future<Student> build() {
    return repo.getById(id);
  }
}
