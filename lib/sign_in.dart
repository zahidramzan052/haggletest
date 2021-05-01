import 'package:flutter/material.dart';
import 'package:haggle_test/Dashbord.dart';
import './configuration.dart';
import './register.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './signin_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

bool _isHidden = true;

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void saveDataUser(String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('email', email);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final HttpLink httpLink = HttpLink(uri: SizeConfig.baseUrl);

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
        GraphQLClient(
            link: httpLink,
            cache:
                OptimisticCache(dataIdFromObject: typenameDataIdFromObject)));

    double xLarg = SizeConfig.xlargText;

    double larg = SizeConfig.largText;
    double small = SizeConfig.smallText;
    String query = r"""
      mutation login($input:String!,$password:String!){
  login(data:{
    input :$input
    password :$password
  }){
    user {
      _id
      email
      phonenumber
    }
    token
  }
}
                  """;
    return GraphQLProvider(
      client: client,
      child: Scaffold(
        backgroundColor: PrimaryColor,
        body: Mutation(
            options: MutationOptions(
              documentNode: gql(query),
              update: (Cache cache, QueryResult result) {
                return cache;
              },
              onCompleted: (dynamic resultData) {
                try {
                  String val = jsonEncode(resultData);
                  var data = json.decode(val);
                  SignInModel signinModel = SignInModel.fromJson(data);
                  print(signinModel.login.token);
                  saveDataUser(_emailController.value.text.trim());

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Dashbord(
                            email: _emailController.value.text.trim(),
                          )));

                  print(_emailController.value.text.trim());
                } catch (e) {
                  _create(context);
                  print("email" + _emailController.text);
                }
              },
            ),
            builder: (RunMutation insert, QueryResult result) {
              return Padding(
                  padding: EdgeInsets.only(left: larg, right: larg),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.1,
                      ),
                      Text(
                        "Welcome !",
                        style: TextStyle(
                            fontSize: xLarg + small,
                            color: accentColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.0633,
                      ),
                      Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              TextFormField(
                                  controller: _emailController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.purple),
                                      ),
                                      labelText: 'Email Address',
                                      labelStyle:
                                          TextStyle(color: Colors.white)),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) {
                                    if (val.isEmpty || !val.contains('@')) {
                                      return 'Invalid email';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {}),
                              TextFormField(
                                  obscureText: _isHidden,
                                  obscuringCharacter: "*",
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      suffixIcon: InkWell(
                                        onTap: _togglePasswordView,
                                        child: Icon(
                                            _isHidden
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.white),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.purple),
                                      ),
                                      labelText: 'Password',
                                      labelStyle:
                                          TextStyle(color: Colors.white)),
                                  controller: _passwordController,
                                  validator: (val) {
                                    if (val.isEmpty || val.length < 5) {
                                      return 'Password is too short!';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {}),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      Text("Forgat Password?",
                          textAlign: TextAlign.end,
                          style:
                              TextStyle(fontSize: small, color: accentColor)),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.04,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.meduimText,
                            left: SizeConfig.smallText,
                            right: SizeConfig.smallText),
                        child: SizedBox(
                          width: double.infinity,
                          height: SizeConfig.xlargText + SizeConfig.largText,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            color: buttonColor,
                            onPressed: () {
                              //      if (!_formKey.currentState.validate()) {
                              //        return;
                              //      }
                              //      FocusScope.of(context).unfocus();

                              //      _formKey.currentState.save();

                              insert(<String, dynamic>{
                                "input": _emailController.value.text.trim(),
                                "password": "12345678"
                              });
                              print(_emailController.value.text);
                            },
                            child: Text(
                              "LOG IN",
                              style: TextStyle(
                                  fontSize: SizeConfig.meduimText,
                                  color: PrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.04,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Register()));
                          },
                          child: Text("New User?Create a new account",
                              style: TextStyle(
                                  fontSize: small, color: accentColor)),
                        ),
                      ),
                    ],
                  ));
            }),
      ),
    );
  }
}

void _create(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
            height: SizeConfig.screenHeight * 0.25,
            width: SizeConfig.screenHeight * 0.5,
            color: Colors.white,
            child: Center(child: Text("The data is not true")))),
  );
}
