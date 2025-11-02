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
          'Đăng ký',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
                      height: context.h(150),
                    ),

                    // Username Input
                    FormBuilderTextField(
                      name: 'username',
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: 'Tên người dùng',
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
                          errorText: 'Tên người dùng không được để trống',
                        ),
                      ]),
                      onChanged: (value) =>
                          formKey.currentState?.fields['username']?.validate(),
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
                          errorText: 'Email không được để trống',
                        ),
                        FormBuilderValidators.email(
                          errorText: 'Email không đúng định dạng',
                        ),
                      ]),
                      onChanged: (value) =>
                          formKey.currentState?.fields['email']?.validate(),
                    ),
                    SizedBox(height: context.h(16)),

                    // Password Input
                    FormBuilderTextField(
                      name: 'password',
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Mật khẩu',
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
                          errorText: 'Mật khẩu không được để trống',
                        ),
                        FormBuilderValidators.minLength(
                          8,
                          errorText: 'Mật khẩu phải có ít nhất 8 ký tự',
                        ),
                      ]),
                      onChanged: (value) =>
                          formKey.currentState?.fields['password']?.validate(),
                    ),
                    SizedBox(height: context.h(16)),

                    // Confirm Password Input
                    FormBuilderTextField(
                      name: 'confirm_password',
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Xác nhận mật khẩu',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.radius(30),
                          ),
                        ),
                        prefixIcon: const Icon(Icons.lock, color: Colors.black),
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
                          errorText: 'Xác nhận mật khẩu không được để trống',
                        ),
                        (value) {
                          if (value != passwordController.text) {
                            return 'Mật khẩu không khớp';
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
                        if (formKey.currentState?.saveAndValidate() ?? false) {
                          final email = emailController.text;
                          final password = passwordController.text;
                          final username = usernameController.text;

                          final authService = AuthService();

                          await callSupabaseAuthApi<AuthResponse>(
                            service: () => authService.signUpWithEmailPassword(
                              email,
                              password,
                              {'username': username},
                            ),
                            context: context,
                            successMessage: 'Đăng ký thành công!',
                            onSuccess: (res) {
                              context.go(Routes.home);
                            },
                            onError: (msg) {
                              debugPrint('Đăng ký thất bại: $msg');
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                      ),
                      child: const Text('Đăng ký'),
                    ),

                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => context.push(Routes.signin),
                      child: Text(
                        'Đã có tài khoản? Đăng nhập ngay',
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
