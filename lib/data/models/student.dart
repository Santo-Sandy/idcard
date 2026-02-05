import 'dart:typed_data';

class Student {
  final String regNo;
  final String name;
  final String department;
  final int startYear;
  final int endYear;
  final String bloodGroup;
  final String mobile;
  final String aadhaar;
  final String email;
  final String address;
  final Uint8List? photo;

  const Student({
    required this.regNo,
    required this.name,
    required this.department,
    required this.startYear,
    required this.endYear,
    required this.bloodGroup,
    required this.mobile,
    required this.aadhaar,
    required this.email,
    required this.address,
    this.photo,
  });
}
