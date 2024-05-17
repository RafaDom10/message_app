import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
User? user;

Future<String?> signInWithGoogle() async {
  await Firebase.initializeApp();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication? googleSignInAuthentication =
      await googleSignInAccount?.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken);
  final UserCredential userCredential =
      await firebaseAuth.signInWithCredential(credential);
  user = userCredential.user;

  if (user != null) {
    assert(user?.email != null);
    assert(user?.photoURL != null);
    assert(user?.displayName != null);
    assert(!user!.isAnonymous);
    assert(await user?.getIdToken() != null);
    assert(user?.uid == firebaseAuth.currentUser?.uid);
    return '$user';
  }

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  user = null;
}
