import 'package:dushshop/models/http_exception.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String? _userId;
  String? _token;
  DateTime? _expiryDate;

// getters
  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    } else {
      return null;
    }
  }

///////////////////////////////////////////////////////
  Future<void> _authenticate(
      String? email, String? password, String? urlSegment) async {
    var url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:${urlSegment}?key=AIzaSyBene9EPgiUJ-LfnBZBS75qo_Zo4c0zQ2w');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();

      // print(json.decode(response.body));
    } catch (err) {
      throw err;
    }
  }

// signUp
  Future<void> signUp(String? email, String? password) async {
    return _authenticate(email, password, 'signUp');
  }

  //  login function signInWithPassword
  Future<void> login(String? email, String? password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
