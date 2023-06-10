import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visit_egypt/Core/Shared/methods.dart';
import 'package:visit_egypt/Features/Home/View/Cubit/trips_cubit.dart';

class PendingGuidesDisplay extends StatelessWidget {
  final PendingGuidesLoaded state;
  const PendingGuidesDisplay({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final guide = state.guidesList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              elevation: 4,
              child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        backgroundImage: NetworkImage(
                          guide.userImage!,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        guide.userName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                          child: IconButton(
                        onPressed: () {
                          BlocProvider.of<TripsCubit>(context)
                              .activateGuideAccount(
                                  guide.id!, TourGuideApplicationEnum.accept);
                          ConstantMethods.showContentToast(
                              context, 'Approved successfully');
                        },
                        tooltip: "Approve Guide",
                        splashColor: Colors.green,
                        splashRadius: 22,
                        icon: const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 30,
                        ),
                      )),
                      SizedBox(
                          child: IconButton(
                        onPressed: () async {
                          await BlocProvider.of<TripsCubit>(context)
                              .activateGuideAccount(
                                  guide.id!, TourGuideApplicationEnum.reject);
                          ConstantMethods.showContentToast(context, 'Rejected');
                        },
                        tooltip: "Reject Guide",
                        splashColor: Colors.red,
                        splashRadius: 22,
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 30,
                        ),
                      ))
                    ],
                  )),
            ),
          );
        },
        itemCount: state.guidesList.length,
      ),
    );
  }
}
