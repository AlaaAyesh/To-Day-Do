import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../busines_logic/user_provider.dart';
import '../../../../auth_screen/persentation/authentication_screen.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key, required this.auth}) : super(key: key);
  final FirebaseAuth auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          final user = snapshot.data;
          final isLoggedIn = user != null;
          return Row(
            children: [
              IconButton(
                icon: Icon(isLoggedIn ? Icons.logout : Icons.login),
                onPressed: () async {
                  if (isLoggedIn) {
                    try {
                      final saveDataAfterLogout =
                      await _showLogoutDialog(context);
                      await Provider.of<UserProvider>(context, listen: false)
                          .signOut(
                        saveDataAfterLogout: saveDataAfterLogout,
                      );
                    } catch (error) {
                      print('Error signing out: $error');
                      // Handle error
                    }
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthenticationScreen(),
                      ),
                    );
                  }
                },
                tooltip: isLoggedIn ? 'Logout' : 'Login',
              ),
              const SizedBox(width: 8), // Add some space between icon and text
              Text(
                isLoggedIn ? 'Logout' : 'Login',
                style: TextStyle(fontSize: 16),
              ),
            ],
          );
        }
      },
    );
  }

  Future<bool> _showLogoutDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Do you want to save your data after logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    ) ??
        false; // Return false if the dialog is dismissed
  }
}
