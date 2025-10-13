import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';

class CustomAddMealDialog extends StatefulWidget {
  final Function({
  required String mealName,
  required String description,
  required XFile image,
  required int price,
  required int extraPrice,
  required int tExtraPrice,
  int? hasTypes,
  List<String>? typeNames,
  List<int>? typePrices,
  List<int>? typeExtraPrices,
  }) onAdd;


  const CustomAddMealDialog({super.key, required this.onAdd});

  @override
  State<CustomAddMealDialog> createState() => _CustomAddMealDialogState();
}

class _CustomAddMealDialogState extends State<CustomAddMealDialog> {
  final _mealNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _extraPriceController = TextEditingController(text: "0");
  final _tExtraPriceController = TextEditingController();

  XFile? _image;
  bool _hasTypes = false;

  final List<TextEditingController> _typeNameControllers = [];
  final List<TextEditingController> _typePriceControllers = [];
  final List<TextEditingController> _typeExtraPriceControllers = [];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _image = picked);
  }

  void _addTypeField() {
    setState(() {
      _hasTypes = true;
      _typeNameControllers.add(TextEditingController());
      _typePriceControllers.add(TextEditingController());
      _typeExtraPriceControllers.add(TextEditingController());
    });
  }

  void _removeTypeField(int index) {
    setState(() {
      _typeNameControllers.removeAt(index);
      _typePriceControllers.removeAt(index);
      _typeExtraPriceControllers.removeAt(index);
      if (_typeNameControllers.isEmpty) {
        _hasTypes = false;
      }
    });
  }

  Widget _buildField(String hint, TextEditingController controller,
      {TextInputType type = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: type,
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
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
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
                _buildField("اسم الوجبة", _mealNameController),
                const SizedBox(height: 8),
                _buildField("الوصف", _descriptionController),
                const SizedBox(height: 8),
                _buildField("السعر", _priceController,
                    type: TextInputType.number),
                Row(
                  children: [
                    const Text("هل الوجبة مدعومة؟",
                        style: TextStyle(color: Colors.white)),
                    const Spacer(),
                    StatefulBuilder(
                      builder: (context, setSwitchState) {
                        bool isSupported = _extraPriceController.text == "1";
                        return Switch(
                          value: isSupported,
                          activeColor: AppColors.amber,
                          onChanged: (val) {
                            setSwitchState(() {
                              _extraPriceController.text = val ? "1" : "0";
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                _buildField("السعر الإضافي للنوع", _tExtraPriceController,
                    type: TextInputType.number),

                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("هل للوجبة أنواع؟",
                        style: TextStyle(color: Colors.white)),
                    Switch(
                      value: _hasTypes,
                      onChanged: (val) => setState(() => _hasTypes = val),
                      activeColor: AppColors.amber,
                    ),
                  ],
                ),

                if (_hasTypes)
                  Column(
                    children: [
                      for (int i = 0; i < _typeNameControllers.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Expanded(
                                  child: _buildField(
                                      "اسم النوع", _typeNameControllers[i])),
                              const SizedBox(width: 5),
                              Expanded(
                                  child: _buildField("سعر النوع",
                                      _typePriceControllers[i],
                                      type: TextInputType.number)),
                              const SizedBox(width: 5),
                              Expanded(
                                  child: _buildField(
                                      "سعر المدعومة للنوع",
                                      _typeExtraPriceControllers[i],
                                      type: TextInputType.number)),
                              IconButton(
                                icon: const Icon(Icons.remove_circle,
                                    color: Colors.red),
                                onPressed: () => _removeTypeField(i),
                              ),
                            ],
                          ),
                        ),
                      TextButton(
                        onPressed: _addTypeField,
                        child: const Text("+ إضافة نوع جديد",
                            style: TextStyle(color: AppColors.amber)),
                      ),
                    ],
                  ),

                const SizedBox(height: 10),
                InkWell(
                  onTap: _pickImage,
                  child: Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      color: AppColors.smooky2,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.amber, width: 2),
                    ),
                    child: _image == null
                        ? const Center(
                        child: Text("اختر صورة",
                            style: TextStyle(color: AppColors.grey1)))
                        : ClipOval(
                      child: kIsWeb
                          ? Image.network(_image!.path, fit: BoxFit.cover)
                          : Image.file(File(_image!.path),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('إلغاء',
                          style: TextStyle(color: AppColors.grey1)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.amber),
                      onPressed: _image != null
                          ? () {
                        final typeNames =
                        _typeNameControllers.map((c) => c.text).toList();
                        final typePrices = _typePriceControllers
                            .map((c) => int.tryParse(c.text) ?? 0)
                            .toList();
                        final typeExtraPrices = _typeExtraPriceControllers
                            .map((c) => int.tryParse(c.text) ?? 0)
                            .toList();

                        widget.onAdd(
                          mealName: _mealNameController.text.trim(),
                          description: _descriptionController.text.trim(),
                          image: _image!,
                          price: int.tryParse(_priceController.text.trim()) ?? 0,
                          extraPrice: int.tryParse(_extraPriceController.text.trim()) ?? 0,
                          tExtraPrice: int.tryParse(_tExtraPriceController.text.trim()) ?? 0,
                          hasTypes: _hasTypes ? 1 : 0,
                          typeNames: _hasTypes ? typeNames : null,
                          typePrices: _hasTypes ? typePrices : null,
                          typeExtraPrices: _hasTypes ? typeExtraPrices : null,
                          // hasTypes: _hasTypes ? 1 : 0,
                          // typeNames:
                          // _hasTypes ? typeNames : null,
                          // typePrices:
                          // _hasTypes ? typePrices : null,
                          // typeExtraPrices:
                          // _hasTypes ? typeExtraPrices : null,
                        );
                        Navigator.of(context).pop();
                      }
                          : null,
                      child: const Text("إضافة",
                          style: TextStyle(color: Colors.white)),
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
