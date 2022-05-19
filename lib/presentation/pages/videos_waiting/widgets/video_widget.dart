part of '../videos_waiting_viewmodel.dart';

/// Video widget for How to make video screen

class VideoWidget extends StatefulWidget {
  final ScannedVideoModel scannedVideoModel;
  final String fileLink;
  final Function(ScannedVideoModel) deleteScannedVideo;

  VideoWidget({
    Key? key,
    required this.scannedVideoModel,
    required this.fileLink,
    required this.deleteScannedVideo,
  }) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      widget.fileLink,
    )..initialize().then((_) {
        _controller.addListener(() {
          setState(() {});
        });
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              _controller.pause();
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.symmetric(horizontal: 10),
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                LockOverlayDialog().showCustomOverlay(
                  child: LocationPermissionDialog(
                    descriptionText: 'Are you sure to delete this video?',
                    button1Text: 'Delete',
                    button2Text: 'Cancel',
                    onButton1Tap: () async {
                      LockOverlayDialog().closeOverlay();
                      LockOverlay().showClassicLoadingOverlay();
                      //await Future.delayed(Duration(seconds: 1));
                      await widget.deleteScannedVideo(widget.scannedVideoModel);
                      LockOverlay().closeOverlay();
                      Navigator.pop(context);
                    },
                    onButton2Tap: () {
                      LockOverlayDialog().closeOverlay();
                    },
                  ),
                );
              },
            ),
          ],
        ),
        body: Container(
          child: _controller.value.isInitialized
              ? Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        color: Colors.black,
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CustomLoadIndicator(),
                ),
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
