import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';

const double kMaxIconFrame = 500;

const String kSvgValid =
    '''<svg viewBox="0 0 520 520" xmlns="http://www.w3.org/2000/svg" fill="currentColor"><path d="M256 0C114.6 0 0 114.6 0 256s114.6 256 256 256 256-114.6 256-256S397.4 0 256 0zm0 128c17.67 0 32 14.33 32 32s-14.33 32-32 32-32-14.3-32-32 14.3-32 32-32zm40 256h-80c-13.2 0-24-10.7-24-24s10.75-24 24-24h16v-64h-8c-13.25 0-24-10.75-24-24s10.8-24 24-24h32c13.25 0 24 10.75 24 24v88h16c13.25 0 24 10.75 24 24s-10.7 24-24 24z"/></svg>''';

const String kSvgSuspect =
//    '''<svg xmlns="http://www.w3.org/2000/svg" style="vertical-align:-.125em" viewBox="0 0 16 16"><path fill="none" d="M0 0h16v16H0z"/><g fill="currentColor"><path d="M14.5 3a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h13zm-13-1A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13z"/><path d="M3 8.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5zm0-5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5v-1z"/></g></svg>''';
//    '''<svg viewBox="0 0 612 612" class="bi bi-chat-left-dots" fill="currentColor" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v11.586l2-2A2 2 0 0 1 4.414 11H14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/><path d="M5 6a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/></svg>''';
    '''<svg xmlns="http://www.w3.org/2000/svg" style="vertical-align: -0.125em;" preserveAspectRatio="xMidYMid meet" viewBox="0 0 16 16"><g fill="currentColor"><path d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H4.414A2 2 0 0 0 3 11.586l-2 2V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/><path d="M5 6a1 1 0 1 1-2 0a1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0a1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0a1 1 0 0 1 2 0z"/></g></svg>''';

class RenderHelpers {
/*
  static SvgPicture displaySvg(String rawSvg, String rawColor) {
    SvgPicture sv = SvgPicture.string(
      rawSvg,
      fit: BoxFit.contain,
      color: HexColor(rawColor),
    );

    return sv;
  }
*/

  static bool svgIsSupported(String rawSvg) {
    final SvgParser parser = SvgParser();
    try {
      parser.parse(rawSvg, warningsAsErrors: true);
      //print('SVG is supported');
      return true;
    } catch (e) {
      //print('SVG contains unsupported features');
    }
    return false;
  }

/*
  static SvgPicture? displaySvgToCanvas(String rawSvg, String rawColor, double iconHeight) async{

    final DrawableRoot svgRoot = await svg.fromSvgString(rawSvg, rawSvg);
    return await svgRoot.toPicture().toImage(100, 100);
    return await svgRoot.toPicture();
    SvgPicture sv = SvgPicture.string(rawSvg);

  }
*/

  static SvgPicture? displaySvgWithSizing(String rawSvg, String rawColor, double iconHeight) {
    //print('displaySvgWithSizing size='+iconHeight.toString());

    SvgPicture? sv;
    try {
      sv = SvgPicture.string(
        //clipBehavior: Clip.antiAliasWithSaveLayer,
        rawSvg,
        color: HexColor(rawColor),
        fit: BoxFit.cover,
        //fit: BoxFit.fitHeight,
        height: iconHeight,
        //width: iconHeight,

        //allowDrawingOutsideViewBox: true,
        //alignment: Alignment.center,
      );
    } catch (exc) {
      print('SVG build exception: [$exc]');
    }
    return sv;
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
