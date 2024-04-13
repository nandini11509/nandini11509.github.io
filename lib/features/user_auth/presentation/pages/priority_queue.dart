import 'dart:collection';

class Node {
  final String string;
  final int amount;

  Node(this.string, this.amount);

  @override
  String toString() {
    return '($string, $amount)';
  }
}

class PriorityQueue {
  final List<Node> _queue = [];
  int get length => _queue.length;
  void add(Node element) {
    int index = 0;
    for (var item in _queue) {
      if (element.amount < item.amount) break;
      index++;
    }
    _queue.insert(index, element);
  }

  Node? remove() => _queue.isNotEmpty ? _queue.removeAt(0) : null;

  bool get isEmpty => _queue.isEmpty;
  bool get isNotEmpty => _queue.isNotEmpty;
}
