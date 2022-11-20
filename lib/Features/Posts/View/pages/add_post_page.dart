import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Shared/Widgets/user_circular_avatar.dart';
import '../../../../Core/Shared/methods.dart';
import '../../Model/posts_model.dart';
import '../cubit/posts_cubit.dart';
import '../widgets/add_post_header.dart';
import '../widgets/add_post_images_button.dart';
import '../widgets/add_post_location_dropdown.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/loading_post_widget.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<AddPostPage>
    with SingleTickerProviderStateMixin {
  late AnimationController slidersAnimationController;
  late Animation<Offset> offsetAnimation;

  String _selectedLocation = "";
  List<Media> images = [];
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    slidersAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    offsetAnimation =
        Tween<Offset>(begin: const Offset(0, 700), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: slidersAnimationController,
      curve: Curves.easeIn,
    ));
    slidersAnimationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    slidersAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return BlocListener<PostsCubit, PostsState>(
      listener: (context, state) {
        if (state is PostsErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMsg)));
        } else if (state is PostsLoadedState) {
          ConstantMethods.showContentToast(
              context, "Post uploaded successfully !");
          Navigator.pop(context);
        }
      },
      child:
          BlocBuilder<PostsCubit, PostsState>(builder: (context, cubitState) {
        return StatefulBuilder(
          builder: (ctx, state) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    child: AnimatedBuilder(
                        animation: slidersAnimationController,
                        builder: (context, value) {
                          return cubitState is PostsLoadingState
                              ? const LoadingPostWidget()
                              : Transform.translate(
                                  offset: Offset(offsetAnimation.value.dx,
                                      offsetAnimation.value.dy),
                                  child: AnimatedOpacity(
                                    curve: Curves.bounceInOut,
                                    duration: const Duration(milliseconds: 200),
                                    opacity: slidersAnimationController.value,
                                    child: Column(
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(10),
                                            color: Colors.blue.shade600,
                                            child: AddPostHeader(
                                              addPostFun: () async {
                                                List<File> imageFiles = [];
                                                if (images.isNotEmpty) {
                                                  for (var i in images) {
                                                    imageFiles
                                                        .add(File(i.path!));
                                                  }
                                                }
                                                final Posts post = Posts(
                                                    locationName:
                                                        _selectedLocation,postOwnerName: FirebaseAuth.instance.currentUser!.email,
                                                    postImages: imageFiles,
                                                    postContent:
                                                        _textEditingController
                                                            .text,
                                                    userID: FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid);
                                                await context
                                                    .read<PostsCubit>()
                                                    .uploadPostImages(post);
                                              },
                                              content:
                                                  _textEditingController.text,
                                              onClosingPage: () async {
                                                slidersAnimationController
                                                    .reverse();
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 300));

                                                Navigator.pop(context);
                                              },
                                            )),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              const UserCircularAvatar(),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "Where was this at ?",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  AddPostLocationDropdown(
                                                    onDone: (e) {
                                                      _selectedLocation = e;
                                                    },
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: _textEditingController,
                                            onChanged: (value) {
                                              if (_textEditingController
                                                      .text.length ==
                                                  1) {
                                                setState(() {});
                                                SystemChrome
                                                    .setEnabledSystemUIMode(
                                                        SystemUiMode.manual,
                                                        overlays: []);
                                              }
                                            },
                                            decoration: const InputDecoration(
                                                hintText:
                                                    "What is on your mind ?"),
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                        AddPostImagesButton(
                                          getImages: (imgs) {
                                            images = imgs;
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                );
                        }),
                  )),
            );
          },
        );
      }),
    );
  }
}
