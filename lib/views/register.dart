import 'package:flutter/material.dart';
import 'package:flutter_b8_backend/services/auth.dart';
import 'package:flutter_b8_backend/views/login.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController emailController = TextEditingController();

  TextEditingController pwdController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
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
                          .signUpUser(
                              email: emailController.text,
                              password: pwdController.text)
                          .then((val) {
                        isLoading = false;
                        setState(() {});
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Message"),
                                content: Text(
                                    "User has been registered successfully"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginView()));
                                      },
                                      child: Text("Okay"))
                                ],
                              );
                            });
                      });
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Register")),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
