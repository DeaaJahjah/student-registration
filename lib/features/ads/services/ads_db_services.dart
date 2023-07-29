import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_registeration_system/features/ads/models/ad.dart';
import 'package:student_registeration_system/registration/providers/registration_provider.dart';

class AdsDbServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Ad>> getAds(BuildContext context) async {
    List<Ad> ads = [];
    // final String collageId = SharedPref.load('collage_id');
    var query = await _db
        .collection('colleges')
        .doc(context.read<RegistrationProvider>().student.collageId)
        .collection('ads')
        .get();

    for (var doc in query.docs) {
      ads.add(Ad.fromFirestore(doc));
    }
    return ads;
  }
}
