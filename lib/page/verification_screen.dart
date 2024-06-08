import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patrimonie/page/kayit.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});
  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 236, 243),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return const KayitEkrani();
                  })),
                  child: const Icon(
                    FontAwesomeIcons.arrowLeft,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Doğrulama',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Kod doğrulamasını şu adrese gönderdik ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    "sedatcnr02@gmail.com",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(191, 0, 0, 0),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    " E-posta adresinizi değiştirin?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 117, 36, 164),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(first: true, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: true),
                      ],
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStateProperty.all<Color>(Colors.white),
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(204, 189, 132, 152)),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Doğrula',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Herhangi bir kod almadınız mı?",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Yeni Kod Gönder",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 94, 37, 158),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({bool first = false, bool last = false}) {
    return Form(
      child: Row(
        children: [
          SizedBox(
            height: 68,
            width: 64,
            child: TextField(
              autofocus: true,
              onChanged: (value) {
                if (value.length == 1 && !last) {
                  FocusScope.of(context).nextFocus();
                }
                if (value.isEmpty && !first) {
                  FocusScope.of(context).previousFocus();
                }
              },
              style: Theme.of(context).textTheme.titleLarge,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                counter: const Offstage(),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: Color.fromARGB(31, 162, 21, 21)),
                    borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 2, color: Color.fromARGB(255, 100, 19, 114)),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
