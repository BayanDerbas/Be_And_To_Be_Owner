import 'package:flutter/material.dart';
import 'package:untitled/core/constants/app_colors.dart';

class CustomAdminTile extends StatelessWidget {
  final String name;
  final String phone;
  final String branch;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CustomAdminTile({
    super.key,
    required this.name,
    required this.phone,
    required this.branch,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.smooky2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(name, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center),
            ),
            Expanded(
              flex: 2,
              child: Text(phone, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center),
            ),
            Expanded(
              flex: 2,
              child: Text(branch, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete, color: Colors.redAccent, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}