import 'package:cooking_pad/config/dimens.dart';
import 'package:cooking_pad/config/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cooking_pad/navigation/route_names.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đăng ký',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
                      onChanged: (value) {
                        _formKey.currentState?.fields['username']?.validate();
                      },
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
                      onChanged: (value) {
                        _formKey.currentState?.fields['email']?.validate();
                      },
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
                          errorText: 'Mật khẩu không được để trống',
                        ),
                        FormBuilderValidators.minLength(
                          8,
                          errorText: 'Mật khẩu phải có ít nhất 8 ký tự',
                        ),
                      ]),
                      onChanged: (value) {
                        _formKey.currentState?.fields['password']?.validate();
                      },
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
                            _obscureConfirmText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmText = !_obscureConfirmText;
                            });
                          },
                        ),
                        errorStyle: const TextStyle(color: Colors.red),
                      ),
                      obscureText: _obscureConfirmText,
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
                      onChanged: (value) {
                        _formKey.currentState?.fields['confirm_password']
                            ?.validate();
                      },
                    ),
                    SizedBox(height: context.h(24)),
                    // Register Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          final username =
                              _formKey.currentState?.fields['username']?.value;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Đăng ký thành công với tên người dùng: $username',
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
                      child: const Text('Đăng ký'),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        context.push(Routes.signin);
                      },
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
