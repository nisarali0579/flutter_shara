import 'package:flutter/material.dart';
import 'package:fluttera_share/pages/comments.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttera_share/widgets/header.dart';
import 'package:fluttera_share/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

final _firebase = FirebaseFirestore.instance.collection('messages');
FirebaseAuth _auth = FirebaseAuth.instanceFor();

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  User loggedUser;

  List<Text> users = [];

  @override
  void initState() {
    // getCurrenUser();
    // getUser();
    super.initState();
  }

  getUser() async {
    final message = await _firebase.get();
    message.docs.forEach((element) {
      print(element.data());
    });
  }

  getCurrenUser() async {
    final cUser = await _auth.currentUser;
    loggedUser = cUser;
    print(loggedUser);
  }

  // @override
  // void initState() {
  //   getUser();
  //   createUser();
  //   super.initState();
  // }
  //
  // createUser() {
  //   usersRef
  //       .doc("nisar")
  //       .set({
  //     "username": "nisar Shalmani",
  //     "postsCount": 2,
  //     "isAdmin": false
  //       });
  // }
  // getUser() async {
  //   final QuerySnapshot snapshot =
  //       await usersRef.where("isAdmin", isEqualTo: false).get();
  //   snapshot.docs.forEach((element) {
  //     print(element.data());
  //   });
  // }

  // getUsersById() async{
  //   final String id = "B4xU1b7njGybbSYvFaIz";
  //   final DocumentSnapshot docs = await usersRef.doc(id).get();
  //   print(docs.data());
  //   print(docs.get('isAdmin'));
  //   print(docs.id);
  // }
  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firebase.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return new Column(
                  children:  [
                    Text(document.data()["sender"]),
                    Text(document.data()["text"]),
                  ]
                  // subtitle: new Text(document.data()['text']),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}





// StreamBuilder<QuerySnapshot>(
// stream: _firebase.snapshots(),
// builder:
// (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// if (snapshot.hasError) {
// return Text('Something went wrong');
// }
//
// if (snapshot.connectionState == ConnectionState.waiting) {
// return Text("Loading");
// }
// return new ListView(
// children: snapshot.data.docs.map((DocumentSnapshot document) {
// return new Column(
// children:  [
// Text(document.data()["sender"]),
// Text(document.data()["text"]),
// ]
// // subtitle: new Text(document.data()['text']),
// );
// }).toList(),
// );
// },
// ),