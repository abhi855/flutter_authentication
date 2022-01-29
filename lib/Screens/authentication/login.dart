import 'package:flutter/material.dart';
import 'package:flutter_authentication/Services/AuthenticationServices/auth_services.dart';

class Login extends StatefulWidget {
  Function toggleScreen;
  Login({required this.toggleScreen});
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<Login> {
  late TextEditingController _email;
  late TextEditingController _pass;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    
    _email= TextEditingController();
    _pass = TextEditingController();
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool loading=false;
    AuthServices authServices=AuthServices();
    return Scaffold(
      
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Text('Welcome Back!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                ),
                const SizedBox(height: 20,),
                const Text('Sign in to Continue!',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _email,
                  validator: (val)=>val!.isNotEmpty?null:'Enter valid email',
                decoration:  InputDecoration(hintText: "Email",icon: Icon(Icons.email),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _pass,
                  obscureText: true,
                  validator: (val)=>val!.length>7?null:'Enter password of atleast length 8',
                decoration:  InputDecoration(hintText: "Password",icon: Icon(Icons.vpn_key),border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 20,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    
                    child: ElevatedButton(
                      onPressed: ()async{
                        if(_formKey.currentState!.validate()){
                          print(_email.text.trim());
                          print(_pass.text.trim());
                          await authServices.login(_email.text.trim(), _pass.text.trim());
                        }
                      },
                      child: Text('Sign In'),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account"),
                    TextButton(
                        onPressed: (){
                          widget.toggleScreen();
                        },
                        child: Text("Register"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}