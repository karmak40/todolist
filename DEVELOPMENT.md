# Инструкции по разработке TODO List

## Установка и подготовка

### Предварительные требования
- Flutter 3.0 или выше
- Dart 3.0 или выше
- Git
- IDE (VS Code, Android Studio или IntelliJ)

### Первый запуск

```bash
# Перейти в директорию проекта
cd d:\Projects\Flutter\todolist

# Получить зависимости
flutter pub get

# Запустить анализ кода
flutter analyze

# Запустить приложение
flutter run
```

## Разработка новых факторий

### Добавление новой задачи

1. Создайте новый модель в `lib/models/`
2. Добавьте соответствующий Provider в `lib/providers/`
3. Создайте новый Screen в `lib/screens/`
4. При необходимости добавьте новые Widget в `lib/widgets/`

### Пример: Добавление новой функции

```dart
// 1. Модель (lib/models/new_model.dart)
class NewModel {
  final String id;
  final String name;
  // ... другие поля
}

// 2. Provider (lib/providers/new_provider.dart)
class NewProvider extends ChangeNotifier {
  List<NewModel> items = [];
  
  void addItem(NewModel item) {
    items.add(item);
    notifyListeners();
  }
}

// 3. Screen (lib/screens/new_screen.dart)
class NewScreen extends StatefulWidget {
  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... реализация
    );
  }
}
```

## Разработка новых Widget'ов

### Структура Widget'а

```dart
import 'package:flutter/material.dart';

class MyCustomWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const MyCustomWidget({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // Widget implementation
      ),
    );
  }
}
```

### Лучшие практики
- Использовать `const` для construtctor
- Добавлять `super.key` в constructor
- Документировать параметры
- Делать Widget'ы переиспользуемыми
- Направить параметры как callback для взаимодействия

## Тестирование

### Запуск тестов

```bash
# Все тесты
flutter test

# Конкретный файл
flutter test test/models/task_test.dart

# С меткой
flutter test --tags=unit
```

### Написание unit теста

```dart
void main() {
  group('Task Model', () {
    test('Task should be created with correct values', () {
      final task = Task(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        durationMinutes: 30,
        date: DateTime.now(),
      );

      expect(task.id, '1');
      expect(task.title, 'Test Task');
      expect(task.isCompleted, false);
    });
  });
}
```

### Написание widget теста

```dart
void main() {
  group('TaskCard Widget', () {
    testWidgets('TaskCard should display task information', 
        (WidgetTester tester) async {
      final task = Task(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        durationMinutes: 30,
        date: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskCard(
              task: task,
              onToggle: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Task'), findsOneWidget);
      expect(find.byType(Checkbox), findsOneWidget);
    });
  });
}
```

## Форматирование и анализ кода

```bash
# Форматировать весь код
flutter format .

# Форматировать конкретный файл
flutter format lib/screens/home_screen.dart

# Анализ кода
flutter analyze

# Анализ с исправлениями
dart fix --apply
```

## Отладка

### Отладка в VS Code
1. Установите расширение Flutter
2. Откройте Run and Debug (Ctrl+Shift+D)
3. Нажмите на "create a launch.json file" или выберите Flutter
4. Нажмите F5 для запуска в режиме отладки

### Отладка в IDE
- Android Studio: Контроль+Shift+D
- IntelliJ IDEA: Контроль+Альт+Shift+D

### Печать логов
```dart
print('Debug message');
debugPrint('Debug print');
developer.log('Detailed message');
```

### Hot Reload
- Горячая перезагрузка: Ctrl+S (VS Code)
- Перезагрузка приложения: Shift+F5

## Версионирование

### Обновление версии

В файле `pubspec.yaml`:
```yaml
version: 1.0.0+1  # версия+код версии
```

Команда для обновления:
```bash
flutter pub version 1.1.0
```

## Управление зависимостями

```bash
# Список всех зависимостей
flutter pub deps

# Поиск устаревших зависимостей
flutter pub outdated

# Обновить зависимости
flutter pub get

# Обновить все до последней версии
flutter pub upgrade
```

## Build и Release

### Debug Build
```bash
flutter run --debug
```

### Release Build

**Android:**
```bash
flutter build apk --release
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

## Интеграция с Git

```bash
# Инициализировать git
git init
git add .
git commit -m "Initial commit"

# Добавить remote инстанцию
git remote add origin <your_repo_url>

# Отправить код
git push -u origin main
```

## Структура коммитов

```
feat: Добавление новой функции
fix: Исправление баг
refactor: Переструктурирование кода
docs: Обновление документации
test: Добавление тестов
chore: Обновление зависимостей
```

Пример:
```bash
git commit -m "feat: add task deletion functionality"
git commit -m "fix: resolve date formatting issue"
```

## Переменные окружения

Создайте файл `.env`:
```
API_BASE_URL=http://localhost:8000
DEBUG_MODE=true
```

Используйте в коде:
```dart
const String apiUrl = String.fromEnvironment('API_BASE_URL');
```

## Логирование

### Создание логгера

```dart
// lib/utils/logger.dart
class Logger {
  static void log(String message) {
    debugPrint('[LOG] $message');
  }

  static void error(String message, [Object? error]) {
    debugPrint('[ERROR] $message');
    if (error != null) debugPrint(error.toString());
  }

  static void warning(String message) {
    debugPrint('[WARNING] $message');
  }
}
```

Использование:
```dart
Logger.log('Task added successfully');
Logger.error('Failed to load tasks', exception);
Logger.warning('Network speed is slow');
```

## Производительность

### Профилирование
```bash
flutter run --profile
```

### Timeline мониторинга
1. Откройте DevTools: `flutter pub global run devtools`
2. Перейдите на вкладку Timeline
3. Запустите операции для тестирования

### Оптимизация памяти
- Использовать `const` где возможно
- Избегать глобальных переменных
- Правильно очищать ресурсы в `dispose()`

## Особенности для платформ

### Android-специфичный код
```dart
import 'package:flutter/services.dart';

if (Theme.of(context).platform == TargetPlatform.android) {
  // Android-специфичная реализация
}
```

### iOS-специфичный код
```dart
if (Theme.of(context).platform == TargetPlatform.iOS) {
  // iOS-специфичная реализация
}
```

## Частые проблемы и решения

### Статус Flutter
```bash
flutter doctor
```

### Очистка кэша
```bash
flutter clean
flutter pub get
flutter run
```

### Проблемы с Android
```bash
# Обновить SDK
flutter upgrade android-sdk

# Очистить Gradle кэш
cd android
./gradlew clean
cd ..
```

### Проблемы с iOS
```bash
flutter clean
rm -rf ios/Pods ios/Podfile.lock
flutter pub get
flutter run
```

## Ресурсы

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Best Practices](https://flutter.dev/docs/testing/best-practices)
- [Flutter Troubleshooting](https://flutter.dev/docs/testing/troubleshooting)
