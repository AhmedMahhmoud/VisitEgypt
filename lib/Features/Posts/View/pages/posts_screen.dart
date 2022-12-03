import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:visit_egypt/Features/Posts/View/cubit/posts_cubit.dart';
import '../../../../Core/Colors/app_colors.dart';
import '../../../../Core/Constants/constants.dart';
import '../../../../Core/Styles/text_style.dart';
import '../widgets/add_post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/display_post.dart';

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
    var postsCubit = BlocProvider.of<PostsCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              // borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
            image: AssetImage(
              'assets/images/bgg.jpg',
            ),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: [
              const AddPostCard(),
              Expanded(
                // height: MediaQuery.of(context).size.height*0.7,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(Constants.postsCollection)
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator());

                        /*         case ConnectionState.done:
                            {
                              postsCubit.retrievePosts(snapshot.data!.docs);
                              return postsCubit.retrievedPosts.isNotEmpty
                                  ? ListView.separated(
                                itemCount:
                                postsCubit.retrievedPosts.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return PostCardItem(
                                    postsCubit: postsCubit,
                                    index: index,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w),
                                    child: const Divider(
                                      thickness: 2,
                                    ),
                                  );
                                },
                              )
                                  : Center(
                                  child: Column(
                                    children: [
                                      Lottie.asset(
                                          'assets/lotties/horus.json',
                                          height: 320.h),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AutoSizeText(
                                          'There are no posts',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.niceYellow,
                                            fontSize:
                                            setResponsiveFontSize(28),
                                          ),
                                        ),
                                      )
                                    ],
                                  ));
                            }*/

                        default:
                          {
                            postsCubit.retrievePosts(snapshot.data!.docs);

                            return postsCubit.retrievedPosts.isNotEmpty
                                ? DisplayPostsList(
                                    posts: postsCubit.retrievedPosts)
                                : Center(
                                    child: Column(
                                    children: [
                                      Lottie.asset('assets/lotties/horus.json',
                                          height: 320.h),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AutoSizeText(
                                          'There are no posts',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: CustomColors.niceYellow,
                                            fontSize: setResponsiveFontSize(28),
                                          ),
                                        ),
                                      )
                                    ],
                                  ));
                          }
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
