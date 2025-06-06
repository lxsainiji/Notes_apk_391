import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/home.dart';
import 'db_helper.dart';

class EditPage extends StatefulWidget{
  int? id;
  EditPage({required this.id});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  DBHelper varDb =DBHelper.getInstance();
  List<Map<String,dynamic>> editNotesData=[];
  @override
  void initState() {
    super.initState();
    editData();
  }

  void editData()async{
    editNotesData=await varDb.editView(widget.id!);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    var editNoteTitle=TextEditingController();
    var editNoteDes=TextEditingController();
    if(editNotesData.isNotEmpty){
      editNoteTitle.text=editNotesData[0][DBHelper.columnNoteTitle];
      editNoteDes.text=editNotesData[0][DBHelper.columnNoteDes];
    }
    else{
      editNoteTitle.text="Loading...";
      editNoteDes.text="Loading...";
    }

    return Scaffold(
        backgroundColor: Color(0xff252525),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
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
                          color: Color(0xff3b3b3b),
                          borderRadius: BorderRadius.circular(7)
                      ),
                      child: Icon(Icons.keyboard_backspace,size: 30,color: Colors.white,),
                    ),
                  ),
                  InkWell(
                    onTap: ()async{
                      bool check =await varDb.updateNote(editNoteTitle.text, editNoteDes.text, widget.id!);
                      if(check){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                          return HomePage();
                        }));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color(0xff3b3b3b),
                          borderRadius: BorderRadius.circular(7)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("Save",style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700
                        ),),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      controller: editNoteTitle,
                      autofocus: true,
                      style: TextStyle(color: Colors.white,fontSize: 32),
                      keyboardType: TextInputType.multiline,
                      // maxLines: null,
                      // minLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Title...',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                      ),
                      cursorColor: Colors.white54,
                    ),
                    TextField(
                      controller: editNoteDes,
                      autofocus: true,
                      style: TextStyle(color: Colors.white,fontSize: 22),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 1, 
                      decoration: InputDecoration(
                        hintText: 'Type something...',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                      ),
                      cursorColor: Colors.white54,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
