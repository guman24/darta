import 'package:flutter/cupertino.dart';

class JariSifaris {
  final String title;
  final String date;
  final String photoURL;
  final String status;
  final double workPercent;
  final Color color;
  JariSifaris({
    this.title,
    this.date,
    this.photoURL,
    this.status,
    this.workPercent,
    this.color,
  });
}

List<JariSifaris> jariSifarisList = [
  JariSifaris(
      title: "जाँच हुदै",
      date: "२०२०/०१/०२",
      photoURL: null,
      status: "जाँच हुदै",
      color: Color(0xFFEB9615),
      workPercent: 0.5),
  JariSifaris(
      title: "जाँच हुदै",
      date: "२०२०/०१/०२",
      photoURL: null,
      status: "सफल",
      color: Color(0xFF00A928),
      workPercent: 1.0),
  JariSifaris(
      title: "जाँच हुदै",
      date: "२०२०/०१/०२",
      photoURL: null,
      status: "असफल",
      color: Color(0xFFBD0912),
      workPercent: 1.0),
];
