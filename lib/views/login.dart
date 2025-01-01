import 'package:flutter/material.dart';
import 'package:flutter_b8_backend/services/auth.dart';
import 'package:flutter_b8_backend/views/dashboard.dart';
import 'package:flutter_b8_backend/views/forgot_pwd.dart';
import 'package:flutter_b8_backend/views/get_all_categories.dart';
import 'package:flutter_b8_backend/views/get_all_task.dart';
import 'package:flutter_b8_backend/views/register.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();

  TextEditingController pwdController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
          ),
          TextField(
            controller: pwdController,
          ),
          SizedBox(
            height: 40,
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Email cannot be empty")));
                      return;
                    }
                    if (pwdController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Password cannot be empty")));
                      return;
                    }

                    try {
                      isLoading = true;
                      setState(() {});
                      await AuthServices()
                          .signInUser(
                              email: emailController.text,
                              password: pwdController.text)
                          .then((val) {
                        isLoading = false;
                        setState(() {});
                        if (val != null) {
                          if (val.emailVerified == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GetAllCategoriesView()));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Message"),
                                    content: Text("Kindly verify your email"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            emailController.clear();
                                            pwdController.clear();
                                            Navigator.pop(context);
                                          },
                                          child: Text("Okay"))
                                    ],
                                  );
                                });
                          }
                        }
                      });
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Login")),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordView()));
              },
              child: Text("Forgot Password")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterView()));
              },
              child: Text("Register"))
        ],
      ),
    );
  }
}
