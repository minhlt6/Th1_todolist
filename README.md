# todolist

Ứng dụng TodoList Flutter - Quản lý công việc, nhắc nhở, giao diện hiện đại.

## Cấu trúc source code

```
├── android/           # Mã nguồn và cấu hình cho Android
├── ios/               # Mã nguồn và cấu hình cho iOS
├── lib/               # Thư mục chính chứa mã nguồn Dart
│   ├── main.dart      # Điểm khởi động ứng dụng, giao diện chính, logic chính
│   └── todo_item.dart # Định nghĩa model Todo và widget hiển thị từng công việc
├── test/              # Thư mục chứa các file test cho ứng dụng
├── web/               # Cấu hình cho build web
├── windows/, macos/, linux/ # Hỗ trợ build đa nền tảng
├── pubspec.yaml       # Khai báo dependencies, assets, thông tin app
├── analysis_options.yaml # Quy tắc lint cho Dart/Flutter
└── README.md          # Tài liệu mô tả dự án
```

### Giải thích nhanh:

- **lib/main.dart**: Xử lý giao diện chính, quản lý danh sách công việc, logic thông báo nhắc nhở.
- **lib/todo_item.dart**: Định nghĩa class `Todo` (model) và widget `TodoItem` để hiển thị từng công việc.
- **android/**, **ios/**, **web/**, **windows/**, **macos/**, **linux/**: Mã nguồn và cấu hình để build app trên các nền tảng tương ứng.
- **pubspec.yaml**: Khai báo các package sử dụng (ví dụ: `flutter_local_notifications`, `timezone`, ...).
- **test/**: Chứa các file kiểm thử (unit test, widget test).

## Kế hoạch hỗ trợ đa ngôn ngữ cho ứng dụng

Để thêm tính năng đa ngôn ngữ (internationalization - i18n) cho TodoList, bạn có thể thực hiện theo các bước sau:

1. **Thêm dependencies cần thiết**
   - Thêm vào `pubspec.yaml`:
     ```yaml
     dependencies:
       flutter_localizations:
         sdk: flutter
       intl: ^0.18.0
     ```

2. **Cấu hình hỗ trợ đa ngôn ngữ trong app**
   - Trong `MaterialApp` (file `lib/main.dart`), thêm các tham số:
     ```dart
     import 'package:flutter_localizations/flutter_localizations.dart';
     // ...existing code...
     return MaterialApp(
       // ...existing code...
       localizationsDelegates: const [
         GlobalMaterialLocalizations.delegate,
         GlobalWidgetsLocalizations.delegate,
         GlobalCupertinoLocalizations.delegate,
       ],
       supportedLocales: const [
         Locale('en'), // Tiếng Anh
         Locale('vi'), // Tiếng Việt
       ],
       // ...existing code...
     );
     ```

3. **Tạo file ngôn ngữ**
   - Tạo thư mục `lib/l10n/` và các file như `app_en.arb`, `app_vi.arb` để chứa các chuỗi dịch:
     ```json
     // lib/l10n/app_en.arb
     {
       "appTitle": "TodoList",
       "addTask": "Add Task"
     }
     // lib/l10n/app_vi.arb
     {
       "appTitle": "Danh sách công việc",
       "addTask": "Thêm công việc"
     }
     ```

4. **Tích hợp tool tạo mã tự động**
   - Thêm vào `pubspec.yaml`:
     ```yaml
     flutter:
       generate: true
     ```
   - Chạy lệnh: `flutter gen-l10n`

5. **Sử dụng chuỗi đa ngôn ngữ trong code**
   - Thay các chuỗi text cứng bằng truy cập qua lớp sinh tự động, ví dụ:
     ```dart
     AppLocalizations.of(context)!.addTask
     ```

6. **Kiểm tra và mở rộng**
   - Chạy app, kiểm tra chuyển đổi ngôn ngữ trên thiết bị.
   - Bổ sung thêm ngôn ngữ mới bằng cách thêm file `.arb` tương ứng.

**Tài liệu tham khảo:**

- [Flutter Internationalization](https://docs.flutter.dev/accessibility-and-localization/internationalization)
- [Package intl](https://pub.dev/packages/intl)

Bạn có thể cá nhân hóa ứng dụng TodoList theo ý thích của mình:

- **Đổi chủ đề màu sắc:**
  - Sửa các giá trị màu trong `ThemeData` ở file `lib/main.dart` để phù hợp với phong cách cá nhân (ví dụ: màu chủ đạo, màu nền, màu nút).
- **Thay đổi icon, hình nền:**
  - Thay icon ứng dụng trong thư mục `android/app/src/main/res/` và `ios/Runner/Assets.xcassets`.
  - Thêm hình nền hoặc ảnh minh họa vào thư mục `assets/` và khai báo trong `pubspec.yaml`.
- **Tùy biến chức năng:**
  - Thêm các trường mới cho công việc (ví dụ: mức độ ưu tiên, nhãn, hình ảnh đính kèm) trong model `Todo` (`lib/todo_item.dart`).
  - Bổ sung các bộ lọc, tìm kiếm, hoặc nhóm công việc theo ngày/tháng.
- **Cá nhân hóa trải nghiệm:**
  - Thêm thông báo động viên, lời chúc, hoặc hiệu ứng khi hoàn thành công việc.
  - Tích hợp đồng bộ hóa dữ liệu với Google Drive, Firebase, hoặc lưu trữ đám mây.
- **Đa ngôn ngữ:**
  - Thêm hỗ trợ nhiều ngôn ngữ bằng cách sử dụng package `flutter_localizations`.

Hãy sáng tạo để biến TodoList thành ứng dụng phù hợp nhất với nhu cầu và phong cách của bạn!

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
