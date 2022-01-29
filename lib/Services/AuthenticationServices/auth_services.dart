import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/Services/database.dart';

class AuthServices {
  bool _isLoading=false;
  late String _errorMsg;
   bool get isLoading => _isLoading;
   String get errorMsg =>_errorMsg;
   FirebaseAuth _auth=FirebaseAuth.instance;
   FirebaseAuth get auth =>_auth;
   Future register (String email,String pass) async{
     //setLoading(true);
     try{
      UserCredential authresult=await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      User user=authresult.user!;
      //setLoading(false);
      await Database(uid: user.uid).updateUserData('0', 'New Member', 100);
      return user;
     }on
      SocketException{
       //setLoading(false);
       setMessage("Please Connect to internet");
     }
     catch(e){
       //setLoading(false);
       setMessage(e.toString());
     }
     //notifyListeners();
   }

  Future login (String email,String pass) async{
    //setLoading(true);
    try{
      UserCredential authresult=await _auth.signInWithEmailAndPassword(email: email, password: pass);
      User user=authresult.user!;
      //setLoading(false);
      return user;
    }on
    SocketException{
      //setLoading(false);
      setMessage("Please Connect to internet");
    }
    catch(e){
      //setLoading(false);
      setMessage(e.toString());
    }
    //notifyListeners();
  }

  Future logout() async
  {
    try{

      return await _auth.signOut();

    }catch(e){
      print(e.toString());
      return null;
    }
    //notifyListeners();
  }
   /*void setLoading(val)
   {
     _isLoading=val;
     notifyListeners();
   }*/
   void setMessage(message)
   {
     _errorMsg=message;
     print(message);
    // notifyListeners();
   }

   Stream<User?> get user => _auth.authStateChanges().map((event) => event);
}