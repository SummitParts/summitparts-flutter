import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/features/auth/logic/user_provider.dart';
import 'package:summit_parts/features/auth/ui/screen/auth_screen.dart';

class UserScreen extends ConsumerWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userNotifierProvider);
    return userAsync.maybeWhen(
      data: (user) {
        return user == null
            ? AuthScreen()
            : Scaffold(
              appBar: AppBar(
                title: const Text('Account'),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('User Logged In'),
                    TextButton(
                      onPressed: () {
                        ref.read(userNotifierProvider.notifier).signOut();
                      },
                      child: Text('Logout'),
                    ),
                  ],
                ),
              ),
            );
      },
      orElse: () => Scaffold(body: Center(child: CircularProgressIndicator.adaptive())),
    );
  }
}
