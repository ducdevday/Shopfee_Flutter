import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:video_player/video_player.dart';

class LocalVideoFullScreen extends StatefulWidget {
  static const String route = "/local_video_full_screen";
  final File file;

  const LocalVideoFullScreen({
    required this.file,
  });

  @override
  State<LocalVideoFullScreen> createState() => _LocalVideoFullScreenState();
}

class _LocalVideoFullScreenState extends State<LocalVideoFullScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(),
        ),
        Positioned(
          top: AppDimen.headerMargin,
          left: AppDimen.screenPadding,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColor.disableColor,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  iconSize: 16,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                )),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
