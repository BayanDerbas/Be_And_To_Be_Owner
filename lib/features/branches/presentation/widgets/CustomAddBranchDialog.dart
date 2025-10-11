import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';

class CustomAddBranchDialog extends StatefulWidget {
  final Function({
  required String name,
  required String length,
  required String width,
  required String instagramtoken,
  required String facebooktoken,
  required List<String> phones,
  required XFile image,
  }) onAdd;

  const CustomAddBranchDialog({super.key, required this.onAdd});

  @override
  State<CustomAddBranchDialog> createState() => _CustomAddBranchDialogState();
}

class _CustomAddBranchDialogState extends State<CustomAddBranchDialog> {
  final _nameController = TextEditingController();
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  final _instagramController = TextEditingController();
  final _facebookController = TextEditingController();
  final List<TextEditingController> _phoneControllers = [TextEditingController()];
  XFile? pickedImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => pickedImage = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        backgroundColor: AppColors.smooky,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildField("اسم الفرع", _nameController),
                const SizedBox(height: 8),
                _buildField("الطول", _lengthController),
                const SizedBox(height: 8),
                _buildField("العرض", _widthController),
                const SizedBox(height: 8),
                _buildField("رابط الانستغرام", _instagramController),
                const SizedBox(height: 8),
                _buildField("رابط الفيسبوك", _facebookController),

                const SizedBox(height: 10),
                Text("أرقام الهاتف", style: const TextStyle(color: Colors.white)),
                ..._phoneControllers.map((controller) => Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _buildField("رقم الهاتف", controller),
                )),
                TextButton(
                  onPressed: () {
                    setState(() => _phoneControllers.add(TextEditingController()));
                  },
                  child: const Text("+ إضافة رقم", style: TextStyle(color: AppColors.amber)),
                ),

                InkWell(
                  onTap: pickImage,
                  child: Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      color: AppColors.smooky2,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.amber, width: 2),
                    ),
                    child: pickedImage == null
                        ? const Center(child: Text("اختر صورة", style: TextStyle(color: AppColors.grey1)))
                        : ClipOval(
                      child: kIsWeb
                          ? Image.network(pickedImage!.path, fit: BoxFit.cover)
                          : Image.file(File(pickedImage!.path), fit: BoxFit.cover),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('إلغاء', style: TextStyle(color: AppColors.grey1)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.amber),
                      onPressed: pickedImage != null
                          ? () {
                        widget.onAdd(
                          name: _nameController.text.trim(),
                          length: _lengthController.text.trim(),
                          width: _widthController.text.trim(),
                          instagramtoken: _instagramController.text.trim(),
                          facebooktoken: _facebookController.text.trim(),
                          phones: _phoneControllers.map((c) => c.text.trim()).toList(),
                          image: pickedImage!,
                        );
                      }
                          : null,
                      child: const Text("حفظ", style: TextStyle(color: Colors.white)),
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

  Widget _buildField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.grey1),
        filled: true,
        fillColor: AppColors.smooky2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }
}
