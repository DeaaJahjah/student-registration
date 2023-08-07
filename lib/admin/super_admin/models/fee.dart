import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_registeration_system/config/enums/enums.dart';

part 'fee.g.dart';

@JsonSerializable(explicitToJson: true)
class Fee extends Equatable {
  final String id;
  @JsonKey(name: 'acceptance_type')
  final AcceptanceType acceptanceType;
  @JsonKey(name: 'study_state')
  final StudyState studyState;
  final double cost;

  const Fee({
    required this.id,
    required this.acceptanceType,
    required this.studyState,
    required this.cost,
  });

  Fee copyWith({
    String? id,
    AcceptanceType? acceptanceType,
    StudyState? studyState,
    double? cost,
  }) {
    return Fee(
      id: id ?? this.id,
      acceptanceType: acceptanceType ?? this.acceptanceType,
      studyState: studyState ?? this.studyState,
      cost: cost ?? this.cost,
    );
  }

  factory Fee.fromJson(Map<String, dynamic> json) => _$FeeFromJson(json);

  Map<String, dynamic> toJson() => _$FeeToJson(this);

  factory Fee.fromFirestore(DocumentSnapshot documentSnapshot) {
    Fee fees = Fee.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    fees = fees.copyWith(id: documentSnapshot.id);
    return fees;
  }

  @override
  List<Object?> get props => throw [id, acceptanceType, studyState, cost];
}
