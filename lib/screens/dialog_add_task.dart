import 'package:flutter/material.dart';
import '../models/task.dart';
import '../constants/app_constants.dart';
import '../providers/board_provider.dart';

class AddTaskDialog extends StatefulWidget {
  final DateTime initialDate;
  final Function(Task) onTaskAdded;
  final BoardProvider? boardProvider;
  final String? initialBoardId;

  const AddTaskDialog({
    super.key,
    required this.initialDate,
    required this.onTaskAdded,
    this.boardProvider,
    this.initialBoardId,
  });

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController durationController;
  late DateTime selectedDate;
  String? selectedBoardId;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    durationController = TextEditingController(text: '30');
    selectedDate = widget.initialDate;
    // Set board based on initialBoardId or first available board
    if (widget.initialBoardId != null) {
      selectedBoardId = widget.initialBoardId;
    } else if (widget.boardProvider != null && widget.boardProvider!.boards.isNotEmpty) {
      selectedBoardId = widget.boardProvider!.boards.first.id;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    durationController.dispose();
    super.dispose();
  }

  void _addTask() {
    if (titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, введите название задачи')),
      );
      return;
    }

    final task = Task(
      id: DateTime.now().toString(),
      title: titleController.text,
      description: descriptionController.text,
      durationMinutes: int.tryParse(durationController.text) ?? 30,
      date: selectedDate,
      boardId: selectedBoardId,
    );

    widget.onTaskAdded(task);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppConstants.cardBackgroundColor,
      title: const Text(
        'Добавить новую задачу',
        style: TextStyle(color: AppConstants.textColor),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(color: AppConstants.textColor),
              decoration: const InputDecoration(
                labelText: 'Название',
                hintText: 'Введите название задачи',
                hintStyle: TextStyle(color: AppConstants.textSecondary),
                labelStyle: TextStyle(color: AppConstants.textSecondary),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppConstants.textSecondary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppConstants.accentColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              style: const TextStyle(color: AppConstants.textColor),
              decoration: const InputDecoration(
                labelText: 'Описание',
                hintText: 'Введите описание задачи',
                hintStyle: TextStyle(color: AppConstants.textSecondary),
                labelStyle: TextStyle(color: AppConstants.textSecondary),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppConstants.textSecondary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppConstants.accentColor),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: durationController,
              style: const TextStyle(color: AppConstants.textColor),
              decoration: const InputDecoration(
                labelText: 'Длительность (минут)',
                hintText: '30',
                hintStyle: TextStyle(color: AppConstants.textSecondary),
                labelStyle: TextStyle(color: AppConstants.textSecondary),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppConstants.textSecondary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppConstants.accentColor),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            // Board Dropdown
            if (widget.boardProvider != null && widget.boardProvider!.boards.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Доска:',
                    style: TextStyle(
                      color: AppConstants.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppConstants.textSecondary),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownButton<String>(
                      value: selectedBoardId,
                      isExpanded: true,
                      dropdownColor: AppConstants.cardBackgroundColor,
                      style: const TextStyle(color: AppConstants.textColor),
                      items: widget.boardProvider!.boards
                          .map((board) => DropdownMenuItem(
                                value: board.id,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Text(board.icon, style: const TextStyle(fontSize: 18)),
                                      const SizedBox(width: 8),
                                      Text(board.name),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedBoardId = value;
                          });
                        }
                      },
                      underline: const SizedBox(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            Row(
              children: [
                const Text(
                  'Дата:',
                  style: TextStyle(color: AppConstants.textColor),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          const Duration(days: 365),
                        ),
                      );
                      if (date != null) {
                        setState(() {
                          selectedDate = date;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppConstants.textSecondary),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppConstants.textColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Отмена',
            style: TextStyle(color: AppConstants.textSecondary),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.accentColor,
            foregroundColor: AppConstants.textColor,
          ),
          onPressed: _addTask,
          child: const Text('Добавить'),
        ),
      ],
    );
  }
}
