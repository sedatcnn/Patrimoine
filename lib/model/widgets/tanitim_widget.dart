import 'package:flutter/material.dart';

class TanitimWidget extends StatelessWidget {
  const TanitimWidget({
    super.key,
    required this.model,
  });

  final TanitimModel model;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(30.0),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(model.image),
            height: size.height * 0.5,
          ),
          Column(
            children: [
              Text(
                model.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(model.subTitle, textAlign: TextAlign.center),
            ],
          ),
          Text(model.counterText, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}

class TanitimModel {
  final String image;
  final String title;
  final String subTitle;
  final String counterText;
  final Color bgColor;

  TanitimModel({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.counterText,
    required this.bgColor,
  });
}
