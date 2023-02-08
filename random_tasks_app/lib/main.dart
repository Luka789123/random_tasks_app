import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/features/get_activity/data/data_source/remote_datasource.dart';
import 'package:test_app/features/get_activity/presentation/bloc/activity_bloc.dart';
import 'package:test_app/features/get_activity/presentation/route/home_route.dart';
import 'injection_container.dart' as ic;
import 'injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ic.init();
  runApp(MultiBlocProvider(
    providers: [BlocProvider(create: (_) => sl<ActivityBloc>())],
    child: BoredApp(),
  ));
}

class BoredApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.cyan,
          textTheme: TextTheme(
              bodyLarge: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                  fontSize: 25),
              bodyMedium: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
              labelMedium: TextStyle(
                  color: Colors.grey.shade100,
                  fontWeight: FontWeight.w600,
                  fontSize: 15))),
      home: HomeRoute(),
    );
  }
}
