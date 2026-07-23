// lib/features/profile/view/widgets/saving_goal_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wafferxp/core/res/theme.dart';

class SavingGoalCard extends StatelessWidget {
  const SavingGoalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.accentYellow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/icons/hand_coin.svg',
            width: 50,
            height: 50,
            // This forces the SVG to take the color of your design
            colorFilter: const ColorFilter.mode(
              AppColors.primaryBlue,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "وفر XP",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Text("حول الادخار إلى إنجاز"),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("ابدأ الادخار"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
