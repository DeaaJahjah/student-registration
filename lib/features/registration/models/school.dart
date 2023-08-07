import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_registeration_system/config/enums/enums.dart';

part 'school.g.dart';

@JsonSerializable(explicitToJson: true)
class School extends Equatable {
  final String id;
  final String name;
  @JsonKey(name: "study_level")
  final StudyLevel studyLevel;
  final String city;
  final String province;

  const School({
    required this.id,
    required this.name,
    required this.studyLevel,
    required this.city,
    required this.province,
  });
  School copyWith({
    String? id,
    String? name,
    StudyLevel? studyLevel,
    String? city,
    String? province,
  }) {
    return School(
      id: id ?? this.id,
      name: name ?? this.name,
      studyLevel: studyLevel ?? this.studyLevel,
      city: city ?? this.city,
      province: province ?? this.province,
    );
  }

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolToJson(this);

  factory School.fromFirestore(DocumentSnapshot documentSnapshot) {
    School school = School.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    school = school.copyWith(id: documentSnapshot.id);
    return school;
  }

  @override
  List<Object?> get props => [id, name, studyLevel, city, province];
}
