import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class ConcaminSaludFirebaseUser {
  ConcaminSaludFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

ConcaminSaludFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ConcaminSaludFirebaseUser> concaminSaludFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<ConcaminSaludFirebaseUser>(
            (user) => currentUser = ConcaminSaludFirebaseUser(user));
