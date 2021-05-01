import 'dart:ui';

import 'package:flutter/material.dart';
import './configuration.dart';

class Countries extends StatefulWidget {
  @override
  _CountriesState createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  TextEditingController controllerSearch = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: PrimaryColor,
      body: Center(
        child: new CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            new SliverPadding(
              padding: EdgeInsets.only(
                  left: SizeConfig.meduimText, right: SizeConfig.meduimText),
              sliver: new SliverList(
                delegate: new SliverChildListDelegate(
                  <Widget>[
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.05,
                    ),
                    searchUser(context, controllerSearch),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.01,
                    ),
                    Divider(
                      height: SizeConfig.screenHeight * 0.02,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.01,
                    ),
                    Container(
                      height: SizeConfig.screenHeight * 0.80,
                      child: ListView.builder(
                        itemCount: countryList.length,
                        itemBuilder: (BuildContext contex, index) => ListTile(
                          title: Text(
                            countryList[index].name,
                            style: TextStyle(
                                color: accentColor,
                                fontSize: SizeConfig.meduimText),
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0), //or 15.0
                            child: Container(
                              width: SizeConfig.xlargText * 2,
                              child: Image.asset(
                                countryList[index].image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget searchUser(context, TextEditingController controllerSearch) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    color: accentColor.withOpacity(0.3),
    child: new TextFormField(
      controller: controllerSearch,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Search for country',
        hintStyle:
            TextStyle(fontSize: SizeConfig.smallText, color: Colors.grey),
        contentPadding: EdgeInsets.only(
            left: SizeConfig.screenHeight * 0.033,
            top: SizeConfig.screenHeight * 0.02),
        suffixIcon: Icon(
          Icons.search,
          color: accentColor.withOpacity(0.3),
        ),
      ),
    ),
  );
}

class Country {
  String image;
  String name;
  Country({this.image, this.name});
}

List<Country> countryList = [
  Country(image: "images/flag.png", name: "(+234) Nigira"),
  Country(image: "images/flag.png", name: "(+234) Nigira"),
  Country(image: "images/flag.png", name: "(+234) Nigira"),
  Country(image: "images/flag.png", name: "(+234) Nigira"),
  Country(image: "images/flag.png", name: "(+234) Nigira"),
  Country(image: "images/flag.png", name: "(+234) Nigira"),
  Country(image: "images/flag.png", name: "(+234) Nigira"),
  Country(image: "images/flag.png", name: "(+234) Nigira"),
  Country(image: "images/flag.png", name: "(+234) Nigira"),
  Country(image: "images/flag.png", name: "(+234) Nigira"),
  Country(image: "images/flag.png", name: "(+234) Nigira"),
];
