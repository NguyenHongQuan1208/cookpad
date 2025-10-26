import 'package:cooking_pad/config/dimens.dart';
import 'package:cooking_pad/config/image_paths.dart';
import 'package:cooking_pad/network/services/auth_service.dart';
import 'package:cooking_pad/utils/helpers/call_supabase_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cooking_pad/navigation/route_names.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _obscureText = true;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng nhập',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        scrolledUnderElevation: 0,
      ),
      body: FocusScope(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Logo
                    Image.asset(
                      ImagePaths.cookpadLogo2,
                      width: context.w(200),
                      height: context.h(200),
                    ),
                    SizedBox(height: context.h(20)),
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
                          errorText: 'Email không được để trống',
                        ),
                        FormBuilderValidators.email(
                          errorText: 'Email không đúng định dạng',
                        ),
                      ]),
                      onChanged: (value) {
                        _formKey.currentState?.fields['email']?.validate();
                      },
                    ),
                    SizedBox(height: context.h(16)),
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
                        prefixIcon: const Icon(Icons.lock, color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        errorStyle: const TextStyle(color: Colors.red),
                      ),
                      obscureText: _obscureText,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Password không được để trống',
                        ),
                        FormBuilderValidators.minLength(
                          8,
                          errorText: 'Password phải có ít nhất 8 ký tự',
                        ),
                      ]),
                      onChanged: (value) {
                        _formKey.currentState?.fields['password']?.validate();
                      },
                    ),
                    SizedBox(height: context.h(24)),
                    // Sign-In Button
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          final email =
                              _formKey.currentState?.fields['email']?.value;
                          final password =
                              _formKey.currentState?.fields['password']?.value;

                          final authService = AuthService();

                          await callSupabaseAuthApi<AuthResponse>(
                            context: context,
                            service: () => authService.signInWithEmailPassword(
                              email,
                              password,
                            ),
                            successMessage: 'Đăng nhập thành công!',
                            onSuccess: (response) {
                              context.go(Routes.home);
                            },
                            onError: (errorMessage) {
                              debugPrint('Lỗi đăng nhập: $errorMessage');
                            },
                            errorPrefix: 'Lỗi đăng nhập',
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                      ),
                      child: const Text('Đăng nhập'),
                    ),

                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        context.push(Routes.register);
                      },
                      child: Text(
                        'Chưa có tài khoản? Đăng ký ngay',
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
    );
  }
}
