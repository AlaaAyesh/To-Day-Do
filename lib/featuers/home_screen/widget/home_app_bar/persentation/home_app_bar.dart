import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/global/colors/app_color.dart';
import '../../../../../busines_logic/user_provider.dart';
import '../widget/app_bar_profile_image.dart';
import '../widget/app_bar_profile_info.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final FirebaseAuth _auth;

  const HomeScreenAppBar({
    Key? key,
    required FirebaseAuth auth,
  })  : _auth = auth,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    final Color backgroundColor = brightness == Brightness.light
        ? AppColors.mainColor1
        : AppColors.mainColor5;
    final Color iconColor = brightness == Brightness.light
        ? AppColors.mainColor4
        : AppColors.mainColor1;

    return Consumer<UserProvider>(
      builder: (context, userProvider, child) => AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: iconColor),
        backgroundColor: backgroundColor,
        title: _buildProfileInfo(context),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return ProfileImage(
                  imageUrl: userProvider.imageUrl,
                );
              },
            ),
          ),
          AppBarProfileInfo(auth: _auth), // Access widget._auth
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
