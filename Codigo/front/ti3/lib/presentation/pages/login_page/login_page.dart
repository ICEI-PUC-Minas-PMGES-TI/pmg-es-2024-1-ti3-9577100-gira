import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti3/presentation/pages/login_page/controller/login_controller.dart';
import 'package:ti3/utils/gira_colors.dart';
import 'package:ti3/utils/gira_fonts.dart';
import 'package:ti3/utils/gira_images.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = Get.find<LoginController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: GiraColors.loginBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            const HeaderLogin(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    GiraTextInput(
                      controller: controller.emailController,
                      labelColor: GiraColors.loginInputColor,
                      borderColor: GiraColors.loginInputColor,
                      labelText: "Usuário",
                    ),
                    const SizedBox(height: 8),
                    GiraTextInput(
                      controller: controller.passwordController,
                      labelColor: GiraColors.loginInputColor,
                      borderColor: GiraColors.loginInputColor,
                      labelText: "Senha",
                      suffixIcon: controller.passwordIsVisible ? Icons.visibility : Icons.visibility_off,
                      onClickSuffixIcon: () {
                        controller.togglePasswordVisibility();
                        setState(() {});
                      },
                      suffixIconColor: GiraColors.loginInputColor,
                      isPassword: !controller.passwordIsVisible,
                    ),
                    const SizedBox(height: 32),
                    InkWell(
                      onTap: () {
                        // if (_formKey.currentState?.validate() ?? false) {
                        //   controller.loginTeste();
                        //
                        //   // controller.reset();
                        // }
                        controller.login();
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: GiraColors.loginBoxColor,
                        ),
                        child: const Text(
                          "Entrar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: GiraFonts.poppins,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Problemas para entrar?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: GiraFonts.poppins,
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: null,
                  child: const Text(
                    "Clique aqui",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: GiraFonts.poppins,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GiraTextInput extends StatelessWidget {
  const GiraTextInput({
    super.key,
    required this.controller,
    required this.labelColor,
    required this.borderColor,
    required this.labelText,
    this.suffixIcon,
    this.onClickSuffixIcon,
    this.suffixIconColor,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final Function()? onClickSuffixIcon;
  final IconData? suffixIcon;
  final Color labelColor;
  final Color borderColor;
  final Color? suffixIconColor;
  final String labelText;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, digite algo';
        }
        return null;
      },
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: labelColor,
          fontSize: 20,
        ),
        suffixIcon: suffixIcon == null ? null : GestureDetector(
          onTap: onClickSuffixIcon,
          child: Icon(
            suffixIcon,
            color: suffixIconColor,
          ),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: GiraColors.loginInputColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}

class HeaderLogin extends StatelessWidget {
  const HeaderLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GiraColors.loginBoxColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(GiraImages.imageLogin),
          const Text(
            "GIRA",
            style: TextStyle(
              fontFamily: GiraFonts.poorStory,
              fontSize: 64,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
