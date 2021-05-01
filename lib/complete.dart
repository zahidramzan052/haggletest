import 'package:flutter/material.dart';
import './configuration.dart';
import './Dashbord.dart';

class Complete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: PrimaryColor,
        body: Column(
          children: [
            Expanded(flex: 3, child: SizedBox()),
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(flex: 1, child: Image.asset("images/done.png")),
                    Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            "Setup Complete",
                            style: TextStyle(
                                color: accentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.meduim2Text),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(
                          "Thank you for setting up your Hagglex accounts",
                          style: TextStyle(
                              color: accentColor,
                              fontSize: SizeConfig.smallText),
                        )),
                  ],
                )),
            Expanded(flex: 3, child: SizedBox()),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.xlargText, right: SizeConfig.xlargText),
                  child: FlatButton(
                    minWidth: SizeConfig.screenWidth,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: buttonColor,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => Dashbord()));
                    },
                    child: Text(
                      "START EXPLORING",
                      style: TextStyle(
                          fontSize: SizeConfig.meduimText,
                          color: PrimaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
            Expanded(flex: 2, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
