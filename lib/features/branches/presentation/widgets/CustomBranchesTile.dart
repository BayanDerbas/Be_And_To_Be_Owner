import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/constants/app_colors.dart';

class CustomBranchesTile extends StatelessWidget {
  final String name;
  final String image;
  final String socialmedia;
  final String location;
  final String numbers;
  final VoidCallback onDelete;

  const CustomBranchesTile({
    super.key,
    required this.name,
    required this.image,
    required this.socialmedia,
    required this.onDelete,
    required this.location, required this.numbers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.smooky2,
      margin: EdgeInsets.symmetric(horizontal: 0.5.w, vertical: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Expanded(
            flex: 2,
            child: Center(
              child: CircleAvatar(
                radius: 35.r,
                backgroundColor: AppColors.grey2.withOpacity(0.3),
                backgroundImage: image.isNotEmpty
                    ? NetworkImage(image)
                    : null,
                child: image.isEmpty
                    ? Icon(Icons.image_not_supported,
                    color: AppColors.grey1, size: 35)
                    : null,
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              socialmedia,
              style: const TextStyle(color: AppColors.white),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              location,
              style: const TextStyle(color: AppColors.white),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              numbers,
              style: const TextStyle(color: AppColors.white),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          /// Actions
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete,
                    color: Colors.redAccent, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
