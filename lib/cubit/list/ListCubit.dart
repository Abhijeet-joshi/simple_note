import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_note/cubit/states/state_cubit.dart';

import '../../database/MyDbHelper.dart';

class ListCubit extends Cubit<StateCubit>{
  ListCubit() : super(StateCubit(arrData: []));

  //emit state to get initial data
  Future<void> getInitialDataCubit()async{
    emit(StateCubit(arrData: await MyDBHelper().fetchAllNotes()));
  }

  //emit states for add data and then fetch them
  void addDataCubit({required String noteId, required String noteTitle, required String noteDesc}) async{
    bool check = await MyDBHelper().addNote(noteId, noteTitle, noteDesc);
    if(check){
      emit(StateCubit(arrData: await MyDBHelper().fetchAllNotes()));
    }else{
      print("Data insertion failed");
    }
  }

  //emit states to update data and then fetch them
  void updateDataCubit({required String noteId, required String noteTile, required String noteDesc}) async{
    bool check = await MyDBHelper().updateNote(noteId, noteTile, noteDesc);
    if(check){
      emit(StateCubit(arrData: await MyDBHelper().fetchAllNotes()));
    }else{
      print("Data updation failed");
    }
  }

  //emit states to delete data and fetch
  void deleteDataCubit({required String id}) async{
    bool check = await MyDBHelper().deleteNote(id);
    if(check){
      emit(StateCubit(arrData: await MyDBHelper().fetchAllNotes()));
    }else{
      print("Data deletion failed");
    }
  }




}