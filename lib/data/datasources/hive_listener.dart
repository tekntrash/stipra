import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveListener<T> extends StatefulWidget {
  final Box<T> box;
  final List<String>? keys;

  final Widget Function(Box<T> bx) builder;

  const HiveListener({
    Key? key,
    required this.box,
    this.keys,
    required this.builder,
  }) : super(key: key);

  @override
  _HiveListenerState createState() => _HiveListenerState();
}

class _HiveListenerState<T> extends State<HiveListener<T>> {
  late Box<T> _box;
  bool _boxOpened = false;

  void _valueChanged() {
    _box = widget.box;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    _box = widget.box;
    _boxOpened = Hive.isBoxOpen(_box.name);
    if (_boxOpened)
      _box.listenable(keys: widget.keys).addListener(_valueChanged);
    else
      throw Exception('Box is not opened');

    super.initState();
  }

  @override
  void dispose() {
    if (_boxOpened)
      _box.listenable(keys: widget.keys).removeListener(_valueChanged);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_box);
  }
}
