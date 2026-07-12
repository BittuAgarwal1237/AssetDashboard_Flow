import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_controller/auth_controller.dart';
import '../../../core/responsive.dart';
import '../../../core/app_constants.dart';
import 'signupview.dart';
import '../../dashboard/view/dashboard_page.dart';
import '../../dashboard/dashboard_binding.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  final AuthController controller = Get.find<AuthController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await controller.login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (success && mounted) {
      Get.snackbar('Success', 'Login successful!');
      Get.offAll(() => const DashboardPage(), binding: DashboardBinding());
    }
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.adaptiveSpacing;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: context.adaptiveHPadding,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: context.dialogWidth),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.account_balance_wallet_rounded,
                      size: context.isDesktopScreen ? 72 : 64,
                    ),
                    SizedBox(height: spacing),
                    Text(
                      'Welcome back',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: (Theme.of(context).textTheme.headlineSmall?.fontSize ?? 24) *
                            context.fontScale,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spacing / 2),
                    Text(
                      'Login to continue to ${AppConstants.appName}',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spacing * 2),

                    // Email field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email Important';
                        }
                        if (!value.contains('@')) {
                          return 'Enter correct Eail';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: spacing),

                    // Password field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          onPressed: () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password Is Empty';
                        }
                        if (value.length < 6) {
                          return 'Password Must have 6 Character';
                        }
                        return null;
                      },
                    ),

                    Obx(() {
                      if (controller.status.value == AuthStatus.error) {
                        return Padding(
                          padding: EdgeInsets.only(top: spacing),
                          child: Text(
                            controller.errorMessage.value,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),

                    SizedBox(height: spacing * 1.5),

                    Obx(
                          () => FilledButton(
                        onPressed: controller.isLoading ? null : _handleLogin,
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: context.useCompactMode ? 12 : 16),
                        ),
                        child: controller.isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                            : const Text('Login'),
                      ),
                    ),

                    SizedBox(height: spacing),

                    TextButton(
                      onPressed: () => Get.to(() => const SignupView()),
                      child: const Text("Do not have Account? Do Sign up "),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}