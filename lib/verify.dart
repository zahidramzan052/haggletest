import 'package:flutter/material.dart';
import './configuration.dart';
import './register.dart';
import './complete.dart';
import 'package:email_auth/email_auth.dart';

class Verify extends StatefulWidget {
  final String email;

  Verify({this.email});

  @override
  _VerifyState createState() => _VerifyState();
}

final _codeController = TextEditingController();

class _VerifyState extends State<Verify> {
  @override
  void initState() {
    super.initState();
    sendOtp(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: PrimaryColor,
        body: ListView(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Card(
                        color: Colors.white.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: accentColor,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Register()));
                            })),
                  ),
                ),
                Expanded(flex: 3, child: SizedBox())
              ],
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.xlargText),
              child: Text(
                "Verify your account",
                style: TextStyle(
                    color: accentColor,
                    fontSize: SizeConfig.meduim2Text,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(SizeConfig.meduimText),
              child: Card(
                elevation: 4,
                child: Container(
                  height: SizeConfig.screenHeight * 0.7,
                  child: Padding(
                    padding: EdgeInsets.only(top: SizeConfig.meduimText),
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.largText,
                                      right: SizeConfig.largText),
                                  child: Image.asset(
                                    "images/checked.png",
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.meduim2Text,
                                  right: SizeConfig.meduim2Text),
                              child: Text(
                                "We just sent a verification code to your email.\nPlease enter the code",
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: SizeConfig.smallText),
                              ),
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.xlargText,
                                  right: SizeConfig.xlargText),
                              child: TextFormField(
                                  controller: _codeController,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.purple),
                                      ),
                                      labelText: 'Verification code',
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: SizeConfig.meduimText)),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Invalid code';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {}),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.04,
                        ),
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.xlargText,
                                    right: SizeConfig.xlargText),
                                child: FlatButton(
                                  height: SizeConfig.screenHeight / 12,
                                  minWidth: SizeConfig.screenWidth,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  color: PrimaryColor,
                                  onPressed: () {
                                    verify(widget.email, _codeController.text,
                                        context);
                                  },
                                  child: Text(
                                    "VERIFY ME",
                                    style: TextStyle(
                                        fontSize: SizeConfig.meduimText,
                                        color: accentColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.largText,
                                  right: SizeConfig.largText),
                              child: Text(
                                "this code will expire in 10 minutes",
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: SizeConfig.smallText),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.largText,
                                  right: SizeConfig.largText),
                              child: Text(
                                "Resend Code",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: SizeConfig.meduim2Text,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void verify(String email, String code, BuildContext context) {
  if (EmailAuth.validate(receiverMail: email, userOTP: code))
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => Complete()));
}

void sendOtp(String email) async {
  EmailAuth.sessionName = "Company Name";
  bool result = await EmailAuth.sendOtp(receiverMail: email);
  if (result) {
    print(result.toString());
  }
}
