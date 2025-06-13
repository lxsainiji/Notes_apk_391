import 'package:flutter/material.dart';
import 'package:notes/db_helper.dart';
import 'package:notes/notes_provider.dart';
import 'package:provider/provider.dart';

import 'home.dart';

void main(){
  runApp(ChangeNotifierProvider(create: (_)=>NotesProvider(varDb: DBHelper.getInstance()),child: Myapp(),));
}

class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}