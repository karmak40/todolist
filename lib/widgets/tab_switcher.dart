import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class TabSwitcher extends StatelessWidget {
  final bool isFirstTabSelected;
  final String firstTabLabel;
  final String secondTabLabel;
  final ValueChanged<bool> onTabChanged;

  const TabSwitcher({
    super.key,
    required this.isFirstTabSelected,
    required this.firstTabLabel,
    required this.secondTabLabel,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onTabChanged(true),
            child: Column(
              children: [
                Text(
                  firstTabLabel,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isFirstTabSelected 
                        ? AppConstants.textActiveTab 
                        : AppConstants.textInactiveTab,
                  ),
                ),
                if (isFirstTabSelected)
                  Container(
                    height: 3,
                    width: 40,
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: AppConstants.textActiveTab,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => onTabChanged(false),
            child: Column(
              children: [
                Text(
                  secondTabLabel,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:
                        !isFirstTabSelected 
                            ? AppConstants.textActiveTab 
                            : AppConstants.textInactiveTab,
                  ),
                ),
                if (!isFirstTabSelected)
                  Container(
                    height: 3,
                    width: 40,
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: AppConstants.textActiveTab,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
