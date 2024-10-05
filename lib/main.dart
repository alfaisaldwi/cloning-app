import 'package:fast8_test/modules/tabs/bloc/navbar_bloc.dart';
import 'package:fast8_test/modules/tabs/tabs_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBloc(), 
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavigationView(),
      ),
    );
  }
}
