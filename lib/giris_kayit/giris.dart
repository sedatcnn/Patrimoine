import 'package:flutter/material.dart';
import 'package:patrimonie/giris_kayit/kayit.dart';


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

class Body extends StatelessWidget {
  const Body({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:  const Color.fromRGBO(255,236,243, 0.8),
      body: SizedBox(
        width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [Positioned(top: -5,left: -5,
        width: size.width*0.60, child: Image.asset("asset/images/kenar2.png"),),
        Positioned(right: -5,bottom: -5,
        width: size.width*0.40, child: Image.asset("asset/images/kenar.png"),),
        Positioned(top: 150,right: -60,
        width: size.width*0.40, child: Image.asset("asset/images/kenar3.png"),),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("asset/images/logo.png",height:size.height*0.35,width: size.width*0.7,),
            const RoundedInputField(hintText: "E-Posta"),
            SifreInputField(onChanged: (value) {},),
            SizedBox(height:size.height*0.02,),
            GirisButton(size: size),
            SizedBox(height:size.height*0.03,),
            const HesapKontrol( ),


            
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
    super.key,  this.login=true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [ Text(login ?
        "Bir hesabınız yok mu ?" : "Mevcut bir hesabınız var mı ? ",
       style:const TextStyle(color:
         Color.fromARGB(204, 218, 91, 135)) ,
      ),
      GestureDetector(onTap: (){
        Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const KayitEkrani()),
                  );
      } ,child: Text(login ? "Kayıt Ol": "Giriş Yap",style:const  TextStyle(color: Color.fromARGB(204, 218, 91, 135),fontWeight: FontWeight.bold),),)
       ],
    );
  }
}

class GirisButton extends StatelessWidget {
  const GirisButton({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: () {
    },
    padding: const EdgeInsets.all(13),
    minWidth: size.width*0.8,
    
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    color: const Color.fromRGBO(238, 196, 211, 0.8),
    child:const Text("Giriş",style: TextStyle(fontSize: 16,color:  Color.fromARGB(204, 218, 91, 135))),
    
    
    );
  }
}

class SifreInputField extends StatelessWidget {
  final ValueChanged onChanged;
   const SifreInputField({
    super.key, required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: 
      TextField(
        
      obscureText: true,
      onChanged: onChanged,
      decoration: const InputDecoration(
        hintText: "Şifre",
        icon: Icon( 
          Icons.lock,
          color:  Color.fromARGB(204, 218, 91, 135),
          ),
          suffixIcon: Icon(Icons.visibility,color:  Color.fromARGB(204, 218, 91, 135),),
          border: InputBorder.none,
          
      ),));
  }
}

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  const RoundedInputField({
    super.key,
     required this.hintText,
       this.icon=Icons.person,
  });

  @override
  Widget build(BuildContext context) {
    return  TextFieldContainer(child: TextField (decoration: InputDecoration(
      icon: Icon(icon,
      color: const Color.fromARGB(204, 218, 91, 135),),
      hintText: hintText,
      border: InputBorder.none
    ),) ,);
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
    Size size=MediaQuery.of(context).size;
    return Container(
      margin:const EdgeInsets.symmetric(vertical: 10),
      padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 2),
      width: size.width*0.8,
              decoration: BoxDecoration(
              color:const Color.fromRGBO(238, 196, 211, 0.8) ,
              borderRadius: BorderRadius.circular(29)
              ),
              child: child,
            );
  }
}