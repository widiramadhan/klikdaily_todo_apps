class TodoModel{
  int todo_id;
  int category_id;
  String title;
  String note;
  String date;
  int status;

  TodoModel({this.todo_id, this.category_id, this.title, this.note, this.date, this.status});

  TodoModel.fromJson(Map<String, dynamic> json) {
    todo_id = json['todo_id'] ?? null;
    category_id = json['category_id'] ?? null;
    title = json['title'] ?? '';
    note = json['note'] ?? '';
    date = json['date'] ?? '';
    status = json['status'] ?? 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['todo_id'] = this.todo_id;
    data['category_id'] = this.category_id;
    data['title'] = this.title;
    data['note'] = this.note;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }

  TodoModel.fromMap(Map<String, dynamic> map) {
    todo_id = map['todo_id'] ?? null;
    category_id = map['category_id'] ?? null;
    title = map['title'] ?? '';
    note = map['note'] ?? '';
    date = map['date'] ?? '';
    status = map['status'] ?? 1;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['todo_id'] = this.todo_id;
    data['category_id'] = this.category_id;
    data['title'] = this.title;
    data['note'] = this.note;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}
