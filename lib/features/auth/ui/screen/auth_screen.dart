import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:summit_parts/core/ui/exception_handling/error_snack_bar.dart';
import 'package:summit_parts/features/auth/logic/auth_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  static const String path = '/auth';

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(authNotifierProvider.notifier).signIn(_emailController.text.trim(), _passwordController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    ref.listen(authNotifierProvider, (_, next) {
      next.maybeWhen(error: (error, _) => showErrorSnackBar(context, error), orElse: () {});
    });
    return Scaffold(
      appBar: AppBar(title: const Text('User Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'User ID',
                  hintText: 'Enter your email address',
                  prefixIcon: Icon(FontAwesomeIcons.userLarge),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(FontAwesomeIcons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible ? FontAwesomeIcons.solidEye : FontAwesomeIcons.solidEyeSlash),
                    onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  ),
                ),
                obscureText: !_isPasswordVisible,
                textInputAction: TextInputAction.done,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _signIn(),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 20,
                  child: TextButton(
                    onPressed: () {
                      launchUrl(
                        Uri.https('www.summitparts.com', '/shop/login/retrieve/'),
                        mode: LaunchMode.inAppBrowserView,
                      );
                    },
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelMedium,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                    ),
                    child: const Text('Forgot your password?'),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              authState.maybeWhen(
                loading: () => const Center(child: CircularProgressIndicator.adaptive()),
                orElse: () => ElevatedButton(onPressed: _signIn, child: const Text('Login')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
