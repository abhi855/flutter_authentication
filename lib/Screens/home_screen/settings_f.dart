import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SettingForm extends StatefulWidget {
  const SettingForm({Key? key}) : super(key: key);

  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey =GlobalKey<FormState>();
  final List<String> _sugars=['0','1','2','3','4'];

  String _sugar='0',_name='';
  int _strength=100;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text('UPDATE',style: TextStyle(color: Colors.brown,fontSize: 20,fontWeight:FontWeight.bold ),),
          SizedBox(height: 20.0,),
          TextFormField(

            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
            validator: (val) => val!.isEmpty?'Enter valid':null,
            onChanged: (value)=>setState(() {
              _name=value;
            }),
          ),
          SizedBox(height: 20,),
          DropdownButtonFormField<String>(
            value: _sugar,
            items: _sugars.map((element) {
              return DropdownMenuItem(
                value: element,
                child: Text('$element sugars'),
              );
            }).toList(),
            onChanged: (value) =>//setState(() {
              _sugar=value!
           // })
          ),
          SizedBox(height: 20.0,),
          Slider(
            min: 100,
            max: 900,
            divisions: 8,
            activeColor: Colors.brown[_strength],
            inactiveColor: Colors.brown[_strength],
            value: _strength.toDouble(),
            onChanged: (val) => setState(() {
              _strength=val.round();
            })
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.brown[600]
            ),
            onPressed: () async{
              print(_name);
              print(_sugar);
              print(_strength);
            },
            child: Text('UPDATE',style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }
}
