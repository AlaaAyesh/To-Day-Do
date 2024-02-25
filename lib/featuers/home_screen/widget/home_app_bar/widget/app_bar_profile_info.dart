import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_day_do/featuers/auth_screen/persentation/authentication_screen.dart';
import 'package:to_day_do/featuers/auth_screen/signup/persentation/signup.dart';

class AppBarProfileInfo extends StatelessWidget {
  const AppBarProfileInfo({
    Key? key,
    required FirebaseAuth auth,
  }) : _auth = auth, super(key: key);

  final FirebaseAuth _auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else if (!snapshot.hasData) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthenticationScreen()));
            },
            child: Text(
              'START LOGIN IN ',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize:28,
                fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
              ),
            ),
          );
        } else {
          final user = snapshot.data!;
          return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error');
              } else {
                final userData = snapshot.data!.data();
                final username = userData?['firstName'] ?? 'Username';
                final imageUrl = userData?['imageUrl'] ?? '';

                return Text(
                  'hello , $username',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 28,
                    fontFamily:
                    Theme.of(context).textTheme.bodyLarge?.fontFamily,
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
