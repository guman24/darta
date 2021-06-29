import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sifaris_app/features/template/data/model/test/dhancha.dart';

class Category {
  final String name;
  final Color color;

  List<Dhancha> templates;
  Category({
    @required this.name,
    @required this.color,
    @required this.templates,
  });
}

List<Category> categoryList = [
  Category(
    name: "व्यवसाय दर्ता",
    color: Color(0xFF7F69EF),
    templates: [
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFFF47181),
          icon: Icons.add_business_rounded),
      Dhancha(
          title: "अपाङ्गता प्रमाणित",
          color: Color(0xFF7F5B53),
          icon: Icons.child_care_sharp),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFF2488FF),
          icon: Icons.business),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFF2488FF),
          icon: Icons.business),
      Dhancha(
          title: "अपाङ्गता प्रमाणित",
          color: Color(0xFF7F5B53),
          icon: Icons.child_care_sharp),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFFF47181),
          icon: Icons.add_business_rounded),
    ],
  ),
  Category(
    name: "अपाङ्गता प्रमाणित",
    color: Color(0xFFFD7153),
    templates: [
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFFF47181),
          icon: Icons.add_business_rounded),
      Dhancha(
          title: "अपाङ्गता प्रमाणित",
          color: Color(0xFF7F5B53),
          icon: Icons.child_care_sharp),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFF2488FF),
          icon: Icons.business),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFF2488FF),
          icon: Icons.business),
      Dhancha(
          title: "अपाङ्गता प्रमाणित",
          color: Color(0xFF7F5B53),
          icon: Icons.child_care_sharp),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFFF47181),
          icon: Icons.add_business_rounded),
    ],
  ),
  Category(
    name: "विद्यालय ठाउँसारी",
    color: Color(0xFFFDB209),
    templates: [
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFFF47181),
          icon: Icons.add_business_rounded),
      Dhancha(
          title: "अपाङ्गता प्रमाणित",
          color: Color(0xFF7F5B53),
          icon: Icons.child_care_sharp),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFF2488FF),
          icon: Icons.business),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFF2488FF),
          icon: Icons.business),
      Dhancha(
          title: "अपाङ्गता प्रमाणित",
          color: Color(0xFF7F5B53),
          icon: Icons.child_care_sharp),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFFF47181),
          icon: Icons.add_business_rounded),
    ],
  ),
  Category(
    name: "अंगिकृत नागरिकता",
    color: Color(0xFF48A983),
    templates: [
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFFF47181),
          icon: Icons.add_business_rounded),
      Dhancha(
          title: "अपाङ्गता प्रमाणित",
          color: Color(0xFF7F5B53),
          icon: Icons.child_care_sharp),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFF2488FF),
          icon: Icons.business),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFF2488FF),
          icon: Icons.business),
      Dhancha(
          title: "अपाङ्गता प्रमाणित",
          color: Color(0xFF7F5B53),
          icon: Icons.child_care_sharp),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFFF47181),
          icon: Icons.add_business_rounded),
    ],
  ),
  Category(
    name: "व्यवसाय दर्ता",
    color: Color(0xFF6590D3),
    templates: [
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFFF47181),
          icon: Icons.add_business_rounded),
      Dhancha(
          title: "अपाङ्गता प्रमाणित",
          color: Color(0xFF7F5B53),
          icon: Icons.child_care_sharp),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFF2488FF),
          icon: Icons.business),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFF2488FF),
          icon: Icons.business),
      Dhancha(
          title: "अपाङ्गता प्रमाणित",
          color: Color(0xFF7F5B53),
          icon: Icons.child_care_sharp),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFFF47181),
          icon: Icons.add_business_rounded),
    ],
  ),
  Category(
    name: "अपाङ्गता प्रमाणित",
    color: Color(0xFF20D0D0),
    templates: [
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFFF47181),
          icon: Icons.add_business_rounded),
      Dhancha(
          title: "अपाङ्गता प्रमाणित",
          color: Color(0xFF7F5B53),
          icon: Icons.child_care_sharp),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFF2488FF),
          icon: Icons.business),
      Dhancha(
          title: "अपाङ्गता प्रमाणित",
          color: Color(0xFF7F5B53),
          icon: Icons.child_care_sharp),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFF2488FF),
          icon: Icons.business),
      Dhancha(
          title: "व्यवसाय दर्ता",
          color: Color(0xFFF47181),
          icon: Icons.add_business_rounded),
    ],
  ),
];
