import 'package:flutter/material.dart';

// Model giữ nguyên
class Todo {
  String id;
  String title;
  String description;
  DateTime? dueDate;
  bool isDone;

  Todo({
    required this.id,
    required this.title,
    this.description = '',
    this.dueDate,
    this.isDone = false,
  });
}

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(bool?) onToDoChanged;
  final Function() onDeleteItem;
  final Function() onEditItem;

  const TodoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
    required this.onEditItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format ngày giờ
    String formattedDate = "";
    if (todo.dueDate != null) {
       String hour = todo.dueDate!.hour.toString().padLeft(2, '0');
       String min = todo.dueDate!.minute.toString().padLeft(2, '0');
       formattedDate = "$hour:$min - ${todo.dueDate!.day}/${todo.dueDate!.month}";
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95), // Nền trắng hơi trong suốt
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFFFD700), width: 2), // Viền Vàng Kim
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        onTap: () {
          onToDoChanged(!todo.isDone);
        },
        leading: Transform.scale(
          scale: 1.2,
          child: Checkbox(
            value: todo.isDone,
            onChanged: onToDoChanged,
            activeColor: Colors.red, // Check vào thì màu đỏ
            checkColor: Colors.yellow, // Dấu tích màu vàng
            shape: const CircleBorder(), // Checkbox hình tròn cho mềm mại
            side: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
            color: todo.isDone ? Colors.grey : const Color(0xFFB71C1C), // Chữ đỏ đậm
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (todo.description.isNotEmpty)
              Text(
                todo.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black87),
              ),
            if (formattedDate.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    // Thay icon lịch bằng icon hoa mai/đào (hoặc đồng hồ)
                    Icon(Icons.access_time_filled, 
                         size: 14, 
                         color: (todo.dueDate != null && todo.dueDate!.isBefore(DateTime.now()) && !todo.isDone) 
                         ? Colors.red : Colors.orange),
                    const SizedBox(width: 5),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                         color: (todo.dueDate != null && todo.dueDate!.isBefore(DateTime.now()) && !todo.isDone) 
                         ? Colors.red : Colors.black54
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_note, color: Colors.orange, size: 28),
              onPressed: onEditItem,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: onDeleteItem,
            ),
          ],
        ),
      ),
    );
  }
}