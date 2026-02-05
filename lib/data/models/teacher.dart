import 'dart:typed_data';

class Teacher {
  final String staffId;
  final String name;
  final String department;
  final String designation;
  final String bloodGroup;
  final String mobile;
  final String email;
  final String address;
  final Uint8List? photo;

  const Teacher({
    required this.staffId,
    required this.name,
    required this.department,
    required this.designation,
    required this.bloodGroup,
    required this.mobile,
    required this.email,
    required this.address,
    this.photo,
  });
}
