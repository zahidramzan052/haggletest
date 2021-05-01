import 'package:flutter/material.dart';
import './configuration.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: PrimaryColor,
      body: SafeArea(
        child: Stack(
          children: [Background(), Logo(), Contain()],
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: FittedBox(
        child: Image.asset("images/hagglex.png"),
        fit: BoxFit.cover,
      ),
    );
  }
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: SizeConfig.screenWidth / 2 - SizeConfig.screenWidth / 4,
      child: Padding(
        padding: EdgeInsets.only(top: SizeConfig.screenWidth / 4),
        child: Container(
          width: SizeConfig.screenWidth / 2,
          height: SizeConfig.screenWidth / 2,
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.asset("images/logo.png"),
          ),
        ),
      ),
    );
  }
}

class Contain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double larg = SizeConfig.largText;
    double meduim = SizeConfig.meduimText;
    double small = SizeConfig.smallText;
    double height = SizeConfig.screenHeight;
    double width = SizeConfig.screenWidth;
    return Padding(
      padding: EdgeInsets.only(top: width / 1.2),
      child: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Text(
                  "Welcome to",
                  style: TextStyle(
                      fontSize: larg,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "My GYM",
                  style: TextStyle(
                      fontSize: larg,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height / 25,
                ),
                Text(
                  "The best way to management your work!",
                  style: TextStyle(
                    fontSize: meduim,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: height / 25,
                ),
                Text(
                  "Start trial period for 7 days ",
                  style: TextStyle(
                    fontSize: meduim,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height / 25,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: meduim, left: small, right: small),
            child: SizedBox(
              width: double.infinity,
              height: SizeConfig.xlargText + SizeConfig.meduim2Text,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: buttonColor,
                onPressed: () {
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (BuildContext context) => SignIn()));
                },
                child: Text(
                  "Start Now",
                  style: TextStyle(
                    fontSize: meduim,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
