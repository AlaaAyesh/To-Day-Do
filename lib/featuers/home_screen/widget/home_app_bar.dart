import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/global/colors/app_color.dart';
import '../../auth/persentation/authentication_screen.dart';
import '../../tasks_screen/widget/switch_theme_button.dart';
import '../../user/persentation/profile_screen.dart';
import '../../../busines_logic/user_provider.dart';

class HomeScreenAppBar extends StatefulWidget {
  const HomeScreenAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreenAppBar> createState() => _HomeScreenAppBarState();
}

class _HomeScreenAppBarState extends State<HomeScreenAppBar> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) => Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProfileInfo(),
              PopupMenuButton(
                  itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          child: ThemeToggleSwitch(),
                        ),
                        PopupMenuItem(
                          child: _buildLogoutButton(),
                        )
                      ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.cyan,
            child: GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
                if (result == true) {
                  // Refresh the widget when profile updates
                  setState(() {});
                }
              },
              child: Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  return _buildProfileImage(userProvider);
                },
              ),
            ),
          ),
        ),
        StreamBuilder<User?>(
          stream: _auth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else if (!snapshot.hasData) {
              return const Text('Not logged in');
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
                      'hello , ${username}',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1?.color,
                        fontSize: 18,
                        fontFamily: Theme.of(context).textTheme.bodyText1?.fontFamily,
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildProfileImage(UserProvider userProvider) {
    final imageUrl = userProvider.imageUrl;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return CircleAvatar(
        backgroundColor: Colors.red,
        backgroundImage: CachedNetworkImageProvider(
          imageUrl,
        ),
        radius: 30,
      );
    } else {
      return const CircleAvatar(
        backgroundColor: Colors.green,
        child: Icon(Icons.person),
        radius: 30,
      );
    }
  }

  Widget _buildLogoutButton() {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          final user = snapshot.data;
          final isLoggedIn = user != null;
          return IconButton(
            icon: Icon(isLoggedIn ? Icons.logout : Icons.login),
            onPressed: () async {
              if (isLoggedIn) {
                await _auth.signOut();
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthenticationScreen(),
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
