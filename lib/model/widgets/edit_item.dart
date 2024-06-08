import 'package:flutter/material.dart';

class EditItem extends StatelessWidget {
  final String title;
  final TextEditingController controller; // controller parametresi eklendi
  final bool isPassword; // isPassword parametresi eklendi

  const EditItem({
    Key? key,
    required this.title,
    required this.controller, // controller parametresi eklendi
    this.isPassword = false, // varsayılan değer atanması
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 5,
          child: _buildTextField(controller,
              isPassword: isPassword), // _buildTextField çağrısı güncellendi
        )
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 16.0, 8.0),
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          style: TextStyle(color: Colors.deepPurple),
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12.0),
            ),
            contentPadding: EdgeInsets.all(16.0),
          ),
        ),
      ),
    );
  }
}
