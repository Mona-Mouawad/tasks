import 'package:database/cubit/cubit.dart';
import 'package:database/cubit/stasts.dart';
import 'package:database/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchiveTask extends StatelessWidget {
  const ArchiveTask({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<currentCubit,curentstate>(
      listener: (context,state){}, 
      builder: (context,state){
        var tasks=currentCubit.get(context).archivetasks;
        return tasksBuilder(tasks: tasks);
    
      },
    ); 
      }
  }


    