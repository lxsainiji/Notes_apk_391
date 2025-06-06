import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/add.dart';
import 'package:notes/db_helper.dart';
import 'package:notes/view.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateFormat df=DateFormat.yMMMd();
  DBHelper varDb =DBHelper.getInstance();
  List<Map<String,dynamic>> NotesData=[];

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  getNotes()async{
    NotesData=await varDb.fetchNotes();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xff131212FF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Notes",style: TextStyle(
                  color: Colors.white,
                  fontSize: 32
                ),),
                Row(
                  children:[
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_){
                          return AddPage();
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Color(0xff3b3b3b),
                            borderRadius: BorderRadius.circular(7)
                        ),
                        child: Icon(Icons.add,size: 30,color: Colors.white,),
                      ),
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color(0xff3b3b3b),
                          borderRadius: BorderRadius.circular(7)
                      ),
                      child: Icon(Icons.search,size: 30,color: Colors.white,),
                    ),
                  ]
                )
              ],
            ),
            Expanded(
              child: NotesData.isNotEmpty ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200,
                      // childAspectRatio: 8/8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing:10,
                  ),
                  itemCount: NotesData.length,
                  itemBuilder: (_,index){
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_){
                          return ViewPage(ind: index);
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.cyanAccent,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(NotesData[index][DBHelper.columnNoteTitle],maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                  color: Colors.red.shade400
                                ),),
                                Text(NotesData[index][DBHelper.columnNoteDes],maxLines: 4,overflow: TextOverflow.ellipsis,style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700
                                ),),
                              ],
                            ),

                            Center(
                              child: Text(df.format(DateTime.fromMillisecondsSinceEpoch(int.parse(NotesData[index][DBHelper.columnCreatedAt]))),maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.w900
                              ),),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              ) :Center(child: Text("No Data Yet!!",style: TextStyle(
                fontSize: 28,
                color: Colors.white
              ),),)
            )
          ],
        ),
      )
    );
  }
}