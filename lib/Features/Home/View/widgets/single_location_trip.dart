import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Core/Colors/app_colors.dart';
import 'package:visit_egypt/Features/Home/Model/tourguide_trip.dart';
import 'package:visit_egypt/Features/Home/View/Cubit/trips_cubit.dart';

import '../../../../Core/Shared/methods.dart';
import '../../../Posts/View/widgets/add_post_location_dropdown.dart';
import '../../../bottom_navigation/bottom_navigation.dart';
import 'location_chips.dart';

class TripCreationDisplay extends StatefulWidget {
  final int pageIndex;
  const TripCreationDisplay({
    required this.pageIndex,
    super.key,
  });

  @override
  State<TripCreationDisplay> createState() => _TripCreationDisplayState();
}

class _TripCreationDisplayState extends State<TripCreationDisplay> {
  List<String> locations = [];
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _tripPrice = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  bool dataFilled() {
    List<String> data = [
      _tripPrice.text == '' ? 'null' : _tripPrice.text,
      _timeController.text == '' ? 'null' : _timeController.text,
      _dayController.text == '' ? 'null' : _dayController.text,
    ];

    if (data.contains('null') || locations.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: DefaultTextStyle(
        style: TextStyle(fontSize: 16.sp, color: CustomColors.blackK),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              "Please enter trip details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
            Divider(
              endIndent: 100.w,
              thickness: 1,
            ),
            widget.pageIndex == 0
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100.w,
                          child: const AutoSizeText(
                            "Trip location",
                          ),
                        ),
                        AddPostLocationDropdown(
                          onDone: (v) {
                            if (locations.isNotEmpty) {
                              locations[0] = v;
                            } else {
                              locations.add(v);
                            }
                          },
                        )
                      ],
                    ),
                  )
                : LocationChips(callBackFun: (List<String> chips) {
                    locations = chips;
                  }),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  SizedBox(
                      width: 100.w, child: const AutoSizeText('Time of trip')),
                  InkWell(
                    onTap: () async {
                      var date = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      // ignore: use_build_context_synchronously
                      _timeController.text = date!.format(context);
                      setState(() {});
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: 200.w,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey)),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _timeController,
                            readOnly: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.5.h, horizontal: 30.w),
                              icon: const Icon((Icons.date_range)),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  SizedBox(
                      width: 100.w, child: const AutoSizeText('Day of trip')),
                  InkWell(
                    onTap: () async {
                      var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              2023, DateTime.now().month, DateTime.now().day),
                          lastDate: DateTime(2030));
                      setState(() {
                        _dayController.text = date.toString().substring(0, 11);
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: 200.w,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey)),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _dayController,
                            readOnly: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.5.h, horizontal: 30.w),
                              icon: const Icon((Icons.date_range)),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  SizedBox(
                      width: 100.w, child: const AutoSizeText("Total price")),
                  Container(
                    width: 80.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Center(
                      child: TextField(
                        controller: _tripPrice,
                        keyboardType: TextInputType.number,
                        cursorColor: CustomColors.blackK,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20.w),
                          hintText: '',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const AutoSizeText('Description for meeting'),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              child: TextField(
                controller: _description,
                maxLines: null,
                cursorColor: CustomColors.blackK,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'ex : place of meet , Rules , etc... '),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            BlocConsumer<TripsCubit, TripsState>(
              builder: (context, state) {
                if (state is TripsLoadingState) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: const SizedBox(
                      height: 40,
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: SizedBox(
                    height: 40,
                    child: MaterialButton(
                      color: CustomColors.blackK,
                      onPressed: () async {
                        if (!dataFilled()) {
                          ConstantMethods.showContentToast(
                              context, 'Please fill the data first', true);
                        } else {
                          TripModel tripModel = TripModel(
                              locations: locations,
                              numberOfJoiners: 0,
                              description: _description.text,
                              dayOfMeet: _dayController.text,
                              timeOfMeet: _timeController.text,
                              totalPrice: double.parse(_tripPrice.text),
                              isStarted: false);
                          await BlocProvider.of<TripsCubit>(context,
                                  listen: false)
                              .addNewTrip(tripModel);
                        }
                      },
                      child: const Center(
                          child: AutoSizeText(
                        'Create Trip',
                        style: TextStyle(color: CustomColors.whiteK),
                      )),
                    ),
                  ),
                );
              },
              listener: (context, state) {
                if (state is TripsLoadedState) {
                  ConstantMethods.showContentToast(
                      context, 'TripCreated Successfully !');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNav(
                                comingIndex: 0,
                              )));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
