import 'package:flutter/material.dart';
import 'package:phistrap/Functions/Auth.dart';
import 'package:phistrap/Utils/constants.dart';
import 'package:phistrap/Widgets/custom_button.dart';
import 'package:phistrap/Widgets/custom_text.dart';
import 'package:phistrap/Widgets/custom_text_button.dart';
import 'package:phistrap/Widgets/custom_text_field.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: transaparent,
        toolbarHeight: 180,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const CustomText(
                textAlign: TextAlign.start,
                value: "Phis-Trap",
                size: 29.96,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700,
                color: primaryColor,
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                        labelText: "Enter Email",
                        errorText: "Enter your Email ID",
                        controller: _emailController),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                        labelText: "Enter Password",
                        errorText: "Enter your Password",
                        controller: _passwordController),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Forgot Password?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                  child: CustomButton(
                text: "Log in",
                color: primaryColor,
                fixedSize: const Size(350, 55),
                callback: () {
                  if (_formKey.currentState!.validate()) {
                    signInWithEmailAndPassword(context);
                  }
                },
              )),
              const SizedBox(
                height: 20,
              ),
              const CustomText(
                textAlign: TextAlign.center,
                value: "or",
                color: secondaryColor,
                size: 16,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: CustomTextButton(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
