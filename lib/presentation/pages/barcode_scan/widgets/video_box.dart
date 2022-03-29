import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../../data/models/barcode_timestamp_model.dart';
import '../../../../shared/app_theme.dart';
import '../barcode_scan_viewmodel.dart';

class VideoBox extends StatefulWidget {
  final String path;
  final List<BarcodeTimeStampModel> barcodeTimeStamps;
  VideoBox(this.path, this.barcodeTimeStamps);
  @override
  _VideoBoxState createState() => _VideoBoxState();
}

class _VideoBoxState extends State<VideoBox> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      })
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          Positioned(
            bottom: 0,
            child: Material(
              elevation: 5,
              color: AppTheme().greyScale1.withOpacity(0.55),
              child: Container(
                margin: EdgeInsets.only(left: 15, top: 10),
                width: 1.sw,
                height: 100,
                child: ListView(
                  children: [
                    Text(
                      'Barcode TimeStamps',
                      style: AppTheme()
                          .smallParagraphSemiBoldText
                          .copyWith(color: Colors.white),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.barcodeTimeStamps.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Text(
                          '${widget.barcodeTimeStamps[index].barcode} - ${widget.barcodeTimeStamps[index].timeStamp}',
                          style: AppTheme()
                              .smallParagraphRegularText
                              .copyWith(color: Colors.white),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme().primaryColor,
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
