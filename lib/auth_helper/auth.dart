import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:smart_patientmanagement_system/Starter/SignIn.dart';
import 'package:smart_patientmanagement_system/auth_helper/user.dart';



class AuthService extends ChangeNotifier{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User_model _userFromFirebaseUSer(User user){
    return user!=null ? User_model(uid: user.uid):null;

  }
  Stream<User_model> get user{

    return _auth.authStateChanges().map(_userFromFirebaseUSer);

  }

  Future getCurrenbtUser() async{

    return await _auth.currentUser;

  }
  Future<bool> usernameCheck(String username) async {
    final result = await FirebaseFirestore.instance
        .collection('Usernames')
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isEmpty;
  }
  Future<String> getCurrenbtUid() async{

    String uid= (await _auth.currentUser).uid;
    return uid;

  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUSer(user);
    } catch (error) {
      print(error.toString());
      
      return null;
    }
  }
  Future signout()async{
    try{
      return await _auth.signOut();


    }catch(e){
      print(e.toString());
    }
  }
}