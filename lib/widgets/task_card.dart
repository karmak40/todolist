import 'package:flutter/material.dart';
import '../models/task.dart';
import '../utils/date_utils.dart';
import '../constants/app_constants.dart';
import '../providers/board_provider.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final int index;
  final BoardProvider? boardProvider;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.index,
    this.boardProvider,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = AppConstants.getBoardCardColor(index);
    
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        color: cardColor.withValues(alpha: 0.15),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // User avatar
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppConstants.primaryDarkBg,
                    child: task.userIcon != null
                        ? Image.asset(
                            task.userIcon!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.person, color: AppConstants.textSecondary),
                  ),
                  const SizedBox(width: 12),
                  // Title and time
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.textColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          formatTime(task.durationMinutes),
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppConstants.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Checkbox circle with black checkmark and board name
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: cardColor,
                              width: 2,
                            ),
                            color: task.isCompleted ? cardColor : Colors.transparent,
                          ),
                          child: task.isCompleted
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.black,
                                  size: 16,
                                )
                              : null,
                        ),
                        if (task.boardId != null && boardProvider != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Builder(
                              builder: (context) {
                                try {
                                  final board = boardProvider!.boards
                                      .firstWhere((b) => b.id == task.boardId);
                                  return Text(
                                    board.name,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppConstants.textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                } catch (e) {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Description
              Padding(
                padding: const EdgeInsets.only(left: 52),
                child: Text(
                  task.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: task.isCompleted 
                        ? AppConstants.textSecondary
                        : AppConstants.textColor,
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
