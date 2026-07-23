import 'package:flutter/material.dart';
import 'package:wafferxp/core/res/theme.dart';
import 'package:wafferxp/features/profile/view/widgets/saving_goal_card.dart';
import 'package:wafferxp/features/profile/view/widgets/balance_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              const BalanceCard(), // Your new reusable widget
              const SizedBox(height: 24),
              Text(
                "الخدمات السريعة",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(height: 16),
              _buildQuickServices(),
              const SizedBox(height: 24),
              SavingGoalCard(),
              const SizedBox(height: 24),
              Text(
                "آخر العمليات",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(height: 16),
              _buildTransactionList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Icon(Icons.notifications_none, size: 28),
      Text("مرحباً، محمد", style: AppTheme.lightTheme.textTheme.headlineMedium),
      CircleAvatar(
        backgroundColor: AppColors.white,
        child: Icon(Icons.person, color: AppColors.primaryBlue),
      ),
    ],
  );

  Widget _buildQuickServices() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _serviceItem(Icons.payment, "بطاقات"),
      _serviceItem(Icons.account_balance_wallet, "مدفوعات"),
      _serviceItem(Icons.calculate, "سداد"),
      _serviceItem(Icons.swap_horiz, "تحويل"),
    ],
  );

  Widget _serviceItem(IconData icon, String label) => Column(
    children: [
      CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.white,
        child: Icon(icon, color: AppColors.primaryBlue),
      ),
      const SizedBox(height: 8),
      Text(label),
    ],
  );

  Widget _buildTransactionList() => ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 3,
    separatorBuilder: (ctx, i) => const Divider(),
    itemBuilder: (ctx, i) => ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.white,
        child: Icon(Icons.history),
      ),
      title: Text("تحويل محلي"),
      subtitle: Text("اليوم 10:20 ص"),
      trailing: Text(
        "-250.00 SAR",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}
