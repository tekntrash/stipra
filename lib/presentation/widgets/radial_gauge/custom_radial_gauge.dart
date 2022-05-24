import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:gauges/gauges.dart';
import 'package:stipra/presentation/widgets/radial_gauge/custom_render_radial_gauge.dart';

/// A radial gauge.
class CustomRadialGauge extends LeafRenderObjectWidget {
  final double? radius;

  final List<RadialGaugeAxis> axes;

  const CustomRadialGauge({
    required this.axes,
    this.radius,
  }) : assert(axes != null && axes.length > 0);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CustomRenderRadialGauge(radius: radius, axes: axes);
  }

  @override
  void updateRenderObject(
      BuildContext context, CustomRenderRadialGauge renderObject) {
    renderObject
      ..radius = radius
      ..axes = axes;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
