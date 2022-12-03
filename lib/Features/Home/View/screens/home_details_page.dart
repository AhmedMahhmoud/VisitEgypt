import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Features/Home/Model/place_model.dart';
import 'package:visit_egypt/Features/Home/View/screens/home_page.dart';
import 'package:build_daemon/constants.dart';
import '../../../../Core/Colors/app_colors.dart';
import '../../../../Core/Constants/constants.dart';
import '../../../../Core/Shared/methods.dart';
import '../../../../Core/Styles/text_style.dart';

class HomeDetailsPage extends StatefulWidget {
  final int placeId;

  const HomeDetailsPage({Key? key, required this.placeId}) : super(key: key);

  @override
  State<HomeDetailsPage> createState() => _HomeDetailsPageState();
}

class _HomeDetailsPageState extends State<HomeDetailsPage> {
  // List<String> imageList=[];
  late PlaceModel placeModel;
  int initialPage = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    placeModel = Constants.allPlaces
        .where((element) => element.placeId == widget.placeId)
        .first;
    print('place model ${placeModel.cityOfPlace}');
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
            child: Column(
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
                      autoPlay: true,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        placeModel.placeRate.toString(),
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: setResponsiveFontSize(14),
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
                            padding:  EdgeInsets.symmetric(horizontal:10.w ),
                            child: AutoSizeText(
                              placeModel.placeDescription,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black38,
                                fontSize:
                                setResponsiveFontSize(16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
