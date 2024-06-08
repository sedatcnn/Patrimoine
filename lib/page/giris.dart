import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patrimonie/core/viewModel/login_viewModel.dart';
import 'package:patrimonie/page/kayit.dart';
import 'package:patrimonie/page/navbar/nav_controller.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserLoginPageViewModel viewModel = UserLoginPageViewModel();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 236, 243, 0.8),
      body: SizedBox(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -5,
              left: -5,
              width: size.width * 0.60,
              child: Image.asset("asset/images/kenar2.png"),
            ),
            Positioned(
              right: -5,
              bottom: -5,
              width: size.width * 0.40,
              child: Image.asset("asset/images/kenar.png"),
            ),
            Positioned(
              top: 150,
              right: -60,
              width: size.width * 0.40,
              child: Image.asset("asset/images/kenar3.png"),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "asset/images/logo.png",
                  height: size.height * 0.25,
                  width: size.width * 0.7,
                ),
                CustomTextField(
                  controller: viewModel.emailController,
                  hintText: "E-Posta",
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: size.height * 0.02),
                CustomTextField(
                  controller: viewModel.passwordController,
                  hintText: "Şifre",
                  icon: FontAwesomeIcons.lock,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                GirisButton(
                  size: size,
                  text: 'Giriş',
                  press: () {
                    MyBottomNavBar();
                    viewModel.signInUser(context);
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                const HesapKontrol(),
                SizedBox(
                  height: size.height * 0.03,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HesapKontrol extends StatelessWidget {
  final bool login;
  const HesapKontrol({
    super.key,
    this.login = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "Bir hesabınız yok mu ?" : "Mevcut bir hesabınız var mı ? ",
          style: const TextStyle(color: Color.fromARGB(204, 218, 91, 135)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const KayitEkrani()),
            );
          },
          child: Text(
            login ? " Kayıt Ol" : "Giriş Yap",
            style: const TextStyle(
                color: Color.fromARGB(204, 218, 91, 135),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final void Function() press;
  const SocialMediaButton({
    super.key,
    required this.icon,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(204, 218, 91, 135)),
                shape: BoxShape.circle),
            child: Icon(
              icon,
              color: const Color.fromARGB(204, 218, 91, 135),
            ),
          )
        ],
      ),
    );
  }
}

class GirisButton extends StatelessWidget {
  final String text;
  final void Function() press;
  const GirisButton({
    super.key,
    required this.size,
    required this.text,
    required this.press,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: press,
      padding: const EdgeInsets.all(13),
      minWidth: size.width * 0.8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      color: const Color.fromRGBO(238, 196, 211, 0.8),
      child: Text(text,
          style: const TextStyle(
              fontSize: 16, color: Color.fromARGB(204, 218, 91, 135))),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.icon = FontAwesomeIcons.solidUser,
    required this.keyboardType,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: const Color.fromARGB(204, 218, 91, 135),
          ),
          hintText: hintText,
          border: InputBorder.none,
          suffixIcon: obscureText
              ? IconButton(
                  icon: const Icon(
                    Icons.visibility,
                    color: Color.fromARGB(204, 218, 91, 135),
                  ),
                  onPressed: () => controller.text =
                      '', // Reset text on tap (toggle visibility)
                )
              : null,
        ),
        keyboardType: keyboardType,
        obscureText: obscureText, // Set obscureText based on the provided value
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(238, 196, 211, 0.8),
          borderRadius: BorderRadius.circular(29)),
      child: child,
    );
  }
}
