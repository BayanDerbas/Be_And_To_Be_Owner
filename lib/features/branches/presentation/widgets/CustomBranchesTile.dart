import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomBranchesTile extends StatelessWidget {
  final String name;
  final String image;
  final String socialmediaInstagram;
  final String socialmediaFacebook;
  final String location;
  final String numbers;
  final VoidCallback onDelete;

  const CustomBranchesTile({
    super.key,
    required this.name,
    required this.image,
    required this.socialmediaInstagram,
    required this.socialmediaFacebook,
    required this.onDelete,
    required this.location,
    required this.numbers,
  });

  // helper to open links safely
  Future<void> _launchURL(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.smooky2,
      margin: EdgeInsets.symmetric(horizontal: 0.5.w, vertical: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      child: Row(
        children: [
          // name
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // image
          Expanded(
            flex: 2,
            child: Center(
              child: CircleAvatar(
                radius: 35.r,
                backgroundColor: AppColors.grey2.withOpacity(0.3),
                backgroundImage:
                image.isNotEmpty ? NetworkImage(image) : null,
                child: image.isEmpty
                    ? Icon(Icons.image_not_supported,
                    color: AppColors.grey1, size: 35)
                    : null,
              ),
            ),
          ),

          // social media
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                socialmediaInstagram.isNotEmpty
                    ? GestureDetector(
                  onTap: () => _launchURL(socialmediaInstagram),
                  child: const Text(
                    'Instagram',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
                    : const SizedBox.shrink(),
                SizedBox(height: 4.h),
                socialmediaFacebook.isNotEmpty
                    ? GestureDetector(
                  onTap: () => _launchURL(socialmediaFacebook),
                  child: const Text(
                    'Facebook',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
                    : const SizedBox.shrink(),
              ],
            ),
          ),

          // location (clickable)
          Expanded(
            flex: 2,
            child: location.isNotEmpty
                ? GestureDetector(
              onTap: () => _launchURL(location),
              child: Text(
                location,
                style: const TextStyle(
                  color: Colors.blueAccent,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
            )
                : const Text(
              ' ',
              style: TextStyle(color: AppColors.white),
              textAlign: TextAlign.center,
            ),
          ),

          // phone numbers
          Expanded(
            flex: 2,
            child: Text(
              numbers,
              style: const TextStyle(color: AppColors.white),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // delete button
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
