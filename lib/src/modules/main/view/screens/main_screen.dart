import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/error/remote_error.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawi_hub_owner/src/modules/main/cubit/main_cubit.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/bottom_nav_bar.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';

import '../../../../core/routing/routes.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (ConstantsManager.userId != null) {
      AuthBloc.get(context).add(GetProfileEvent(ConstantsManager.userId!));
    }
    MainCubit mainCubit = MainCubit.get()
      ..getBanner()
      ..getSports();
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            MainCubit.get().getSports();
            MainCubit.get().getBanner();
            PlaceCubit.get().getPlaces(refresh: true);
            PlaceCubit.get().getBookingRequests();
          },
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add_home_outlined),
              onPressed: () {
                if (ConstantsManager.appUser == null) {
                  errorToast(msg: S.of(context).loginFirst);
                } else {
                  if (ConstantsManager.appUser!.approvalStatus == 0) {
                    errorToast(msg: S.of(context).shouldActivate);
                  } else {
                    context.push(Routes.createPlace);
                  }
                }
                // context.push(Routes.createPlace);
              },
            ),
            bottomNavigationBar: const CustomBottomNavigationBar(),
            body: BlocListener<PlaceCubit, PlaceState>(
              listener: (context, state) {
                if (state is PlaceError) {
                  errorToast(
                      msg: ExceptionManager(state.exception)
                          .translatedMessage());
                } else if (state is AcceptBookingRequestSuccess) {
                  defaultToast(msg: S.of(context).requestAccepted);
                } else if (state is DeclineBookingRequestSuccess) {
                  defaultToast(msg: S.of(context).requestRejected);
                }
              },
              child: BlocBuilder<MainCubit, MainState>(
                bloc: mainCubit,
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        mainCubit.pages[mainCubit.currentIndex],
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
