import 'package:flutter/material.dart';
import 'package:untitled/core/constants/app_colors.dart';

class CustomCategoriesHeaderRow extends StatelessWidget {
  const CustomCategoriesHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.smooky,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        children: const [
          Expanded(
            flex: 2,
            child: Text(
              "الاسم",
              style: TextStyle(color: AppColors.amber, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "الصورة",
              style: TextStyle(color: AppColors.amber, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "الفرع",
              style: TextStyle(color: AppColors.amber, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "إجراءات",
              style: TextStyle(color: AppColors.amber, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}