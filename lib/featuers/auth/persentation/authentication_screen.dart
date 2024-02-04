import 'package:flutter/material.dart';

import '../login/persentation/login.dart';
import '../signup/persentation/signup.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Welcome',
          ),
          elevation: 0,
          backgroundColor: Colors.cyan,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.lock),
                text: "login",
              ),
              Tab(
                icon: Icon(Icons.lock),
                text: "login",
              )
            ],
            indicatorColor: Colors.white,
            indicatorWeight: 5,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xffF5F5F5),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(6),
              topLeft: Radius.circular(6),
            ),
          ),
          child: const TabBarView(children: [LoginScreen(), SignUpScreen()]),
        ),
      ),
    );
  }
}
