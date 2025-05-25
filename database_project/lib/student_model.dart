class Student {
  final String id;
  final String name;
  final String roomId;
  final String contact;
  final String gender;

  Student({
    required this.id,
    required this.name,
    required this.roomId,
    required this.contact,
    required this.gender,
  });

  // Method to create a Student object from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['StudentID'].toString(),
      name: json['StudentName'],
      roomId: json['RoomID'],
      contact: json['SContactNo'],
      gender: json['Gender'],
    );
  }
}
