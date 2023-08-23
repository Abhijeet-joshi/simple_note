import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_note/appScreens/AddScreen.dart';
import 'package:simple_note/appScreens/EditScreen.dart';
import 'package:simple_note/cubit/list/ListCubit.dart';
import 'package:simple_note/cubit/states/state_cubit.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ListCubit>(context).getInitialDataCubit();
  }

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<ListCubit>(context).getInitialDataCubit();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Row(
          children: [
            const Expanded(flex: 9, child: Text("Simple Note")),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder) => AddScreen()));
              },
              child: const Icon(
                Icons.add,
                size: 35,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10,),
          ],
        ),
      ),
      body: BlocBuilder<ListCubit, StateCubit>(builder: (ctx, state){
        notes = state.arrData;
        return Column(
          children: [
            const SizedBox(height: 10,),
            Text("${notes.length.toString()} ${getCountWord(notes.length)} added", style: TextStyle(color: Colors.grey.shade600),),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (ctx, index){
                  var currNote = state.arrData[index];
                  return noteCard(NOTE_ID: "${currNote["note_id"]}" ,NOTE_TITLE: "${currNote["note_title"]}", NOTE_DESCRIPTION: "${currNote["note_desc"]}");
              },),
            ),
          ],
        );
      }),
      );
  }

  Widget noteCard({required String NOTE_ID, required String NOTE_TITLE, required String NOTE_DESCRIPTION}) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset(0, 3)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 21),
                    child: SelectableText(
                      NOTE_TITLE,
                      style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder) =>
                            EditScreen(mID: NOTE_ID, mTitle: NOTE_TITLE, mDesc: NOTE_DESCRIPTION,)));
                      },
                        child: const Icon(Icons.edit, color: Colors.grey,))),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: (){

                        // set up the buttons
                        Widget cancelButton = TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            //cancel dialog
                            Navigator.pop(context);
                          },
                        );
                        Widget deleteButton = TextButton(
                          child: const Text("Delete"),
                          onPressed: () async{
                            //delete query
                            BlocProvider.of<ListCubit>(context).deleteDataCubit(id: NOTE_ID);
                            Navigator.pop(context);
                          },
                        );
                        AlertDialog alert = AlertDialog(
                          title: const Text("Do you want to delete this note ?"),
                          actions: [
                            cancelButton,
                            deleteButton,
                          ],
                        );
                        // show the dialog
                        showDialog(context: context, builder: (BuildContext context) {
                          return alert;
                        });

                      },
                        child: Icon(Icons.delete, color: Colors.grey,))),
              ],
            ),
            Divider(
              color: Colors.grey.shade800,
              indent: 21,
              endIndent: 21,
            ),
            Padding(
              padding: EdgeInsets.all(14.0),
              child: SelectableText(NOTE_DESCRIPTION,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ],

        ),
      ),
    );
  }

  String getCountWord(int count){
    String word;
    if(count>1){
      word = "Notes";
    }else{
      word = "Note";
    }
    return word;
  }
}
