import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/features/branches/domain/entities/branch_entity.dart';
import '../../../../../../core/constants/app_colors.dart';

class CustomAddCategoriesDialog extends StatelessWidget {
  final TextEditingController nameController;
  final VoidCallback onPickImage;
  final XFile? pickedImagePath;
  final List<BranchEntity> branches;
  final BranchEntity? selectedBranch;
  final Function(BranchEntity) onBranchSelected;
  final VoidCallback onAdd;

  const CustomAddCategoriesDialog({
    super.key,
    required this.nameController,
    required this.onPickImage,
    required this.pickedImagePath,
    required this.branches,
    required this.selectedBranch,
    required this.onBranchSelected,
    required this.onAdd,
  });

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
                  style: const TextStyle(color: AppColors.white),
                  decoration: InputDecoration(
                    hintText: 'الاسم',
                    hintStyle: const TextStyle(color: AppColors.grey1),
                    filled: true,
                    fillColor: AppColors.smooky2,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                  ),
                ),
                const SizedBox(height: 10),

                InkWell(
                  onTap: onPickImage,
                  child: Container(
                    height: 190,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.smooky2,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: pickedImagePath == null
                        ? const Center(
                      child: Text(
                        "اختر صورة",
                        style: TextStyle(color: AppColors.grey1),
                      ),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: kIsWeb
                          ? Image.network(
                        pickedImagePath!.path,
                        fit: BoxFit.cover,
                      )
                          : Image.file(
                        File(pickedImagePath!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.smooky2,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.amber),
                  ),
                  child: DropdownButton<BranchEntity>(
                    value: selectedBranch,
                    hint: const Text(
                      "اختر الفرع",
                      style: TextStyle(color: AppColors.grey1),
                    ),
                    isExpanded: true,
                    underline: const SizedBox(),
                    dropdownColor: AppColors.smooky2,
                    borderRadius: BorderRadius.circular(10),
                    iconEnabledColor: AppColors.amber,
                    items: branches.map((branch) {
                      return DropdownMenuItem<BranchEntity>(
                        value: branch,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4),
                          child: Text(
                            branch.branch_name ?? '',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (branch) {
                      if (branch != null) onBranchSelected(branch);
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text(
                        'إلغاء',
                        style: TextStyle(color: AppColors.grey1),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: onAdd,
                      child: const Text(
                        'حفظ',
                        style: TextStyle(color: Colors.white),
                      ),
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
