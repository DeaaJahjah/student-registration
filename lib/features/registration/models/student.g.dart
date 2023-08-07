// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      id: json['id'] as String?,
      studentId: json['student_id'] as String?,
      acceptanceType:
          $enumDecodeNullable(_$AcceptanceTypeEnumMap, json['acceptance_type']),
      studyState: $enumDecodeNullable(_$StudyStateEnumMap, json['studyState']),
      accountState:
          $enumDecodeNullable(_$AccountStateEnumMap, json['accountState']),
      collageName: json['collage_name'] as String?,
      email: json['email'] as String?,
      collageId: json['collage_id'] as String?,
      departmentName: json['department_name'] as String?,
      annualFees: (json['annual_fees'] as num?)?.toDouble(),
      fullName: json['full_name'] as String?,
      nationality: json['nationality'] as String?,
      phoneNumber: json['phone_number'] as String?,
      work: json['work'] as String?,
      image: json['image'] as String?,
      placeOfBirth: json['place_of_birth'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      province: json['province'] as String?,
      area: json['area'] as String?,
      faceColor: json['face_color'] as String?,
      eyesColor: json['eyes_color'] as String?,
      studentHigh: json['student_high'] as String?,
      specialMarks: json['special_marks'] as String?,
      recordNameNumber: json['record_name_number'] as String?,
      fatherName: json['father_name'] as String?,
      fatherNationality: json['father_nationality'] as String?,
      fatherAge: json['father_age'] == null
          ? null
          : DateTime.parse(json['father_age'] as String),
      fatherJob: json['father_job'] as String?,
      fatherAnnualSalary: (json['father_annual_salary'] as num?)?.toDouble(),
      motherName: json['mother_name'] as String?,
      motherNationality: json['mother_nationality'] as String?,
      motherAge: json['mother_age'] == null
          ? null
          : DateTime.parse(json['mother_age'] as String),
      originalAdderss: json['original_adderss'] as String?,
      currentAddress: json['current_address'] as String?,
      friendAddress: json['friend_address'] as String?,
      wifeName: json['wife_name'] as String?,
      wifeNationality: json['wife_nationality'] as String?,
      wifeJob: json['wife_job'] as String?,
      childrenNumber: json['children_number'] as int?,
      childrenNames: (json['children_names'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      sistersBrothers: (json['sisters_brothers'] as List<dynamic>?)
          ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
      secondLanguage: json['second_language'] as String?,
      sportGames: json['sport_games'] as String?,
      maritalStatus: json['marital_status'] as bool?,
      freeToStudy: json['free_to_study'] as bool?,
      countriesYouTravled: json['countries_you_travled'] as String?,
      clubsOrgs: json['clubs_orgs'] as String?,
      notes: json['notes'] as String?,
      schools: (json['schools'] as List<dynamic>?)
          ?.map((e) => School.fromJson(e as Map<String, dynamic>))
          .toList(),
      certificate: json['certificate'] == null
          ? null
          : Certificate.fromJson(json['certificate'] as Map<String, dynamic>),
      partisanName: json['partisan_name'] as String?,
      partisanDate: json['partisan_date'] == null
          ? null
          : DateTime.parse(json['partisan_date'] as String),
      partisanNumber: json['partisan_number'] as int?,
      partisanCharacter: json['partisan_character'] as String?,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'id': instance.id,
      'student_id': instance.studentId,
      'acceptance_type': _$AcceptanceTypeEnumMap[instance.acceptanceType],
      'studyState': _$StudyStateEnumMap[instance.studyState],
      'accountState': _$AccountStateEnumMap[instance.accountState],
      'collage_name': instance.collageName,
      'collage_id': instance.collageId,
      'department_name': instance.departmentName,
      'annual_fees': instance.annualFees,
      'full_name': instance.fullName,
      'email': instance.email,
      'nationality': instance.nationality,
      'phone_number': instance.phoneNumber,
      'work': instance.work,
      'image': instance.image,
      'place_of_birth': instance.placeOfBirth,
      'birthday': instance.birthday?.toIso8601String(),
      'province': instance.province,
      'area': instance.area,
      'face_color': instance.faceColor,
      'eyes_color': instance.eyesColor,
      'student_high': instance.studentHigh,
      'special_marks': instance.specialMarks,
      'record_name_number': instance.recordNameNumber,
      'father_name': instance.fatherName,
      'father_age': instance.fatherAge?.toIso8601String(),
      'father_nationality': instance.fatherNationality,
      'father_job': instance.fatherJob,
      'father_annual_salary': instance.fatherAnnualSalary,
      'mother_name': instance.motherName,
      'mother_age': instance.motherAge?.toIso8601String(),
      'mother_nationality': instance.motherNationality,
      'marital_status': instance.maritalStatus,
      'original_adderss': instance.originalAdderss,
      'current_address': instance.currentAddress,
      'friend_address': instance.friendAddress,
      'wife_name': instance.wifeName,
      'wife_nationality': instance.wifeNationality,
      'wife_job': instance.wifeJob,
      'children_number': instance.childrenNumber,
      'children_names': instance.childrenNames,
      'sisters_brothers':
          instance.sistersBrothers?.map((e) => e.toJson()).toList(),
      'second_language': instance.secondLanguage,
      'sport_games': instance.sportGames,
      'free_to_study': instance.freeToStudy,
      'countries_you_travled': instance.countriesYouTravled,
      'clubs_orgs': instance.clubsOrgs,
      'notes': instance.notes,
      'schools': instance.schools?.map((e) => e.toJson()).toList(),
      'certificate': instance.certificate?.toJson(),
      'partisan_name': instance.partisanName,
      'partisan_date': instance.partisanDate?.toIso8601String(),
      'partisan_number': instance.partisanNumber,
      'partisan_character': instance.partisanCharacter,
    };

const _$AcceptanceTypeEnumMap = {
  AcceptanceType.general: 'general',
  AcceptanceType.engineersChildren: 'engineersChildren',
  AcceptanceType.parallel: 'parallel',
};

const _$StudyStateEnumMap = {
  StudyState.newStudent: 'newStudent',
  StudyState.zeroFail: 'zeroFail',
  StudyState.failOnce: 'failOnce',
  StudyState.failTwice: 'failTwice',
};

const _$AccountStateEnumMap = {
  AccountState.active: 'active',
  AccountState.pending: 'pending',
  AccountState.frozen: 'frozen',
};
