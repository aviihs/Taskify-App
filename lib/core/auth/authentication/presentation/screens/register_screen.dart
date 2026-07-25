import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:taskify_app/core/constants/app_colors.dart';
import 'package:taskify_app/core/widget/buttons/app_button.dart';
import 'package:taskify_app/router/routes/app_routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register"), centerTitle: true),
      body:  Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Card(
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person_add_alt_1,
                    size: 60,
                    color: Colors.deepPurple,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Register Screen",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Create your account to continue.",
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 8),
                  AppButton(
                    text: 'Login',
                    backgroundColor: AppColors.accent,
                    height: 52,
                    borderRadius: 14,
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.login);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
