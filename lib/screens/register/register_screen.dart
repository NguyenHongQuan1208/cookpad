import 'package:cooking_pad/config/dimens.dart';
import 'package:cooking_pad/config/image_paths.dart';
import 'package:cooking_pad/network/services/auth_service.dart';
import 'package:cooking_pad/utils/helpers/call_supabase_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:cooking_pad/navigation/route_names.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RegisterScreen extends HookWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final usernameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    final obscureText = useState(true);
    final obscureConfirmText = useState(true);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: FocusScope(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: FormBuilder(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Logo
                          Image.asset(
                            ImagePaths.cookpadLogo2,
                            width: context.w(200),
                            height: context.h(150),
                          ),

                          // Username Input
                          FormBuilderTextField(
                            name: 'username',
                            controller: usernameController,
                            decoration: InputDecoration(
                              hintText: 'Username',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  context.radius(30),
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              errorStyle: const TextStyle(color: Colors.red),
                            ),
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'Username cannot be empty',
                              ),
                            ]),
                            onChanged: (value) => formKey
                                .currentState
                                ?.fields['username']
                                ?.validate(),
                          ),
                          SizedBox(height: context.h(16)),

                          // Email Input
                          FormBuilderTextField(
                            name: 'email',
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  context.radius(30),
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              errorStyle: const TextStyle(color: Colors.red),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'Email cannot be empty',
                              ),
                              FormBuilderValidators.email(
                                errorText: 'Invalid email format',
                              ),
                            ]),
                            onChanged: (value) => formKey
                                .currentState
                                ?.fields['email']
                                ?.validate(),
                          ),
                          SizedBox(height: context.h(16)),

                          // Password Input
                          FormBuilderTextField(
                            name: 'password',
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  context.radius(30),
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscureText.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed: () =>
                                    obscureText.value = !obscureText.value,
                              ),
                              errorStyle: const TextStyle(color: Colors.red),
                            ),
                            obscureText: obscureText.value,
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'Password cannot be empty',
                              ),
                              FormBuilderValidators.minLength(
                                8,
                                errorText:
                                    'Password must be at least 8 characters',
                              ),
                            ]),
                            onChanged: (value) => formKey
                                .currentState
                                ?.fields['password']
                                ?.validate(),
                          ),
                          SizedBox(height: context.h(16)),

                          // Confirm Password Input
                          FormBuilderTextField(
                            name: 'confirm_password',
                            controller: confirmPasswordController,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  context.radius(30),
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscureConfirmText.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed: () => obscureConfirmText.value =
                                    !obscureConfirmText.value,
                              ),
                              errorStyle: const TextStyle(color: Colors.red),
                            ),
                            obscureText: obscureConfirmText.value,
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'Confirm Password cannot be empty',
                              ),
                              (value) {
                                if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ]),
                            onChanged: (value) => formKey
                                .currentState
                                ?.fields['confirm_password']
                                ?.validate(),
                          ),
                          SizedBox(height: context.h(24)),

                          // Register Button
                          ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState?.saveAndValidate() ??
                                  false) {
                                final email = emailController.text;
                                final password = passwordController.text;
                                final username = usernameController.text;

                                final authService = AuthService();

                                await callSupabaseAuthApi<AuthResponse>(
                                  service: () =>
                                      authService.signUpWithEmailPassword(
                                        email,
                                        password,
                                        {'username': username},
                                      ),
                                  context: context,
                                  successMessage: 'Registration successful!',
                                  onSuccess: (res) {
                                    context.go(Routes.home);
                                  },
                                  onError: (msg) {
                                    debugPrint('Registration failed: $msg');
                                  },
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                            ),
                            child: const Text('Register'),
                          ),

                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () => context.push(Routes.signin),
                            child: Text(
                              'Already have an account? Sign in now',
                              style: TextStyle(
                                color: colorScheme.primary,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Skip Button
          Positioned(
            bottom: context.h(30),
            right: context.w(20),
            child: TextButton(
              onPressed: () => context.go(Routes.home),
              style: TextButton.styleFrom(backgroundColor: Colors.transparent),
              child: Text(
                'Skip',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
