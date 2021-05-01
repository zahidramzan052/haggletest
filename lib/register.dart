import 'package:flutter/material.dart';
import './sign_in.dart';
import './configuration.dart';
import './country.dart';
import './verify.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:convert';
import './Register_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _usernameController = TextEditingController();
final _phoneController = TextEditingController();

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey();

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

    String query = r"""
                   mutation register($username:String!,$email:String!,$password:String!
  ,$phonenumber:String!,$country:String!,$currency:String!){
  register(data:{
    username:$username
    email: $email
    password:$password
    phonenumber:$phonenumber
    country:$country
    currency:$currency
    
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

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: GraphQLProvider(
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
                    RegisterModel registerModel = RegisterModel.fromJson(data);

                    print("dddd" + registerModel.register.token);

                    saveDataUser(_emailController.value.text);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Verify(
                              email: _emailController.value.text,
                            )));
                  } catch (e) {
                    print("${e.toString()}");
                    _create(context);
                  }
                },
              ),
              builder: (RunMutation insert, QueryResult result) {
                return ListView(
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
                                                  SignIn()));
                                    })),
                          ),
                        ),
                        Expanded(flex: 3, child: SizedBox())
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.meduimText),
                      child: Card(
                        elevation: 4,
                        child: Container(
                          height: SizeConfig.screenHeight,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: SizeConfig.meduimText),
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.largText),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Create a new account",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    SizeConfig.meduim2Text),
                                          ),
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.largText,
                                          right: SizeConfig.largText),
                                      child: Form(
                                        key: _formKey,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                  controller: _emailController,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.purple),
                                                      ),
                                                      labelText:
                                                          'Email Address',
                                                      labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: SizeConfig
                                                              .meduimText)),
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  validator: (val) {
                                                    if (val.isEmpty ||
                                                        !val.contains('@')) {
                                                      return 'Invalid email';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (val) {}),
                                              TextFormField(
                                                  controller:
                                                      _passwordController,
                                                  obscureText: true,
                                                  obscuringCharacter: "*",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.purple),
                                                      ),
                                                      labelText: 'Password',
                                                      labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: SizeConfig
                                                              .meduimText)),
                                                  validator: (val) {
                                                    if (val.isEmpty ||
                                                        val.length < 5) {
                                                      return 'Password is too short!';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (val) {}),
                                              TextFormField(
                                                  controller:
                                                      _usernameController,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.purple),
                                                      ),
                                                      labelText:
                                                          'Create a username',
                                                      labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: SizeConfig
                                                              .meduimText)),
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  validator: (val) {
                                                    if (val.isEmpty) {
                                                      return 'Please enter username';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (val) {}),
                                              SizedBox(
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.02,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              Countries()));
                                                },
                                                child: Container(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey),
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.2),
                                                            ),
                                                            width: 80,
                                                            height: 35,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Image
                                                                        .asset(
                                                                            "images/flag.png"),
                                                                  ),
                                                                  Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Text(
                                                                        "(+234)",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                10),
                                                                      ))
                                                                ],
                                                              ),
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: TextFormField(
                                                            controller:
                                                                _phoneController,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                            decoration:
                                                                InputDecoration(
                                                                    enabledBorder:
                                                                        UnderlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                              color: Colors.purple),
                                                                    ),
                                                                    labelText:
                                                                        'Enter your phone number',
                                                                    labelStyle: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            SizeConfig
                                                                                .meduimText)),
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            validator: (val) {
                                                              if (val.isEmpty) {
                                                                return 'Please enter your phone number';
                                                              }
                                                              return null;
                                                            },
                                                            onSaved: (val) {}),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.02,
                                              ),
                                              SizedBox(
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.02,
                                              ),
                                              TextFormField(
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.8)),
                                                      ),
                                                      labelText:
                                                          'Referral link',
                                                      labelStyle: TextStyle(
                                                          color: Colors.grey
                                                              .withOpacity(0.8),
                                                          fontSize: SizeConfig
                                                              .meduimText)),
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  onSaved: (val) {}),
                                              SizedBox(
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.02,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left:
                                                        SizeConfig.meduim2Text,
                                                    right:
                                                        SizeConfig.meduim2Text),
                                                child: Text(
                                                  "By signing. you agree to HaggleX terms and privacy policy.",
                                                  style: TextStyle(
                                                      fontSize:
                                                          SizeConfig.smallText),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.05,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: SizeConfig.largText,
                                                    right: SizeConfig.largText),
                                                child: FlatButton(
                                                  height:
                                                      SizeConfig.screenHeight *
                                                          0.08,
                                                  minWidth:
                                                      SizeConfig.screenWidth,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  color: PrimaryColor,
                                                  onPressed: () {
                                                    if (!_formKey.currentState
                                                        .validate()) {
                                                      return;
                                                    }
                                                    FocusScope.of(context)
                                                        .unfocus();

                                                    _formKey.currentState
                                                        .save();

                                                    insert(<String, dynamic>{
                                                      "username":
                                                          _usernameController
                                                              .text,
                                                      "email":
                                                          _emailController.text,
                                                      "password":
                                                          _passwordController
                                                              .text,
                                                      "phonenumber":
                                                          _phoneController.text,
                                                      "country": "ee",
                                                      "currency": "dd"
                                                    });
                                                  },
                                                  child: Text(
                                                    "SIGN UP",
                                                    style: TextStyle(
                                                        fontSize: SizeConfig
                                                            .meduimText,
                                                        color: accentColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
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
                );
              }),
        ),
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
            child: Center(child: Text("This email already exist")))),
  );
}
