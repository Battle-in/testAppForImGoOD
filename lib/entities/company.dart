class Company {
  String name;
  String bs;
  String catchPhrase;

  Company({required this.name, required this.bs, required this.catchPhrase});

  static Company fromMap(Map map) {
    return Company(
        name: map['name'], bs: map['bs'], catchPhrase: map['catchPhrase']);
  }
}
