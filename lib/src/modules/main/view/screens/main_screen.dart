import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/src/modules/main/cubit/main_cubit.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/bottom_nav_bar.dart';

import '../../../places/data/models/place.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get();

    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: BlocBuilder<MainCubit, MainState>(
        bloc: mainCubit,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                mainCubit.pages[mainCubit.currentIndex],
                // Center(
                //   child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: PlaceItem(
                //         place: place,
                //       )),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}