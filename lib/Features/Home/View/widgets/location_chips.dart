import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:visit_egypt/Core/Colors/app_colors.dart';

import '../../../../Core/Constants/constants.dart';

class LocationChips extends StatefulWidget {
  final Function callBackFun;
  const LocationChips({required this.callBackFun, super.key});

  @override
  State<LocationChips> createState() => _LocationChipsState();
}

class _LocationChipsState extends State<LocationChips> {
  List<String> locations = Constants.allPlaces.map((e) => e.placeName).toList();
  List<String> selectedChoices = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AutoSizeText(
          'Choose trip locations',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Wrap(
          children: List.generate(
            locations.length,
            (index) => ChoiceChip(
              selectedColor: CustomColors.successColor,
              label: Text(locations[index]),
              selected: selectedChoices.contains(locations[index]),
              onSelected: (selected) {
                {
                  setState(() {
                    selectedChoices.contains(locations[index])
                        ? selectedChoices.remove(locations[index])
                        : selectedChoices.add(locations[index]);
                  });
                  widget.callBackFun(selectedChoices);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
