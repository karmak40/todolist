import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/user.dart';
import '../utils/date_utils.dart';
import '../widgets/task_card.dart';
import '../widgets/week_navigation.dart';
import '../constants/app_constants.dart';
import 'dialog_add_task.dart';
import 'task_detail_screen.dart';
import 'board_screen.dart';
import '../providers/board_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime selectedDate;
  late PageController pageController;
  int currentPageIndex = 0;
  final boardProvider = BoardProvider();

  // Sample user
  final user = User(
    id: '1',
    name: 'Пользователь',
    avatarUrl: null,
  );

  // Sample tasks
  final List<Task> allTasks = [
    Task(
      id: '1',
      title: 'Купить продукты',
      description: 'Купить хлеб, молоко, яйца и масло на рынке',
      durationMinutes: 30,
      date: DateTime.now(),
      isCompleted: false,
    ),
    Task(
      id: '2',
      title: 'Написать отчет',
      description: 'Завершить квартальный отчет для начальника',
      durationMinutes: 120,
      date: DateTime.now(),
      isCompleted: true,
    ),
    Task(
      id: '3',
      title: 'Спортзал',
      description: 'Тренировка: 20 минут кардио + силовые упражнения',
      durationMinutes: 90,
      date: DateTime.now(),
      isCompleted: false,
    ),
    Task(
      id: '4',
      title: 'Позвонить маме',
      description: 'Обновить на встречу в выходной',
      durationMinutes: 15,
      date: DateTime.now().add(const Duration(days: 1)),
      isCompleted: false,
    ),
    Task(
      id: '5',
      title: 'Прочитать статью',
      description: 'Новая статья по Flutter разработке',
      durationMinutes: 45,
      date: DateTime.now(),
      isCompleted: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<Task> getTasksForSelectedDate() {
    return allTasks
        .where((task) => isSameDay(task.date, selectedDate))
        .toList();
  }

  int getActiveTasksCount() {
    final tasksForToday =
        allTasks.where((task) => isSameDay(task.date, DateTime.now())).toList();
    return tasksForToday.where((task) => !task.isCompleted).length;
  }

  int getCompletionPercentage() {
    final tasksForToday =
        allTasks.where((task) => isSameDay(task.date, DateTime.now())).toList();
    if (tasksForToday.isEmpty) return 0;
    return calculateCompletionPercentage(
      tasksForToday.map((task) => task.isCompleted).toList(),
    );
  }

  void toggleTaskCompletion(Task task) {
    setState(() {
      final index = allTasks.indexOf(task);
      if (index != -1) {
        allTasks[index] = task.copyWith(isCompleted: !task.isCompleted);
      }
    });
  }

  void addTask(Task newTask) {
    setState(() {
      allTasks.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasksForSelected = getTasksForSelectedDate();
    final completionPercentage = getCompletionPercentage();
    final isToday = isSameDay(selectedDate, DateTime.now());

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User avatar and greeting
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppConstants.cardBackgroundColor,
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: AppConstants.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getGreeting(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppConstants.accentColor,
                            ),
                          ),
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppConstants.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Date and completion percentage
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isToday
                                ? 'Сегодня (${getDayName(DateTime.now().weekday)})'
                                : getDayName(selectedDate.weekday),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppConstants.textColor,
                            ),
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
                      if (isToday)
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
                  ),
                ],
              ),
            ),
            // Tasks/Board tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        pageController.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                        );
                      },
                      child: Column(
                        children: [
                          Text(
                            'Задания (${getActiveTasksCount()})',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: currentPageIndex == 0
                                  ? AppConstants.textActiveTab
                                  : AppConstants.textInactiveTab,
                            ),
                          ),
                          if (currentPageIndex == 0)
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
                      onTap: () {
                        pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                        );
                      },
                      child: Column(
                        children: [
                          Text(
                            'Доска (${boardProvider.boards.length})',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: currentPageIndex == 1
                                  ? AppConstants.textActiveTab
                                  : AppConstants.textInactiveTab,
                            ),
                          ),
                          if (currentPageIndex == 1)
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
              ),
            ),
            const SizedBox(height: 8),
            // Week navigation (only show for Tasks tab)
            if (currentPageIndex == 0)
              WeekNavigation(
                selectedDate: selectedDate,
                onDateChanged: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
            // PageView for smooth sliding
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                children: [
                  // Tasks Tab
                  tasksForSelected.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.task_alt,
                                size: 64,
                                color: AppConstants.textSecondary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Нет заданий',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppConstants.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: tasksForSelected.length,
                          itemBuilder: (context, index) {
                            final task = tasksForSelected[index];
                            return TaskCard(
                              key: ValueKey(task.id),
                              task: task,
                              index: index,
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskDetailScreen(
                                      task: task,
                                      user: user,
                                    ),
                                  ),
                                );
                                
                                if (result != null) {
                                  toggleTaskCompletion(task);
                                }
                              },
                            );
                          },
                        ),
                  // Board Tab
                  BoardScreen(boardProvider: boardProvider),
                ],
              ),
            ),
            ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTaskDialog(
              initialDate: selectedDate,
              onTaskAdded: addTask,
            ),
          );
        },
        backgroundColor: AppConstants.accentColor,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
