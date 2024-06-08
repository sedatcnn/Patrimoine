import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:patrimonie/model/widgets/edit_item.dart';
import 'package:patrimonie/model/user_model.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchCurrentUserInformation();
  }

  Future<void> fetchCurrentUserInformation() async {
    try {
      var currentUser = _auth.currentUser;
      var userDocument =
          await _firestore.collection('Users').doc(currentUser!.uid).get();

      Users user = Users.fromMap(userDocument.data() as Map<String, dynamic>);

      setState(() {
        emailController.text = user.email;
        passwordController.text = user.password;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateUser() async {
    var currentUser = _auth.currentUser;

    if (currentUser != null) {
      Users updatedUser = Users(
        userID: currentUser.uid,
        email: emailController.text,
        password: passwordController.text,
      );

      try {
        await _firestore
            .collection('Users')
            .doc(currentUser.uid)
            .update(updatedUser.toMap());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bilgileriniz Güncellendi!'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: updateUser,
              style: IconButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: const Size(60, 50),
                elevation: 3,
              ),
              icon: const Icon(Ionicons.checkmark, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hesap",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              const SizedBox(height: 40),
              EditItem(
                controller: emailController,
                title: "EPosta",
              ),
              const SizedBox(height: 40),
              EditItem(
                controller: passwordController,
                isPassword: false,
                title: "Şifre",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
