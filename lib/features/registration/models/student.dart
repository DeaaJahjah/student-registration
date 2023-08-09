import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_registeration_system/config/enums/enums.dart';
import 'package:student_registeration_system/features/registration/models/certificate.dart';
import 'package:student_registeration_system/features/registration/models/person.dart';
import 'package:student_registeration_system/features/registration/models/school.dart';

part 'student.g.dart';

@JsonSerializable(explicitToJson: true)
class Student extends Equatable {
  String? id;
  @JsonKey(name: "student_id")
  String? studentId;
  @JsonKey(name: "acceptance_type")
  AcceptanceType? acceptanceType;
  @JsonKey(name: "studyState")
  StudyState? studyState;
  @JsonKey(name: "accountState")
  AccountState? accountState;
  @JsonKey(name: "study_year")
  String? studyYear;
  @JsonKey(name: "collage_name")
  String? collageName;
  @JsonKey(name: "collage_id")
  String? collageId;
  @JsonKey(name: "department_name")
  String? departmentName;
  @JsonKey(name: "annual_fees")
  double? annualFees;
  @JsonKey(name: "full_name")
  String? fullName;
  String? email;
  String? nationality;
  @JsonKey(name: "phone_number")
  String? phoneNumber;
  String? work;
  String? image;
  @JsonKey(name: "place_of_birth")
  String? placeOfBirth;
  DateTime? birthday;
  String? province;
  String? area;
  @JsonKey(name: "face_color")
  String? faceColor;
  @JsonKey(name: "eyes_color")
  String? eyesColor;
  @JsonKey(name: "student_high")
  String? studentHigh;
  @JsonKey(name: "special_marks")
  String? specialMarks;
  @JsonKey(name: "record_name_number")
  String? recordNameNumber;
  @JsonKey(name: "father_name")
  String? fatherName;
  @JsonKey(name: "father_age")
  DateTime? fatherAge;
  @JsonKey(name: "father_nationality")
  String? fatherNationality;
  @JsonKey(name: "father_job")
  String? fatherJob;
  @JsonKey(name: "father_annual_salary")
  double? fatherAnnualSalary;
  @JsonKey(name: "mother_name")
  String? motherName;
  @JsonKey(name: "mother_age")
  DateTime? motherAge;
  @JsonKey(name: "mother_nationality")
  String? motherNationality;
  @JsonKey(name: "marital_status")
  bool? maritalStatus;
  @JsonKey(name: "original_adderss")
  String? originalAdderss;
  @JsonKey(name: "current_address")
  String? currentAddress;
  @JsonKey(name: "friend_address")
  String? friendAddress;
  @JsonKey(name: "wife_name")
  String? wifeName;
  @JsonKey(name: "wife_nationality")
  String? wifeNationality;
  @JsonKey(name: "wife_job")
  String? wifeJob;
  @JsonKey(name: "children_number")
  int? childrenNumber;
  @JsonKey(name: "children_names")
  List<String?>? childrenNames;
  @JsonKey(name: "sisters_brothers")
  List<Person>? sistersBrothers;
  @JsonKey(name: "second_language")
  String? secondLanguage;
  @JsonKey(name: "sport_games")
  String? sportGames;
  @JsonKey(name: "free_to_study")
  bool? freeToStudy;
  @JsonKey(name: "countries_you_travled")
  String? countriesYouTravled;
  @JsonKey(name: "clubs_orgs")
  String? clubsOrgs;
  String? notes;
  List<School>? schools;
  Certificate? certificate;
  @JsonKey(name: "partisan_name")
  String? partisanName;
  @JsonKey(name: "partisan_date")
  DateTime? partisanDate;
  @JsonKey(name: "partisan_number")
  int? partisanNumber;
  @JsonKey(name: "partisan_character")
  String? partisanCharacter;

  Student({
    this.id,
    this.studentId,
    this.acceptanceType,
    this.studyState,
    this.accountState,
    this.studyYear,
    this.collageName,
    this.email,
    this.collageId,
    this.departmentName,
    this.annualFees,
    this.fullName,
    this.nationality,
    this.phoneNumber,
    this.work,
    this.image,
    this.placeOfBirth,
    this.birthday,
    this.province,
    this.area,
    this.faceColor,
    this.eyesColor,
    this.studentHigh,
    this.specialMarks,
    this.recordNameNumber,
    this.fatherName,
    this.fatherNationality,
    this.fatherAge,
    this.fatherJob,
    this.fatherAnnualSalary,
    this.motherName,
    this.motherNationality,
    this.motherAge,
    this.originalAdderss,
    this.currentAddress,
    this.friendAddress,
    this.wifeName,
    this.wifeNationality,
    this.wifeJob,
    this.childrenNumber,
    this.childrenNames,
    this.sistersBrothers,
    this.secondLanguage,
    this.sportGames,
    this.maritalStatus,
    this.freeToStudy,
    this.countriesYouTravled,
    this.clubsOrgs,
    this.notes,
    this.schools,
    this.certificate,
    this.partisanName,
    this.partisanDate,
    this.partisanNumber,
    this.partisanCharacter,
  });

  Student copyWith({
    String? id,
    String? studentId,
    AcceptanceType? acceptanceType,
    StudyState? studyState,
    AccountState? accountState,
    String? studyYear,
    String? collageName,
    String? collageId,
    String? departmentName,
    double? annualFees,
    String? fullName,
    String? nationality,
    String? phoneNumber,
    String? work,
    String? image,
    String? email,
    String? placeOfBirth,
    DateTime? birthday,
    String? province,
    String? area,
    String? faceColor,
    String? eyesColor,
    String? studentHigh,
    String? specialMarks,
    String? recordNameNumber,
    String? fatherName,
    String? fatherNationality,
    DateTime? fatherAge,
    String? fatherJob,
    double? fatherAnnualSalary,
    String? motherName,
    String? motherNationality,
    DateTime? motherAge,
    String? originalAdderss,
    String? currentAddress,
    String? friendAddress,
    String? wifeName,
    String? wifeNationality,
    String? wifeJob,
    bool? maritalStatus,
    int? childrenNumber,
    List<String>? childrenNames,
    List<Person>? sistersBrothers,
    String? secondLanguage,
    String? sportGames,
    bool? freeToStudy,
    String? countriesYouTravled,
    String? clubsOrgs,
    String? notes,
    List<School>? schools,
    Certificate? certificate,
    String? partisanName,
    DateTime? partisanDate,
    int? partisanNumber,
    String? partisanCharacter,
  }) {
    return Student(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      acceptanceType: acceptanceType ?? this.acceptanceType,
      studyState: studyState ?? this.studyState,
      accountState: accountState ?? this.accountState,
      studyYear: studyYear ?? this.studyYear,
      email: email ?? this.email,
      collageName: collageName ?? this.collageName,
      collageId: collageId ?? this.collageId,
      departmentName: departmentName ?? this.departmentName,
      annualFees: annualFees ?? this.annualFees,
      fullName: fullName ?? this.fullName,
      nationality: nationality ?? this.nationality,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      work: work ?? this.work,
      image: image ?? this.image,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      birthday: birthday ?? this.birthday,
      province: province ?? this.province,
      area: area ?? this.area,
      faceColor: faceColor ?? this.faceColor,
      eyesColor: eyesColor ?? this.eyesColor,
      studentHigh: studentHigh ?? this.studentHigh,
      specialMarks: specialMarks ?? this.specialMarks,
      recordNameNumber: recordNameNumber ?? this.recordNameNumber,
      fatherName: fatherName ?? this.fatherName,
      fatherNationality: fatherNationality ?? this.fatherNationality,
      fatherAge: fatherAge ?? this.fatherAge,
      fatherJob: fatherJob ?? this.fatherJob,
      fatherAnnualSalary: fatherAnnualSalary ?? this.fatherAnnualSalary,
      motherName: motherName ?? this.motherName,
      motherNationality: motherNationality ?? this.motherNationality,
      motherAge: motherAge ?? this.motherAge,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      originalAdderss: originalAdderss ?? this.originalAdderss,
      currentAddress: currentAddress ?? this.currentAddress,
      friendAddress: friendAddress ?? this.friendAddress,
      wifeName: wifeName ?? this.wifeName,
      wifeNationality: wifeNationality ?? this.wifeNationality,
      wifeJob: wifeJob ?? this.wifeJob,
      childrenNumber: childrenNumber ?? this.childrenNumber,
      childrenNames: childrenNames ?? this.childrenNames,
      sistersBrothers: sistersBrothers ?? this.sistersBrothers,
      secondLanguage: secondLanguage ?? this.secondLanguage,
      sportGames: sportGames ?? this.sportGames,
      freeToStudy: freeToStudy ?? this.freeToStudy,
      countriesYouTravled: countriesYouTravled ?? this.countriesYouTravled,
      clubsOrgs: clubsOrgs ?? this.clubsOrgs,
      notes: notes ?? this.notes,
      schools: schools ?? this.schools,
      certificate: certificate ?? this.certificate,
      partisanName: partisanName ?? this.partisanName,
      partisanDate: partisanDate ?? this.partisanDate,
      partisanNumber: partisanNumber ?? this.partisanNumber,
      partisanCharacter: partisanCharacter ?? this.partisanCharacter,
    );
  }

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);

  factory Student.fromFirestore(DocumentSnapshot documentSnapshot) {
    Student student = Student.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    student = student.copyWith(id: documentSnapshot.id);
    return student;
  }

  @override
  List<Object?> get props => [
        id,
        studentId,
        acceptanceType,
        studyState,
        accountState,
        collageName,
        email,
        collageId,
        departmentName,
        annualFees,
        fullName,
        nationality,
        phoneNumber,
        work,
        image,
        placeOfBirth,
        birthday,
        province,
        area,
        faceColor,
        eyesColor,
        studentHigh,
        specialMarks,
        recordNameNumber,
        fatherName,
        fatherNationality,
        fatherAge,
        fatherJob,
        fatherAnnualSalary,
        motherName,
        motherNationality,
        motherAge,
        originalAdderss,
        currentAddress,
        friendAddress,
        wifeName,
        wifeNationality,
        wifeJob,
        childrenNumber,
        childrenNames,
        sistersBrothers,
        secondLanguage,
        sportGames,
        maritalStatus,
        freeToStudy,
        countriesYouTravled,
        clubsOrgs,
        notes,
        schools,
        certificate,
        partisanName,
        partisanDate,
        partisanNumber,
        partisanCharacter,
      ];
}
