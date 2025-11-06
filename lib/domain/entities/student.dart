class Student {
  final String id;
  final String fullName;
  final int age;
  final String address;
  final String major;

  Student({
    required this.id,
    required this.fullName,
    required this.age,
    required this.address,
    required this.major,
  });

  Student copyWith({
    String? id,
    String? fullName,
    int? age,
    String? address,
    String? major,
  }) {
    return Student(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      age: age ?? this.age,
      address: address ?? this.address,
      major: major ?? this.major,
    );
  }
}
