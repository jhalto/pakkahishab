import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pakkahishab/features/auth/viewmodel/signup_viewmodel.dart';

class SignupView extends ConsumerWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(signupViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Name"),
              onChanged: (val) => vm.updateName(val),
            ),
            if (vm.error != null && vm.error!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  vm.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: "Phone"),
              keyboardType: TextInputType.phone,
              onChanged: (val) => vm.updatePhone(val),
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
              onChanged: (val) => vm.updatePassword(val),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: vm.isLoading
                  ? null
                  : () async {
                      final success = await vm.register();
                      if (success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Registration Successful")),
                        );
                      }
                    },
              child: vm.isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}