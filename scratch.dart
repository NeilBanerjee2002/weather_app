import 'dart:io';

void main(){
  performTask();
}

void performTask() async{
  task1();
  String task2result = await task2();
  task3(task2result);
}

void task1(){
  String result = 'task 1 data';
  print('task 1 completed');
}

Future<String> task2() async {
  Duration threesecdelay = Duration(seconds: 3);
  String result = 'Default val';
  await Future.delayed(threesecdelay, (){
    result = 'task 2 data';
    print('task 2 completed');
  });
  return result;
}

void task3(String task2data){
  String result = 'task 3 data';
  print('task 3 completed with $task2data');
}


