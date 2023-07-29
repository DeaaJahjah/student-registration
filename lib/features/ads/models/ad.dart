import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ad.g.dart';

@JsonSerializable(explicitToJson: true)
class Ad extends Equatable {
  final String id;
  final String text;
  final String? image;

  const Ad({
    required this.id,
    required this.text,
    this.image,
  });
  Ad copyWith({
    String? id,
    String? text,
    String? image,
  }) {
    return Ad(
      id: id ?? this.id,
      text: text ?? this.text,
      image: image ?? this.image,
    );
  }

  factory Ad.fromJson(Map<String, dynamic> json) => _$AdFromJson(json);

  Map<String, dynamic> toJson() => _$AdToJson(this);

  factory Ad.fromFirestore(DocumentSnapshot documentSnapshot) {
    Ad ad = Ad.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    ad = ad.copyWith(id: documentSnapshot.id);
    return ad;
  }
  @override
  List<Object?> get props => [id, text, image];
}
