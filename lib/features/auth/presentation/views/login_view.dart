import 'package:attendance_appp/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:attendance_appp/features/auth/presentation/views/widgets/text_field_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDarkMode ? const Color(0xff161d38) : Colors.white,
        statusBarIconBrightness: isDarkMode
            ? Brightness.light
            : Brightness.dark, // Icon color
      ),
    );

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xff161d38) : Colors.white,
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform login action here
                    // For example, you can navigate to another screen or show a success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login Successful'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const MapScreen()),
                    // );
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
