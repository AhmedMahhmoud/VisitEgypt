import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

import '../widgets/post_card.dart';

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
                            {
                              postsCubit.retrievePosts(snapshot.data!.docs);

                              return ListView.separated(
                                itemCount: postsCubit.retrievedPosts.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return PostCardItem(postsCubit: postsCubit,index: index,);
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: const Divider(
                                      thickness: 2,
                                    ),
                                  );
                                },
                              );
                            }
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
