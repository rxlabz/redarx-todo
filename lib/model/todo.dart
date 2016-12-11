class Todo {
  int uid;
  String label;
  bool completed;

  Todo(this.label, [this.completed = false, this.uid = null]) {
    if (uid == null) uid = new DateTime.now().millisecondsSinceEpoch;
  }

  Todo.fromMap(Map<String, dynamic> data){
    this.uid = data['uid'];
    this.label = data['label'];
    this.completed = data['completed'] == 1;
  }

  @override
  String toString() {
    return 'Todo{ $uid , $label }';
  }
}