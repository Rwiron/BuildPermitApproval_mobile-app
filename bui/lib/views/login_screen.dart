import 'package:bui/controllers/authentication.dart';
import 'package:bui/views/register_screen.dart';
import 'package:bui/views/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              const SizedBox(height: 120),
              Image.asset(
                'assets/images/RoundedTB1.png',
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 20),
              Text(
                'Login',
                style: GoogleFonts.poppins(
                  fontSize: size * 0.09, //
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 24, 17, 120),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InputWidget(
                hintText: 'username',
                obscureText: false,
                controller: _usernameController,
              ),
              const SizedBox(
                height: 20,
              ),
              InputWidget(
                hintText: 'Password',
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 24, 17, 120),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    // Add this line
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () async {
                  await _authenticationController.login(
                      username: _usernameController.text.trim(),
                      password: _passwordController.text.trim());
                },
                child: Obx(() {
                  return _authenticationController.isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            fontSize: size * 0.040,
                            color: Colors.white,
                          ),
                        );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => const RegisterScreen());
                },
                child: Text(
                  'Register First to have an access ?!',
                  style: GoogleFonts.poppins(
                    fontSize: size * 0.040,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
