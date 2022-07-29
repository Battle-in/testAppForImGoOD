import 'package:flutter/material.dart';
import 'package:test_app_im_good/entities/person_from_list.dart';

import 'package:test_app_im_good/redux/my_redux.dart';

class PersonsList extends StatelessWidget {
  const PersonsList({Key? key, required this.store}) : super(key: key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    store.dispatch(LoadFriendsAction(context: context));
    return StoreConnector<AppState, List<Friend>>(
        builder: (BuildContext context, List<Friend> friends) {
          return Center(
            child: friends.isNotEmpty
                ? _userList(context, friends)
                : const CircularProgressIndicator(),
          );
        },
        converter: (store) => store.state.friends);
  }

  Widget _userList(BuildContext context, List<Friend> friends) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => store.dispatch(SetUserIdAction(
                newId: friends[index].id, context: context)),
            child: ListTile(
              title: Text(friends[index].name),
              subtitle: Text(friends[index].userName),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: friends.length);
  }
}
