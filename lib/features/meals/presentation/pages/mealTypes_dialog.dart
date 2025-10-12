import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/networks/api_constant.dart';

class MealTypesDialog extends StatelessWidget {
  final String mealName;
  final String mealImage;
  final String description;
  final int price;
  final int extraPrice;
  final String availble;
  final VoidCallback onDelete;
  final Function(int newPrice, int newExtraPrice) onEdit;

  const MealTypesDialog({
    super.key,
    required this.mealName,
    required this.mealImage,
    required this.description,
    required this.price,
    required this.extraPrice,
    required this.availble,
    required this.onDelete,
    required this.onEdit,
  });

  bool get isAvailable =>
      availble == "1" ||
          availble.toLowerCase() == "available" ||
          availble == "متاحة";

  bool get hasExtra => extraPrice > 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.smooky,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: AppColors.amber, width: 1.5),
      ),
      title: Column(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: CachedNetworkImageProvider(
              '${ApiConstant.imageBase}$mealImage',
            ),
            backgroundColor: AppColors.grey2,
          ),
          const SizedBox(height: 12),
          Text(
            mealName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'السعر: $price ل.س',
            style: const TextStyle(color: AppColors.amber, fontSize: 16),
          ),
          if (hasExtra) ...[
            const SizedBox(height: 6),
            Text(
              'سعر إضافي: $extraPrice ل.س',
              style: const TextStyle(color: Colors.lightGreenAccent, fontSize: 15),
            ),
          ],
          const SizedBox(height: 10),
          Text(
            isAvailable ? '✅ متاحة' : '❌ غير متاحة',
            style: TextStyle(
              color: isAvailable ? Colors.greenAccent : Colors.redAccent,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "هل تريد حذف أو تعديل هذا النوع؟ ",
              style: TextStyle(color: AppColors.grey),
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
                onDelete();
              },
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              tooltip: "حذف النوع",
            ),
            IconButton(
              onPressed: () async {
                final result = await showDialog<Map<String, int>>(
                  context: context,
                  builder: (context) {
                    final priceController =
                    TextEditingController(text: price.toString());
                    final extraController =
                    TextEditingController(text: extraPrice.toString());
                    return AlertDialog(
                      backgroundColor: AppColors.smooky,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                            color: AppColors.amber, width: 1.5),
                      ),
                      title: const Text(
                        "تعديل الأسعار",
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: AppColors.white),
                            decoration: const InputDecoration(
                              labelText: "السعر الأساسي",
                              labelStyle: TextStyle(color: AppColors.grey),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: extraController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: AppColors.white),
                            decoration: const InputDecoration(
                              labelText: "السعر الإضافي",
                              labelStyle: TextStyle(color: AppColors.grey),
                            ),
                          ),
                        ],
                      ),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, {
                              "price": int.tryParse(priceController.text) ?? price,
                              "extraPrice":
                              int.tryParse(extraController.text) ??
                                  extraPrice,
                            });
                          },
                          child: const Text(
                            "حفظ",
                            style: TextStyle(
                                color: AppColors.amber,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "إلغاء",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
                    );
                  },
                );

                if (result != null) {
                  onEdit(result["price"]!, result["extraPrice"]!);
                }
              },
              icon: const Icon(Icons.edit, color: AppColors.white),
              tooltip: "تعديل الأسعار",
            ),
          ],
        ),
        TextButton(
          onPressed: () => context.pop(),
          style: TextButton.styleFrom(foregroundColor: AppColors.amber),
          child: const Text(
            "إغلاق",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
