import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Cubit/home_cubit.dart';

class FilterByList extends StatefulWidget {
  @override
  _FilterByListState createState() => _FilterByListState();
}

class _FilterByListState extends State<FilterByList> {
  // by default first item will be selected

  List filters = [
    'All Places',
    'Best Rated',
    'By Location',

  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {

      /*    if (state.filteredBooksState == RequestState.loaded) {
            Navigator.maybePop(context);
          }*/

        },
        child: Container(
          margin:  EdgeInsets.symmetric(
              vertical: 10.h),
          height: 30.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () async {
       /*         if(index!=0){
                  showLoaderDialog(context);
                }


                BlocProvider.of<BookBloc>(context).add( FilteredBooksEvent(
                    filters[index].toString().toLowerCase(), index));*/

              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  left: 20.w,
                  // At end item it add extra 20 right  padding
                  right: index == filters.length - 1
                      ? 20.w
                      : 0,
                ),
                padding:  EdgeInsets.symmetric(
                    horizontal: 20.w),
                decoration: BoxDecoration(
                  color:
                  index == BlocProvider.of<HomeCubit>(context).selectedIndex
                      ? Colors.green.withOpacity(0.8)
                      : Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  filters[index],
                  style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ));

  }
}
