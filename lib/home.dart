
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/Screens/authentication/authentication.dart';
import 'package:flutter_authentication/Screens/wrapper.dart';
import 'package:flutter_authentication/Services/AuthenticationServices/auth_services.dart';
import 'package:provider/provider.dart';
import 'Screens/authentication/login.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final _init  = Firebase.initializeApp();
    
    return FutureBuilder(
      future: _init,
      builder: (context,snapshot) {
        if(snapshot.hasError) {
          return ErrorWidget();
        } else
        if(snapshot.hasData) {
          return StreamProvider<User?>.value(
              value: AuthServices().user,
              initialData: null,
              child: Wrapper(),
          );
        }
        else{
          return Scaffold(
          body: Center(
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                ),
              ],
            ),
          )
          );
        }
      }
    );
  }
}
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: const [
          Icon(Icons.error),
          Text('Error Occured'),
        ],
      ),),
    );
  }
}