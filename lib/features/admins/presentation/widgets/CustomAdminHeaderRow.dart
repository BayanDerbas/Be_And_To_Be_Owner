import 'package:flutter/material.dart';
import 'package:untitled/core/constants/app_colors.dart';

class CustomAdminHeaderRow extends StatelessWidget {
  const CustomAdminHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.smooky,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: const [
          Expanded(
            flex: 2,
            child: Text(
              "الاسم",
              style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "رقم الهاتف",
              style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "كلمة السر",
              style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "الفرع",
              style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "الإجراءات",
              style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}