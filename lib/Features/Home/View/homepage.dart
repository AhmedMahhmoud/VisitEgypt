import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:visit_egypt/Features/Home/View/widgets/filter_by_list.dart';
import 'package:visit_egypt/Features/Home/View/widgets/place_card.dart';
import 'package:visit_egypt/Features/Home/View/widgets/search_bar.dart';
import '../../../Core/Colors/app_colors.dart';
import 'Cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchedName = '';
  final _controller = ScrollController();



  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).getUserAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  /*    floatingActionButton: FloatingActionButton(
          onPressed: (() => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              )))),*/
      backgroundColor: CustomColors.niceBlue,
      body: SafeArea(
        bottom: false,
        child: Container(
          /*        decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/bg1.jpeg',
                  ),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.white, BlendMode.softLight))),*/
          child: Column(
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
                        const SizedBox(
                          width: 6,
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
              FilterByList(cityName:BlocProvider.of<HomeCubit>(context,listen: true).userAddress),
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

                    Expanded(
                      child: BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
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
