import 'package:dbapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dbapp/services/database.dart';

class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;

  //create user object based on firebase user
  // User _userFromFireBaseUser(FirebaseUser user){
  //   return user!=null ? User(uid:user.uid) : null;
  // }

  //auth change using stream
  Stream<FirebaseUser> get user{
    return _auth.onAuthStateChanged;
  }
   
  //sign in anonymously
  // Future signInAnon() async{
  //   try{
  //     AuthResult result =await _auth.signInAnonymously();
  //     FirebaseUser user=result.user;
  //     return _userFromFireBaseUser(user);
  //   }catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //sign in with email and password
  Future signin(String email,String password) async{
    try{
      AuthResult result=await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
      );
      FirebaseUser user=result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register wit email and password
  Future register(String email,String password,String name,int year,int rollNo,String branch,int contact,String linkedInURL,String githubURL,List<String> domains,bool hosteller,List<String> languages,bool mentor) async{
    try{
      AuthResult result=await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      );
      FirebaseUser user=result.user;
      await DataBaseService(uid:user.uid).updateUserData(name,year,email,rollNo,branch,contact,linkedInURL,githubURL,domains,hosteller,languages,false);
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //signout
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}