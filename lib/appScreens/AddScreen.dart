import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_note/cubit/list/ListCubit.dart';
import 'package:simple_note/customWidgets/customWidgets.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomWidgets().customTextField(ctrl: titleCtrl, hint: "Enter Title", fontWeight: FontWeight.bold),
                const SizedBox(height: 20,),
                CustomWidgets().customTextField(ctrl: descCtrl, hint: "Enter Description", fontWeight: FontWeight.normal),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: CustomWidgets().customElevatedButton(btnText: "Clear", btnClr: Colors.red, voidCallback: () {
                    titleCtrl.clear();
                    descCtrl.clear();
                  }),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 5,
                  child: CustomWidgets().customElevatedButton(btnText: "Save", btnClr: Colors.lightGreen, voidCallback: () {
                    if(titleCtrl.text.isEmpty || descCtrl.text.isEmpty){
                      Fluttertoast.showToast(
                          msg: "All Fields are Mandatory",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey.shade200,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );
                    }else{
                      int noteId = DateTime.now().millisecondsSinceEpoch;
                      String noteTitle = titleCtrl.text.toString();
                      String noteDescription = descCtrl.text.toString();
                      BlocProvider.of<ListCubit>(context).addDataCubit(noteId: noteId.toString(), noteTitle: noteTitle, noteDesc: noteDescription);
                      Navigator.pop(context);
                    }
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
