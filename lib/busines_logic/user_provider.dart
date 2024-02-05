import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  late SharedPreferences _prefs; // SharedPreferences instance
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;
   File? _imageFile;

  File? get imageFile => _imageFile;

  UserProvider() {
    _loadUserData(); // Load user data from SharedPreferences
  }
  Future<void> signOut({bool saveDataAfterLogout = true}) async {
    try {
      if (!saveDataAfterLogout) {
        // Clear SharedPreferences if the user chooses not to save data after logout
        await _prefs.clear();
      }

      // Sign out the user from FirebaseAuth
      await FirebaseAuth.instance.signOut();

      // Clear user-related data in Firestore and Storage if the user chooses not to save data after logout
      if (!saveDataAfterLogout) {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          // Delete user document in Firestore
          await FirebaseFirestore.instance.collection('users').doc(userId).delete();

          // Delete user image in Firebase Storage
          final ref = FirebaseStorage.instance.ref().child('user_images').child('$userId.png');
          await ref.delete();
        }

        // Reset local user data if the user chooses not to save data after logout
        firstName = null;
        lastName = null;
        email = null;
        imageUrl = null;
        _imageFile = null;
      }

      // Notify listeners about the changes
      notifyListeners();
    } catch (error) {
      print('Error signing out: $error');
      throw error;
    }
  }


  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required File? imageFile,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await updateUserProfile(
          userId: userCredential.user!.uid,
          firstName: firstName,
          lastName: lastName,
          email: email,
          imageFile: imageFile,
        );

        notifyListeners();
      }
    } catch (error) {
      print('Error signing up: $error');
      throw error;
    }
  }

  Future<void> updateUserProfile({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    File? imageFile,
  }) async {
    try {
      final userData = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      };

      // If a new image file is provided, upload it to Firebase Storage
      if (imageFile != null) {
        final ref = FirebaseStorage.instance.ref().child('user_images').child('$userId.png');
        await ref.putFile(imageFile);
        final imageUrl = await ref.getDownloadURL();

        // Update user data with the new image URL
        userData['imageUrl'] = imageUrl;
      }

      // Update user data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).set(userData);

      // Update user data locally and notify listeners
      setUserData(
        firstName: firstName,
        lastName: lastName,
        email: email,
        imageUrl: userData['imageUrl'], // Use the new image URL if available
      );
      notifyListeners();

    } catch (error) {
      print('Error updating profile: $error');
      throw error;
    }
  }


  Future<void> _loadUserData() async {
    _prefs = await SharedPreferences.getInstance();
    firstName = _prefs.getString('firstName') ?? '';
    lastName = _prefs.getString('lastName') ?? '';
    email = _prefs.getString('email') ?? '';
    imageUrl = _prefs.getString('imageUrl') ?? '';
    notifyListeners();
  }

  void setImageFile(File file) {
    _imageFile = file;
    notifyListeners();
  }

  // Method to update user data and save to SharedPreferences
  void setUserData({
    String? firstName,
    String? lastName,
    String? email,
    String? imageUrl,
  }) async {
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.imageUrl = imageUrl;

    // Save data to SharedPreferences
    await _prefs.setString('firstName', firstName ?? '');
    await _prefs.setString('lastName', lastName ?? '');
    await _prefs.setString('email', email ?? '');
    await _prefs.setString('imageUrl', imageUrl ?? '');

    notifyListeners();
  }

}
