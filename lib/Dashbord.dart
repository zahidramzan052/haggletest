import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashbord extends StatelessWidget {
  final String email;

  Dashbord({this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2E1963),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
          ),
          Center(
            child: Text(email,style: TextStyle(color: Colors.white),),
          ),
          RaisedButton(
            onPressed: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.clear();
              SystemNavigator.pop();
            },
            child: Text("Logout"),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.dashboard), title: Text('Home')),
          BottomNavigationBarItem(
              icon: new Icon(Icons.account_balance_wallet_rounded),
              title: Text('Wallet')),
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_circle_up,size: 40.0,color: Color(0xFF2E1963),), title: Text('')),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on), title: Text('CryptoSave')),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box), title: Text('More'))
        ],
        currentIndex: 0,
      ),
    );
  }
}
