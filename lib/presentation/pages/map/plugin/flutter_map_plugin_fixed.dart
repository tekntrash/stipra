import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';

import 'flutter_map_plugin_state.dart';

/// Renders a map composed of a list of layers powered by [LayerOptions].
///
/// Use a [MapController] to interact programmatically with the map.
///
/// Through [MapOptions] map's callbacks and properties can be defined.
class FlutterMapPlugin extends StatefulWidget {
  /// A set of layers' options to used to create the layers on the map.
  ///
  /// Usually a list of [TileLayerOptions], [MarkerLayerOptions] and
  /// [PolylineLayerOptions].
  ///
  /// These layers will render above [children]
  final List<LayerOptions> layers;

  /// These layers won't be rotated.
  /// Usually these are plugins which are floating above [layers]
  ///
  /// These layers will render above [nonRotatedChildren]
  final List<LayerOptions> nonRotatedLayers;

  /// A set of layers' widgets to used to create the layers on the map.
  final List<Widget> children;

  /// These layers won't be rotated.
  ///
  /// These layers will render above [layers]
  final List<Widget> nonRotatedChildren;

  /// [MapOptions] to create a [MapState] with.
  ///
  /// This property must not be null.
  final MapOptions options;

  /// A [MapController], used to control the map.
  final MapControllerImpl? _mapController;

  FlutterMapPlugin({
    Key? key,
    required this.options,
    this.layers = const [],
    this.nonRotatedLayers = const [],
    this.children = const [],
    this.nonRotatedChildren = const [],
    MapController? mapController,
  })  : _mapController = mapController as MapControllerImpl?,
        super(key: key);

  @override
  FlutterMapPluginState createState() => FlutterMapPluginState(_mapController);

  // enable move with one finger
  static const int drag = 1 << 0;

  // enable fling animation when drag or pinchMove have enough Fling Velocity
  static const int flingAnimation = 1 << 1;

  // enable move with two or more fingers
  static const int pinchMove = 1 << 2;

  // enable pinch zoom
  static const int pinchZoom = 1 << 3;

  // enable double tap zoom animation
  static const int doubleTapZoom = 1 << 4;
}
