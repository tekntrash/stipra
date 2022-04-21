import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:stipra/presentation/pages/map/plugin/flutter_map_plugin_fixed.dart';
import 'package:stipra/presentation/widgets/custom_load_indicator.dart';
import 'package:stipra/shared/app_theme.dart';

class MapControllerPage extends StatefulWidget {
  final String geoPoint;
  final Color binColor;
  final String name;
  MapControllerPage({
    Key? key,
    required this.geoPoint,
    required this.binColor,
    required this.name,
  }) : super(key: key);

  static const String route = 'map_controller';

  @override
  MapControllerPageState createState() {
    return MapControllerPageState();
  }
}

class MapControllerPageState extends State<MapControllerPage> {
  late List<LatLng> filledPoints;
  late List<Marker> markers;
  LatLng? userLocation;

  late final MapController mapController;
  double rotation = 0.0;

  @override
  void initState() {
    super.initState();
    markers = [];
    //Get coordinates from geo
    final coordinates = widget.geoPoint.split(',');
    filledPoints = [
      LatLng(double.parse(coordinates[0]), double.parse(coordinates[1])),
      LatLng(double.parse(coordinates[0]), double.parse(coordinates[3])),
      LatLng(double.parse(coordinates[2]), double.parse(coordinates[3])),
      LatLng(double.parse(coordinates[2]), double.parse(coordinates[1])),
    ];
    mapController = MapController();
    initMarkers();
  }

  initMarkers() async {
    final loc = await Location().getLocation();
    userLocation = LatLng(loc.latitude ?? 0, loc.longitude ?? 0);
    markers = <Marker>[
      Marker(
        width: 80.0,
        height: 80.0,
        point: userLocation!,
        builder: (ctx) => Container(
          key: Key('purple'),
          width: 40,
          height: 40,
          child: Center(
            child: Icon(
              Icons.person,
              color: Colors.black,
              size: 40.0,
            ),
          ),
        ),
      ),
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            //color: AppTheme().blackColor,
            gradient: AppTheme().gradientPrimary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: widget.binColor != Colors.transparent
            ? RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Right bin for this: ',
                      style: AppTheme().paragraphSemiBoldText,
                    ),
                    WidgetSpan(
                      child: Icon(
                        Icons.delete,
                        color: widget.binColor,
                        size: AppTheme().paragraphSemiBoldText.fontSize! * 1.1,
                      ),
                    ),
                  ],
                ),
              )
            : RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.name,
                      style: AppTheme().paragraphSemiBoldText,
                    ),
                  ],
                ),
              ),
        centerTitle: true,
        actions: [
          /*Container(
            margin: EdgeInsets.only(right: 5),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: IconButton(
              icon: Icon(
                Icons.public,
                color: Colors.white,
                size: 26,
              ),
              onPressed: () {
                //Navigator.of(context).pop();
              },
            ),
          ),*/
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: userLocation == null
                ? CustomLoadIndicator()
                : FlutterMapPlugin(
                    mapController: mapController,
                    options: MapOptions(
                      center: userLocation,
                      //center: LatLng(51.5, -0.09),
                      zoom: 4.0,
                      allowPanningOnScrollingParent: false,
                      rotationThreshold: 0,
                      rotationWinGestures: MultiFingerGesture.none,
                      rotation: 0,
                      enableMultiFingerGestureRace: false,
                      interactiveFlags: FlutterMapPlugin.drag |
                          FlutterMapPlugin.flingAnimation |
                          FlutterMapPlugin.pinchMove |
                          FlutterMapPlugin.pinchZoom |
                          FlutterMapPlugin.doubleTapZoom,
                      maxZoom: 18,
                      minZoom: 4,
                    ),
                    layers: [
                      TileLayerOptions(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c']),
                      MarkerLayerOptions(markers: markers),
                      PolygonLayerOptions(polygons: [
                        Polygon(
                          points: filledPoints,
                          color: Colors.teal.withOpacity(0.125),
                          borderColor: AppTheme().darkPrimaryColor,
                          borderStrokeWidth: 3.0,
                        ),
                      ]),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({
    Key? key,
    required this.mapController,
  }) : super(key: key);

  final MapController mapController;

  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  int _eventKey = 0;

  var icon = Icons.gps_not_fixed;
  late final StreamSubscription<MapEvent> mapEventSubscription;

  @override
  void initState() {
    super.initState();

    mapEventSubscription =
        widget.mapController.mapEventStream.listen(onMapEvent);
  }

  @override
  void dispose() {
    mapEventSubscription.cancel();
    super.dispose();
  }

  void setIcon(IconData newIcon) {
    if (newIcon != icon && mounted) {
      setState(() {
        icon = newIcon;
      });
    }
  }

  void onMapEvent(MapEvent mapEvent) {
    if (mapEvent is MapEventMove && mapEvent.id == _eventKey.toString()) {
      setIcon(Icons.gps_not_fixed);
    }
  }

  void _moveToCurrent() async {
    _eventKey++;
    var location = Location();

    try {
      var currentLocation = await location.getLocation();
      var moved = widget.mapController.move(
        LatLng(currentLocation.latitude!, currentLocation.longitude!),
        18,
        id: _eventKey.toString(),
      );

      if (moved) {
        setIcon(Icons.gps_fixed);
      } else {
        setIcon(Icons.gps_not_fixed);
      }
    } catch (e) {
      setIcon(Icons.gps_off);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: _moveToCurrent,
    );
  }
}
