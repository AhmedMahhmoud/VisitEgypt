import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/Features/Home/View/widgets/place_card.dart';
import 'package:task/Features/Home/View/widgets/search_bar.dart';
import 'package:task/Features/Home/View/widgets/filter_by_list.dart';

import '../../../Core/Colors/app_colors.dart';
import '../../../Core/Constants/constants.dart';
import '../Cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchedName = '';
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.niceBlue,
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/images/bg1.jpeg',
                ),
                fit: BoxFit.cover,colorFilter: ColorFilter.mode(Colors.white, BlendMode.softLight)
              )),
          child: Column(
            children: <Widget>[
              SearchBox(onChanged: (value) async {
                //     searchedName = value;

                BlocProvider.of<HomeCubit>(context).searchInPlaces(value);
              }),
              FilterByList(),
              SizedBox(height: 10.h),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    // Our background
                    Container(
                      margin:  EdgeInsets.only(top: 100.h),
                      decoration: const BoxDecoration(
                        color: CustomColors.niceGrey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                    ),

                    Expanded(
                      child: BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                        if (state is SearchLoading) {
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
                            itemBuilder: (context, index) => PlaceCard(
                                itemIndex: index,
                                press: () {},
                                place: BlocProvider.of<HomeCubit>(context)
                                    .filteredPlaces[index]),
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
