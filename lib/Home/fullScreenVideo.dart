import 'dart:async';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

import '../Helper/Utils/common_utils.dart';


class FullScreenVideo extends StatefulWidget {
  String Link;

  FullScreenVideo({Key? key, required this.Link}) : super(key: key);

  @override
  State<FullScreenVideo> createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo> {
  late VideoPlayerController _controller;
  late Future<void> _video;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.Link);
    _video = _controller.initialize();
    //  setLandscape();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        backgroundColor: Colors.black.withOpacity(0.10),
        appBar: AppBar(
            backgroundColor: Colors.black.withOpacity(0.10),
            leading: Container(
              child: IconButton(
                icon: new Image.asset(
                  "Assets/Image/back.png",
                  alignment: Alignment.topLeft,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )),
        body: SafeArea(
          child: WillPopScope(
        onWillPop: () async {
         
          return await true;
        },
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Stack(
                children: [
                  Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height,
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 300
                          : MediaQuery.of(context).size.height * 0.75,
                      child: SizedBox(child: VideoPlayer(_controller))),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                    ),
                  ),
                  Positioned(
                    left: 50,
                    right: 50,
                    top: 50,
                    bottom: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Duration currentPosition =
                                  _controller.value.position;
                              Duration targetPosition =
                                  currentPosition - const Duration(seconds: 10);
                              _controller.seekTo(targetPosition);
                            },
                            // ignore: prefer_const_constructors
                            icon: Icon(
                              Icons.replay_10,
                              color: Colors.black,
                              size: 35,
                            )),
                        IconButton(
                            onPressed: () {},
                            // ignore: prefer_const_constructors
                            icon: Icon(
                              Icons.skip_previous,
                              color: Colors.black,
                              size: 35,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                              });
                            },
                            // ignore: prefer_const_constructors
                            icon: _controller.value.isPlaying
                                ? const Icon(Icons.pause, color: Colors.black)
                                : const Icon(
                                    Icons.play_arrow,
                                    color: Colors.black,
                                    size: 35,
                                  )),
                        IconButton(
                            onPressed: () {},
                            // ignore: prefer_const_constructors
                            icon: Icon(
                              Icons.skip_next,
                              color: Colors.black,
                              size: 35,
                            )),
                        IconButton(
                            onPressed: () {
                              Duration currentPosition =
                                  _controller.value.position;
                              Duration targetPosition =
                                  currentPosition + const Duration(seconds: 10);
                              _controller.seekTo(targetPosition);
                            },
                            // ignore: prefer_const_constructors
                            icon: Icon(
                              Icons.forward_10,
                              color: Colors.black,
                              size: 35,
                            ))
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 30,
                    child: IconButton(
                      // ignore: prefer_const_constructors
                      icon: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? const Icon(Icons.fullscreen, color: Colors.white)
                          : const Icon(
                              Icons.fullscreen_exit,
                              color: Colors.white,
                              size: 35,
                            ),
                      onPressed: () {
                        if (MediaQuery.of(context).orientation ==
                            Orientation.portrait) {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeLeft,
                            DeviceOrientation.landscapeRight,
                          ]);
                        } else {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitDown,
                            DeviceOrientation.portraitUp,
                          ]);
                        }
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 28,
                    child: InkWell(
                      onTap: (() async {
                        Map<Permission, PermissionStatus> statuses = await [
                          Permission.storage,
//add more permission to request here.
                        ].request();
                        if (statuses[Permission.storage]!.isGranted) {
                          var dir =
                              await DownloadsPathProvider.downloadsDirectory;
                          if (dir != null) {
                            String savename = "${widget.Link}";
                            String savePath = dir.path + "/$savename";
                            print(savePath);

//output: /storage/emulated/0/Download/banner.png

                            try {
                              Dio().download(widget.Link, savePath,
                                  onReceiveProgress: (received, total) {
                                if (total != -1) {
                                  print((received / total * 100)
                                          .toStringAsFixed(0) +
                                      "%");
//you can build progressbar feature too
                                }
                              });
                              print("File is saved to download folder.");
                              CommonUtils.toastMessage(
                                  "File Downloaded successfully");
                            } on DioError catch (e) {
                              print(e.message);
                            }
                          }
                        } else {
                          print("No permission to read and write.");
                        }
                      }),
                      child: Image.asset(
                        "Assets/Image/threeDot.png",color: Colors.white,
                       // alignment: Alignment.topLeft,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,)
            ]),
          ),
        )
        )
        );
  }
}
