import 'package:flutter/material.dart';
import '../utils/date_utils.dart';
import '../constants/app_constants.dart';

class WeekNavigation extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  const WeekNavigation({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    final startOfWeek = getStartOfWeek();
    
    return SizedBox(
      height: 80,
      child: Row(
        children: List.generate(7, (index) {
          final date = startOfWeek.add(Duration(days: index));
          final isSelected = isSameDay(date, selectedDate);

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () => onDateChanged(date),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? AppConstants.accentColor 
                        : AppConstants.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        getShortDayName(date.weekday),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isSelected 
                              ? AppConstants.textColor 
                              : AppConstants.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${date.day}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isSelected 
                              ? AppConstants.textColor 
                              : AppConstants.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
