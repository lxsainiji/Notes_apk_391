import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/home.dart';
import 'db_helper.dart';

class AddPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    DBHelper varDb =DBHelper.getInstance();
    var addNoteDes=TextEditingController();
    var addNoteTitle= TextEditingController();
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
                    onTap: () async {
                      var rowAffectes =await varDb.add(addNoteTitle.text, addNoteDes.text);
                      if(rowAffectes){
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
                        child: Text("Add",style: TextStyle(
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
                      controller: addNoteTitle,
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
                      controller: addNoteDes,
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
