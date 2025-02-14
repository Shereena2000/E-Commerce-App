import 'package:fashion_admin_app/controllers/auth_service.dart';
import 'package:flutter/material.dart';

class AuthStateProvider with ChangeNotifier {
  bool _obsecureText = true;
  bool _isLoading = false;

  bool get obsecureText => _obsecureText;
  bool get isLoading => _isLoading;

  void toggleObsecureText(){
    _obsecureText=!_obsecureText;
    notifyListeners();
    
  }
   Future<String> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    String result = await AuthService().loginWithEmail(email, password);

    _isLoading = false;
    notifyListeners();

    return result;
  }
  Future<String>signup(String name,String email, String password)async{
    _isLoading=true;
    notifyListeners();
    String result=await AuthService().createAccountwithEmail(name,email, password);
   _isLoading =false;
   notifyListeners();
   return result;

  }
}