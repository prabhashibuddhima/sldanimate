import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sldanimate/page_transformer.dart';

import 'jsn_data/visit_places.dart';

class MainSlidesHome extends StatefulWidget {
  @override
  _MainSlidesHomeState createState() => _MainSlidesHomeState();
}

class _MainSlidesHomeState extends State<MainSlidesHome> {
  final PageController controller = PageController(viewportFraction: 0.8);
  int currentPage = 0;

  String arrayObjsText =
      '{"visitPlaces": [{ "placeId": 1,"imgName": "https://firstclasse.com.my/wp-content/uploads/2018/12/Sri-Lanka-Sigiriya-featured.jpg", "placeName": "Sigiriya", "placeDesc" : "Sigiriya is a wonderful place to visit", "placeLocation" : "Sigiriya", "placePoints" : "120"}, { "placeId": 2, "imgName": "https://live.staticflickr.com/6196/6131715817_86ed8d94be_b.jpg", "placeName": "Temple of the Tooth", "placeDesc" : "Temple of the Tooth is a wonderful place to visit", "placeLocation" : "Kandy", "placePoints" : "100"},{ "placeId": 3,"imgName": "https://www.brownshotels.com/paradisedambulla/wp-content/uploads/sites/27/2018/12/dambulla-rock-fortress-3.jpg", "placeName": "Dambulla Temple", "placeDesc" : "Dambulla cave temple also known as the Golden Temple of Dambulla is a World Heritage Site (1991) in Sri Lanka, situated in the central part of the country.", "placeLocation" : "Dambulla", "placePoints" : "110"}, { "placeId": 4, "imgName": "https://www.thecoastalcampaign.com/wp-content/uploads/2019/06/Things-to-do-in-Ella-1040x675.jpg", "placeName": "Nine Arch Bridge", "placeDesc" : "Ella is a small town in the Badulla District of Uva Province, Sri Lanka governed by an Urban Council.", "placeLocation" : "Ella", "placePoints" : "140"}]}';

  List<VisitPlaces> placestovisit;

  @override
  void initState() {
    var tagObjsJson = jsonDecode(arrayObjsText)['visitPlaces'] as List;
    placestovisit =
        tagObjsJson.map((tagJson) => VisitPlaces.fromJson(tagJson)).toList();
    print(placestovisit);
    controller.addListener(() {
      int next = controller.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  AnimatedContainer _buildStoryPage(
      int index, bool active, PageVisibility pageVisibility) {

    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 20 : 70;
    final double xTranslation = pageVisibility.pagePosition * 1000;
    final mqry = MediaQuery.of(context);
    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(placestovisit[index].imgName),
          ),
          boxShadow: [
            BoxShadow(
              color: HexColor('#e8e8e8'),
              blurRadius: blur,
              offset: Offset(offset, offset),
            ),
          ],
        ),
        child: Transform(
            alignment: FractionalOffset.topLeft,
            transform: Matrix4.translationValues(
              xTranslation,
              0.0,
              0.0,
            ),
            child: Stack(children: [
              Positioned(
                bottom: 66.0,
                left: 26.0,
                // right: 32.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        placestovisit[index].placeName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: mqry.size.width / 18,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              ),
             
            ])));
  }

  @override
  Widget build(BuildContext context) {
    final mqry = MediaQuery.of(context);

    return new Container(
      height: mqry.size.height / 1.8,
      child: PageTransformer(
        pageViewBuilder: (context, visibilityResolver) {
          List slideList = placestovisit;
          return PageView.builder(
            controller: controller,
            itemCount: slideList.length,
            itemBuilder: (context, int currentIndex) {
              bool active = currentIndex == currentPage;
              final pageVisibility =
                  visibilityResolver.resolvePageVisibility(currentIndex);
                return _buildStoryPage(currentIndex, active, pageVisibility);
            },
          );
        },
      ),
    );
  }
}