import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visit_egypt/Features/Posts/Model/posts_model.dart';
import 'package:visit_egypt/Features/Posts/View/cubit/posts_cubit.dart';
import 'package:visit_egypt/Features/Posts/View/widgets/display_post.dart';

class PostsByLocation extends StatefulWidget {
  final String locationName;
  const PostsByLocation({required this.locationName, super.key});

  @override
  State<PostsByLocation> createState() => _PostsByLocationState();
}

class _PostsByLocationState extends State<PostsByLocation> {
  @override
  void initState() {
    print(widget.locationName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            // borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
          image: AssetImage(
            'assets/images/bgg.jpg',
          ),
          fit: BoxFit.cover,
        )),
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<Posts> posts = snapshot.data as List<Posts>;
              if (posts.isEmpty) {
                return const Center(
                  child: Material(
                    color: Colors.transparent,
                    elevation: 20,
                    child: Text(
                      "There are no posts for this place !",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                );
              } else {
                return DisplayPostsList(posts: posts);
              }
            }
          },
          future: BlocProvider.of<PostsCubit>(context, listen: false)
              .getPostsByLocation(widget.locationName),
        ),
      ),
    );
  }
}
