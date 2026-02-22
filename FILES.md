# Файловая структура и описание TODO List проекта

## Корневые файлы

| Файл | Описание |
|------|---------|
| `README.md` | Основная документация проекта |
| `FEATURES.md` | Подробное описание всех функций |
| `TECHNICAL.md` | Техническая документация |
| `DEVELOPMENT.md` | Инструкции по разработке |
| `ARCHITECTURE.md` | Описание архитектуры и будущих расширений |
| `FILES.md` | Этот файл - справка по структуре |
| `pubspec.yaml` | Конфигурация проекта и зависимости |
| `pubspec.lock` | Зафиксированные версии зависимостей |
| `analysis_options.yaml` | Настройки анализа кода |
| `.gitignore` | Файлы, игнорируемые Git |

## Папка `lib/` - Основной код приложения

### `lib/main.dart`
**Описание:** Точка входа приложения.
- Инициализирует приложение
- Определяет основной Material App
- Устанавливает тему приложения
- Задает домашний экран (HomeScreen)

**Ключевые компоненты:**
- `main()` - главная функция
- `MyApp` - корневой виджет приложения

### `lib/constants/`
Папка с глобальными константами.

#### `app_constants.dart`
**Описание:** Хранит все константы приложения.
- Цветовая схема
- Размеры и отступы
- Размеры шрифтов
- Радиусы границ
- Дефолтные значения

**Использование:** `AppConstants.primaryColor`, `AppConstants.paddingMedium`

### `lib/models/`
Папка с моделями данных.

#### `task.dart`
**Описание:** Модель данных для задачи.
- Поля: id, title, description, durationMinutes, date, isCompleted, userIcon
- Метод `copyWith()` для создания копии с изменениями

**Использование:** Передача и хранение информации о задачах

#### `user.dart`
**Описание:** Модель данных для пользователя.
- Поля: id, name, avatarUrl

**Использование:** Хранение информации о текущем пользователе

### `lib/providers/`
Папка с провайдерами (управление состоянием).

#### `task_provider.dart`
**Описание:** Управление состоянием задач (ChangeNotifier).
- Методы: addTask(), removeTask(), updateTask(), toggleTaskCompletion()
- Методы получения: getTasksByDate(), getCompletionPercentageForDate()

**Использование:** Глобальное управление списком задач

### `lib/screens/`
Папка с экранами приложения.

#### `home_screen.dart`
**Описание:** Главный экран приложения.
- Отображает профиль и приветствие
- Показывает информацию о дате
- Отображает вкладки (Задания/Доска)
- Показывает навигацию по дням
- Список задач

**Структура:**
- `HomeScreen` (StatefulWidget) - главный экран
- `_HomeScreenState` - состояние экрана
- Методы: getTasksForSelectedDate(), getCompletionPercentage(), toggleTaskCompletion(), addTask()

#### `dialog_add_task.dart`
**Описание:** Диалог для добавления новой задачи.
- Поля ввода: название, описание, длительность, дата
- Валидация названия (обязательное)
- Выбор даты через DatePicker

**Структура:**
- `AddTaskDialog` (StatefulWidget) - диалог добавления
- `_AddTaskDialogState` - состояние диалога
- Методы: _addTask()

### `lib/utils/`
Папка с утилитами и вспомогательными функциями.

#### `date_utils.dart`
**Описание:** Функции для работы с датами и временем.

**Функции:**
| Функция | Назначение |
|---------|-----------|
| `getGreeting()` | Получить приветствие по времени суток |
| `getDayName(int)` | Получить полное имя дня недели |
| `getShortDayName(int)` | Получить сокращение дня (Пн, Вт и т.д.) |
| `formatDate(DateTime)` | Форматировать дату как "1 января 2026" |
| `formatTime(int)` | Форматировать время как "30 мин" или "1 ч 30 мин" |
| `calculateCompletionPercentage(List)` | Вычислить процент выполнения |
| `isSameDay(DateTime, DateTime)` | Проверить, одинаковые ли даты |
| `getStartOfWeek()` | Получить первый день недели (понедельник) |

### `lib/widgets/`
Папка с переиспользуемыми виджетами.

#### `task_card.dart`
**Описание:** Виджет для отображения карточки задачи.
- Отображает аватар, название, время
- Чекбокс для отметки выполнения
- Описание задачи с перечеркиванием при выполнении

**Props:**
- `task` (Task) - задача для отображения
- `onToggle` (VoidCallback) - callback при клике на чекбокс

#### `week_navigation.dart`
**Описание:** Виджет навигации по дням недели.
- Горизонтальный список дней с понедельника по воскресенье
- Выбор дня с подсветкой

**Props:**
- `selectedDate` (DateTime) - выбранная дата
- `onDateChanged` (ValueChanged<DateTime>) - callback при изменении даты

#### `user_header.dart`
**Описание:** Компонент заголовка с информацией пользователя.
- Аватар пользователя
- Приветствие
- Имя пользователя
- Callback при клике на профиль

**Props:**
- `userName` (String) - имя пользователя
- `greeting` (String) - текст приветствия
- `avatarUrl` (String?) - URL аватара
- `onProfileTap` (VoidCallback?) - callback при клике

#### `date_info.dart`
**Описание:** Виджет для отображения информации о дате и прогрессе.
- Название дня и полная дата
- Процент выполнения задач (только для сегодня)

**Props:**
- `selectedDate` (DateTime) - выбранная дата
- `completionPercentage` (int?) - процент выполнения

#### `tab_switcher.dart`
**Описание:** Переключатель между вкладками.
- Две вкладки с подчеркиванием выбранной
- Гибкие названия вкладок

**Props:**
- `isFirstTabSelected` (bool) - выбрана ли первая вкладка
- `firstTabLabel` (String) - название первой вкладки
- `secondTabLabel` (String) - название второй вкладки
- `onTabChanged` (ValueChanged<bool>) - callback при изменении

## Папка `test/` - Тесты

Папка для unit тестов и widget тестов (пока пуста, готова для расширения).

## Папка `web/` - Web версия

Конфигурация для web-версии приложения.

## Папка `ios/` и `android/`

Платформо-специфичные файлы для iOS и Android.

## Правила именования файлов

1. **Экраны:** `lowercase_with_underscores_screen.dart` (например: `home_screen.dart`)
2. **Диалоги:** `dialog_lowercase_with_underscores.dart` (например: `dialog_add_task.dart`)
3. **Модели:** `lowercase.dart` (например: `task.dart`, `user.dart`)
4. **Виджеты:** `lowercase_with_underscores.dart` (например: `task_card.dart`)
5. **Утилиты:** `lowercase_with_underscores.dart` (например: `date_utils.dart`)
6. **Провайдеры:** `lowercase_with_underscores_provider.dart` (например: `task_provider.dart`)

## Граф зависимостей

```
main.dart
├── MyApp
│   └── HomeScreen
│       ├── UserHeader (widget)
│       ├── DateInfo (widget)
│       ├── TabSwitcher (widget)
│       ├── WeekNavigation (widget)
│       ├── TaskCard (widget) × N
│       └── AddTaskDialog
│           └── Task (model)
└── Task (model)
└── User (model)
```

## Сумма кода

| Категория | Файлов | Примерно строк |
|-----------|--------|---|
| Модели | 2 | 60 |
| Провайдеры | 1 | 90 |
| Экраны | 2 | 300 |
| Виджеты | 5 | 400 |
| Утилиты | 2 | 150 |
| Константы | 1 | 40 |
| **Итого** | **13** | **1040** |

## Как найти нужное

### Хочу изменить...

| Нужно изменить | Файл |
|---|---|
| Цвета приложения | `lib/constants/app_constants.dart` |
| Приветствие пользователю | `lib/utils/date_utils.dart` (getGreeting) |
| Формат даты | `lib/utils/date_utils.dart` (formatDate) |
| Визуал задачи | `lib/widgets/task_card.dart` |
| Навигацию по дням | `lib/widgets/week_navigation.dart` |
| Логику добавления задачи | `lib/screens/home_screen.dart` + `lib/screens/dialog_add_task.dart` |
| Логику отметки выполнения | `lib/screens/home_screen.dart` (toggleTaskCompletion) |
| Макет главного экрана | `lib/screens/home_screen.dart` (build method) |
| Модель задачи | `lib/models/task.dart` |
| Хранение задач | `lib/providers/task_provider.dart` |

## Развитие структуры

Проект подготовлен к расширению. Рекомендуемые новые папки:
- `lib/services/` - для сервисов (БД, API, уведомления)
- `lib/extensions/` - для расширений классов Dart
- `lib/validators/` - для функций валидации
- `test/` - для тестов (unit & widget)

Подробнее в `ARCHITECTURE.md`.
