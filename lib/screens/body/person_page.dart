import 'package:flutter/material.dart';
import 'package:test_app_im_good/entities/company.dart';
import 'package:test_app_im_good/entities/person.dart';

import 'package:test_app_im_good/redux/my_redux.dart';

class PersonPage extends StatelessWidget {
  const PersonPage({Key? key, required this.store}) : super(key: key);
  final Store<AppState> store;

  final TextStyle _titleTextStyle = const TextStyle(
      fontSize: 30
  );
  final TextStyle _contentTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    store.dispatch(LoadPersonAction(context: context));

    return StoreConnector<AppState, Person>(
        builder: (BuildContext context, Person person) {
          if (person.isDefault()) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text(person.userName),
                ),
                body: _body(context, person));
          }
        },
        converter: (store) => store.state.person);
  }

  Widget _body(BuildContext context, Person person) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: ListView(
        children: [
          Text('Личные данные' ,style: _titleTextStyle,),
          _personalData(person),
          const SizedBox(
            height: 15,
          ),
          Text('Компания' ,style: _titleTextStyle,),
          _companyData(person.company),
          const SizedBox(
            height: 15,
          ),
          _buttonMenu(context)
        ],
      ),
    );
  }

  Widget _personalData(Person person){
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const Text('Имя Фамилия'),
          Text(
            person.name,
            style: _contentTextStyle,
          ),
          const Divider(),
          const Text('Email'),
          Text(
            person.email,
            style: _contentTextStyle,
          ),
          const Divider(),
          const Text('Номер телефона'),
          Text(
            person.phone,
            style: _contentTextStyle,
          ),
          const Divider(),
          const Text('Website'),
          Text(
            person.website,
            style: _contentTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _companyData(Company company){
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const Text('Названии компании'),
          Text(company.name,
              style: _contentTextStyle, textAlign: TextAlign.center),
          const Divider(),
          const Text('Слоган'),
          Text(
            company.catchPhrase,
            style: _contentTextStyle,
            textAlign: TextAlign.center,
          ),
          const Divider(),
          const Text('Сфера деятельности'),
          Text(company.bs,
              style: _contentTextStyle, textAlign: TextAlign.center),
        ],
      ),
    );
  }
  
  Widget _buttonMenu(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        int.parse(store.state.currentUserId) > 1 ? IconButton(onPressed: () => store.dispatch(BeforeUserIdAction(context)), icon: const Icon(Icons.navigate_before_outlined)) : Container(),
        int.parse(store.state.currentUserId) < store.state.friends.length ? IconButton(onPressed: () => store.dispatch(NextUserIdAction(context)), icon: const Icon(Icons.navigate_next_outlined)) : Container(),
      ],
    );
  }
}
