// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sizer/sizer.dart';
//
// class EditProfileScreen extends StatelessWidget {
//   final Player player;
//
//   const EditProfileScreen({super.key, required this.player});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         return Scaffold(
//           body: Column(
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 child: Stack(
//                   children: [
//                     _appBar(context, player.profilePictureUrl),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsetsDirectional.symmetric(
//                   horizontal: 5.w,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 2.h,
//                     ),
//                     Text(
//                       player.userName,
//                       style: TextStyle(
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 2.h,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         _pentagonalWidget(
//                           player.games,
//                           "Games",
//                         ),
//                         SizedBox(
//                           width: 5.w,
//                         ),
//                         _pentagonalWidget(
//                           player.bookings,
//                           "Booking",
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 2.h,
//                     ),
//                     Text(
//                       player.rate!.remainder(1).toString(),
//                       style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//                     ),
//                     RatingBar.builder(
//                       initialRating: player.rate!,
//                       minRating: 1,
//                       itemSize: 25.sp,
//                       direction: Axis.horizontal,
//                       ignoreGestures: true,
//                       allowHalfRating: true,
//                       itemPadding: EdgeInsets.zero,
//                       itemBuilder: (context, _) => const Icon(
//                         Icons.star,
//                         color: ColorManager.golden,
//                       ),
//                       onRatingUpdate: (rating) {},
//                     ),
//                     SizedBox(
//                       height: 2.h,
//                     ),
//                     player.feedbacks.isEmpty
//                         ? Container()
//                         : Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     "People Rate",
//                                     style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
//                                   ),
//                                   const Spacer(),
//                                   _seeAll(() {
//                                     context.pushWithTransition(RatesScreen(
//                                       player: player,
//                                     ));
//                                   })
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 2.h,
//                               ),
//                               state is GetMyProfileLoadingState
//                                   ? ShimmerWidget(
//                                       height: 13.h,
//                                       width: double.infinity,
//                                       placeholder: ShimmerPlaceHolder(
//                                         borderRadius: 15.sp,
//                                       ),
//                                     )
//                                   : ListView.separated(
//                                       shrinkWrap: true,
//                                       physics: const NeverScrollableScrollPhysics(),
//                                       itemBuilder: (context, index) =>
//                                           _peopleRateBuilder(player.feedbacks[index]),
//                                       separatorBuilder: (context, index) => SizedBox(
//                                             height: 2.h,
//                                           ),
//                                       itemCount: player.feedbacks.take(2).length),
//                             ],
//                           ),
//                     SizedBox(
//                       height: 2.h,
//                     ),
//                     Align(
//                       alignment: AlignmentDirectional.centerStart,
//                       child: Text(
//                         "My Wallet",
//                         style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 2.h,
//                     ),
//                     _walletWidget(() {}, player.myWallet.toString()),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// Widget _walletWidget(VoidCallback onTap, String wallet) {
//   return Container(
//     height: 5.h,
//     width: double.infinity,
//     decoration: BoxDecoration(
//       color: const Color(0xff757575),
//       borderRadius: BorderRadius.circular(25.sp),
//     ),
//     child: Row(
//       children: [
//         Padding(
//           padding: EdgeInsetsDirectional.only(
//             start: 4.w,
//             top: 1.h,
//             bottom: 1.h,
//           ),
//           child: Text(
//             "$wallet \$",
//             style: const TextStyle(
//               color: ColorManager.white,
//             ),
//           ),
//         ),
//         const Spacer(),
//         InkWell(
//           onTap: onTap,
//           child: Container(
//             width: 25.w,
//             height: 5.h,
//             decoration: BoxDecoration(
//               color: ColorManager.primary,
//               borderRadius: BorderRadiusDirectional.only(
//                 topEnd: Radius.circular(25.sp),
//                 bottomEnd: Radius.circular(25.sp),
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 "Add Wallet",
//                 style: TextStyle(
//                     color: ColorManager.white, fontSize: 13.sp, fontWeight: FontWeight.w500),
//               ),
//             ),
//           ),
//         )
//       ],
//     ),
//   );
// }
//
// Widget _appBar(
//   BuildContext context,
//   String profilePictureUrl,
// ) {
//   return Stack(
//     alignment: AlignmentDirectional.bottomCenter,
//     children: [
//       CustomAppBar(
//         blendMode: BlendMode.exclusion,
//         backgroundImage: "assets/images/app_bar_backgrounds/4.webp",
//         height: 32.h,
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: 5.w,
//             vertical: 2.h,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               backIcon(context),
//               SizedBox(
//                 width: 20.w,
//               ),
//               Text(
//                 "Profile",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: ColorManager.white,
//                   fontSize: 32.sp,
//                 ),
//               ),
//               const Spacer(),
//               _editIcon(),
//             ],
//           ),
//         ),
//       ),
//       CircleAvatar(
//         radius: 50.sp,
//         backgroundColor: ColorManager.grey3,
//         backgroundImage: NetworkImage(profilePictureUrl),
//       )
//     ],
//   );
// }
//
// Widget _editIcon() {
//   return CircleAvatar(
//     radius: 12.sp,
//     backgroundColor: ColorManager.white,
//     child: Image.asset(
//       "assets/images/icons/edit.webp",
//       height: 3.h,
//       width: 4.w,
//     ),
//   );
// }
//
// Widget _pentagonalWidget(int number, String text) {
//   return Stack(
//     alignment: AlignmentDirectional.center,
//     children: [
//       ClipPath(
//         clipper: TriangleClipper(),
//         child: Container(
//           width: 30.w,
//           height: 15.h,
//           color: ColorManager.black,
//         ),
//       ),
//       ClipPath(
//         clipper: TriangleClipper(),
//         child: Container(
//           width: 29.w,
//           height: 14.5.h,
//           color: ColorManager.white,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 1.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   number.toString(),
//                   maxLines: 1,
//                   style: TextStyle(
//                     color: ColorManager.primary,
//                     fontSize: 25.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 1.h,
//                 ),
//                 Text(
//                   text,
//                   style: TextStyle(
//                     color: ColorManager.grey3,
//                     fontSize: 15.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }
//
// class TriangleClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0, 0);
//     path.lineTo(0, size.height * .7);
//     path.lineTo(size.width / 2, size.height);
//     path.lineTo(size.width, size.height * .7);
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(TriangleClipper oldClipper) => false;
// }
//
// Widget _seeAll(VoidCallback onTap) {
//   return InkWell(
//     onTap: onTap,
//     child: Row(
//       children: [
//         Text(
//           "See all",
//           style: TextStyle(
//             fontSize: 11.sp,
//             fontWeight: FontWeight.w600,
//             color: ColorManager.golden,
//           ),
//         ),
//         Icon(
//           Icons.arrow_forward_rounded,
//           color: const Color(0xffFFC107),
//           size: 18.sp,
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _peopleRateBuilder(FeedBack feedBack) {
//   return Stack(
//     children: [
//       Column(
//         children: [
//           SizedBox(
//             height: 1.h,
//           ),
//           Container(
//             height: 12.h,
//             width: double.infinity,
//             decoration:
//                 BoxDecoration(borderRadius: BorderRadius.circular(25.sp), border: Border.all()),
//             child: Padding(
//               padding: EdgeInsetsDirectional.symmetric(horizontal: 3.w, vertical: 1.h),
//               child: Row(children: [
//                 CircleAvatar(
//                   radius: 20.sp,
//                   backgroundColor: ColorManager.grey3,
//                   backgroundImage: NetworkImage(feedBack.userImageUrl!),
//                 ),
//                 SizedBox(
//                   width: 4.w,
//                 ),
//                 Expanded(
//                   child: Text(feedBack.comment ?? "No comment",
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: ColorManager.black.withOpacity(0.5),
//                         fontWeight: FontWeight.bold,
//                       )),
//                 ),
//               ]),
//             ),
//           ),
//         ],
//       ),
//       Positioned(
//         left: 5.w,
//         top: -1.h,
//         child: Container(
//           padding: EdgeInsetsDirectional.symmetric(
//             vertical: 1.h,
//             horizontal: 2.w,
//           ),
//           color: Colors.white,
//           child: Row(
//             children: [
//               Text(
//                 feedBack.userName,
//                 style: TextStyle(fontSize: 12.sp, color: Colors.green, fontWeight: FontWeight.w500),
//               ),
//               SizedBox(width: 1.w),
//               RatingBar.builder(
//                 initialRating: feedBack.rating,
//                 minRating: 1,
//                 itemSize: 10.sp,
//                 direction: Axis.horizontal,
//                 ignoreGestures: true,
//                 allowHalfRating: true,
//                 itemPadding: EdgeInsets.zero,
//                 itemBuilder: (context, _) => const Icon(
//                   Icons.star,
//                   color: ColorManager.golden,
//                 ),
//                 onRatingUpdate: (rating) {},
//               ),
//             ],
//           ),
//         ),
//       ),
//     ],
//   );
// }
