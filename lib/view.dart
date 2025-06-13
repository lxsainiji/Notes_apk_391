import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/db_helper.dart';
import 'package:notes/edit.dart';
import 'package:notes/home.dart';
import 'package:notes/notes_provider.dart';
import 'package:provider/provider.dart';

class ViewPage extends StatefulWidget{
  int? ind;
  ViewPage({required this.ind});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  DateFormat df=DateFormat.yMMMd();
  List<Map<String,dynamic>> NotesData=[];
  @override
  void initState() {
    super.initState();
    context.read<NotesProvider>().fetchInitData();
  }

  @override
  Widget build(BuildContext context) {
    NotesData=context.watch<NotesProvider>().getData();
    if (NotesData.isEmpty) {
      return Scaffold(
        backgroundColor: Color(0xff252525),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
        backgroundColor: Color(0xff252525),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7)
                      ),
                      child: Icon(Icons.keyboard_backspace,size: 30,),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          Provider.of<NotesProvider>(context,listen: false).deleteNote(id: NotesData[widget.ind!][DBHelper.columnNoteId]);
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: Icon(Icons.delete_forever,size: 30,),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_){
                            return EditPage(id: NotesData[widget.ind!][DBHelper.columnNoteId]);
                          }));
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: Icon(Icons.edit_note,size: 30,),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NotesData.isEmpty ? Text("Loading...."):Text(NotesData[widget.ind!][DBHelper.columnNoteTitle],maxLines: 2,overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 33
                      ),),
                    NotesData.isEmpty ? Text("Loading...."):Text(df.format(DateTime.fromMillisecondsSinceEpoch(int.parse(NotesData[widget.ind!][DBHelper.columnCreatedAt]))),maxLines: 2,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 21
                      ),),
                    NotesData.isEmpty ? Text("Loading...."):Text(NotesData[widget.ind!][DBHelper.columnNoteDes],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 24
                      ),),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}