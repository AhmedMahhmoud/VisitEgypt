import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_pickers/image_pickers.dart';
import '../../../../Core/Colors/app_colors.dart';
import '../../../../Core/Constants/constants.dart';
import '../../../../Core/Styles/text_style.dart';
import '../widgets/add_post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final TextEditingController _postsEditingController = TextEditingController();
  List<Media> images = [];

  Future<void> selectImages() async {
    List<Media> listImagePaths = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 3,
        showGif: false,
        showCamera: true,
        compressSize: 500,
        uiConfig: UIConfig(uiThemeColor: CustomColors.niceBlue),
        cropConfig: CropConfig(enableCrop: false, width: 2, height: 1));
    if (listImagePaths.isNotEmpty) {
      setState(() {
        images = listImagePaths;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            child: Column(
              children: [
               const AddPostCard(),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 550.h,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(Constants.postsCollection)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator());
                        default:

                          return ListView(
                            shrinkWrap: true,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {

                              List<String> postImages = [];
                              for (int i = 0;
                                  i < document['postImages'].length;
                                  i++) {
                                postImages.add(document['postImages'][i]);
                              }

                              return Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(
                                            color: CustomColors.niceBlue,
                                            width: 1.5.w),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: ListTile(
                                        title: Padding(
                                          padding:  EdgeInsets.only(bottom: 10.h,top: 6.h),
                                          child: Row(
                                            children: [
                                              const CircleAvatar(radius: 20,
                                                backgroundColor: CustomColors.niceBlue,
                                                child: AutoSizeText('A',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                              ),
                                              SizedBox(width: 8.w,),
                                              AutoSizeText(
                                                document['postContent'],
                                                style: TextStyle(color: Colors.black,fontSize:setResponsiveFontSize(18) ),textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        subtitle: postImages.isNotEmpty
                                            ? SizedBox(
                                                height: 200.h,
                                                child: ListView.builder(
                                                  itemCount: postImages.length,
                                                  scrollDirection: Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemBuilder: (context, index) {
                                                    return SizedBox(
                                                      width: 200.w,
                                                      child: Card(
                                                        child: InkWell(

                                                          onTap: (){
                                                            showDialog(
                                                                context:
                                                                context,
                                                                builder:
                                                                    (context) {
                                                                  return Dialog(
                                                                    shape:
                                                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                    elevation:
                                                                    16,
                                                                    child:
                                                                    SizedBox(
                                                                      height: 400.h,
                                                                      width: double.infinity,
                                                                      child: CachedNetworkImage(imageUrl:  postImages[index],fit: BoxFit.fill,
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          child: CachedNetworkImage(imageUrl:  postImages[index],fit: BoxFit.fill,
                                                             ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            : Container()),
                                  ),
                                Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Divider(thickness: 2,),
                                  )
                                ],
                              );
                            }).toList(),
                          );
                      }
                    },
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
