import 'company.dart';

class Person {
  String userName;
  String name;
  String email;
  String phone;
  String website;
  Company company;

  Person({required this.userName,
    required this.name,
    required this.email,
    required this.phone,
    required this.website,
    required this.company});

  static Person fromMap(Map map) {
    return Person(userName: map['username'],
        name: map['name'],
        email: map['email'],
        phone: map['phone'],
        website: map['website'],
        company: Company.fromMap(map['company']) 
    );
  }

  static getDefault() {
    return Person(
        userName: 'none0',
        name: 'none0',
        email: 'none0',
        phone: 'none0',
        website: 'none0',
        company: Company(name: 'none0', bs: 'none0', catchPhrase: 'none0'));
  }

  bool isDefault() {
    Person defaultValue = getDefault();
    return userName == defaultValue.userName &&
        name == defaultValue.name &&
        email == defaultValue.email &&
        phone == defaultValue.phone &&
        website == defaultValue.website &&
        company.name == defaultValue.company.name &&
        company.bs == defaultValue.company.bs &&
        company.catchPhrase == defaultValue.company.catchPhrase;
  }

  @override
  String toString() {
    return 'Person{userName: $userName, name: $name, email: $email, phone: $phone, website: $website, company: $company}';
  }
}
