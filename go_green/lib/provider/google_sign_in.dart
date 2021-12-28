import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_green/database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {

  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user!;

  Future  googleLogin() async{
    try{
    final googleUser  =  await GoogleSignIn().signIn();

    if(googleUser == null ) return;

    _user= googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult=await FirebaseAuth.instance.signInWithCredential(credential);

    if(authResult.additionalUserInfo!.isNewUser){
      await DataBase.addListNewUser();
    }

    } catch (e){
      debugPrint(e.toString());
    }

    notifyListeners();
  }

  Future logout() async{
   await _googleSignIn.disconnect() ;
   FirebaseAuth.instance.signOut();
  }
 
}