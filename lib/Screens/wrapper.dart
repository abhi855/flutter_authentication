
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/Screens/authentication/authentication.dart';
import 'package:provider/provider.dart';

import 'home_screen/home_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User?>(context);
    print(user);
    if(user==null){
      return Authentication();
    }else{
      return HomeScreen();
    }
  }
}
