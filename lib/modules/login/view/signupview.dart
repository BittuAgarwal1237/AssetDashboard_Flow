import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_controller/auth_controller.dart';
import '../../../core/responsive.dart';
import '../../dashboard/view/dashboard_page.dart';
import '../../dashboard/dashboard_binding.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;

  final AuthController controller = Get.find<AuthController>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await controller.signUp(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (success && mounted) {
      Get.snackbar(
        'Success',
        'Account created Successfully.',
      );
      Get.offAll(() => const DashboardPage(), binding: DashboardBinding());

    }
  }

  @override
  Widget build(BuildContext context) {
    final spacing = context.adaptiveSpacing;

    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
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
                    Text(
                      'Create your account',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spacing / 2),
                    Text(
                      'Sign up with your email to get started',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spacing * 2),

                    // Name field
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Name Important';
                        }
                        if (value.trim().length < 2) {
                          return 'Enter Correct Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: spacing),

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
                          return 'Enter Correct Email';
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
                          return 'Password Do not Empty';
                        }
                        if (value.length < 6) {
                          return 'Password Must have 6 Character';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: spacing),

                    // Confirm Password field
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscurePassword,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Password match nahi ho raha';
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

                    // Signup button
                    Obx(
                          () => FilledButton(
                        onPressed: controller.isLoading ? null : _handleSignup,
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: context.useCompactMode ? 12 : 16),
                        ),
                        child: controller.isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                            : const Text('Sign Up'),
                      ),
                    ),

                    SizedBox(height: spacing),

                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Already Account? Do Login '),
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