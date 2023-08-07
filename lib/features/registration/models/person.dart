import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_registeration_system/config/enums/enums.dart';

part 'person.g.dart';

@JsonSerializable(explicitToJson: true)
class Person extends Equatable {
  String id;
  String? name;
  String? work;
  String? address;
  @JsonKey(name: "marital_status")
  MaritalStatus maritalStatus;

  Person({
    required this.id,
    required this.name,
    required this.work,
    required this.address,
    required this.maritalStatus,
  });
  Person copyWith({
    String? id,
    String? name,
    String? work,
    String? address,
    MaritalStatus? maritalStatus,
  }) {
    return Person(
      id: id ?? this.id,
      name: name ?? this.name,
      work: work ?? this.work,
      address: address ?? this.address,
      maritalStatus: maritalStatus ?? this.maritalStatus,
    );
  }

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  factory Person.fromFirestore(DocumentSnapshot documentSnapshot) {
    Person person = Person.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    person = person.copyWith(id: documentSnapshot.id);
    return person;
  }

  @override
  List<Object?> get props => [id, name, work, address, maritalStatus];
}
