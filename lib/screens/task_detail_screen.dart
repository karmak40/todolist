import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/user.dart';
import '../constants/app_constants.dart';
import '../utils/date_utils.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;
  final User user;

  const TaskDetailScreen({
    super.key,
    required this.task,
    required this.user,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late ValueNotifier<double> completeSliderValue;
  late ValueNotifier<double> cancelSliderValue;
  bool showCompleted = false;
  bool taskCompleted = false; // Track if task was just completed

  @override
  void initState() {
    super.initState();
    completeSliderValue = ValueNotifier(0.0);
    cancelSliderValue = ValueNotifier(0.0);
    taskCompleted = widget.task.isCompleted;
  }

  @override
  void dispose() {
    completeSliderValue.dispose();
    cancelSliderValue.dispose();
    super.dispose();
  }

  String getRemainingTime() {
    final now = DateTime.now();
    if (widget.task.date.isBefore(now)) {
      return 'Истекла';
    }
    final difference = widget.task.date.difference(now);
    if (difference.inDays > 0) {
      return '${difference.inDays} дн';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ч';
    } else {
      return '${difference.inMinutes} мин';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryDarkBg,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryDarkBg,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppConstants.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                widget.task.title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.textColor,
                ),
              ),
              const SizedBox(height: 24),

              // Time and User Info Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side: Time info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Осталось времени',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppConstants.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          getRemainingTime(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.accentColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Время на задание',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppConstants.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formatTime(widget.task.durationMinutes),
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppConstants.textColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Дата',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppConstants.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formatDate(widget.task.date),
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppConstants.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Right side: Assigned user
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Назначено',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppConstants.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppConstants.cardBackgroundColor,
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: AppConstants.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Additional Description
              Text(
                'Дополнительное описание',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.textColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.task.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppConstants.textSecondary,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 32),

              // Created Info
              Text(
                'Создано',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.textColor,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatDate(DateTime.now()),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppConstants.textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.user.name,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppConstants.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppConstants.cardBackgroundColor,
                    child: const Icon(
                      Icons.person,
                      size: 32,
                      color: AppConstants.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // iPhone-style Sliders - Show only one at a time
              if (!showCompleted)
                if (!taskCompleted)
                  // Complete Task Slider - Swipe Right
                  Center(
                    child: ValueListenableBuilder<double>(
                      valueListenable: completeSliderValue,
                      builder: (context, value, _) {
                        return GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            if (details.delta.dx > 0) {
                              completeSliderValue.value = (completeSliderValue.value + details.delta.dx / 300).clamp(0, 1);
                            }
                          },
                          onHorizontalDragEnd: (details) {
                            if (completeSliderValue.value >= 0.95) {
                              setState(() {
                                showCompleted = true;
                                taskCompleted = true;
                              });
                              
                              // After delay, pop with result true
                              final nav = Navigator.of(context);
                              Future.delayed(const Duration(milliseconds: 800), () {
                                if (mounted) {
                                  nav.pop(true);
                                }
                              });
                            } else {
                              completeSliderValue.value = 0;
                            }
                          },
                          child: SizedBox(
                            width: 280,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                color: AppConstants.cardBackgroundColor,
                                borderRadius: BorderRadius.circular(
                                  AppConstants.borderRadiusMedium,
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  // Background text
                                  Positioned.fill(
                                    child: Center(
                                      child: Text(
                                        value >= 0.95 
                                            ? 'Отпустите!' 
                                            : 'Тяните вправо →',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppConstants.textSecondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Draggable thumb
                                  Align(
                                    alignment: Alignment(value * 2 - 1, 0),
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppConstants.accentColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppConstants.accentColor.withValues(alpha: 0.4),
                                            blurRadius: 8,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                else
                  // Cancel Task Slider - Swipe Left (shown after task is marked complete)
                  Center(
                    child: ValueListenableBuilder<double>(
                      valueListenable: cancelSliderValue,
                      builder: (context, value, _) {
                        return GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            if (details.delta.dx < 0) {
                              cancelSliderValue.value = (cancelSliderValue.value - details.delta.dx / 300).clamp(0, 1);
                            }
                          },
                          onHorizontalDragEnd: (details) {
                            if (cancelSliderValue.value >= 0.95) {
                              // Cancel completion and go back
                              final nav = Navigator.of(context);
                              nav.pop(false);
                            } else {
                              cancelSliderValue.value = 0;
                            }
                          },
                          child: SizedBox(
                            width: 280,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                color: AppConstants.cardBackgroundColor,
                                borderRadius: BorderRadius.circular(
                                  AppConstants.borderRadiusMedium,
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  // Background text
                                  Positioned.fill(
                                    child: Center(
                                      child: Text(
                                        value >= 0.95 
                                            ? 'Отпустите!' 
                                            : '← Тяните влево',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppConstants.textSecondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Draggable thumb
                                  Align(
                                    alignment: Alignment(1 - value * 2, 0),
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red.withValues(alpha: 0.8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.red.withValues(alpha: 0.4),
                                            blurRadius: 8,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
              else
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                      decoration: BoxDecoration(
                        color: AppConstants.cardBackgroundColor,
                        borderRadius: BorderRadius.circular(
                          AppConstants.borderRadiusMedium,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 80,
                            color: AppConstants.greenColor,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Задание выполнено!',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppConstants.greenColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
