import 'package:flutter/material.dart';

import 'package:test_app_im_good/redux/my_redux.dart';
import 'package:test_app_im_good/redux/middleware.dart';

import 'package:test_app_im_good/screens/home_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

main() => runApp(const MyApp());

//----for clear data
//_clearSharedPreferences();
//------------------

void _clearSharedPreferences() async {
  var prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = Store<AppState>(
        reducer,
        initialState: AppState.initState(),
        middleware: [
          loaderMiddleware
        ]
    );
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          home: HomeScreen(store: store),
        )
    );
  }
}
