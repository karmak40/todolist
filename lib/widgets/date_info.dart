import 'package:flutter/material.dart';
import '../utils/date_utils.dart';
import '../constants/app_constants.dart';

class DateInfo extends StatelessWidget {
  final DateTime selectedDate;
  final int? completionPercentage;

  const DateInfo({
    super.key,
    required this.selectedDate,
    this.completionPercentage,
  });

  @override
  Widget build(BuildContext context) {
    final isToday = isSameDay(selectedDate, DateTime.now());
    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppConstants.textColor,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isToday
                  ? 'Сегодня (${getDayName(DateTime.now().weekday)})'
                  : getDayName(selectedDate.weekday),
              style: textStyle,
            ),
            Text(
              formatDate(selectedDate),
              style: const TextStyle(
                fontSize: 14,
                color: AppConstants.textSecondary,
              ),
            ),
          ],
        ),
        if (isToday && completionPercentage != null)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppConstants.cardBackgroundColor,
              border: Border.all(
                color: AppConstants.accentColor,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Text(
                  '$completionPercentage%',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.accentColor,
                  ),
                ),
                Text(
                  'выполнено',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppConstants.textSecondary,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
