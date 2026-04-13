import 'package:flutter/material.dart';
import 'package:genxshop/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.find<AuthController>();
  final RxBool rememberMe = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
            
              Image.network(
                'https://kiwiears.com/cdn/shop/files/KiwiEarsAltruva_4.jpg?v=1773412631', 
                height: 100,
              ),
              const SizedBox(height: 30),

              
              const Text(
                "Welcome Back!",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1F2937)),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please login first to view your products.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 40),

             
              _buildLabel("Email Address"),
              _buildTextField(
                controller: emailController,
                hint: "ras*****@gmail.com",
              ),
              const SizedBox(height: 20),

             
              _buildLabel("Password"),
              _buildTextField(
                controller: passwordController,
                hint: "••••••••",
                obscure: true,
                suffixIcon: Icons.visibility_off_outlined,
              ),
              const SizedBox(height: 15),

           
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(() => Checkbox(
                            value: rememberMe.value,
                            activeColor: const Color(0xFF246BFE),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            onChanged: (val) => rememberMe.value = val!,
                          )),
                      const Text("Remember Me",
                          style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Forgot Password",
                        style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontWeight: FontWeight.w500)),
                  )
                ],
              ),
              const SizedBox(height: 30),

             
              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => controller.login(
                            emailController.text, passwordController.text),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF246BFE),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28)),
                          elevation: 0,
                        ),
                        child: const Text("Sign In",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    )),
              const SizedBox(height: 25),

         
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("New product? ",
                      style: TextStyle(color: Color(0xFF9CA3AF))),
                  GestureDetector(
                    onTap: () => Get.toNamed('/register'),
                    child: const Text("Create Account",
                        style: TextStyle(
                            color: Color(0xFF246BFE),
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 4),
        child: Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF1F2937))),
      ),
    );
  }


  Widget _buildTextField(
      {required TextEditingController controller,
      required String hint,
      bool obscure = false,
      IconData? suffixIcon}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: const Color(0xFF9CA3AF))
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Color(0xFF246BFE), width: 1.5),
        ),
      ),
    );
  }
}
