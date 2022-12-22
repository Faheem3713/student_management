class StudentModel {
  int? id;

  final String studentName;

  final String studentAge;

  final String studentClass;

  final String studentContactNum;
  final String studentImage;
  StudentModel({
    required this.studentImage,
    required this.studentName,
    required this.studentAge,
    required this.studentClass,
    required this.studentContactNum,
    this.id,
  });
  static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final studentName = map['name'] as String;
    final studentAge = map['age'] as String;
    final studentClass = map['class'] as String;
    final studentNum = map['number'] as String;
    final studentImage = map['image'] as String;
    return StudentModel(
        studentImage: studentImage,
        id: id,
        studentName: studentName,
        studentAge: studentAge,
        studentClass: studentClass,
        studentContactNum: studentNum);
  }
}
