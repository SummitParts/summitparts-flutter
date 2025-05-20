import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:summit_parts/core/ui/widget/generic_error.dart';
import 'package:summit_parts/features/auth/logic/auth_provider.dart';
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
            ? const AuthScreen()
            : Scaffold(
                appBar: AppBar(title: const Text('Account')),
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('userKey: ${user.userKey}'),
                      Text('userId: ${user.userId}'),
                      Text('customerId: ${user.customerId}'),
                      Text('customerNo: ${user.customerNo}'),
                      Text('arDivisionNo: ${user.arDivisionNo}'),
                      Text('customerKey: ${user.customerKey}'),
                      Text('fullName: ${user.fullName}'),
                      TextButton(
                        onPressed: () => ref.read(authNotifierProvider.notifier).signOut(),
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                ),
              );
      },
      error: (error, _) {
        return GenericError(
          exception: error,
          onRetry: () => ref.invalidate(userNotifierProvider),
          actions: [
            TextButton(onPressed: () => ref.read(authNotifierProvider.notifier).signOut(), child: const Text('Logout')),
          ],
        );
      },
      orElse: () => const Scaffold(body: Center(child: CircularProgressIndicator.adaptive())),
    );
  }
}
