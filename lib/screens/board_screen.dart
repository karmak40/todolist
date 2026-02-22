import 'package:flutter/material.dart';
import '../models/board.dart';
import '../constants/app_constants.dart';
import '../providers/board_provider.dart';

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
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Add button
                      GestureDetector(
                        onTap: () {
                          // Handle add task to this board
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Добавить задание в ${board.name}'),
                              duration: const Duration(milliseconds: 1500),
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
                      const SizedBox(height: 12),
                      // Active tasks count
                      Text(
                        '$activeCount активных заданий',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppConstants.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Board name
                      Row(
                        children: [
                          Text(
                            board.icon,
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              board.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.textColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppConstants.accentColor,
        onPressed: () {
          _showAddBoardDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _showAddBoardDialog(BuildContext context) {
    final nameController = TextEditingController();
    final iconController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppConstants.cardBackgroundColor,
          title: const Text(
            'Добавить доску',
            style: TextStyle(
              color: AppConstants.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: const TextStyle(color: AppConstants.textColor),
                decoration: InputDecoration(
                  hintText: 'Название доски',
                  hintStyle: const TextStyle(color: AppConstants.textSecondary),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConstants.textSecondary.withValues(alpha: 0.3)),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConstants.accentColor),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: iconController,
                style: const TextStyle(color: AppConstants.textColor),
                decoration: InputDecoration(
                  hintText: 'Эмодзи (например: 💼)',
                  hintStyle: const TextStyle(color: AppConstants.textSecondary),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConstants.textSecondary.withValues(alpha: 0.3)),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConstants.accentColor),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Отмена',
                style: TextStyle(color: AppConstants.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  final newBoard = Board(
                    id: DateTime.now().toString(),
                    name: nameController.text,
                    icon: iconController.text.isEmpty ? '📋' : iconController.text.characters.first,
                  );
                  widget.boardProvider.addBoard(newBoard);
                  Navigator.pop(context);
                  setState(() {});
                }
              },
              child: const Text(
                'Добавить',
                style: TextStyle(color: AppConstants.accentColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
