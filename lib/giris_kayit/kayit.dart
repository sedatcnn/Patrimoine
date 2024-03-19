import 'package:flutter/material.dart';
import 'package:patrimonie/giris_kayit/giris.dart';


class KayitEkrani extends StatefulWidget {
  const KayitEkrani({super.key});

  @override
  State<KayitEkrani> createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
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
        children: [Positioned(top: -65,left: -35,
        width: size.width*0.60, child: Image.asset("asset/images/kenar5.png"),),
        Positioned(right: -15,bottom: -15,
        width: size.width*0.40, child: Image.asset("asset/images/kenar4.png"),),
        Positioned(top: 150,right: -40,
        width: size.width*0.40, child: Image.asset('asset/images/kenar6.png'),),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("asset/images/logo.png",height:size.height*0.35,width: size.width*0.7,),
              const RoundedInputField(hintText: "E-Posta"),
              SifreInputField(onChanged: (value) {},),
              SizedBox(height:size.height*0.02,),
              KayitButton(size: size,text:"Kayıt Ol",press:(){}),
              SizedBox(height:size.height*0.03,),
              HesapKontrol( login: false,
              press:(){
                Navigator.push(context, MaterialPageRoute(builder: (context){return const GirisEkrani();}),);
              }),
              const Dividers(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialMediaButton(icon: Icons.facebook_rounded,press: (){},),
                  SocialMediaButton(icon: Icons.facebook,press: (){},),
                  SocialMediaButton(icon: Icons.facebook_rounded,press: (){},),
                ],
              ),
              
            ],
            
            ),
        ),
          
        ],
      
      ),
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final void Function() press;
  const SocialMediaButton({
    super.key, required this.icon, required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Row(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Container(
          margin:const EdgeInsets.symmetric(horizontal: 10),
        padding:const EdgeInsets.all(15),
        decoration: 
        BoxDecoration(
          border: Border.all(color:const Color.fromARGB(204, 218, 91, 135)),
        shape: BoxShape.circle
      ),child: Icon(icon,color:const Color.fromARGB(204, 218, 91, 135),)
       ,)
       ],
       ),
    );
  }
}

class Dividers extends StatelessWidget {
  const Dividers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return  Container(
      width: size.width*0.8,
      margin: EdgeInsets.symmetric(vertical: size.height*0.02),
      child: Row(
        children: [
           buildDivider(),
          const Text(
            "YA DA",
          style: TextStyle(
            color:Color.fromARGB(204, 218, 91, 135),
            fontWeight: FontWeight.bold),
            ),
            buildDivider(),
          ],
          ),
    );
  }

  Expanded buildDivider() {
    return const Expanded(
        child: Divider(
          color:Color.fromARGB(204, 218, 91, 135),
          height: 1.5,
          
        ),
        );
  }
}

class HesapKontrol extends StatelessWidget {
  final bool login;
  final void Function() press;
    const HesapKontrol({
    super.key,  this.login=true, required this.press,
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
      GestureDetector(onTap:press  ,child: Text(login ? "Kayıt Ol": "Giriş Yap",style:const  TextStyle(color:Color.fromARGB(204, 218, 91, 135),fontWeight: FontWeight.bold),),)
       ],
    );
  }
}

class KayitButton extends StatelessWidget {
  final String text;
  final void Function() press;
   const KayitButton({
    super.key,
    required this.size, required this.text, required this.press,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: press,
    padding: const EdgeInsets.all(13),
    minWidth: size.width*0.8,
    
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    color: const Color.fromRGBO(238, 196, 211, 0.8),
    child: Text(text,style:const  TextStyle(fontSize: 16,color: Color.fromARGB(204, 218, 91, 135))),
    
    
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
          color: Color.fromARGB(204, 218, 91, 135),
          ),
          suffixIcon: Icon(Icons.visibility,color: Color.fromARGB(204, 218, 91, 135),),
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
      color:const Color.fromARGB(204, 218, 91, 135),),
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