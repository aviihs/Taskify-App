import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify_app/core/auth/authentication/domain/entity/auth_entity.dart';
import 'package:taskify_app/core/auth/authentication/presentation/providers/auth_provider.dart';

class AuthTestScreen extends ConsumerWidget {
  const AuthTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Auth Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            if (authState.isLoading)
              const CircularProgressIndicator(),


            Text(
              "Token: ${authState.token ?? "No token"}",
            ),

            const SizedBox(height: 10),

            Text(
              "Email: ${authState.user?.email ?? "No user"}",
            ),


            const SizedBox(height: 20),


            ElevatedButton(
              onPressed: () async {

                final result =
                    await ref.read(authProvider.notifier).login(
                      const AuthEntity(
                        email: "shiva@gmail.com",
                        password: "Password@123",
                      ),
                    );


                if (result) {
                  debugPrint("Login Success");
                } else {
                  debugPrint(
                    authState.error ?? "Login Failed",
                  );
                }
              },
              child: const Text("Login Test"),
            ),


            const SizedBox(height: 20),


            if (authState.error != null)
              Text(
                authState.error!,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),


            if (authState.successMessage != null)
              Text(
                authState.successMessage!,
                style: const TextStyle(
                  color: Colors.green,
                ),
              ),

          ],
        ),
      ),
    );
  }
}