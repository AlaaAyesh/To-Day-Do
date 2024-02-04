import 'package:flutter/material.dart';

import '../../../core/global/colors/app_color.dart';

class EditUserInfoBottomSheet extends StatelessWidget {
  const EditUserInfoBottomSheet({
    super.key,
    required this.firstNameTextController,
    required this.lastNameTextController,
    required this.emailNameTextController,
    required this.formKey,
    required this.chooseImage,
    required this.saveChanges,
  });
  final Future<void> Function() chooseImage;
  final Future<void> Function() saveChanges;
  final TextEditingController firstNameTextController;
  final TextEditingController lastNameTextController;
  final TextEditingController emailNameTextController;
  final Key? formKey;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final gradientColors =
        isDarkMode ? darkThemeGradientColors : lightThemeGradientColors;
    return Center(
      child: ElevatedButton(
        child: const Text('Edit Your Information'),
        onPressed: () {
          showModalBottomSheet<void>(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(22),
                        topLeft: Radius.circular(22)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: gradientColors,
                    ),
                  ),
                  height: 1000,
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: firstNameTextController,
                              decoration: const InputDecoration(
                                  labelText: 'First Name'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: lastNameTextController,
                              decoration:
                                  const InputDecoration(labelText: 'Last Name'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: emailNameTextController,
                              decoration:
                                  const InputDecoration(labelText: 'Email'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 22,),
                            ElevatedButton(
                              onPressed: saveChanges,
                              child: const Text('Save Changes'),
                            ),
                            ElevatedButton(
                              onPressed: chooseImage,
                              child: const Text('Choose Image'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  List<Color> get lightThemeGradientColors => [
        AppColors.mainColor1,
        AppColors.mainColor2,
      ];

  List<Color> get darkThemeGradientColors => [
        AppColors.mainColor5,
        AppColors.mainColor4,
      ];
}
