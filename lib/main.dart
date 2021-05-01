import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:haggle_test/Dashbord.dart';
import 'package:page_transition/page_transition.dart';
import './sign_in.dart';
import './configuration.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:convert';
import './Register_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String email;

  loadUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      if (sharedPreferences.getString('email') != null &&
          sharedPreferences.getString('email').isNotEmpty) {
        email = sharedPreferences.getString('email');
        print("email" + email);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink =
        HttpLink(uri: "https://hagglex-backend-staging.herokuapp.com/graphql");

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
        GraphQLClient(
            link: httpLink,
            cache:
                OptimisticCache(dataIdFromObject: typenameDataIdFromObject)));

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HaggleX',
        theme: ThemeData(
          primaryColor: PrimaryColor,
        ),
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: Image.asset("images/hagglex.png"),
            splashIconSize: 150,
            nextScreen: email == "" || email == null
                ? SignIn()
                : Dashbord(
                    email: "aaaa@gmail.com",
                  ),
            splashTransition: SplashTransition.rotationTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: PrimaryColor),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Mutation(
        options: MutationOptions(
          documentNode: gql(query),
          update: (Cache cache, QueryResult result) {
            return cache;
          },
          onCompleted: (dynamic resultData) {
            String val = jsonEncode(resultData);

            var data = json.decode(val);
            RegisterModel productModel = RegisterModel.fromJson(data);

            print(productModel.register.token);
          },
        ),
        builder: (RunMutation insert, QueryResult result) {
          return Column(
            children: [
              RaisedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    insert(<String, dynamic>{
                      "username": "w2fwes1x23",
                      "email": "aweffwewe.com",
                      "password": "fwefwefdasa",
                      "phonenumber": "ewfwefasdwwe",
                      "country": "ee",
                      "currency": "dd"
                    });
                  })
            ],
          );
        },
      ),
    );
  }
}
