import 'package:attendance_appp/core/utils/routs.dart';
import 'package:attendance_appp/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:attendance_appp/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:attendance_appp/features/auth/presentation/views/widgets/text_field_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signinWithEmail(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      //    backgroundColor: isDarkMode ? const Color(0xff161d38) : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 90),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: Image.asset(
                            'assets/images/management.png',
                            height: 200,
                            width: 200,
                          ),
                        ),
                        //email
                        const SizedBox(height: 80),
                        CustomTextField(
                          controller: emailController,
                          hintText: 'Email',
                          prefixIcon: Icons.email_outlined,
                          validator: TextFieldsValidation.emailValidation,
                        ),
                        const SizedBox(height: 24),
                        //password
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          prefixIcon: Icons.lock_outlined,
                          validator: TextFieldsValidation.emptyValidation,
                          suffixIcon: Icons.visibility,
                          obscureText: true,
                        ),

                        //forgetPassword
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 34),
              BlocConsumer<AuthCubit, AutheState>(
                listener: (context, state) async {
                  if (state is AuthLoading) {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is AuthSuccess) {
                    (context).pop; // Close the loading dialog
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('requirePostSignupLogin', false);
                    GoRouter.of(context).go(AppRouter.kHomeView);
                  } else if (state is AuthFailure) {
                    Navigator.pop(context); // Close the loading dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //  backgroundColor: Colors.blue,
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      _validateAndSubmit();
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
