import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svgsandbox/renderhelpers.dart';

class SvgWrapper extends StatefulWidget {
  final String svgString;
  final double wrapperSize;
  final bool applyColor;
  final String infoString;

  const SvgWrapper(
      {Key? key, required this.svgString, required this.wrapperSize, this.applyColor = false, this.infoString = ''})
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: widget.infoString.isNotEmpty ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
      children: [
        widget.infoString.isNotEmpty
            ? Container(
                color: Colors.blueAccent.shade700,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.infoString, style: const TextStyle(color: Colors.white)),
                ),
              )
            : const SizedBox.shrink(),
        Container(
          color: Colors.blueAccent,
          height: kMaxIconFrame,
          width: kMaxIconFrame,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.applyColor ? sp : spNoColor,
          ),
        ),
      ],
    );
  }
}
