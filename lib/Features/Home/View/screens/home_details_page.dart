import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:visit_egypt/Enums/firebase_request_enum.dart';
import 'package:visit_egypt/Features/Home/Model/place_model.dart';
import 'package:visit_egypt/Features/Home/View/widgets/ticket.dart';
import 'package:visit_egypt/Features/bottom_navigation/bottom_navigation.dart';
import '../../../../Core/Colors/app_colors.dart';
import '../../../../Core/Constants/constants.dart';
import '../../../../Core/Shared/methods.dart';
import '../../../../Core/Styles/text_style.dart';
import '../../../Posts/View/pages/posts_by_location.dart';
import '../Cubit/home_cubit.dart';
import '../widgets/place_card.dart';
import '../widgets/place_location_map_display.dart';
import '../widgets/reviews_display.dart';

class HomeDetailsPage extends StatefulWidget {
  final int placeId;

  const HomeDetailsPage({Key? key, required this.placeId}) : super(key: key);

  @override
  State<HomeDetailsPage> createState() => _HomeDetailsPageState();
}

class _HomeDetailsPageState extends State<HomeDetailsPage> {
  late PlaceModel placeModel;
  final initialPageNotifier = ValueNotifier<int>(0);
  int ticketHeight = 0;
  bool seeMoreBtn = true;
  final CarouselController _controller = CarouselController();
  void updatePage(int page) {
    initialPageNotifier.value = page;
  }

  @override
  void initState() {
    super.initState();
    placeModel = Constants.allPlaces
        .where((element) => element.placeId == widget.placeId)
        .first;
    BlocProvider.of<HomeCubit>(context)
        .filterPlacesByLocation(placeModel.cityOfPlace);
  }

  @override
  Widget build(BuildContext context) {
    var homeCubit = BlocProvider.of<HomeCubit>(context);
    return WillPopScope(
      onWillPop: () {
        ConstantMethods.navigateReplacementTo(
            context,
            BottomNav(
              firebaseRequestType: FirebaseRequestType.login,
              comingIndex: 0,
            ));
        throw '';
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/bgg.jpg',
                    ),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.softLight))),
            child: SizedBox(
              child: ListView(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height - 20,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 16.h,
                            ),
                            CarouselSlider(
                                carouselController: _controller,
                                items: placeModel.placeImagesList!
                                    .map((ImageList) {
                                  return Builder(
                                      builder: (BuildContext context) {
                                    return Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          image: DecorationImage(
                                              image: AssetImage(ImageList),
                                              fit: BoxFit.cover)),
                                    );
                                  });
                                }).toList(),
                                options: CarouselOptions(
                                  height: 200.0.h,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  enlargeCenterPage: true,
                                  onPageChanged: (index, reason) {
                                    updatePage(index);
                                  },
                                )),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: placeModel.placeImagesList!
                                  .asMap()
                                  .entries
                                  .map((ImageList) {
                                return ValueListenableBuilder(
                                  valueListenable: initialPageNotifier,
                                  builder: (context, value, child) {
                                    return InkWell(
                                      onTap: () {
                                        _controller.jumpToPage(ImageList.key);
                                        // setState(() {});
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(12),
                                        height: 8.h,
                                        width: 8.w,
                                        decoration: BoxDecoration(
                                          shape: initialPageNotifier.value ==
                                                  ImageList.key
                                              ? BoxShape.circle
                                              : BoxShape.rectangle,
                                          color: initialPageNotifier.value ==
                                                  ImageList.key
                                              ? CustomColors.lightGold
                                              : Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            Expanded(
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: SizedBox(
                                      height: constraints.maxHeight - 30,
                                      child: ListView(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 4.h),
                                            child: Row(
                                              children: [
                                                AutoSizeText(
                                                  'Description',
                                                  style: TextStyle(
                                                      fontFamily: 'Changa',
                                                      color: Colors.black,
                                                      fontSize:
                                                          setResponsiveFontSize(
                                                              16),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Spacer(),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w),
                                              child: ReadMoreText(
                                                placeModel.placeDescription,
                                                trimLines: 3,
                                                trimMode: TrimMode.Line,
                                                lessStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: CustomColors.lightGold,
                                                  fontSize:
                                                      setResponsiveFontSize(14),
                                                ),
                                                trimCollapsedText: 'Show more',
                                                trimExpandedText: 'Show less',
                                                moreStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: CustomColors.lightGold,
                                                  fontSize:
                                                      setResponsiveFontSize(14),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          seeMoreBtn
                                              ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 110.w),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        ticketHeight = 260;
                                                        seeMoreBtn = false;
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 90.0.w,
                                                      height: 20.0.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    30.0.w),
                                                        border: Border.all(
                                                            width: 1.5.w,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      child: const Center(
                                                        child: AutoSizeText(
                                                          'More Info',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          AnimatedContainer(
                                            curve: Curves.linear,
                                            height: ticketHeight.h,
                                            duration:
                                                const Duration(seconds: 1),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TicketWidget(
                                                width: 300.w,
                                                height: ticketHeight.h,
                                                color: Colors.black12,
                                                isCornerRounded: true,
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: TicketData(
                                                    placeName:
                                                        placeModel.placeName),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          DisplayLocationMap(
                                              placeModel: placeModel),
                                          ReviewsDisplay(
                                              placeModel: placeModel),
                                          homeCubit.filteredPlaces.length > 1
                                              ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w,
                                                      vertical: 4.h),
                                                  child: AutoSizeText(
                                                    'You will also like',
                                                    style: TextStyle(
                                                        fontFamily: 'Changa',
                                                        color: Colors.black,
                                                        fontSize:
                                                            setResponsiveFontSize(
                                                                14),
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                )
                                              : Container(),
                                          homeCubit.filteredPlaces.length > 1
                                              ? SizedBox(
                                                  height: 150.h,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: homeCubit
                                                        .filteredPlaces.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      if (homeCubit
                                                              .filteredPlaces[
                                                                  index]
                                                              .placeName ==
                                                          placeModel
                                                              .placeName) {
                                                        return Container();
                                                      } else {
                                                        return SizedBox(
                                                          width: 240.h,
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10.w,
                                                                    vertical:
                                                                        4.h),
                                                            child: PlaceCard(
                                                                itemIndex:
                                                                    index,
                                                                press: () {},
                                                                place: homeCubit
                                                                        .filteredPlaces[
                                                                    index]),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                )
                                              : Container(),
                                          SizedBox(
                                            height: 50.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: 16.h,
                          left: 45.w,
                          right: 45.w,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostsByLocation(
                                        locationName: placeModel.placeName),
                                  ));
                            },
                            child: Container(
                              height: 40.h,
                              width: 200.w,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: CustomColors.lightGold,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                              ),
                              child: AutoSizeText(
                                'See related posts',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: setResponsiveFontSize(18)),
                              ),
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
