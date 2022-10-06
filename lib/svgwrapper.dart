import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svgsandbox/renderhelpers.dart';

class SvgWrapper extends StatefulWidget {
  final String svgString;
  final double wrapperSize;
  final bool applyColor;

  const SvgWrapper({Key? key, required this.svgString, required this.wrapperSize, this.applyColor = false})
      : super(key: key);

  @override
  State<SvgWrapper> createState() => _SvgWrapperState();
}

class _SvgWrapperState extends State<SvgWrapper> {
  late SvgPicture? sp;
  late SvgPicture? spNoColor;

  @override
  Widget build(BuildContext context) {
    // double sw = MediaQuery.of(context).size.width;
    // print('SVG wrapper width='+sw.toString());

    if (!RenderHelpers.svgIsSupported(widget.svgString)) {
      return Container(
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          //child: RenderHelpers.displaySvg(btn.icon, btn.iconColor),
          child: Text(
            'Invalid SVG data',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    // strangely it appears the SvgPicture object retains cached values (when using HTML) so a browser refresh is required
    sp = RenderHelpers.displaySvgWithSizing(widget.svgString, '#FFFFFF', widget.wrapperSize, widget.applyColor);
    spNoColor = RenderHelpers.displaySvgWithSizing(widget.svgString, '#FFFFFF', widget.wrapperSize, widget.applyColor);

    return Container(
      color: Colors.blueAccent,
      height: kMaxIconFrame,
      width: kMaxIconFrame,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.applyColor ? sp : spNoColor,
      ),
    );
  }
}
