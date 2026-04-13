import 'package:flutter/material.dart';
import 'package:genxshop/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
             
              _buildBackButton(),
              const SizedBox(height: 30),

            
              const Text(
                "Welcome to Eduline",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1F2937)),
              ),
              const SizedBox(height: 12),
              const Text(
                "Let's join to Eduline learning ecosystem & meet our professional mentor. It's Free!",
                style: TextStyle(
                    fontSize: 15, color: Color(0xFF6B7280), height: 1.5),
              ),
              const SizedBox(height: 40),

              
              _fieldLabel("Email Address"),
              _buildTextField(emailController, "ras*****@gmail.com"),

              _fieldLabel("Full Name"),
              _buildTextField(nameController, "Ras** K**n"),

              _fieldLabel("Password"),
              _buildTextField(passwordController, "••••••••",
                  obscure: true, suffix: Icons.visibility_off_outlined),

              const SizedBox(height: 15),

             
              _buildStrengthIndicator(),

              const SizedBox(height: 12),

             
              _buildValidationItem(
                  "At least 8 characters with a combination of letters and numbers",
                  true),

              const SizedBox(height: 40),

             
              Obx(() => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller.register(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                          );
                          Get.toNamed('/verify');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF246BFE),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28)),
                          elevation: 0,
                        ),
                        child: const Text("Sign Up",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    )),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ",
                      style: TextStyle(color: Color(0xFF9CA3AF))),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Text("Sign In",
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

  Widget _buildBackButton() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: IconButton(
        icon:
            const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
        onPressed: () => Get.back(),
      ),
    );
  }

  Widget _fieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(label,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Color(0xFF1F2937))),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {bool obscure = false, IconData? suffix}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
        suffixIcon: suffix != null
            ? Icon(suffix, color: const Color(0xFF9CA3AF))
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
          borderSide: const BorderSide(color: Color(0xFF246BFE)),
        ),
      ),
    );
  }

  Widget _buildStrengthIndicator() {
    return Row(
      children: [
        Expanded(child: _bar(const Color(0xFF246BFE))),
        const SizedBox(width: 4),
        Expanded(child: _bar(const Color(0xFF246BFE))),
        const SizedBox(width: 4),
        Expanded(child: _bar(const Color(0xFF246BFE))),
        const SizedBox(width: 4),
        Expanded(child: _bar(const Color(0xFFF3F4F6))),
        const SizedBox(width: 10),
        const Text("Strong",
            style: TextStyle(
                color: Color(0xFF246BFE),
                fontWeight: FontWeight.bold,
                fontSize: 12)),
      ],
    );
  }

  Widget _bar(Color color) => Container(
      height: 4,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)));

  Widget _buildValidationItem(String text, bool isValid) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_outline,
            color: isValid ? Colors.green : Colors.grey, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
                color: isValid ? Colors.green : Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
