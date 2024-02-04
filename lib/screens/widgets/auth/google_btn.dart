import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shopsmart_users/root_screen.dart';
import 'package:shopsmart_users/services/my_app_functions.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  Future<void> _googleSignIn({required BuildContext context}) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.additionalUserInfo!.isNewUser) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(
              userCredential.user!.uid,
            )
            .set({
          "userId": userCredential.user!.uid,
          "userName": userCredential.user!.displayName,
          'userImage': userCredential.user!.photoURL,
          'userEmail': userCredential.user!.email,
          'createdAt': Timestamp.now(),
          'userWish': [],
          'userCart': [],
        });
      }

      Navigator.pushReplacementNamed(context, RootScreen.routeName);
    } on FirebaseAuthException catch (error) {
      await MyAppFunctions.showErrorOrWarringDialog(
        context: context,
        fct: () {},
        subTitle: error.message.toString(),
      );
    } catch (error) {
      await MyAppFunctions.showErrorOrWarringDialog(
        context: context,
        fct: () {},
        subTitle: error.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        padding: const EdgeInsets.all(12),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
      ),
      onPressed: () async {
        await _googleSignIn(context: context);
      },
      icon: const Icon(
        Ionicons.logo_google,
        color: Colors.red,
      ),
      label: const Text(
        'Sign in with google',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
