import 'package:flutter/material.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/modules/auth/data/models/owner.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/widgets/auth_app_bar.dart';
import 'package:hawi_hub_owner/src/modules/auth/view/widgets/people_rate_builder.dart';
import 'package:sizer/sizer.dart';

class RatesScreen extends StatelessWidget {
  final Owner owner;

  const RatesScreen({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AuthAppBar(
            context: context,
            owner: owner,
            title: S.of(context).rates,
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
            height: 3.h,
          ),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 5.w,
            ),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                S.of(context).peopleRate,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (owner.feedbacks.isNotEmpty)
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 5.w,
                ),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => PeopleRateBuilder(
                          context: context,
                          feedBack: owner.feedbacks[index],
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 2.h,
                        ),
                    itemCount: owner.feedbacks.length),
              ),
            ),
        ],
      ),
    );
  }
}