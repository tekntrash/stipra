import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';
import 'package:stipra/core/services/scanned_video_service.dart';
import 'package:stipra/data/models/scanned_video_model.dart';
import 'package:stipra/injection_container.dart';
import 'package:stipra/shared/app_images.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../../shared/app_theme.dart';

/// Transform the list of scanned videos into a list of widgets
/// that can be used in a sliver list
/// Also check if the list is empty and display a message if it is empty

class VideosWaitingList extends StatelessWidget {
  final List<ScannedVideoModel> scannedVideos;
  const VideosWaitingList({
    Key? key,
    required this.scannedVideos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return scannedVideos.length == 0
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                'All of your videos uploaded!',
                style: AppTheme().paragraphSemiBoldText.copyWith(
                      color: AppTheme().greyScale0,
                    ),
              ),
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return buildItem(context, index);
              },
              childCount: scannedVideos.length,
            ),
          );
  }

  /// Build a single item in the list
  /// Until thumbnail is ready it is showing a [SvgPicture]
  /// Also convert the date to a readable format
  Widget buildItem(BuildContext context, int index) {
    final newDate = Jiffy(
      '${DateTime.fromMillisecondsSinceEpoch(scannedVideos[index].timeStamp)}',
    ).yMMMMd;

    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: StatefulBuilder(builder: (context, setState) {
        if (scannedVideos[index].isUploaded) {
          return Container(
            key: GlobalKey(),
            margin: EdgeInsets.only(bottom: 8.w),
            padding: EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset(
                    AppImages.uploadComplete.lottiePath,
                    width: 96,
                    height: 96,
                    repeat: false,
                  ),
                ],
              ),
            ),
          );
        }
        return Container(
          margin: EdgeInsets.only(bottom: 8.w),
          child: Container(
            padding: EdgeInsets.symmetric(
                //horizontal: 15.w,
                ),
            child: GestureDetector(
              onTap: () {
                //
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                    //color: AppTheme().blackColor,
                    ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          //
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppTheme().greyScale5,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: FutureBuilder(
                              future:
                                  File(scannedVideos[index].videoPath).exists(),
                              builder: (context, snapshot) {
                                return Center(
                                  child: snapshot.hasData &&
                                          snapshot.data == true
                                      ? Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: FutureBuilder<File?>(
                                            future: genThumbnailFile(
                                                scannedVideos[index].videoPath),
                                            builder: ((context, snapshot) =>
                                                AnimatedSwitcher(
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  transitionBuilder:
                                                      (Widget child,
                                                          Animation<double>
                                                              animation) {
                                                    return FadeTransition(
                                                        child: child,
                                                        opacity: animation);
                                                  },
                                                  child:
                                                      (snapshot.connectionState ==
                                                                  ConnectionState
                                                                      .done &&
                                                              snapshot.data !=
                                                                  null)
                                                          ? ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              child: Container(
                                                                width: 80,
                                                                height: 80,
                                                                child:
                                                                    Image.file(
                                                                  snapshot
                                                                      .data!,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            )
                                                          : Center(
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/images/image_box.svg',
                                                                width: 32,
                                                                height: 32,
                                                                color: AppTheme()
                                                                    .greyScale0,
                                                              ),
                                                            ),
                                                )),
                                          ),
                                        )
                                      : SvgPicture.asset(
                                          'assets/images/image_box.svg',
                                          width: 32,
                                          height: 32,
                                          key: GlobalKey(),
                                          color: AppTheme().greyScale0,
                                        ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 6),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Scanned on:',
                                        style: AppTheme()
                                            .smallParagraphSemiBoldText
                                            .copyWith(
                                              color: AppTheme().greyScale2,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '$newDate',
                                        style: AppTheme()
                                            .smallParagraphRegularText
                                            .copyWith(
                                              color: AppTheme().greyScale3,
                                            ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ValueListenableBuilder<Map<String, UploadingVideo>>(
                              valueListenable: locator<ScannedVideoService>()
                                  .uploadingVideosNotifier,
                              builder: (context, value, child) {
                                if (value[scannedVideos[index].videoPath] !=
                                    null) {
                                  return ValueListenableBuilder(
                                    valueListenable:
                                        value[scannedVideos[index].videoPath]!
                                            .progressNotifier,
                                    builder: (context, value, child) {
                                      if (value == 1.0) {
                                        scannedVideos[index].isUploaded = true;
                                        WidgetsBinding.instance
                                            ?.addPostFrameCallback(
                                          (timeStamp) {
                                            setState(() {});
                                          },
                                        );
                                      }
                                      return Text('Value: $value');
                                    },
                                  );
                                }
                                return Container();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  /// Generate a thumbnail file from a video file
  /// and return it
  Future<File?> genThumbnailFile(String path) async {
    final thumbnail = await VideoThumbnail.thumbnailFile(
      video: path,
      // thumbnailPath: _tempDir,
      imageFormat: ImageFormat.PNG,
      //maxHeightOrWidth: 0,
      //maxHeight: 80,
      //maxWidth: 80,
      //quality: 90
    );

    final file = File(thumbnail ?? '');
    return file;
  }
}
