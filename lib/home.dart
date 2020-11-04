import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sldanimate/main_home_slides.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#16A085'),
        centerTitle: true,
        title: Text('Animated Slides'),
      ),
      body: SingleChildScrollView(
        child: Row(
              children: [
                Expanded(
                    child: MainSlidesHome(),
                ),
              ],
            ),
      ),
    );
  }
}