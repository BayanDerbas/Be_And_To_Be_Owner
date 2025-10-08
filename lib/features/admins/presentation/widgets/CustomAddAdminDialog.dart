import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../branches/domain/entities/branch_entity.dart';

class CustomAddAdminDialog extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;

  final List<BranchEntity> branches;
  final BranchEntity? selectedBranch;
  final Function(BranchEntity) onBranchSelected;
  final VoidCallback onAdd;

  const CustomAddAdminDialog({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.passwordController,
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
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'الاسم'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(hintText: 'رقم الهاتف'),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                      return DropdownMenuItem(
                        value: branch,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                          child: Text(
                            branch.branch_name!,
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
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إلغاء', style: TextStyle(color: AppColors.grey1)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: onAdd,
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
