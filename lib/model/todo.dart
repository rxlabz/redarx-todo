class Todo {
  int uid;
  String label;
  bool completed;

  Todo(this.label, [this.completed = false, this.uid = null]) {
    if (uid == null) uid = new DateTime.now().millisecondsSinceEpoch;
  }

  @override
  String toString() {
    return 'Todo{ $uid , $label }';
  }
}