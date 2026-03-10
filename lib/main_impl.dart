import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'app_settings.dart';
import 'todo_item.dart';

Future<void> startApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyAppImpl());
}

class MyAppImpl extends StatelessWidget {
  const MyAppImpl({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settings,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TodoList',
        locale: settings.locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrange,
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: const Color(0xFFF8F8F8),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black,
            ),
            iconTheme: IconThemeData(color: Colors.deepOrange),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            shape: StadiumBorder(),
            elevation: 3,
          ),
          cardTheme: const CardThemeData(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            surfaceTintColor: Colors.white,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              elevation: 2,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            ),
          ),
          checkboxTheme: CheckboxThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            fillColor: MaterialStatePropertyAll(Colors.deepOrange),
          ),
          listTileTheme: const ListTileThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            tileColor: Colors.white,
            selectedTileColor: Color(0xFFFFE0B2),
            iconColor: Colors.deepOrange,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          ),
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: Colors.deepOrange,
            contentTextStyle: TextStyle(color: Colors.white, fontSize: 16),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
        home: const MainTabScreen(),
      ),
    );
  }
}

// Màn hình chính với các tab chức năng
class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Todo> todos = [
    Todo(
      id: '1',
      title: 'Học Flutter',
      description: 'Xem video và thực hành',
      dueDate: DateTime.now().add(const Duration(hours: 2)),
    ),
    Todo(
      id: '2',
      title: 'Làm bài tập',
      description: 'Bài tập cuối tuần',
      dueDate: DateTime.now().add(const Duration(days: 1)),
    ),
    Todo(
      id: '3',
      title: 'Đi siêu thị',
      description: 'Mua thực phẩm',
      dueDate: DateTime.now().add(const Duration(hours: 5)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _editTodo(Todo todo) {
    String title = todo.title;
    String description = todo.description;
    final titleController = TextEditingController(text: title);
    final descController = TextEditingController(text: description);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        bool isTitleValid = title.trim().isNotEmpty;
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sửa công việc',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(labelText: 'Tiêu đề'),
                  controller: titleController,
                  onChanged: (value) {
                    title = value;
                    setModalState(() {
                      isTitleValid = title.trim().isNotEmpty;
                    });
                  },
                ),
                if (!isTitleValid)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tiêu đề không được để trống',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(labelText: 'Mô tả'),
                  controller: descController,
                  onChanged: (value) => description = value,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Lưu'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: isTitleValid
                      ? () {
                          setState(() {
                            todo.title = title.trim();
                            todo.description = description.trim();
                          });
                          Navigator.pop(context);
                        }
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        String description = '';
        bool isTitleValid = false;
        return StatefulBuilder(
          builder: (context, setStateDialog) => AlertDialog(
            title: const Text('Thêm công việc'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Tiêu đề'),
                  onChanged: (value) {
                    title = value;
                    setStateDialog(() {
                      isTitleValid = title.trim().isNotEmpty;
                    });
                  },
                ),
                if (!isTitleValid)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tiêu đề không được để trống',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Mô tả'),
                  onChanged: (value) => description = value,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: isTitleValid
                    ? () {
                        setState(() {
                          todos.add(
                            Todo(
                              id: DateTime.now().millisecondsSinceEpoch
                                  .toString(),
                              title: title.trim(),
                              description: description.trim(),
                              dueDate: DateTime.now().add(
                                const Duration(days: 1),
                              ),
                            ),
                          );
                        });
                        Navigator.pop(context);
                      }
                    : null,
                child: const Text('Thêm'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateTodoStatus(String id, bool? isDone) {
    setState(() {
      final todo = todos.firstWhere((t) => t.id == id);
      todo.isDone = isDone ?? false;
    });
  }

  void _deleteTodo(String id) {
    setState(() {
      todos.removeWhere((t) => t.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final uncompleted = todos.where((t) => !t.isDone).toList();
    final completed = todos.where((t) => t.isDone).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý công việc'),
        actions: [],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.list_alt), text: 'Tất cả'),
            Tab(
              icon: Icon(Icons.radio_button_unchecked),
              text: 'Chưa hoàn thành',
            ),
            Tab(icon: Icon(Icons.check_circle_outline), text: 'Đã hoàn thành'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TodoListTab(
            todos: todos,
            onStatusChanged: _updateTodoStatus,
            onDelete: _deleteTodo,
            onEdit: _editTodo,
          ),
          TodoListTab(
            todos: uncompleted,
            onStatusChanged: _updateTodoStatus,
            onDelete: _deleteTodo,
            onEdit: _editTodo,
          ),
          TodoListTab(
            todos: completed,
            onStatusChanged: _updateTodoStatus,
            onDelete: _deleteTodo,
            onEdit: _editTodo,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        tooltip: 'Thêm công việc',
        child: const Icon(Icons.add), // Đã đưa child xuống dòng cuối cùng
      ),
    );
  }
}

// Tab hiển thị danh sách công việc (tất cả/chưa hoàn thành/đã hoàn thành)
class TodoListTab extends StatelessWidget {
  final List<Todo> todos;
  final void Function(String, bool?) onStatusChanged;
  final void Function(String) onDelete;
  final void Function(Todo) onEdit;

  const TodoListTab({
    required this.todos,
    required this.onStatusChanged,
    required this.onDelete,
    required this.onEdit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(child: Text('Không có công việc nào.'));
    }
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Card(
          child: ListTile(
            leading: Checkbox(
              value: todo.isDone,
              onChanged: (isDone) => onStatusChanged(todo.id, isDone),
              shape: const CircleBorder(),
            ),
            title: Text(
              todo.title,
              style: TextStyle(
                decoration: todo.isDone ? TextDecoration.lineThrough : null,
                color: todo.isDone ? Colors.grey : Colors.black,
              ),
            ),
            subtitle: todo.description.isNotEmpty
                ? Text(todo.description)
                : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.deepOrange),
                  tooltip: 'Sửa',
                  onPressed: () => onEdit(todo),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  tooltip: 'Xóa',
                  onPressed: () => onDelete(todo.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Tab 1: Danh sách công việc (Được quản lý tự động bởi TodoListTab)
// Tab 2: Thêm công việc mới
// Only keep core functionality: add, edit, delete and status filtering (implemented via tabs above).
