import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/features/branches/domain/entities/branch_entity.dart';
import '../../../../../../core/constants/app_colors.dart';

class CustomAddCategoriesDialog extends StatefulWidget {
  final TextEditingController nameController;
  final List<BranchEntity> branches;
  final Function(BranchEntity) onBranchSelected;
  final Function(String name, XFile image, BranchEntity branch) onAdd;

  const CustomAddCategoriesDialog({
    super.key,
    required this.nameController,
    required this.branches,
    required this.onBranchSelected,
    required this.onAdd,
  });

  @override
  State<CustomAddCategoriesDialog> createState() =>
      _CustomAddCategoriesDialogState();
}

class _CustomAddCategoriesDialogState extends State<CustomAddCategoriesDialog> {
  XFile? pickedImage;
  BranchEntity? selectedBranch;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        pickedImage = picked;
      });
    }
  }

  bool get isFormValid => pickedImage != null && selectedBranch != null;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
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
                    controller: widget.nameController,
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

                  // Circle image picker
                  InkWell(
                    onTap: pickImage,
                    child: Container(
                      height: 190,
                      width: 190,
                      decoration: BoxDecoration(
                        color: AppColors.smooky2,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.amber, width: 2),
                      ),
                      child: pickedImage == null
                          ? const Center(
                        child: Text(
                          "اختر صورة",
                          style: TextStyle(color: AppColors.grey1),
                          textAlign: TextAlign.center,
                        ),
                      )
                          : ClipOval(
                        child: kIsWeb
                            ? Image.network(
                          pickedImage!.path,
                          fit: BoxFit.cover,
                          width: 190,
                          height: 190,
                        )
                            : Image.file(
                          File(pickedImage!.path),
                          fit: BoxFit.cover,
                          width: 190,
                          height: 190,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Branch dropdown
                  Container(
                    height: 48,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                      items: widget.branches.map((branch) {
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
                        setState(() {
                          selectedBranch = branch;
                        });
                        if (branch != null) widget.onBranchSelected(branch);
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
                        onPressed: isFormValid
                            ? () {
                          widget.onAdd(
                            widget.nameController.text,
                            pickedImage!,
                            selectedBranch!,
                          );
                          context.pop();
                        }
                            : null,
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
      ),
    );
  }
}