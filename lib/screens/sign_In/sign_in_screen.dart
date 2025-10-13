import 'package:cooking_pad/config/dimens.dart';
import 'package:cooking_pad/config/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cooking_pad/navigation/route_names.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    // final textTheme = theme.textTheme;

    final formKey = GlobalKey<FormBuilderState>();

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
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
                      width: context.w(150),
                      height: context.h(150),
                    ),
                    SizedBox(height: context.h(20)),
                    FormBuilderTextField(
                      name: 'email',
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        icon: const Icon(Icons.email, color: Colors.black),
                        errorStyle: const TextStyle(color: Colors.red),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Email không được để trống',
                        ),
                        FormBuilderValidators.email(
                          errorText: 'Email không đúng định dạng',
                        ),
                      ]),
                      onChanged: (value) {
                        // Nếu cần xử lý thay đổi giá trị, thêm logic ở đây
                      },
                    ),
                    SizedBox(height: context.h(16)),
                    FormBuilderTextField(
                      name: 'password',
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        icon: const Icon(Icons.lock, color: Colors.black),
                        errorStyle: const TextStyle(color: Colors.red),
                      ),
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Password không được để trống',
                        ),
                        FormBuilderValidators.minLength(
                          9,
                          errorText: 'Password phải có ít nhất 9 ký tự',
                        ),
                      ]),
                    ),
                    SizedBox(height: context.h(24)),
                    // Sign-In Button
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.saveAndValidate() ?? false) {
                          final email =
                              formKey.currentState?.fields['email']?.value;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Đăng nhập thành công với email: $email',
                              ),
                            ),
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
