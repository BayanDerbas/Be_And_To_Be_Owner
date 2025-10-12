import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/networks/api_constant.dart';
import '../../domain/entities/meal_type_entity.dart';
import '../cubits/meal_types_cubit/meal_types_cubit.dart';

class MealTypesDialog extends StatelessWidget {
  final String mealName;
  final String mealImage;

  const MealTypesDialog({
    super.key,
    required this.mealName,
    required this.mealImage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.smooky,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: AppColors.amber, width: 1.5),
      ),
      title: Column(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: CachedNetworkImageProvider(
              '${ApiConstant.imageBase}$mealImage',
            ),
            backgroundColor: Colors.grey[800],
          ),
          const SizedBox(height: 12),
          Text(
            mealName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          style: TextButton.styleFrom(foregroundColor: AppColors.amber),
          child: const Text(
            "إغلاق",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
