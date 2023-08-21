import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_note/cubit/ListCubit.dart';
import 'package:simple_note/customWidgets/customWidgets.dart';

late String ID;
String? OLD_TITLE;
String? OLD_DESC;

class EditScreen extends StatefulWidget {
  EditScreen(
      {super.key,
      required String mID,
      required String mTitle,
      required String mDesc}) {
    ID = mID;
    OLD_TITLE = mTitle;
    OLD_DESC = mDesc;
  }

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleCtrl.text = OLD_TITLE!;
    descCtrl.text = OLD_DESC!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
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
                CustomWidgets().customTextField(
                    ctrl: titleCtrl,
                    hint: "Enter Title",
                    fontWeight: FontWeight.bold),
                const SizedBox(
                  height: 20,
                ),
                CustomWidgets().customTextField(
                    ctrl: descCtrl,
                    hint: "Enter Description",
                    fontWeight: FontWeight.normal),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: CustomWidgets().customElevatedButton(
                      btnText: "Clear",
                      btnClr: Colors.red,
                      voidCallback: () {
                        titleCtrl.clear();
                        descCtrl.clear();
                      }),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 5,
                  child: CustomWidgets().customElevatedButton(
                      btnText: "Update",
                      btnClr: Colors.blue,
                      voidCallback: () {
                        if (titleCtrl.text.isEmpty || descCtrl.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "All Fields are Mandatory",
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey.shade200,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        } else {
                          String NEW_TITLE = titleCtrl.text.toString();
                          String NEW_DESC = descCtrl.text.toString();
                          BlocProvider.of<ListCubit>(context).updateDataCubit(
                              noteId: ID,
                              noteTile: NEW_TITLE,
                              noteDesc: NEW_DESC);
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
