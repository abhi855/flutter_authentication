import 'package:flutter/material.dart';

import 'login.dart';
import 'register.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isToggle=false;
  toggleScreen()
  {
    isToggle=!isToggle;
    setState(() {    });
  }
  @override
  Widget build(BuildContext context) {
    if(isToggle) {
      return Register(toggleScreen:toggleScreen);
    }
    else{
      return Login(toggleScreen:toggleScreen);
    }
  }
}
