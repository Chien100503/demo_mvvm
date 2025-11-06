import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/student.dart';
import '../viewmodels/student_notifier.dart';

class StudentFormScreen extends ConsumerStatefulWidget {
  final Student? student;

  const StudentFormScreen({super.key, this.student});

  @override
  ConsumerState createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends ConsumerState<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _ageController;
  late TextEditingController _addressController;
  late TextEditingController _majorController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(
      text: widget.student?.fullName ?? '',
    );
    _ageController = TextEditingController(
      text: widget.student?.age.toString() ?? '',
    );
    _addressController = TextEditingController(
      text: widget.student?.address ?? '',
    );
    _majorController = TextEditingController(text: widget.student?.major ?? '');
  }

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _majorController.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final notifier = ref.read(studentListProvider.notifier);
      final fullName = _fullNameController.text;
      final age = int.tryParse(_ageController.text) ?? 0;
      final address = _addressController.text;
      final major = _majorController.text;

      if (widget.student == null) {
        notifier.add(
          Student(
            id: '',
            fullName: fullName,
            age: age,
            address: address,
            major: major,
          ),
        );
      } else {
        // Update existing student
        /// vì sao lại sử dụng copyWith ở đây
        /// để giữ nguyên id của student ban đầu và chỉ cập nhật các trường khác
        /// nếu không sử dụng copyWith thì id sẽ bị mất vì ta tạo 1 instance Student mới
        final updated = widget.student!.copyWith(
          fullName: fullName,
          age: age,
          address: address,
          major: major,
        );
        notifier.updateStudent(updated);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.student != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Student' : 'Add Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) => v == null || v.isEmpty ? 'Enter name' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age'),
                validator: (v) => v == null || v.isEmpty ? 'Enter age' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter address' : null,
              ),
              TextFormField(
                controller: _majorController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Major'),
                validator: (v) => v == null || v.isEmpty ? 'Enter major' : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: Text(isEditing ? 'Update' : 'Add'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
