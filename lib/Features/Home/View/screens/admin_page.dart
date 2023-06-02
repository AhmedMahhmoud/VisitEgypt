import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visit_egypt/Core/Colors/app_colors.dart';
import 'package:visit_egypt/Core/Shared/methods.dart';
import 'package:visit_egypt/Features/Home/View/Cubit/trips_cubit.dart';
import 'package:visit_egypt/Features/More/views/more_screen.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  void initState() {
    BlocProvider.of<TripsCubit>(context).getPendingGuides();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.lightGold,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        title: const Text(
          "Pending tourguides",
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TripsCubit, TripsState>(
          buildWhen: (previous, current) =>
              previous is PendingGuidesLoadingState,
          builder: (context, state) {
            log(state.toString());
            if (state is PendingGuidesLoadingState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is PendingGuidesLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final guide = state.guidesList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 4,
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              child: ListTile(
                                title: Text(
                                  guide.userName,
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    guide.userImage!,
                                  ),
                                ),
                                trailing: SizedBox(
                                    child: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<TripsCubit>(context)
                                        .activateGuideAccount(guide.id!);
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
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: state.guidesList.length,
                    ),
                  ),
                  const Spacer(),
                  const LogOut()
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
