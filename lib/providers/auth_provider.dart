// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shopsmart_users/root_screen.dart';
// import 'package:shopsmart_users/services/my_app_functions.dart';

// class AuthsProvider extends ChangeNotifier {
//   final auth = FirebaseAuth.instance;
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();

//   get _nameController => nameController;
//   get _emailController => emailController;

//   Future<void> registerFct(BuildContext context,
//       {required String email, required String password}) async {
//     FocusScope.of(context).unfocus();
//     bool _isLoading = false;
//     try {
//       _isLoading = true;
//       await auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       final User? user = auth.currentUser;
//       final String uid = user!.uid;
//       await FirebaseFirestore.instance.collection('users').doc().set({
//         "userId": uid,
//         "userName": _nameController.text,
//         'userImage': '',
//         'userEmail': _emailController.text.toLowerCase(),
//         'createdAt': Timestamp.now(),
//         'userWish': [],
//         'userCart': [],
//       });
//       await Fluttertoast.showToast(
//         msg: "An account has been created!",
//         textColor: Colors.white,
//       );
//       //  if (!mounted) return;
//       Navigator.pushReplacementNamed(context, RootScreen.routeName);
//     } on FirebaseException catch (e) {
//       await MyAppFunctions.showErrorOrWarringDialog(
//         context: context,
//         fct: () {},
//         subTitle: e.toString(),
//       );
//     } catch (e) {
//       await MyAppFunctions.showErrorOrWarringDialog(
//         context: context,
//         fct: () {},
//         subTitle: e.toString(),
//       );
//     } finally {
//       _isLoading = false;
//     }
//   }
// }
