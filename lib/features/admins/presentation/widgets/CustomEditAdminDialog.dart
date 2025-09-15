import 'package:flutter/material.dart';
import 'package:untitled/features/branches/domain/entities/branch_entity.dart';
import '../../../../../../core/constants/app_colors.dart';

class CustomEditAdminDialog extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController branchController;
  final VoidCallback onSave;
  final List<BranchEntity> branches;
  final BranchEntity? selectedBranch;
  final Function(BranchEntity) onBranchSelected;

  const CustomEditAdminDialog({
    super.key,
    required this.onSave,
    required this.nameController,
    required this.phoneController,
    required this.passwordController,
    required this.branchController,
    required this.branches,
    this.selectedBranch,
    required this.onBranchSelected,
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
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text Fields
                TextField(
                  controller: nameController,
                  decoration: _inputDecoration('الاسم'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  decoration: _inputDecoration('رقم الهاتف'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  decoration: _inputDecoration('كلمة السر'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: branchController,
                  decoration: _inputDecoration('الفرع'),
                ),
                const SizedBox(height: 20),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'إلغاء',
                        style: TextStyle(color: AppColors.grey1),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: onSave,
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
