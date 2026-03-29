# Flutter JWT Authentication App

## Опис проєкту
Цей проєкт — мобільний застосунок на Flutter, який реалізує систему авторизації з використанням JWT токенів.

Застосунок демонструє:
- роботу з HTTP клієнтом (Dio)
- використання Interceptors
- централізовану обробку помилок
- збереження токенів у secure storage
- управління станом через Riverpod

## Функціонал

### Авторизація
- Вхід користувача (Login)
- Валідація email та пароля
- Обробка помилок при неправильних даних
- Збереження токена після входу

### JWT та Interceptors
- Автоматичне додавання Bearer token до кожного запиту
- Логування запитів та відповідей
- Централізована обробка помилок (DioException)

### Захищені маршрути
- Перевірка авторизації при запуску додатку
- Перехід на HomeScreen тільки при наявності токена

### Logout
- Видалення токенів
- Повернення на екран логіну

## Архітектура проєкту
lib/
├── main.dart
├── core/
│ ├── network/
│ │ ├── dio_client.dart
│ │ └── interceptors/
│ │ ├── auth_interceptor.dart
│ │ ├── logging_interceptor.dart
│ │ └── error_interceptor.dart
│ └── storage/
│ └── token_storage.dart
├── features/
│ └── auth/
│ ├── data/
│ │ └── auth_service.dart
│ └── presentation/
│ ├── auth_provider.dart
│ ├── login_screen.dart
│ └── home_screen.dart
└── shared/

## Технології
- Flutter
- Dio (HTTP клієнт)
- Riverpod (state management)
- flutter_secure_storage (безпечне збереження токенів)

## Встановлення та запуск
1. Клонувати репозиторій:
```bash
git clone https://github.com/your-repo.git
```
2. Перейти в папку проєкту:
```bash
cd pr_11_2
```
3. Встановити залежності:
```bash
flutter pub get
```
4. Запустити застосунок:
```bash
flutter run
```

## Дані для тестування
API використовує тестові дані:
```bash
email: eve.holt@reqres.in
password: cityslicka
```

## Важливо
API (ReqRes) іноді може повертати помилку 403, тому в проєкті реалізовано fallback-логіку (mock авторизація), щоб застосунок стабільно працював.

## Реалізовані вимоги
- HTTP клієнт Dio
- Interceptors (request, response, error)
- JWT авторизація
- Secure storage
- State management (Riverpod)
- Обробка помилок
- Захищені маршрути
