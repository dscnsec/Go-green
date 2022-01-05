import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_green/provider/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class UploadPage extends StatefulWidget {
  final String taskName;
  const UploadPage({Key? key, required this.taskName}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {

  File? imageOrVideo;
  UploadTask? task; 

  Future pickImage(ImageSource source)async{
    try {
      final image= await ImagePicker().pickImage(source: source);
      if(image==null) return;
      
      final imageTemporary = File(image.path);
      imageOrVideo = imageTemporary;
    } on PlatformException catch (e) {
      debugPrint('Failed to pick file: $e');
    }
  }
  Future pickVideo(ImageSource source)async{
    try{
      final video = await ImagePicker().pickVideo(source: source);
      if(video==null) return;

      final imageTemporary = File(video.path);
      imageOrVideo = imageTemporary;
    } on PlatformException catch (e){
      debugPrint('Failed to pick file: $e');
    }
  }

  Future uploadImageVideo() async {
    if(imageOrVideo==null) return;

    final fileName = basename(imageOrVideo!.path);
    final destination = 'UserUploads/${DataBase.userUid}/$fileName';

    task= DataBase().uploadFile(destination, imageOrVideo!);

    setState(() {
    });

  }
  Widget buildUploadStatus(BuildContext context,UploadTask task)=> StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot){
      if(snapshot.hasData){
        final snap = snapshot.data!;
        final progress= snap.bytesTransferred/snap.totalBytes;
        final percentage = (progress*100).toStringAsFixed(2);
        debugPrint('percentage : $percentage');
        if(progress==1){
          debugPrint('image or video file uploaded');
          debugPrint('total score in uploadpage: ${DataBase.totalScore}');
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
            debugPrint('timestamp: $timeStamp');
            Provider.of<DataBase>(context, listen: false).updateTask(taskName: widget.taskName, status: true, updateScoreBy: 10);
            await Future.delayed(const Duration(seconds: 2),(){});
            Navigator.pop(context);
           });
        }

        return Text(
          'Uploaded $percentage %',
          style: const TextStyle(
            fontSize: 15, 
            fontWeight: FontWeight.bold,
          ),
        );
      }
      else{
        return const Text('starting upload...', style: TextStyle(fontWeight: FontWeight.bold),);
      }

   });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                ),
                
                Flexible(
                  child: Column(
                    children: [
                      Text('Upload a pic or a video to complete this task!',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.02,
                          ),
                          const Icon(
                            Icons.task_rounded,
                          ),
                          const SizedBox( width: 10,),
                          SizedBox(
                            width: 255,
                            child: Text(
                              widget.taskName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              )
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.06,
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Image.asset('assets/images/upload_image.png', 
                            scale: 3,),
                            const SizedBox(
                              height: 30,
                            ),
                            ActionChip(
                              avatar: const Icon(Icons.image),
                              label: const Text('Picture', 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                )
                                ), 
                              labelPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                              shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              onPressed: ()async{
                                await pickImage(ImageSource.camera);
                                uploadImageVideo();
                              }
                            ),
                            const SizedBox( 
                              height: 15
                              ),
                            ActionChip(
                              avatar: const Icon(Icons.video_camera_back),
                              label: const Text(
                                'Video',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold 
                                )
                              ),
                              labelPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              onPressed: ()async{
                                await pickVideo(ImageSource.camera);
                                uploadImageVideo();
                              }
                            ),
                            const SizedBox( 
                              height:15,
                            ),
                            ActionChip(
                              avatar: const Icon(Icons.cancel),
                              label: const Text('Cancel',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),), 
                              labelPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              onPressed: (){
                                Navigator.of(context).pop();
                              }),
                              const SizedBox(height: 20,),
                              task != null ? buildUploadStatus(context, task!) : const Text(
                                'File not selected!', 
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                          ],
                        )),
                    ],
                  )
                 ),
              ],
            ),
          ),
        )
        ,),
    );
  }
}