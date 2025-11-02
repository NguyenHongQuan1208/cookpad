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

class SignInScreen extends HookWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscureText = useState(true);

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
                key: formKey,
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
                        formKey.currentState?.fields['email']?.validate();
                      },
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
                        prefixIcon: const Icon(Icons.lock, color: Colors.black),
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
                          errorText: 'Password không được để trống',
                        ),
                        FormBuilderValidators.minLength(
                          8,
                          errorText: 'Password phải có ít nhất 8 ký tự',
                        ),
                      ]),
                      onChanged: (value) {
                        formKey.currentState?.fields['password']?.validate();
                      },
                    ),
                    SizedBox(height: context.h(24)),

                    // Sign-In Button
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState?.saveAndValidate() ?? false) {
                          final email =
                              formKey.currentState?.fields['email']?.value;
                          final password =
                              formKey.currentState?.fields['password']?.value;

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
