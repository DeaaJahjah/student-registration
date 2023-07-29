import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'student_guid.g.dart';

@JsonSerializable(explicitToJson: true)
class StudentGuid extends Equatable {
  final String id;
  final String title;
  final String path;
  @JsonKey(name: 'required_docs')
  final String requiredDocs;
  final double fees;
  final String? link;

  const StudentGuid({
    required this.id,
    required this.title,
    required this.path,
    required this.requiredDocs,
    required this.fees,
    this.link,
  });
  StudentGuid copyWith({
    String? id,
    String? title,
    String? path,
    String? requiredDocs,
    String? image,
    double? fees,
    String? link,
  }) {
    return StudentGuid(
      id: id ?? this.id,
      title: title ?? this.title,
      path: path ?? this.path,
      requiredDocs: requiredDocs ?? this.requiredDocs,
      fees: fees ?? this.fees,
      link: link ?? this.link,
    );
  }

  factory StudentGuid.fromJson(Map<String, dynamic> json) => _$StudentGuidFromJson(json);

  Map<String, dynamic> toJson() => _$StudentGuidToJson(this);

  factory StudentGuid.fromFirestore(DocumentSnapshot documentSnapshot) {
    StudentGuid studentGuid = StudentGuid.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    studentGuid = studentGuid.copyWith(id: documentSnapshot.id);
    return studentGuid;
  }
  @override
  List<Object?> get props => [id, title, path, requiredDocs, fees, link];
}
