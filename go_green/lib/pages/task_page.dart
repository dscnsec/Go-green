import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  var _score=0;

  Widget _taskScoreBoard({required int score}){

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
                '$score',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30, 
                  fontWeight: FontWeight.w900,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  final Map<String, bool> _tasks= {
    'Reuse scrap paper. Print on two sides, or use back side of used paper.': false,
    'Wash cars or bikes with bucket of water instead of water jet sprays.': false,
    'Pass down your old bike, skates and other toys or donate to a local charity.': false,
  };

  Widget taskList(){

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
        ListView(
          shrinkWrap: true,
          children: _tasks.keys.map((String taskName){ 
          return CheckboxListTile(
           title: Text(taskName, style: TextStyle(
             fontSize: 14,
             fontWeight: FontWeight.w600,
             color: Colors.grey.shade800),
           ),
           activeColor: Colors.grey.shade800,
           controlAffinity: ListTileControlAffinity.leading,
           visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
           value: _tasks[taskName],
           onChanged: (bool? value){
             setState(() {
               _tasks[taskName]=value!;
               if(value) {
                 _score+=10;
               } else {
                 _score-=10;
               }
             });
           },
          );
        }).toList(),)
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
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                ),
                Flexible(child: _taskScoreBoard(score: _score)),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.01,
                ),
                Flexible(child: taskList()),
              ],
            ),),
        )), 
    );
  }
}

