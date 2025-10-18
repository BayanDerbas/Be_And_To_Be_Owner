import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../branches/domain/entities/branch_entity.dart';

class CustomAddAdminDialog extends StatefulWidget {
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
  State<CustomAddAdminDialog> createState() => _CustomAddAdminDialogState();
}

class _CustomAddAdminDialogState extends State<CustomAddAdminDialog> {
  BranchEntity? _selectedBranch;

  @override
  void initState() {
    super.initState();
    _selectedBranch = widget.selectedBranch;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.smooky,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 300.w,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: widget.nameController,
                  decoration: const InputDecoration(hintText: 'الاسم'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: widget.phoneController,
                  decoration: const InputDecoration(hintText: 'رقم الهاتف'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: widget.passwordController,
                  decoration: const InputDecoration(hintText: 'كلمة السر'),
                ),
                const SizedBox(height: 10),

                Container(
                  height: 48.h,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.smooky2,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.amber),
                  ),
                  child: DropdownButton<BranchEntity>(
                    value: _selectedBranch,
                    hint: const Text(
                      "اختر الفرع",
                      style: TextStyle(color: AppColors.grey1),
                    ),
                    isExpanded: true,
                    underline: const SizedBox(),
                    dropdownColor: AppColors.smooky2,
                    borderRadius: BorderRadius.circular(10),
                    iconEnabledColor: AppColors.amber,
                    items: widget.branches.map((branch) {
                      return DropdownMenuItem(
                        value: branch,
                        child: Text(
                          branch.branch_name ?? '',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (branch) {
                      if (branch != null) {
                        setState(() => _selectedBranch = branch);
                        widget.onBranchSelected(branch);
                      }
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
                      onPressed: widget.onAdd,
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

