import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/owner.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/widgets/auth_app_bar.dart';
import 'package:hawi_hub_owner/src/modules/payment/bloc/payment_cubit.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/utils/color_manager.dart';

class MyWallet extends StatelessWidget {
  final Owner owner;

  const MyWallet({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    PaymentCubit paymentCubit = PaymentCubit.get();
    if (owner.supplierCode != null) {
      paymentCubit.getAccountBalance(owner.supplierCode!);
    }
    double balance = 0;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: _appBar(context, owner),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            owner.userName,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    S.of(context).myWallet,
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                BlocConsumer<PaymentCubit, PaymentState>(
                  listener: (context, state) {
                    if (state is GetAccountBalanceSuccess) {
                      balance = state.balance;
                    }
                  },
                  builder: (context, state) {
                    return _walletWidget("$balance ${S.of(context).sar}");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _appBar(BuildContext context, Owner owner) {
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      AuthAppBar(context: context, owner: owner, title: S.of(context).wallet),
      if (owner.profilePictureUrl != null)
        CircleAvatar(
          radius: 50.sp,
          backgroundColor: ColorManager.grey3,
          backgroundImage: NetworkImage(owner.profilePictureUrl!),
        ),
      if (owner.profilePictureUrl == null)
        CircleAvatar(
          radius: 50.sp,
          backgroundColor: ColorManager.grey3,
          backgroundImage: const AssetImage("assets/images/icons/user.png"),
        ),
    ],
  );
}

Widget _walletWidget(String wallet) {
  return Container(
    height: 5.h,
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xff757575),
      borderRadius: BorderRadius.circular(25.sp),
    ),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            start: 5.w,
            top: 1.h,
            bottom: 1.h,
          ),
          child: Text(
            wallet,
            style: const TextStyle(
              color: ColorManager.white,
            ),
          ),
        ),
      ],
    ),
  );
}
