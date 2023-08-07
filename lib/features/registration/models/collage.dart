import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collage.g.dart';

@JsonSerializable(explicitToJson: true)
class Collage extends Equatable {
  final String id;
  final String name;
  @JsonKey(name: "annual_fees")
  final double annualFees;
  final List<String>? departments;
  @JsonKey(name: "active_registration_for_new_year")
  final bool activeRegistrationForNewYear;

  const Collage(
      {required this.id,
      required this.name,
      required this.departments,
      required this.annualFees,
      required this.activeRegistrationForNewYear});

  Collage copyWith(
      {String? id, String? name, double? annualFees, List<String>? departments, bool? activeRegistrationForNewYear}) {
    return Collage(
        id: id ?? this.id,
        name: name ?? this.name,
        annualFees: annualFees ?? this.annualFees,
        departments: departments ?? this.departments,
        activeRegistrationForNewYear: activeRegistrationForNewYear ?? this.activeRegistrationForNewYear);
  }

  factory Collage.fromJson(Map<String, dynamic> json) => _$CollageFromJson(json);

  Map<String, dynamic> toJson() => _$CollageToJson(this);

  factory Collage.fromFirestore(DocumentSnapshot documentSnapshot) {
    print(documentSnapshot.data());
    Collage collage = Collage.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    collage = collage.copyWith(id: documentSnapshot.id);
    return collage;
  }

  @override
  List<Object?> get props => [id, name, departments];
}
