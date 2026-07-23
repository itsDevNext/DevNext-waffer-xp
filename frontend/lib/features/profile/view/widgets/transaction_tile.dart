import 'package:flutter/material.dart';
import 'package:wafferxp/core/res/theme.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;

  const TransactionTile({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.white,
        child: Icon(icon, color: AppColors.primaryBlue),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: Text(
        amount,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
