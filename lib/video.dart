import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
   late VideoPlayerController _controller;
  late Future<void>_initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller= VideoPlayerController.network("https://cdn.pixabay.com/vimeo/786403437/tiger-145320.mp4?width=640&hash=cbc28d222774e1e78c0c04b517af8d392473f1da");
    _initializeVideoPlayerFuture= _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor:Colors.blue,
        title: Text("Videoplayer tutorial"),

    ),
      body: FutureBuilder(future:
          _initializeVideoPlayerFuture, builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.done){
              return Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              );
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }


          },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if(_controller.value.isPlaying){
              _controller.pause();
            }else(
            _controller.play()
            );
          });
        },
        child: Icon(_controller.value.isPlaying? Icons.pause
        :Icons.play_arrow),
      ),

    );
  }
}
