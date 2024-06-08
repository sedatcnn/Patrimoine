import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patrimonie/page/giris.dart';
import 'package:patrimonie/page/ilk_tanitim.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const GirisEkrani()));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration:
            const BoxDecoration(color: Color.fromRGBO(255, 236, 243, 0.8)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              height: 300,
              width: 300,
              image: AssetImage('asset/images/logo.png'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
