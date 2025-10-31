import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_notes/databse_helper/data_base_helper.dart';

class AuthResult {
  final User? user;
  final String? error;

  AuthResult({this.user, this.error});

  bool get isSuccess => user != null && error == null;
}
