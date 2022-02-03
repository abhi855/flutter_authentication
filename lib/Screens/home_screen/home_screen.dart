import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/Screens/home_screen/Brewlist.dart';
import 'package:flutter_authentication/Screens/home_screen/settings_f.dart';
import 'package:flutter_authentication/Services/AuthenticationServices/auth_services.dart';
import 'package:flutter_authentication/Services/brews.dart';
import 'package:flutter_authentication/Services/database.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthServices authServices = AuthServices();
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('brewcrew');
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('brewcrew').snapshots();
    void showSetting(){
      showModalBottomSheet(
        backgroundColor: Colors.brown[50],


          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
          ),
          context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingForm(),

        );
      });
    }
    return StreamBuilder<List<Brews>>(
      stream:  _usersStream.map(
              (event) => event.docs.map(
                (e) => Brews(name: e.get('name')??'',strength: e.get('strength')??'0',sugar: e.get('sugar')??0)
        ).toList()
      ),
      builder: (BuildContext context, AsyncSnapshot<List<Brews>> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(body: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Text("Loading"));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(authServices.auth.currentUser!.email.toString()),
            actions: [
              IconButton(
                onPressed: () async {
                  print(authServices.auth.currentUser!.email);
                  await authServices.logout();
                },
                icon: Icon(Icons.exit_to_app),
              ),
              IconButton(
                  onPressed: (){
                    showSetting();
                  },
                  icon: Icon(Icons.settings))
            ],
          ),
          body: BrewList(brews: snapshot.data),
          // body: Container(
          //     child: Column(
          //   children: [
          //     ElevatedButton(
          //       child: Text('D'),
          //       onPressed: () async {
          //         print('Pressed');
          //         await collectionReference
          //             .doc('Jwb8I5TUhYO4mpTYGSt9PHgfrDv1')
          //             .set({'sugar': '1000', 'name': '4444', 'strength': 1111})
          //             .then((value) => print("User added"))
          //             .catchError((error) => print(error.toString()));
          //       },
          //     ),
          //     Card(
          //       child: Text('ddd'),
          //     ),
          //     ListView(
          //       shrinkWrap: true,
          //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
          //         Map<String, dynamic> data =
          //             document.data()! as Map<String, dynamic>;
          //         return ListTile(
          //           title: Text(data['name']),
          //           subtitle: Text(data['sugar']),
          //         );
          //       }).toList(),
          //     )
          //   ],
          // )
          // ),
        );
      },
    );
  }
}
