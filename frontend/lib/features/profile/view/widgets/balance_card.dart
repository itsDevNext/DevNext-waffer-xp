import 'package:flutter/material.dart';
import 'package:wafferxp/core/res/theme.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.padding),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.borderRadius),
        // Adding a subtle shadow to make it "pop" like in your design
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "إجمالي الرصيد",
            style: TextStyle(color: AppColors.textGrey),
          ),
          const SizedBox(height: 8),
          const Text(
            "20,456.00 SAR",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            "الحساب الجاري | 1234 •••",
            style: TextStyle(color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }
}
