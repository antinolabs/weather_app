import 'package:dummy/core/utilities/app_color.dart';
import 'package:flutter/material.dart';

class ChipContentWidget extends StatelessWidget {
  final String imagePath;
  final String text;

  ChipContentWidget({
    key,
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(imagePath),
          const SizedBox(width: 2),
          Text(
            text,
            style: const TextStyle(
                color: Colors.white), // You can customize the style here
          )
        ],
      ),
    );
  }
}
class WeatherInfoVerticalChipContainer extends StatelessWidget {
  const WeatherInfoVerticalChipContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("29°C",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.white)),
        Image.asset("assets/images/Group 650.png"),
        const Text(
          "15.00",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.white),
        ),
      ],
    );
  }
}