import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/view_model/Provider/forgot_provider.dart';

import '../res/components/input_text_field.dart';
import '../res/components/round_button.dart';
import '../utils/routes/route_name.dart';
import '../view_model/Provider/login_logout_providers.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  final emailFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ChangeNotifierProvider(
              create: (_) => ForgotProvider(),
              child: Consumer<ForgotProvider>(
                builder: (context, provider, child) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: height * 0.01),
                        Text(
                          'Forgot Password',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          'Enter your email address \n to recover your password',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: height * 0.01),
                        Form(
                          key: formKey,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.06, bottom: height * 0.01),
                            child: Column(
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
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        RoundButton(
                          title: 'Recover',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              provider.forgotPassword(
                                  context, emailController.text);
                            }
                          },
                          loading: provider.loading,
                        ),
                      ],
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }
}
