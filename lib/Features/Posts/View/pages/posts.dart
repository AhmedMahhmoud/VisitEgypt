import 'package:flutter/material.dart';
import 'package:image_pickers/image_pickers.dart';
import '../../../../Core/Colors/app_colors.dart';
import '../widgets/add_post_card.dart';

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
              children: const [
                AddPostCard(),
                SizedBox(
                  height: 10,
                ),
                //  ?HERE ARE THE POSTS TO DISPLAY
              ],
            ),
          ),
        ),
      ),
    );
  }
}
