/*
import 'dart:async';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter/material.dart';


class SocialFacebook extends StatefulWidget {
  @override
  _SocialFacebookState createState() => new _SocialFacebookState();
}

class _SocialFacebookState extends State<SocialFacebook> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  String _message = 'Log in/out by pressing the buttons below.';

  Future<Null> _login() async {
    final FacebookLoginResult result =
    await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessage('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(_message),
              new RaisedButton(
                onPressed: _login,
                child: new Text('Log in'),
              ),
              new RaisedButton(
                onPressed: _logOut,
                child: new Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
class FacebookSocialLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FacebookSocialLoginState();
  }
}

class _FacebookSocialLoginState extends State<FacebookSocialLogin> {
  var loggedIn = false;
  var firebaseAuth ;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {
        firebaseAuth = FirebaseAuth.instance;
      });
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _buildSocialLogin());
  }

  _buildSocialLogin() {
    return Scaffold(
      body: Container(
          color: Color.fromRGBO(0, 207, 179, 1),
          child: Center(
            child: loggedIn
                ? Text("Logged In! :)",
                style: TextStyle(color: Colors.white, fontSize: 40))
                : Stack(
              children: <Widget>[
                SizedBox.expand(
                  child: _buildSignUpText(),
                ),
                Container(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // wrap height
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      // stretch across width of screen
                      children: <Widget>[
                        _buildFacebookLoginButton(),
                        _buildGoogleLoginButton(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Container _buildGoogleLoginButton() {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 0),
      child: ButtonTheme(
        height: 48,
        child: RaisedButton(
            onPressed: () {
              initiateSignIn("G");
            },
            color: Colors.white,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            textColor: Color.fromRGBO(122, 122, 122, 1),
            child: Text("Connect with Google",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ))),
      ),
    );
  }

  Container _buildFacebookLoginButton() {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 0),
      child: ButtonTheme(
        height: 48,
        child: RaisedButton(
            materialTapTargetSize: MaterialTapTargetSize.padded,
            onPressed: () {
              initiateSignIn("FB");
            },
            color: Color.fromRGBO(27, 76, 213, 1),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            textColor: Colors.white,
            child: Text(
              "Connect with Facebook",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )),
      ),
    );
  }

  Container _buildSignUpText() {
    return Container(
      margin: EdgeInsets.only(top: 76),
      child: Text(
        "Sign Up",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontSize: 42,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  void initiateSignIn(String type) {
    _handleSignIn(type).then((result) {
      if (result == 1) {
        setState(() {
          loggedIn = true;
        });
      } else {

      }
    });
  }

  Future<int> _handleSignIn(String type) async {
    switch (type) {
      case "FB":
        print("11111");
        FacebookLoginResult facebookLoginResult = await _handleFBSignIn();
        final accessToken = facebookLoginResult.accessToken.token;
        print("2222");
        if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
          final facebookAuthCred =
          FacebookAuthProvider.credential(accessToken);
          print("3333");
          final user =
          await firebaseAuth.signInWithCredential(facebookAuthCred);
          print("User : " + user.user.displayName);
          print("44444");
          return 1;
        } else{
          print("55555");
          return 0;
        }

        break;
      case "G":
        try {
          GoogleSignInAccount googleSignInAccount = await _handleGoogleSignIn();
          final googleAuth = await googleSignInAccount.authentication;
          final googleAuthCred = GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
          final user = await firebaseAuth.signInWithCredential(googleAuthCred);
          print("User : " + user.user.displayName);
          return 1;
        } catch (error) {
          return 0;
        }
    }
    return 0;
  }
  FacebookLogin facebookLogin = FacebookLogin();

  Future<FacebookLoginResult> _handleFBSignIn() async {
    FacebookLoginResult facebookLoginResult =
    await facebookLogin.logIn(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.cancelledByUser:
        print("Cancelled");
        break;
      case FacebookLoginStatus.error:
        print("error");
        break;
      case FacebookLoginStatus.loggedIn:
        print("Logged In");
        break;
    }
    return facebookLoginResult;
  }
  Future<Null> _logOut() async {
    await facebookLogin.logOut();
    print('Logged out.');
  }
  Future<GoogleSignInAccount> _handleGoogleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    return googleSignInAccount;
  }
}