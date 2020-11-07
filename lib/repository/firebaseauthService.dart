import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get userId => _auth.currentUser.uid;

  Future<void> signIn({
    @required String email,
    @required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signUp({
    @required String email,
    @required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  Future<UserCredential> reAuth({
    @required String email,
    @required String password,
  }) async {
    User user = _auth.currentUser;
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    UserCredential userCredential =
        await user.reauthenticateWithCredential(credential);
    return userCredential;
  }

  Future<void> deleteAccount({@required UserCredential credential}) async {
    await credential.user.delete();
  }
}
