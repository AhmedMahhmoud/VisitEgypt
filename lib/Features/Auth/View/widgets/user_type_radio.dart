import 'package:flutter/material.dart';

class UserTypeRadio extends StatefulWidget {
  final Function callBackFun;
  const UserTypeRadio({required this.callBackFun, super.key});

  @override
  State<UserTypeRadio> createState() => _UserTypeRadioState();
}

class _UserTypeRadioState extends State<UserTypeRadio> {
  String userType = "tourist";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: <Widget>[
          Expanded(
            child: RadioListTile(
              activeColor: Colors.black,
              title: const Text("Tourist"),
              value: "tourist",
              groupValue: userType,
              onChanged: (value) {
                widget.callBackFun(value);
                setState(() {
                  userType = value!;
                });
              },
            ),
          ),
          Expanded(
            child: RadioListTile(
              activeColor: Colors.black,
              title: const Text("TourGuide"),
              value: "tourguide",
              groupValue: userType,
              onChanged: (value) {
                widget.callBackFun(value);
                setState(() {
                  userType = value!;
                });
              },
            ),
          )
          // Radio(
          //   value: userType,
          //   groupValue: "TourGuide",
          //   onChanged: (value) {
          //     setState(() {
          //       userType = value!;
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}
