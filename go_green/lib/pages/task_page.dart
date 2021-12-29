
import 'package:flutter/material.dart';
import 'package:go_green/provider/database.dart';
import 'package:go_green/pages/upload_page.dart';
import 'package:provider/provider.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
 
  //int totalScore=0;
  //Map<String, bool> taskList={};


  Widget _taskScoreBoard(){

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/tree_image.png',
          fit: BoxFit.contain,
          scale: 3, 
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
                    'Total Score:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey.shade800,
                    )
                  ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
              width: 100,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade800,
                  width: 5,
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text( 
                    Provider.of<DataBase>(context).readTotalScore().toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30, 
                      fontWeight: FontWeight.w900,
                      color: Colors.grey.shade800,
                    ),
                  )
              ),
          ],
        )
      ],
    );
  }



  Widget taskContainer(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            'Tasks for today:',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.bold
            ), 
            ),
        ),
        const SizedBox(
            height: 20, 
          ),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.99,
          height: MediaQuery.of(context).size.height*0.3,
          //tasklistbuilder
          child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: DataBase.taskList.keys.map((String taskName){ 
              return CheckboxListTile(
               title: Text(taskName, style: TextStyle(
                 fontSize: 14,
                 fontWeight: FontWeight.w600,
                 color: Colors.grey.shade800),
               ),
               activeColor: Colors.grey.shade800,
               controlAffinity: ListTileControlAffinity.leading,
               visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
               value: DataBase.taskList[taskName],
               onChanged: (bool? value){
                 setState(() {
                   if(value!) {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadPage(taskName: taskName)));
                   } else {
                     Provider.of<DataBase>(context, listen: false).updateTask(taskName: taskName, status: value, updateScoreBy: -10);
                   }
                 });
               },
              );
            }).toList(),),
          ),
      ],
    );
  }

    @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.9,
          child: FutureBuilder<Map<String, dynamic>>(
            future: DataBase().readTasksList(),
            builder: (context, snapshot) {
              if(snapshot.hasData){

               if(DataBase.taskList.isEmpty){
                final userData= snapshot.data;
                final fulltaskList= Map<String, bool>.from(userData?['tasklist']);
                DataBase.name=userData!['name'];
                DataBase.name=DataBase.name.toString().toCapitalize;
                DataBase.totalScore=userData['score'];
                //number of tasks
                int c=0;
                //shortlisting the number of tasks
                fulltaskList.forEach((key, value) { if(value==false && c<3 ){ DataBase.taskList[key]=value; c++; }});
                 
               }
               
               return SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.1,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.34,
                      child: Column(
                      children: [
                        Container(
                          transform: Matrix4.translationValues(
                            -5,
                           -50, 0),
                          child: SizedBox(
                            width: 300,
                            child: Text('Welcome\n${DataBase.name}!', 
                              softWrap: true,
                              style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800
                            )),
                          ),
                        ),
                        _taskScoreBoard(),
                      ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.01,
                    ),
                    Flexible(child: taskContainer(context)),
                  ],
                ),);
              }
              else if(snapshot.hasError){
                return SafeArea(child: Center(
                  child: Text(
                  'Error ${snapshot.error}',
              
                )));
              }
              else{
                return const SafeArea(child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),));
              }
              
            }
          ),
        )), 
    );
  }
}

extension CapExtension on String {
    String get toCapitalize => split(" ").map((str)=> str[0].toUpperCase()+str.substring(1)).join(" ");
} 

