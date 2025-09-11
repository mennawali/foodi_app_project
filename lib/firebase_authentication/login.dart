import 'package:flutter/material.dart';
import 'package:foodi_app_project/app_colors.dart';


import '../home.dart';
import 'firebase_functions.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  bool isLogin = true;
  bool _loading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    String? result;
    if (isLogin) {
      result = await Authentication.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    } else {
      result = await Authentication.createAccount(
        emailController.text.trim(),
        passwordController.text.trim(),
        usernameController.text.trim(),
      );
    }

    if (result != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isLogin
              ? "Login successful "
              : "Signup successful "),
        ),
      );


      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  MyHomePage()),
      );
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Column(
            children: [

              Image.asset(
                "assets/images/login_icon.png",
                height: 150,
              ),
              const SizedBox(height: 30),


              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (!isLogin)
                        TextFormField(
                          controller: usernameController,
                          decoration:
                          _inputDecoration("Username", Icons.person),
                          validator: (val) => val == null || val.isEmpty
                              ? "Enter your username"
                              : null,
                        ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: emailController,
                        decoration: _inputDecoration("Email", Icons.email),
                        validator: (val) => val == null || val.isEmpty
                            ? "Enter your email"
                            : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: _inputDecoration("Password", Icons.lock),
                        validator: (val) => val == null || val.isEmpty
                            ? "Enter your password"
                            : null,
                      ),
                      const SizedBox(height: 25),

                      _loading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 40),
                        ),
                        onPressed: _submit,
                        child: Text(
                          isLogin ? "Login" : "Sign Up",
                          style: const TextStyle(
                              fontSize: 18, color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Text(
                  isLogin
                      ? "Don't have an account? Sign Up"
                      : "Already have an account? Login",
                  style: const TextStyle(color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color:AppColors.primaryColor),
      filled: true,
      fillColor: AppColors.lightGray,
      contentPadding:
      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }
}
