// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Danh sách công việc';

  @override
  String get addTask => 'Thêm công việc';

  @override
  String get editTask => 'Sửa công việc';

  @override
  String get deleteTask => 'Xóa công việc';

  @override
  String get taskCompleted => 'Hoàn thành công việc! Chúc mừng bạn!';

  @override
  String get chooseBackgroundColor => 'Chọn màu nền';

  @override
  String get taskHint => 'Nhập công việc...';

  @override
  String get descHint => 'Mô tả (không bắt buộc)';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get cancel => 'Hủy';
}
