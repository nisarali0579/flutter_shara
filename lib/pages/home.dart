import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttera_share/pages/activity_feed.dart';
import 'package:fluttera_share/pages/profile.dart';
import 'package:fluttera_share/pages/search.dart';
import 'package:fluttera_share/pages/timeline.dart';
import 'package:fluttera_share/pages/upload.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    //detect when user signin
    _googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignin(account);
    }, onError: (err) {
      print('Error sign in: $err');
    });
    //reauthenticate when app reopen
    _googleSignIn
        .signInSilently(suppressErrors: false)
        .then((account) => handleSignin(account).catchError((err) {
              print('Error sign in: $err');
            }));
  }

  handleSignin(GoogleSignInAccount account) {
    if (account != null) {
      print('User SignIn! : $account');
      setState(() {
        isAuth = true;
      });
    } else
      setState(() {
        isAuth = false;
      });
  }

  dispose() {
    pageController.dispose();
    super.dispose();
  }

  login() {
    _googleSignIn.signIn();
  }

  logout() {
    _googleSignIn.signOut();
  }

  onPageChanged(int pageIndex) {
    this.pageIndex = pageIndex;
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 600),
      curve: Curves.easeOutSine,
    );
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Timeline(),
          ActivityFeed(),
          Upload(),
          Search(),
          Profile(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt_rounded,
              size: 35.5,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }

  Scaffold buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).accentColor.withOpacity(0.2),
                Theme.of(context).primaryColor,
              ]),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "FlutterShare",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "signatra",
                fontSize: 90.0,
              ),
            ),
            GestureDetector(
              onTap: login(),
              child: Container(
                width: 260,
                height: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/google_signin_button.png'),
                  fit: BoxFit.cover,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
