import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shopsmart_users/screens/widgets/app_bar_widget.dart';
import 'package:shopsmart_users/screens/widgets/subtitle_text.dart';
import 'package:shopsmart_users/screens/widgets/title_text.dart';
import 'package:shopsmart_users/services/my_app_functions.dart';
import 'package:shopsmart_users/utils/validator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const routeName = "/ForgotPasswordScreen";

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final TextEditingController _emailController;
  late final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    if (mounted) {
      _emailController.dispose();
    }
  }

  Future<void> _forgotPassFCT() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text.trim());
        await MyAppFunctions.showErrorOrWarringDialog(
          context: context,
          fct: () {},
          subTitle: 'password reset link sent! Check your email',
        );
      } on FirebaseAuthException catch (e) {
        await MyAppFunctions.showErrorOrWarringDialog(
          context: context,
          fct: () {},
          subTitle: e.toString(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarWidget(
        centerTitle: true,
        child: TitlesTextWidget(
          label: 'Shop smart',
          fontSize: 22,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/images/forgot_password.jpg',
                width: size.width * 0.6,
                height: size.width * 0.6,
              ),
              const SizedBox(
                height: 10,
              ),
              const TitlesTextWidget(
                label: 'Forgot password',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              const SubTitleTextWidget(
                label:
                    'Please enter the email you\'d like your password reset informat',
                fontSize: 14,
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'test@gmail.com',
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(12),
                          child: const Icon(
                            IconlyLight.message,
                          ),
                        ),
                        filled: true,
                      ),
                      validator: (value) {
                        return MyValidators.emailValidator(value);
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await _forgotPassFCT();
                  },
                  icon: const Icon(
                    IconlyBold.send,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Request link',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
