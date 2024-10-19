import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/modules/main/cubit/main_cubit.dart';


import '../../../../core/utils/color_manager.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get();
    return BlocBuilder<MainCubit, MainState>(
      bloc: mainCubit,
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: mainCubit.currentIndex,
          onTap: (index) {
            mainCubit.changePage(index);
          },
          items: [
            BottomNavigationBarItem(
              icon:
                  const ImageIcon(AssetImage('assets/images/icons/home.webp')),
              label: S.of(context).home,
            ),
            BottomNavigationBarItem(
              icon:
                  const ImageIcon(AssetImage('assets/images/icons/book.webp')),
              label: S.of(context).places,
            ),
            BottomNavigationBarItem(
              icon:
                  const ImageIcon(AssetImage('assets/images/icons/play.webp')),
              label: S.of(context).requests,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: S.of(context).bookings,
            ),
            BottomNavigationBarItem(
              icon:
                  const ImageIcon(AssetImage('assets/images/icons/more.webp')),
              label: S.of(context).more,
            ),
          ],
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
        );
      },
    );
  }
}

// class CustomBottomNavigationBar extends StatelessWidget {
//   const CustomBottomNavigationBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     MainCubit mainCubit = MainCubit.get();
//     return BlocBuilder<MainCubit, MainState>(
//       bloc: mainCubit,
//       builder: (context, state) {
//         return SizedBox(
//           height: 7.5.h,
//           width: double.infinity,
//           child: Stack(children: [
//             Center(
//               child: Container(
//                 color: ColorManager.primary,
//                 height: 2.5.h,
//                 width: double.infinity,
//               ),
//             ),
//             Positioned.fill(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   NavBarItem(
//                     index: 0,
//                     icon: "assets/images/icons/home.webp",
//                     label: S.of(context).home,
//                   ),
//                   NavBarItem(
//                     icon: "assets/images/icons/book.webp",
//                     label: S.of(context).places,
//                     index: 1,
//                   ),
//                   NavBarItem(
//                     iconData: Icons.group_add_outlined,
//                     label: S.of(context).requests,
//                     index: 2,
//                   ),
//                   NavBarItem(
//                     icon: "assets/images/icons/more.webp",
//                     label: S.of(context).more,
//                     index: 3,
//                   )
//                 ],
//               ),
//             )
//           ]),
//         );
//       },
//     );
//   }
// }
//
// class NavBarItem extends StatefulWidget {
//   final String? icon;
//   final String label;
//   final IconData? iconData;
//   final int index;
//
//   const NavBarItem({super.key, this.icon, required this.label, required this.index, this.iconData});
//
//   @override
//   State<NavBarItem> createState() => _NavBarItemState();
// }
//
// class _NavBarItemState extends State<NavBarItem> {
//   MainCubit cubit = MainCubit.get();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<MainCubit, MainState>(
//       bloc: cubit,
//       builder: (context, state) {
//         return Expanded(
//           child: CircleAvatar(
//             radius: double.maxFinite,
//             backgroundColor:
//                 cubit.currentIndex == widget.index ? ColorManager.primary : Colors.grey[300],
//             child: Padding(
//               padding: const EdgeInsets.all(2.0),
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(360),
//                 radius: 360,
//                 onTap: () {
//                   cubit.changePage(widget.index);
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 1.h),
//                     Expanded(
//                         child: FittedBox(
//                       fit: BoxFit.fill,
//                       child: widget.iconData != null
//                           ? Icon(widget.iconData,
//                               color: cubit.currentIndex == widget.index
//                                   ? Colors.white
//                                   : Colors.grey[600])
//                           : ImageIcon(
//                               size: 35.sp,
//                               AssetImage(
//                                 widget.icon!,
//                               ),
//                               color: cubit.currentIndex == widget.index
//                                   ? Colors.white
//                                   : Colors.grey[600]),
//                     )),
//                     FittedBox(
//                       fit: BoxFit.contain,
//                       child: Text(widget.label,
//                           style: TextStyle(
//                               fontSize: 9.5.sp,
//                               color: cubit.currentIndex == widget.index
//                                   ? Colors.white
//                                   : Colors.grey[600])),
//                     ),
//                     SizedBox(height: 1.h),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
