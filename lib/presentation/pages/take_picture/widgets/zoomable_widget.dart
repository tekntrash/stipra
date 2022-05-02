part of '../take_picture_page.dart';

/// Support zoom in and zoom out
/// for taking picture

class ZoomableWidget extends StatefulWidget {
  final Widget child;
  final Function onZoom;
  final Function? onTapUp;

  const ZoomableWidget(
      {Key? key, required this.child, required this.onZoom, this.onTapUp})
      : super(key: key);

  @override
  _ZoomableWidgetState createState() => _ZoomableWidgetState();
}

class _ZoomableWidgetState extends State<ZoomableWidget> {
  Matrix4 matrix = Matrix4.identity();
  double zoom = 1;
  double prevZoom = 1;
  bool showZoom = false;
  Timer? t1;

  /// Controlling zoom in and zoom out
  /// by using gesture detector
  /// When two finger is scaling this functon will be called
  /// and this function will call the [widget.onZoom]
  bool handleZoom(newZoom) {
    if (newZoom >= 1) {
      if (newZoom > 10) {
        return false;
      }
      setState(() {
        showZoom = true;
        zoom = newZoom;
      });

      if (t1 != null) {
        t1!.cancel();
      }

      t1 = Timer(Duration(milliseconds: 2000), () {
        setState(() {
          showZoom = false;
        });
      });
    }
    widget.onZoom(zoom);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return XGestureDetector(
        onScaleStart: (scaleDetails) {
          print('scalStart');
          setState(() => prevZoom = zoom);
          //print(scaleDetails);
        },
        onScaleUpdate: (ScaleEvent scaleDetails) {
          var newZoom = (prevZoom * scaleDetails.scale);

          handleZoom(newZoom);
        },
        onScaleEnd: () {
          print('end');
          //print(scaleDetails);
        },
        onMoveEnd: (MoveEvent det) {
          final RenderBox box = context.findRenderObject() as RenderBox;
          final Offset localPoint = box.globalToLocal(det.position);
          final Offset scaledPoint =
              localPoint.scale(1 / box.size.width, 1 / box.size.height);
          if (widget.onTapUp != null) widget.onTapUp!(scaledPoint);
        },
        child: Stack(children: [
          Positioned.fill(child: widget.child),
          Visibility(
            visible: false, //Default is true,
            child: Positioned.fill(
              child: Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        valueIndicatorTextStyle: TextStyle(
                            color: Colors.amber,
                            letterSpacing: 2.0,
                            fontSize: 30),
                        valueIndicatorColor: Colors.blue,
                        // This is what you are asking for
                        inactiveTrackColor: Color(0xFF8D8E98),
                        // Custom Gray Color
                        activeTrackColor: Colors.white,
                        thumbColor: Colors.red,
                        overlayColor: Color(0x29EB1555),
                        // Custom Thumb overlay Color
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 12.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 20.0),
                      ),
                      child: Slider(
                        value: zoom,
                        onChanged: (double newValue) {
                          handleZoom(newValue);
                        },
                        label: "$zoom",
                        min: 1,
                        max: 10,
                      ),
                    ),
                  ),
                ],
              )),
            ),
            //maintainSize: bool. When true this is equivalent to invisible;
            //replacement: Widget. Defaults to Sizedbox.shrink, 0x0
          )
        ]));
  }
}
