import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:visit_egypt/Features/Home/Model/place_model.dart';
import 'package:visit_egypt/Features/Home/View/screens/home_page.dart';
import '../../../../Core/Colors/app_colors.dart';
import '../../../../Core/Constants/constants.dart';
import '../../../../Core/Shared/methods.dart';
import '../../../../Core/Styles/text_style.dart';
import '../../../Posts/View/pages/posts_by_location.dart';

class HomeDetailsPage extends StatefulWidget {
  final int placeId;

  const HomeDetailsPage({Key? key, required this.placeId}) : super(key: key);

  @override
  State<HomeDetailsPage> createState() => _HomeDetailsPageState();
}

class _HomeDetailsPageState extends State<HomeDetailsPage> {
  late PlaceModel placeModel;
  int initialPage = 0;
  int ticketHeight = 0;
  bool seeMoreBtn = true;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    placeModel = Constants.allPlaces
        .where((element) => element.placeId == widget.placeId)
        .first;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        ConstantMethods.navigateReplacementTo(context, const HomePage());
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
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    CarouselSlider(
                        carouselController: _controller,
                        items: placeModel.placeImagesList!.map((ImageList) {
                          return Builder(builder: (BuildContext context) {
                            return Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                      image: AssetImage(ImageList),
                                      fit: BoxFit.cover)),
                            );
                          });
                        }).toList(),
                        options: CarouselOptions(
                          height: 200.0.h,
                          autoPlay: false,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              initialPage = index;
                            });
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
                        return InkWell(
                          onTap: () {
                            _controller.jumpToPage(ImageList.key);
                            setState(() {});
                          },
                          child: Container(
                            margin: const EdgeInsets.all(12),
                            height: 8.h,
                            width: 8.w,
                            decoration: BoxDecoration(
                              shape: initialPage == ImageList.key
                                  ? BoxShape.circle
                                  : BoxShape.rectangle,
                              color: initialPage == ImageList.key
                                  ? CustomColors.lightGold
                                  : Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.white,
                          elevation: 4,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: ListView(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 4.h),
                                child: Row(
                                  children: [
                                    AutoSizeText(
                                      'Description',
                                      style: TextStyle(
                                          fontFamily: 'Changa',
                                          color: Colors.black,
                                          fontSize: setResponsiveFontSize(16),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            placeModel.placeRate.toString(),
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    setResponsiveFontSize(14),
                                                color: CustomColors.lightGold),
                                            // style: Theme.of(context).textTheme.button,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: CustomColors.lightGold,
                                            size: 22.w,
                                          )
                                        ]),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: AutoSizeText(
                                  placeModel.placeDescription,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black38,
                                    fontSize: setResponsiveFontSize(16),
                                  ),
                                ),
                              ),
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
                                                BorderRadius.circular(30.0.w),
                                            border: Border.all(
                                                width: 1.5.w,
                                                color: Colors.green),
                                          ),
                                          child: const Center(
                                            child: AutoSizeText(
                                              'See more',
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              AnimatedContainer(
                                curve: Curves.linear,
                                height: ticketHeight.h,
                                duration: const Duration(seconds: 1),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TicketWidget(
                                    width: 300.w,
                                    height: ticketHeight.h,
                                    color: Colors.black12,
                                    isCornerRounded: true,
                                    padding: const EdgeInsets.all(20),
                                    child: TicketData(
                                        placeName: placeModel.placeName),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
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
          ),
        ),
      ),
    );
  }
}

class TicketData extends StatelessWidget {
  final String placeName;

  const TicketData({
    Key? key,
    required this.placeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          '$placeName Ticket',
          style: TextStyle(
              color: Colors.black,
              fontSize: setResponsiveFontSize(16),
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.only(top: 25.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ticketDetailsWidget(
                  'opening time', '08:00 Am', 'closing time', '7:00 Pm'),
              Padding(
                padding: EdgeInsets.only(top: 12.0.h, right: 40.0.w),
                child: ticketDetailsWidget(
                    'Price on vacation', '20 LE', 'Price', '40 LE'),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 45.0.h, left: 30.0.w, right: 30.0.w),
          child: Container(
            width: 250.0,
            height: 40.0,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/barcode.jpg'),
                    fit: BoxFit.cover)),
          ),
        ),
      ],
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 12.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AutoSizeText(
              firstTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.0.h),
              child: AutoSizeText(
                firstDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 20.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              secondTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.0.h),
              child: AutoSizeText(
                secondDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      )
    ],
  );
}
