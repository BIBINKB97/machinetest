import 'package:flutter/material.dart';
import 'package:tezda/controller/auth_controller/register_controller.dart';
import 'package:tezda/utils/common_widgets/custom_container.dart';
import 'package:tezda/utils/common_widgets/text_style.dart';
import 'package:tezda/utils/utils.dart';
import 'package:tezda/view/login_screen/registration_screen/widgets/text_form_field.dart';

class RegistrationScreen
    extends StatefulWidget {
  const RegistrationScreen(
      {super.key});

  @override
  State<RegistrationScreen>
      createState() =>
          _RegistrationScreenState();
}

class _RegistrationScreenState
    extends State<
        RegistrationScreen> {
  final loginKey =
      GlobalKey<FormState>();
  TextEditingController
      _nameController =
      TextEditingController();
  TextEditingController
      _emailController =
      TextEditingController();
  TextEditingController
      _passwordController =
      TextEditingController();
  TextEditingController
      _phoneController =
      TextEditingController();

// To dispose the both Controllers
  @override
  void
      dispose() {
    _nameController
        .dispose();
    _emailController
        .dispose();
    _passwordController
        .dispose();
    _phoneController
        .dispose();
    super
        .dispose();
  }

  @override
  Widget build(
      BuildContext
          context) {
    return Scaffold(
      body:
          SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 430,
              child: Form(
                key: loginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                      text: "Register here",
                      fs: 20,
                      fw: FontWeight.w600,
                    ),
                    CustomTextFormField(
                      label: "Enter Name",
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Enter username";
                        }
                        if (value.trim().length < 8) {
                          return "Minimum 8 characters required";
                        }
                        return null;
                      },
                      obscureText: false,
                    ),
                    CustomTextFormField(
                      label: "Enter Email ID",
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Enter Email";
                        }
                        final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return ' Enter a valid email address';
                        }
                        return null;
                      },
                      obscureText: false,
                    ),
                    CustomTextFormField(
                      label: "Enter Password",
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Enter password";
                        }
                        if (value.trim().length < 8) {
                          return "Minimum 8 characters required";
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    CustomTextFormField(
                      label: "Enter Phone Number",
                      controller: _phoneController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Enter a valid PhoneNumber";
                        }
                        if (value.trim().length < 10) {
                          return "Enter a valid phone number";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      obscureText: false,
                    ),
                    InkWell(
                      onTap: () async {
                        //Logic for Registration
                        if (loginKey.currentState!.validate()) {
                          RegisterController authService = RegisterController();
                          final user = await authService.register(_nameController.text, _emailController.text, _phoneController.text, _passwordController.text);
                          if (user != null) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: kwhite,
                                content: Center(
                                    child: CustomText(
                                  text: 'Logged in successfully',
                                  fs: 18,
                                  color: kgreen,
                                ))));
                            Navigator.of(context).pushReplacementNamed('/home');
                          }
                        }
                      },
                      child: CustomContainer(
                        height: 55,
                        width: 200,
                        borderRadius: 10,
                        border: Border.all(width: 2, color: kblue),
                        color: kgrey,
                        child: Center(
                            child: CustomText(
                          text: "Submit",
                          fs: 19,
                          fw: FontWeight.w600,
                          color: kwhite,
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Already have an account ?",
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/');
                    },
                    child: CustomText(
                      text: 'Login Now',
                      fs: 16,
                      fw: FontWeight.w600,
                      color: kblue,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
