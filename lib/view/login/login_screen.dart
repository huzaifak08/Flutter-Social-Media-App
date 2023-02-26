import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/components/input_text_field.dart';
import 'package:tech_media/res/components/round_button.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view/signup/sign_up_screen.dart';
import 'package:tech_media/view_model/Provider/login_providers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
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
              create: (_) => LoginProvider(),
              child: Consumer<LoginProvider>(
                builder: (context, provider, child) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: height * 0.01),
                        Text(
                          'Welcome to the App',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          'Enter your email address \n t0 connect to your account',
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
                                SizedBox(height: height * 0.01),
                                InputTextField(
                                  myController: passwordController,
                                  focusNode: passwordFocusNode,
                                  onFiledSubmissionValue: (newValue) {},
                                  onValidator: (value) {
                                    return value.isEmpty
                                        ? 'Enter Password'
                                        : null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  hint: 'Password',
                                  obsecureText: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('Forgot Password',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 15,
                                      decoration: TextDecoration.underline)),
                        ),
                        const SizedBox(height: 40),
                        RoundButton(
                          title: 'Login',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              provider.logIn(context, emailController.text,
                                  passwordController.text);
                            }
                          },
                          loading: provider.loading,
                        ),
                        SizedBox(height: height * 0.03),
                        Text.rich(
                          TextSpan(
                              text: "Don't have an account?  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 15),
                              children: [
                                TextSpan(
                                    text: 'Create Account',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, RouteName.registerScreen);
                                      })
                              ]),
                        )
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
