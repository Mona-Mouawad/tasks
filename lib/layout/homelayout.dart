import 'package:buildcondition/buildcondition.dart';
import 'package:database/cubit/cubit.dart';
import 'package:database/cubit/stasts.dart';
import 'package:database/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class homelayout extends StatelessWidget {
  //const homelayout({ Key? key }) : super(key: key);

  var scffoldkey =GlobalKey<ScaffoldState>();
  var formkey =GlobalKey<FormState>();
  var textcontroller =TextEditingController();
  var timecontroller =TextEditingController();
  var datecontroller =TextEditingController();
 

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (BuildContext context)=>currentCubit()..createdatabase(),
      child: BlocConsumer<currentCubit,curentstate>(
       listener: (BuildContext context,curentstate state){
           if(state is C_insertdatabase)
           { Navigator.pop(context);}
         },
      
        builder: (BuildContext context,curentstate state){
          currentCubit C = currentCubit.get(context);
        return  Scaffold(
        key: scffoldkey,
        appBar: AppBar (
          title: Text(C.title[C.curentindex]),),  
        body:BuildCondition(
          condition: state is! Loading_getdatabase, 
          builder:(context)=> C.screen[C.curentindex],
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
          ),
      
       floatingActionButton:
        FloatingActionButton(
          onPressed:()
          { 
            if(C.ontappres)
            {  if(formkey.currentState!.validate()){
               C.insertDatabase(
                title:textcontroller.text , 
                data: datecontroller.text ,
                time: timecontroller.text
                );
              }
           }
 
           else{
              scffoldkey.currentState!.showBottomSheet(
              (context) => Container(
                padding: EdgeInsets.all(20),
                child: Form(
                   key: formkey,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [ 
                        defultformfield(
                        text: 'Task Title', 
                        prefix:Icons.title,
                        type: TextInputType.text,
                        controller: textcontroller, 
                      /*  validate: (String value){
                            if(value.isEmpty)
                            {return'title must not be empty';}
                          }
                         */ 
                         ),
                         
                         SizedBox(height: 20,),
                       
                         defultformfield(
                        text: 'Task Time', 
                        prefix:Icons.watch_later_outlined,
                        type: TextInputType.datetime,
                         controller: timecontroller, 
                         ontap: ()
                          {
                            showTimePicker(
                              context: context, 
                              initialTime: TimeOfDay.now()
                              ).then((value) => 
                              timecontroller.text=value!.format(context).toString() );
                            },
                        /*  validate: (String value){
                            if(value.isEmpty)
                            {return'time must not be empty';}
                          },
                          */
                         ),
                         SizedBox(height: 20,),
                       
                         defultformfield(
                        text: 'Task Date', 
                        prefix:Icons.calendar_today_outlined,
                        type: TextInputType.text,
                         controller: datecontroller, 
                         ontap: ()
                         {
                           showDatePicker(
                             context: context, 
                           initialDate: DateTime.now(), 
                           firstDate: DateTime.now(), 
                            lastDate: DateTime.parse('2021-12-31')
                           ).then((value) => 
                           datecontroller.text=DateFormat.yMMMd().format(value!)
                           ) ;
                         },
                        /* validate: (String value){
                            if(value.isEmpty)
                            {return'Date must not be empty';}
                          },*/
                         ),
                         ],
                         
                    ),
                  ),
                ),
                
              ),
              elevation: 20,
             ).closed.then((value) 
             {
               textcontroller.text='';
               timecontroller.text='';
               datecontroller.text='';
                C.changbottomsheet
               (icon: Icons.edit, 
               isShow: false);
               });
               textcontroller.text='';
               timecontroller.text='';
               datecontroller.text='';
           C.changbottomsheet
               (icon: Icons.add, 
               isShow: true);
               
            
            }
            
           } ,
          child:Icon(C.prefix,) 
          ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: C.curentindex,
          onTap: (index)
          {  C.changeIndex(index); },
    
          items: [
            BottomNavigationBarItem(
              label:'Tasks' ,
              icon:Icon(Icons.menu,
            )) ,
             
            BottomNavigationBarItem(
              label:'Done' ,
              icon:Icon(Icons.check_circle_outline,
            )) ,
            
             BottomNavigationBarItem(
              label:'archived' ,
              icon:Icon(Icons.archive_outlined,
            )) ,
            
       
      
          ],
        ),
       );
   
        },
          )
    );
  }

}


