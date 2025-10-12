import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CustomMealsHeaderRow extends StatelessWidget {
  const CustomMealsHeaderRow({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.smooky,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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
            Expanded(
              flex: 2,
              child: Text(
                "العمليات",
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

