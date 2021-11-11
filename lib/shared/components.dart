//import 'package:conditional_builder/conditional_builder.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:database/cubit/cubit.dart';
import 'package:flutter/material.dart';

Widget defultformfield({
  required String text,
  required IconData prefix,
  required TextInputType type,
  required TextEditingController controller,
  //required  Function validate, 
  bool ispassword =false,
  Function? ontap,
  IconData? suffix,
  Function? suffixPressed,
})
{
  
  return TextFormField(
decoration: InputDecoration(
  labelText: text,
  prefixIcon: Icon(prefix),
  border: OutlineInputBorder(),
  suffixIcon: suffix !=null ? IconButton(
    onPressed: (){
      suffixPressed!();},
     icon: Icon(suffix),) : null, 
  ),
  onTap: ()
   {
     ontap!();
  },   
 validator:(String ?value)
 {
    if(value!.isEmpty)
     {
       return ('must not be empty');
     }},
  controller:controller ,
);
}


Widget listOfNewTasks(Map models,context)=>Dismissible(
  key:Key(models['id'].toString()),
   child:   Padding(
  
        padding: const EdgeInsets.all(20.0),
  
        child: Row(
  
          children: [
  
            CircleAvatar(
  
               radius: 32,
  
               child: Text('${models['time']}'),
  
            ),
  
            SizedBox(width: 30,),
  
            Expanded( child: Column(
  
                crossAxisAlignment: CrossAxisAlignment.start,
  
                mainAxisSize: MainAxisSize.min,
  
                children: [
  
                  Text('${models['title']}',
  
                  style:TextStyle(
  
                    fontWeight: FontWeight.bold,
  
                    fontSize: 30
  
                  ),),
  
                  Text('${models['data']}',
  
                  style:TextStyle(
  
                    fontWeight: FontWeight.bold,
  
                    fontSize: 15,
  
                    color: Colors.grey,
  
                  ),),
  
               
  
                ],
  
              ),
  
            ),
  
            IconButton(
  
              onPressed: (){
  
                 currentCubit.get(context).updata(
  
                   status:'done' ,
  
                    id: models['id']);
  
              }, 
  
              icon:Icon(Icons.check_box,
              color: Colors.green[400],) ), 
  
             SizedBox(width: 30,),
  
             IconButton(
  
              onPressed: (){
  
                   currentCubit.get(context).updata(
  
                   status:'archive' ,
  
                    id: models['id']);
  
              }, 
  
              icon:Icon(Icons.archive,
              color: Colors.black45,) ), 
  
           ],
  
        ),
  
      ),
  onDismissed: (direction)
  {
    currentCubit.get(context).delete(id: models['id']);
  },
  );


Widget tasksBuilder({
  required List<Map> tasks,
}) =>BuildCondition(
  condition: tasks.length>0, 
  builder: (context)=>ListView.separated(
        itemBuilder: (context,index)=>listOfNewTasks(tasks[index],context), 
        separatorBuilder: (context,index)=>
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey,
        ), 
         itemCount:tasks.length
         ),

  fallback:(context)=>Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Icon(Icons.menu,
      color: Colors.black54,
      size: 40,
      ),
      Text('No Tasks Yet, Please Add Some Tasks',
      style: TextStyle(
        fontSize: 30,
        color: Colors.black54,
        fontWeight: FontWeight.w900,
      ),)
    ],),
  ) ,
);
