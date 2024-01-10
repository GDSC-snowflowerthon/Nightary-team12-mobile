library music_visualizer;

import "package:flutter/material.dart";

class MusicVisualizer extends StatelessWidget {
  final List<Color>? colors;
  final List<int>? duration;
  final int? barCount;
  final Curve? curve;

  const MusicVisualizer({
    super.key,
    required this.colors,
    required this.duration,
    required this.barCount,
    this.curve = Curves.easeInQuad,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<Widget>.generate(
            barCount!,
            (index) => _VisualComponent(
                curve: curve!,
                duration: duration![index % 5],
                color: colors![index % 4])));
  }
}

class _VisualComponent extends StatefulWidget {
  final int? duration;
  final Color? color;
  final Curve? curve;

  const _VisualComponent({
    required this.duration,
    required this.color,
    required this.curve,
  });

  @override
  State<_VisualComponent> createState() => _VisualComponentState();
}

class _VisualComponentState extends State<_VisualComponent>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  void dispose() {
    animation!.removeListener(() {});
    animation!.removeStatusListener((status) {});
    animationController!.dispose();
    super.dispose();
  }

  void animate() {
    animationController = AnimationController(
        duration: Duration(milliseconds: widget.duration!), vsync: this);
    final curvedAnimation =
        CurvedAnimation(parent: animationController!, curve: widget.curve!);
    animation = Tween<double>(begin: 0, end: 50).animate(curvedAnimation)
      ..addListener(() {
        update();
      });
    animationController!.repeat(reverse: true);
  }

  void update() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: animation!.value,
      decoration: BoxDecoration(
          color: widget.color, borderRadius: BorderRadius.circular(5)),
    );
  }
}
