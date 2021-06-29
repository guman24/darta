import 'package:flutter/material.dart';
import 'package:sifaris_app/features/dashboard/presentation/pages/drawer_page.dart';
import 'package:sifaris_app/features/dashboard/presentation/pages/home_page.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            DrawerPage(),
            HomePage(),
          ],
        ),
      ),
    );
  }
}
