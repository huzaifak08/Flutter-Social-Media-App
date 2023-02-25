import 'package:flutter/material.dart';
import 'package:tech_media/res/components/input_text_field.dart';
import 'package:tech_media/res/components/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputTextField(
              myController: emailController,
              focusNode: emailFocusNode,
              onFiledSubmissionValue: (newValue) {},
              onValidator: (value) {
                return value.isEmpty ? 'Enter Email' : null;
              },
              keyboardType: TextInputType.emailAddress,
              hint: 'Email',
              obsecureText: false,
            ),
            const SizedBox(height: 40),
            RoundButton(
              title: 'Huzaifa',
              onPressed: () {},
              loading: false,
            ),
          ],
        ),
      ),
    );
  }
}
