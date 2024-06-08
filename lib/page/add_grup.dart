import 'package:flutter/material.dart';
import 'package:patrimonie/core/service/grup_service.dart';
import 'package:patrimonie/model/widgets/input_field.dart';
import 'package:patrimonie/model/widgets/theme.dart';
import 'package:patrimonie/page/anasayfa.dart';
import 'package:patrimonie/page/navbar/nav_controller.dart';

class AddGrupPage extends StatefulWidget {
  @override
  State<AddGrupPage> createState() => _AddGrupPageState();
}

class _AddGrupPageState extends State<AddGrupPage> {
  final GrupsService _grupsService = GrupsService();
  final TextEditingController _nameController = TextEditingController();
  final List<String> _kisilerList = ['Sedat', 'Enes', 'Ahmet', 'Ali'];
  final List<String> _selectedKisiler = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Grup Olustur",
                style: headingStyle,
              ),
              MyInputField(
                title: "Grup Adı",
                hint: "Grup adını girin",
                controller: _nameController,
              ),
              const SizedBox(height: 20),
              Text(
                "Kisiler",
                style: headingStyle,
              ),
              ..._kisilerList.map((kisi) => CheckboxListTile(
                    title: Text(kisi),
                    value: _selectedKisiler.contains(kisi),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          _selectedKisiler.add(kisi);
                        } else {
                          _selectedKisiler.remove(kisi);
                        }
                      });
                    },
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validateData,
                child: const Text("Grubu Kaydet"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateData() {
    if (_nameController.text.isNotEmpty && _selectedKisiler.isNotEmpty) {
      _addGrupToDb();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyBottomNavBar()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tüm alanlar zorunludur."),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  _addGrupToDb() async {
    await _grupsService.createGrup(
      '', // userID burada boş string olarak ayarlanıyor, gerektiğinde değiştirin
      _nameController.text,
      _selectedKisiler.join(', '), // Seçilen kişileri birleştirerek string yap
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyBottomNavBar()),
          );
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 24,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
