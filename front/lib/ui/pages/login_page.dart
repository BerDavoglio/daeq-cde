import 'package:flutter/material.dart';

import '../../ui/ui.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[700]!),
              borderRadius: const BorderRadius.all(Radius.circular(42.0)),
              color: const Color.fromRGBO(253, 182, 182, 1),
              boxShadow: [
                const BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 2.5,
                  blurRadius: 7,
                  offset: Offset(10, 10), // changes position of shadow
                ),
                BoxShadow(
                  color: Colors.grey[300]!,
                  spreadRadius: 1,
                  blurRadius: 30,
                  offset: const Offset(-20, -20), // changes position of shadow
                ),
              ],
            ),
            width: 400,
            height: 450,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 120,
                    child: Image(
                      image: AssetImage('lib/ui/assets/image/logo.png'),
                    ),
                  ),
                  Column(
                    children: [
                      Form(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                              ),
                              child: inputTextGeneric(context, 'Email',
                                  Icons.email_outlined, false),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                              ),
                              child: inputTextGeneric(context, 'Password',
                                  Icons.lock_outlined, true),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50),
                          backgroundColor: Colors.deepOrange[400],
                        ),
                        child: Text('Enter'.toUpperCase()),
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.HOME);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
