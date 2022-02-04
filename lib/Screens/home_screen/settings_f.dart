import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/Services/AuthenticationServices/auth_services.dart';
import 'package:flutter_authentication/Services/database.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({Key? key}) : super(key: key);

  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _sugars = ['0', '1', '2', '3', '4'];

  String _sugar = '', _name = '';
  final uid = FirebaseAuth.instance.currentUser!.uid;
  int _strength = 0;
  Stream<UserData> get userData => FirebaseFirestore.instance
      .collection('brewcrew')
      .doc(uid.toString())
      .snapshots()
      .map((event) => UserData(
          uid: event.id,
          sugar: event.get('sugar'),
          strength: event.get('strength'),
          name: event.get('name')));
  @override
  Widget build(BuildContext context) {
   // final u1 = Provider.of<User?>(context,listen: false);
    print('YYY');
   // print(u1);

    return StreamBuilder<UserData>(
        stream: userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'UPDATE',
                    style: TextStyle(
                        color: Colors.brown,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: snapshot.data!.name,
                    decoration: InputDecoration(

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (val) =>
                    val!.length == 0
                        ? 'Enter valid Name'
                        : null,
                    onChanged: (value) =>
                        setState(() {
                          print(value);
                          _name = value;
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                      value: snapshot.data!.sugar,
                      items: _sugars.map((element) {
                        return DropdownMenuItem(
                          value: element,
                          child: Text('$element sugars'),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() {
                            _sugar = value!;
                          })
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Slider(
                      min: 100,
                      max: 900,
                      divisions: 8,
                      activeColor: Colors.brown[_strength],
                      inactiveColor: Colors.brown[_strength],
                      value: (_strength == 0
                          ? snapshot.data!.strength
                          : _strength).toDouble(),
                      onChanged: (val) =>
                          setState(() {
                            _strength = val.round();
                          })
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.brown[600]),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        print(_name);
                        print(_sugar);
                        print(_strength);
                        await Database(uid: uid).updateUserData(
                            _sugar==''?snapshot.data!.sugar:_sugar, _name==''?snapshot.data!.name:_name, _strength==0?snapshot.data!.strength:_strength);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'UPDATE',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return Column(
              children: const [
                Icon(Icons.error),
                Text('Error Occured'),
              ],
            );
          }
          return Column(
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
          );
        }
    );
  }
}
