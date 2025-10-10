import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class CustomDropDown<T> extends StatelessWidget {
  final T? value;
  final String hintText;
  final List<T> items;
  final String Function(T) getLabel;
  final void Function(T?) onChanged;

  const CustomDropDown({
    super.key,
    required this.value,
    required this.hintText,
    required this.items,
    required this.getLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.smooky2,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.grey2, width: 1.2.w),
      ),
      padding:  EdgeInsets.symmetric(horizontal: 12.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          borderRadius: BorderRadius.circular(14.r),
          dropdownColor: AppColors.smooky2,
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.amber),
          hint: Text(
            hintText,
            style: const TextStyle(
              color: AppColors.grey1,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
          ),
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                getLabel(item),
                style: const TextStyle(color: AppColors.white),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
