import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';

class CustomMealsHeaderRow extends StatelessWidget {
  const CustomMealsHeaderRow({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.smooky,
      padding:  EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.smooky2,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: const [
            Expanded(
              flex: 2,
              child: Text(
                "الاسم",
                style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                "الصورة",
                style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                "التفاصيل",
                style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

