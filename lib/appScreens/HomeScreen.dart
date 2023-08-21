import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_note/appScreens/AddScreen.dart';
import 'package:simple_note/appScreens/EditScreen.dart';
import 'package:simple_note/cubit/ListCubit.dart';
import 'package:simple_note/cubit/state_cubit.dart';

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
              child: CircleAvatar(
                  radius: 21,
                  backgroundColor: Colors.blue.shade300,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
      body: BlocBuilder<ListCubit, StateCubit>(builder: (ctx, state){
        notes = state.arrData;
        return ListView.builder(
          itemCount: notes.length,
          itemBuilder: (ctx, index){
            var currNote = state.arrData[index];
            return noteCard(NOTE_ID: "${currNote["note_id"]}" ,NOTE_TITLE: "${currNote["note_title"]}", NOTE_DESCRIPTION: "${currNote["note_desc"]}");
        },);
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
                  child: Center(
                    child: Text(
                      NOTE_TITLE,
                      style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
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
                        child: Icon(Icons.edit, color: Colors.grey,))),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: (){
                        BlocProvider.of<ListCubit>(context).deleteDataCubit(id: NOTE_ID);
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
              child: Text(NOTE_DESCRIPTION,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ],

        ),
      ),
    );
  }
}
