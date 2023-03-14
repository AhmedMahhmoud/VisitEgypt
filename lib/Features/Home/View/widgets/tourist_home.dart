import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Features/Home/View/screens/home_details_page.dart';

import 'package:visit_egypt/Features/Home/View/widgets/filter_by_list.dart';
import 'package:visit_egypt/Features/Home/View/widgets/place_card.dart';
import 'package:visit_egypt/Features/Home/View/widgets/search_bar.dart';

import '../../../../Core/Colors/app_colors.dart';
import '../../../../Core/Shared/methods.dart';
import '../Cubit/home_cubit.dart';

class TouristHome extends StatelessWidget {
  const TouristHome({
    super.key,
    required ScrollController controller,
  }) : _controller = controller;

  final ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          if (state is UserAddressLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: EdgeInsets.only(left: 20.w, top: 12.h),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_city,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Text(
                    BlocProvider.of<HomeCubit>(context, listen: true)
                        .userAddress,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            );
          }
        }),
        SearchBox(onChanged: (value) async {
          BlocProvider.of<HomeCubit>(context).searchInPlaces(value);
        }),
        FilterByList(
            cityName:
                BlocProvider.of<HomeCubit>(context, listen: true).userAddress),
        SizedBox(height: 20.h),
        Expanded(
          child: Stack(
            children: <Widget>[
              // Our background
              Container(
                margin: EdgeInsets.only(top: 100.h),
                decoration: const BoxDecoration(
                  color: CustomColors.niceGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              ),

              BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                if (state is ListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    controller: _controller,
                    itemCount: BlocProvider.of<HomeCubit>(context)
                        .filteredPlaces
                        .length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        ConstantMethods.navigateReplacementTo(
                            context,
                            HomeDetailsPage(
                                placeId: BlocProvider.of<HomeCubit>(context)
                                    .filteredPlaces[index]
                                    .placeId));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 8.h),
                        child: PlaceCard(
                            itemIndex: index,
                            press: () {},
                            place: BlocProvider.of<HomeCubit>(context)
                                .filteredPlaces[index]),
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ],
    );
  }
}
