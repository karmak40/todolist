String getGreeting() {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return 'Доброе утро';
  } else if (hour >= 12 && hour < 17) {
    return 'Добрый день';
  } else if (hour >= 17 && hour < 21) {
    return 'Добрый вечер';
  } else {
    return 'Добрую ночь';
  }
}

String getDayName(int dayOfWeek) {
  const days = [
    'Понедельник',
    'Вторник',
    'Среда',
    'Четверг',
    'Пятница',
    'Суббота',
    'Воскресенье',
  ];
  return days[dayOfWeek - 1];
}

String getShortDayName(int dayOfWeek) {
  const days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
  return days[dayOfWeek - 1];
}

String formatDate(DateTime date) {
  final day = date.day;
  final months = [
    'января',
    'февраля',
    'марта',
    'апреля',
    'мая',
    'июня',
    'июля',
    'августа',
    'сентября',
    'октября',
    'ноября',
    'декабря',
  ];
  final month = months[date.month - 1];
  final year = date.year;
  return '$day $month $year';
}

String formatTime(int minutes) {
  if (minutes < 60) {
    return '$minutes мин';
  }
  final hours = minutes ~/ 60;
  final mins = minutes % 60;
  if (mins == 0) {
    return '$hours ч';
  }
  return '$hours ч $mins мин';
}

int calculateCompletionPercentage(List<bool> completedStatuses) {
  if (completedStatuses.isEmpty) return 0;
  final completed = completedStatuses.where((status) => status).length;
  return ((completed / completedStatuses.length) * 100).toInt();
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

DateTime getStartOfWeek() {
  final now = DateTime.now();
  final monday = now.subtract(Duration(days: now.weekday - 1));
  return DateTime(monday.year, monday.month, monday.day);
}
