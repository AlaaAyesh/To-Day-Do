import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../busines_logic/user_provider.dart';
import 'custom_user_nnfo.dart';
import 'divider.dart';
import 'edit_user_info_bottom_sheet.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({
    super.key,
    required this.firstNameTextController,
    required this.lastNameTextController,
    required this.emailNameTextController,
    required this.formKey,
    required this.saveChanges,
    required this.chooseImage,
  });
  final TextEditingController firstNameTextController;
  final TextEditingController lastNameTextController;
  final TextEditingController emailNameTextController;
  final GlobalKey<FormState> formKey;
  final Future<void> Function() saveChanges;
  final Future<void> Function() chooseImage;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (context, userProvider, child) => SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomUserInfo(
                        title: 'First Name  :  ',
                        value: ' ${userProvider.firstName}'),
                    const CustomDivider(endIndent: 16),
                    CustomUserInfo(
                        title: 'Last Name  :  ',
                        value: ' ${userProvider.lastName}'),
                    const CustomDivider(endIndent: 16),
                    CustomUserInfo(
                        title: 'Email  :  ',
                        value: ' ${userProvider.email}'),
                    const CustomDivider(endIndent: 16),
                    const SizedBox(
                      height: 22,
                    ),
                    EditUserInfoBottomSheet(
                      firstNameTextController: firstNameTextController,
                      lastNameTextController: lastNameTextController,
                      emailNameTextController: emailNameTextController,
                      formKey: formKey,
                      saveChanges: saveChanges,
                      chooseImage: chooseImage,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

