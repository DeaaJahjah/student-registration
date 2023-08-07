import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_registeration_system/config/enums/enums.dart';

part 'certificate.g.dart';

@JsonSerializable(explicitToJson: true)
class Certificate extends Equatable {
  final String id;
  final String type;
  final String major;
  @JsonKey(name: 'success_cycle')
  final String successCycle;
  final double average;
  final DateTime date;

  const Certificate({
    required this.id,
    required this.type,
    required this.major,
    required this.successCycle,
    required this.average,
    required this.date,
  });

  Certificate copyWith({
    String? id,
    String? type,
    String? major,
    String? successCycle,
    double? average,
    DateTime? date,
  }) {
    return Certificate(
      id: id ?? this.id,
      type: type ?? this.type,
      major: major ?? this.major,
      successCycle: successCycle ?? this.successCycle,
      average: average ?? this.average,
      date: date ?? this.date,
    );
  }

  factory Certificate.fromJson(Map<String, dynamic> json) => _$CertificateFromJson(json);

  Map<String, dynamic> toJson() => _$CertificateToJson(this);

  factory Certificate.fromFirestore(DocumentSnapshot documentSnapshot) {
    Certificate certificate = Certificate.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    certificate = certificate.copyWith(id: documentSnapshot.id);
    return certificate;
  }
  @override
  List<Object?> get props => [id, type, major, successCycle, average, date];
}
