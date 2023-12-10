import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_course/controllers/read_data_cubit/read_data_cubit.dart';
import 'package:hive_course/controllers/write_data_cubit/write_data_cubit.dart';
import 'package:hive_course/hive_constants.dart';
import 'package:hive_course/model/word_type_adapter.dart';
import 'package:hive_course/view/screens/home_screen.dart';
import 'package:hive_course/view/styles/theme_manager.dart';

import 'package:hive_flutter/hive_flutter.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordTypeAdapter());
  await Hive.openBox(HiveConstants.wordsBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>ReadDataCubit()..getWords()),
        BlocProvider(create: (context)=>WriteDataCubit()),
      ], 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeManager.getAppTheme(),
        home:const HomeScreen(),
      ),
      );
  }
}
