import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../providers/board_provider.dart';
import 'dialog_add_task.dart';

class BoardScreen extends StatefulWidget {
  final BoardProvider boardProvider;

  const BoardScreen({
    super.key,
    required this.boardProvider,
  });

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryDarkBg,
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: widget.boardProvider.boards.length,
          itemBuilder: (context, index) {
            final board = widget.boardProvider.boards[index];
            final boardColor = AppConstants.getBoardCardColor(index);
            final activeCount = widget.boardProvider.getActiveBoardTaskCount(board.id);

            return GestureDetector(
              onTap: () {
                // Handle board tap
              },
              child: Card(
                color: boardColor.withValues(alpha: 0.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                  side: BorderSide(
                    color: boardColor.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Board name with icon
                      Row(
                        children: [
                          Text(
                            board.icon,
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  board.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppConstants.textColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$activeCount активных заданий',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppConstants.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Add button
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AddTaskDialog(
                                  initialDate: DateTime.now(),
                                  boardProvider: widget.boardProvider,
                                  initialBoardId: board.id,
                                  onTaskAdded: (task) async {
                                    await widget.boardProvider.addTaskToBoard(board.id, task);
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Задание добавлено в ${board.name}'),
                                        duration: const Duration(milliseconds: 1500),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: boardColor.withValues(alpha: 0.25),
                                border: Border.all(
                                  color: boardColor,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                color: boardColor,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
