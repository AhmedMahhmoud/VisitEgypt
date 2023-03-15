import 'package:flutter/material.dart';

import '../widgets/tourist_home.dart';

class TouristPageDisplay extends StatefulWidget {
  const TouristPageDisplay({super.key});

  @override
  State<TouristPageDisplay> createState() => _TouristPageDisplayState();
}

class _TouristPageDisplayState extends State<TouristPageDisplay> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/bgg.jpg',
                ),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.white, BlendMode.softLight))),
        child: TouristHome(controller: _controller));
  }
}
