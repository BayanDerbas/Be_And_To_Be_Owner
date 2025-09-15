import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/constants/app_colors.dart';
import 'dart:io';

class CustomEditCategoriesDialog extends StatelessWidget {
  final TextEditingController nameController;
  final String? pickedImagePath;
  final VoidCallback onPickImage;
  final List<String> branches;
  final String? selectedBranch;
  final Function(String) onBranchSelected;
  final VoidCallback onSave;

  const CustomEditCategoriesDialog({
    super.key,
    required this.nameController,
    required this.pickedImagePath,
    required this.onPickImage,
    required this.branches,
    required this.selectedBranch,
    required this.onBranchSelected,
    required this.onSave,
  });

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.grey1),
      filled: true,
      fillColor: AppColors.smooky2,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.amber),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.amber),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.amber, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.smooky,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 320,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: _inputDecoration('الاسم'),
                ),
                const SizedBox(height: 10),

                InkWell(
                  onTap: onPickImage,
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    color: Colors.grey[800],
                    child: pickedImagePath == null
                        ? const Center(child: Text("اختر صورة", style: TextStyle(color: Colors.white)))
                        : Image.file(File(pickedImagePath!), fit: BoxFit.cover),
                  ),
                ),

                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: selectedBranch,
                  hint: const Text("اختر الفرع"),
                  isExpanded: true,
                  items: branches.map((branch) {
                    return DropdownMenuItem(
                      value: branch,
                      child: Text(branch),
                    );
                  }).toList(),
                  onChanged: (branch) {
                    if (branch != null) onBranchSelected(branch);
                  },
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('إلغاء', style: TextStyle(color: AppColors.grey1)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: onSave,
                      child: const Text('حفظ', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
