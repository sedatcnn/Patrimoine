import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:ionicons/ionicons.dart';
import 'package:patrimonie/page/edit_screen.dart';
import 'package:patrimonie/model/widgets/forward_button.dart';
import 'package:patrimonie/model/widgets/setting_item.dart';
import 'package:patrimonie/page/giris.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class FirebaseUser {}

class _ProfilState extends State<Profil> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 30, left: 30, right: 30, top: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Profil",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 180),
                    child: IconButton(
                      onPressed: () {
                        Get.offAll(GirisEkrani());
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 239, 1, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        fixedSize: Size(60, 50),
                        elevation: 3,
                      ),
                      icon: Icon(Ionicons.log_out, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                "Hesap",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Image.asset("asset/images/P.png", width: 70, height: 70),
                    const SizedBox(width: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Düzenle",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    const Spacer(),
                    ForwardButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditAccountScreen(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Ayarlar",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              // SettingSwitch(
              //   title: "Dark Mode",
              //   icon: Ionicons.earth,
              //   bgColor: Colors.purple.shade100,
              //   iconColor: Colors.purple,
              //   value: isDarkMode,
              //   onTap: (value) {
              //     setState(() {
              //       isDarkMode = value;
              //     });
              //   },
              // ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Yardım",
                icon: Ionicons.nuclear,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              SettingItem(
                title: "Hesabı Sil",
                icon: Ionicons.close,
                bgColor: Colors.red.shade100,
                iconColor: Colors.red,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
