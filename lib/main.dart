import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'persistence/appDatabase.dart';
import 'ui/PersonScreen.dart';
import 'viewmodels/PersonViewModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('appDatabase.db').build();

  runApp(MyApp(database));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;

  const MyApp(this.database, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PersonViewModel(database),
      child: MaterialApp(
        title: 'Person List',
        home: PersonScreen(),
      ),
    );
  }
}
