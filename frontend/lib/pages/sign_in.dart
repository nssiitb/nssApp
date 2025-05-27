import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nssapp/widgets/login_form.dart';
import 'package:nssapp/utils/routes.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'SIGN IN',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 1, 1, 59),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const LoginForm(),
            const Spacer(),
            Column(
              children: [
                const Text(
                  "OR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 1, 1, 59),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  color: const Color.fromARGB(255, 1, 1, 59),
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Facebook button
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                            ),
                            child: FaIcon(
                              FontAwesomeIcons
                                  .facebook, // Use FontAwesome's Facebook icon
                              color: Colors.blue[900],
                            ),
                          ),

                          const SizedBox(width: 16.0),

                          // Twitter button
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                            ),
                            child: const FaIcon(
                              FontAwesomeIcons
                                  .twitter, // Use FontAwesome's Twitter icon
                              color: Colors.lightBlue,
                            ),
                          ),

                          const SizedBox(width: 16.0),

                          // Google button
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                            ),
                            child: const FaIcon(
                              FontAwesomeIcons
                                  .google, // Use FontAwesome's Google icon
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.signUpRoute);
                        },
                        child: Text(
                          "Create a new account",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 16,
                            color: Colors.white.withOpacity(.9),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
