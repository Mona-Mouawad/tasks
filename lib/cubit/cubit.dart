import 'package:bloc/bloc.dart';
import 'package:database/cubit/stasts.dart';
import 'package:database/modules/archived.dart';
import 'package:database/modules/done.dart';
import 'package:database/modules/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class currentCubit extends Cubit<curentstate> {

  currentCubit() : super(initalstate());

 static currentCubit get(context)=> BlocProvider.of(context);

  late Database database;
  List<Map> newtasks=[];
  List<Map> donetasks=[];
  List<Map> archivetasks=[];

  int curentindex=0;
  List<Widget> screen=[
  NewTask(),
  DoneTask(),
  ArchiveTask()
  ];

  List<String> title=[
  'New Tasks',
  'Done Tasks',
  'Archive Tasks'
  ];
  
  void changeIndex(index)
  {
    curentindex=index;
    emit(changebottomBarstate());
  }

  void createdatabase() 
{
  openDatabase(
    'todo.db',
    version: 1,
    onCreate: (database,version) 
    {
      database.execute('CREATE TABLE Tasks(id INTEGER PRIMARY KEY, title TEXT ,data TEXT,time TEXT,status TEXT)').then(
        (value) => print('creat db'));
    },
    onOpen: (database)
    {
      getDatabase(database);
      print('database opened');
     // emit(C_getdatabase());
      }
   
  ).then((value){
    database=value;
    emit(C_createdatabase());
  });
}

 insertDatabase({
    required String title,
    required String data,
    required String time
  }
)async
{
  await  database.transaction((txn) => 
 txn.rawInsert('INSERT INTO Tasks(title,data,time,status) VALUES("$title","$data","$time","new")')
 .then((value) {
   print('$value inserted');
   emit(C_insertdatabase());

   getDatabase(database);

 }));
}
void  getDatabase(database) 
{newtasks=[];
donetasks=[];
archivetasks=[];
  
  emit(Loading_getdatabase());
database.rawQuery('SELECT * FROM Tasks').then((value)
{
  value.forEach((element)
  {
    if(element['status']== 'new')
    {
      newtasks.add(element);
    }
    else if(element['status']== 'done')
    {
      donetasks.add(element);
    }
    else archivetasks.add(element);
  }); 
emit(C_getdatabase());
});

}

void updata({
  required String status,
  required int id 
})async
{
  database.rawUpdate('UPDATE tasks SET status = ? WHERE id =?',
  ['$status',id]).then((value) 
  {
    getDatabase(database);
    emit(C_UpdateDatabaseState());
  });
}

void delete({
  required int id 
})async
{
  database.rawDelete('DELETE FROM tasks  WHERE id =?',
  [id]).then((value) 
  {
    getDatabase(database);
    emit(C_DeleteDatabaseState());
  });
}
 
  IconData prefix =Icons.edit ;
  bool ontappres =false;

  void changbottomsheet({required IconData icon,
    required bool isShow}
  )
  {
   prefix=icon;
   ontappres=isShow;
   emit(changebottomsheetstate());
  }

}
