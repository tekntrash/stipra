part of '../chart_page.dart';

class _ProductImage extends StatelessWidget {
  final WinItemModel winItem;
  final CarouselController carouselController;
  final ValueNotifier<double?> dotPosition;
  const _ProductImage({
    Key? key,
    required this.winItem,
    required this.carouselController,
    required this.dotPosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int imgLength = winItem.images?.where((e) => e.isNotEmpty).length ?? 0;

    return Container(
      height: 350.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: new ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: 250.h,
                  autoPlay: false,
                  initialPage: 0,
                  scrollPhysics: AlwaysScrollableScrollPhysics(),
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                  onScrolled: (value) {
                    dotPosition.value = value;
                  },
                ),
                carouselController: carouselController,
                itemCount: imgLength,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        ImageBox(
                  width: 1.sw,
                  height: 300.h,
                  url: winItem.images![itemIndex],
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: IgnorePointer(
              ignoring: true,
              child: ImageFiltered(
                imageFilter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  width: 1.sw,
                  height: 450.h,
                  color: Colors.black.withOpacity(0.10),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<double?>(
              valueListenable: dotPosition,
              builder: (context, dotpos, child) {
                return imgLength == 1
                    ? Container()
                    : DotsIndicator(
                        dotsCount: imgLength,
                        position: dotpos ?? 0,
                        decorator: DotsDecorator(
                          color: AppTheme().greyScale5, // Inactive color
                          activeColor: AppTheme().primaryColor,
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
