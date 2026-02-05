import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/student.dart';
import '../../data/models/teacher.dart';
import '../../data/excel_parser/excel_parser.dart';

enum IdType { student, teacher }

class IdState {
  final IdType selectedType;
  final List<Student> students;
  final List<Teacher> teachers;
  final bool isLoading;
  final String? error;

  const IdState({
    this.selectedType = IdType.student,
    this.students = const [],
    this.teachers = const [],
    this.isLoading = false,
    this.error,
  });

  IdState copyWith({
    IdType? selectedType,
    List<Student>? students,
    List<Teacher>? teachers,
    bool? isLoading,
    String? error,
  }) {
    return IdState(
      selectedType: selectedType ?? this.selectedType,
      students: students ?? this.students,
      teachers: teachers ?? this.teachers,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class IdNotifier extends StateNotifier<IdState> {
  IdNotifier() : super(const IdState());

  void setIdType(IdType type) {
    state = state.copyWith(selectedType: type);
  }

  Future<void> loadExcelFile(Uint8List bytes) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      if (state.selectedType == IdType.student) {
        final students = ExcelParser.parseStudentExcel(bytes);
        state = state.copyWith(students: students, isLoading: false);
      } else {
        final teachers = ExcelParser.parseTeacherExcel(bytes);
        state = state.copyWith(teachers: teachers, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearData() {
    state = state.copyWith(students: [], teachers: []);
  }
}

final idProvider = StateNotifierProvider<IdNotifier, IdState>((ref) {
  return IdNotifier();
});
