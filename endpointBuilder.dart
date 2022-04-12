class Builder {
  String? endpoint;
  void add(String t) {
    endpoint = endpoint! + t + "/";
  }

  void addMore(List<String> t) {
    for (var n in t) {
      endpoint = endpoint! + n + "/";
    }
  }

  void addFront(String t) {
    endpoint = "/" + t + endpoint!;
  }

  void addAfter(String x, String t) {
    int index = (subString(endpoint!, x))!;
    if (index == -1) {
      print("Данное значение не найдено!");
      return;
    }
    List<String> text = endpoint!.split('').toList();
    var part1 = text.take(index + x.length + 1).join();
    var part2 = text.skip(index + x.length).join();
    endpoint = part1 + t + part2;
  }

  void remove(String t) {
    int index = (subString(endpoint!, t))!;
    if (index == -1) {
      print("Данное значение не найдено!");
      return;
    }
    List<String> text = endpoint!.split('').toList();
    text.removeAt(index);
    while (text[index] != "/") {
      text.removeAt(index);
    }
    text.removeAt(index);
    endpoint = text.join();
  }

  void removeFront() {
    List<String> text = endpoint!.split('').toList();
    text.removeAt(0);
    while (text[0] != "/") {
      text.removeAt(0);
    }
    endpoint = text.join();
  }

  void removeBack() {
    List<String> text = endpoint!.split('').toList();
    text.removeAt(text.length - 1);
    while (text[text.length - 1] != "/") {
      text.removeAt(text.length - 1);
    }
    endpoint = text.join();
  }

  Map table(String pattern) {
    Map<dynamic, dynamic> alph = <dynamic, dynamic>{};
    List<String> string = pattern.split('').toList();
    for (int i = 0; i < pattern.length; i++) {
      alph[string[i]] = i;
    }
    return alph;
  }

  int? subString(String text, String pattern) {
    Map<dynamic, dynamic> alph = table(pattern);
    List<String> text2 = text.split('').toList();
    int? t = 0;
    int last = pattern.length - 1;
    while (t! < text.length - last) {
      int i = last;

      while (i >= 0 && text2[t + i] == pattern[i]) {
        i--;
      }

      if (i == -1) return t;

      if (alph[text2[t + last]] == null) {
        t += last;
      } else if (last - alph[text2[t + last]] == 0) {
        t++;
      } else {
        t += ((last - alph[text2[t + last]]) as int?)!;
      }
    }
    return -1;
  }

  Builder({this.endpoint = "/"});
}

void main() {
  Builder epoint = Builder();
  epoint.add("test1");
  print(epoint.endpoint);
  epoint.addMore(["test2", "test3"]);
  print(epoint.endpoint);
  epoint.addAfter("test2", "ch");
  print(epoint.endpoint);
  epoint.remove("test3");
  print(epoint.endpoint);
  epoint.addMore(["test4", "test5", "test6"]);
  print(epoint.endpoint);
  epoint.addFront("test7");
  print(epoint.endpoint);
  epoint.removeFront();
  print(epoint.endpoint);
  epoint.removeBack();
  print(epoint.endpoint);
  epoint.addAfter("test10", "hi");
  epoint.remove("test10");
}
