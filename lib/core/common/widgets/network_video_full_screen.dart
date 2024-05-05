import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:video_player/video_player.dart';

class NetworkVideoFullScreen extends StatefulWidget {
  static const String route = "/network_video_full_screen";
  final String url;

  const NetworkVideoFullScreen({
    required this.url,
  });

  @override
  State<NetworkVideoFullScreen> createState() => _NetworkVideoFullScreenState();
}

class _NetworkVideoFullScreenState extends State<NetworkVideoFullScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
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
              NavigationUtil.pop();
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
