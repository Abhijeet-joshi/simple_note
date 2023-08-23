import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_note/cubit/list/ListCubit.dart';

import 'appScreens/HomeScreen.dart';

void main(){

  runApp(BlocProvider(
      create: (context) => ListCubit(),
      child: myApp(),
  )
  );

}

class myApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: HomeScreen(),
    );
  }

}
