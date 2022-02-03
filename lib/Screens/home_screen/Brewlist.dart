
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/Services/brews.dart';
import 'package:provider/provider.dart';
class BrewList extends StatefulWidget {
  List<Brews>? brews;
  BrewList({required this.brews});

  @override
  _BrewListState createState() => _BrewListState();
}


class _BrewListState extends State<BrewList> {

  @override
  Widget build(BuildContext context) {
    List<Brews>?brews=widget.brews;
    print(brews);
    brews!.forEach((element) {
      print(element.name);
    });
    return ListView.builder(
      //shrinkWrap: true,
      itemCount: brews.length,
      itemBuilder: (context,index) {
        return BrewTile(brews[index]);
      }
    );
  }
  Widget BrewTile(Brews brews)
  {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[brews.strength],
          ),
          title: Text(brews.name),
          subtitle: Text('Takes ${brews.sugar} sugars'),
        ),
      ),
    );
  }
}

// class BrewList extends StatelessWidget {
//
//   BrewList({required this.brews});
//   List<Brews>? brews;
//   @override
//   Widget build(BuildContext context) {
//     // List<Brews>?brews=widget.brews;
//     print(brews);
//     brews!.forEach((element) {
//       print(element.name);
//     });
//     return ListView.builder(
//       //shrinkWrap: true,
//         itemCount: brews?.length,
//         itemBuilder: (context,index) {
//           return BrewTile(brews![index]);
//         }
//     );
//   }
//   Widget BrewTile(Brews brews)
//   {
//     return Padding(
//       padding: EdgeInsets.only(top: 8.0),
//       child: Card(
//         margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
//         child: ListTile(
//           leading: CircleAvatar(
//             radius: 25,
//             backgroundColor: Colors.brown[brews.strength],
//           ),
//           title: Text(brews.name),
//           subtitle: Text('Takes ${brews.sugar} sugars'),
//         ),
//       ),
//     );
//   }
// }
