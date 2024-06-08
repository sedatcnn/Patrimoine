import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:patrimonie/page/giris.dart';
import 'package:patrimonie/model/widgets/tanitim_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IlkTanitimEkrani extends StatefulWidget {
  const IlkTanitimEkrani({super.key});

  @override
  State<IlkTanitimEkrani> createState() => _IlkTanitimEkraniState();
}

class _IlkTanitimEkraniState extends State<IlkTanitimEkrani> {
  int currentPage = 0;
  late LiquidController controller;
  final List<TanitimWidget> pages = [
    TanitimWidget(
      model: TanitimModel(
        image: Images.tanitimEkrani1,
        title: "title",
        subTitle: "subTitle",
        counterText: "counterText",
        bgColor: Renkler.page1Colors,
      ),
    ),
    TanitimWidget(
      model: TanitimModel(
        image: Images.tanitimEkrani2,
        title: "title",
        subTitle: "subTitle",
        counterText: "counterText",
        bgColor: Renkler.page2Colors,
      ),
    ),
    TanitimWidget(
      model: TanitimModel(
        image: Images.tanitimEkrani3,
        title: "title",
        subTitle: "subTitle",
        counterText: "counterText",
        bgColor: Renkler.page3Colors,
      ),
    ),
  ];
  @override
  void initState() {
    super.initState();
    controller = LiquidController(); // LiquidController'ı burada oluşturduk
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            slidePercentCallback:
                (slidePercentHorizontal, slidePercentVertical) => 0.5,
            pages: pages,
            liquidController: controller,
            onPageChangeCallback: onPageChangeCallback,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
          ),
          Positioned(
            bottom: 60.0,
            child: OutlinedButton(
              onPressed: () {
                if (currentPage == pages.length - 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GirisEkrani()),
                  );
                } else {
                  int nextPage = currentPage + 1;
                  controller.animateToPage(
                    page: nextPage,
                    duration: 800,
                  );
                  setState(() {
                    currentPage = nextPage;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.black12),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Renkler.blackColors,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () {
                int nextPage = 2;
                controller.jumpToPage(page: nextPage);
                setState(() {
                  currentPage = nextPage;
                });
              },
              child: const Text(
                "Geç",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            child: AnimatedSmoothIndicator(
              activeIndex: currentPage,
              count: pages.length,
              effect: const WormEffect(
                activeDotColor: Colors.orange,
                dotHeight: 5.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  onPageChangeCallback(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;
    });
  }
}

class Renkler {
  static const primaryColor = Color.fromRGBO(192, 134, 219, 1);
  static const secondaryColor = Color.fromRGBO(217, 169, 92, 0.962);
  static const accentColor = Color.fromRGBO(132, 96, 232, 1);

  static const whiteColors = Colors.white;
  static const blackColors = Colors.black;
  static const cardBGColors = Color.fromRGBO(3, 4, 5, 0);

  static const page1Colors = Color.fromRGBO(129, 150, 229, 1.0);
  static const page2Colors = Color.fromRGBO(243, 162, 104, 1.0);
  static const page3Colors = Color.fromRGBO(147, 252, 161, 1.0);
}

class Images {
  static const String tanitimEkrani1 = 'asset/images/Adsız.png';
  static const String tanitimEkrani2 = 'asset/images/art.png';
  static const String tanitimEkrani3 = 'asset/images/byc.png';
}
