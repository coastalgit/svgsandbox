// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';

const double kMaxIconFrame = 300;

const String kSvgValid =
    '''<svg viewBox="0 0 520 520" xmlns="http://www.w3.org/2000/svg" fill="currentColor"><path d="M256 0C114.6 0 0 114.6 0 256s114.6 256 256 256 256-114.6 256-256S397.4 0 256 0zm0 128c17.67 0 32 14.33 32 32s-14.33 32-32 32-32-14.3-32-32 14.3-32 32-32zm40 256h-80c-13.2 0-24-10.7-24-24s10.75-24 24-24h16v-64h-8c-13.25 0-24-10.75-24-24s10.8-24 24-24h32c13.25 0 24 10.75 24 24v88h16c13.25 0 24 10.75 24 24s-10.7 24-24 24z"/></svg>''';

const String kSvgSuspect =
    '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 16 16"><g fill="currentColor"><path d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H4.414A2 2 0 0 0 3 11.586l-2 2V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/><path d="M5 6a1 1 0 1 1-2 0a1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0a1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0a1 1 0 0 1 2 0z"/></g></svg>'''; // orig from https://icon-sets.iconify.design/bi/chat-left-dots/
//    '''<svg xmlns="http://www.w3.org/2000/svg" style="vertical-align:-.125em" viewBox="0 0 16 16"><path fill="none" d="M0 0h16v16H0z"/><g fill="currentColor"><path d="M14.5 3a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h13zm-13-1A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13z"/><path d="M3 8.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5zm0-5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5v-1z"/></g></svg>''';
//    '''<svg viewBox="0 0 612 612" class="bi bi-chat-left-dots" fill="currentColor" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M14 1H2a1 1 0 0 0-1 1v11.586l2-2A2 2 0 0 1 4.414 11H14a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/><path d="M5 6a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/></svg>''';
//    '''<svg viewBox="0 0 16 16" style="vertical-align: -0.125em;" preserveAspectRatio="xMidYMid meet" xmlns="http://www.w3.org/2000/svg"><g fill="currentColor"><path d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H4.414A2 2 0 0 0 3 11.586l-2 2V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/><path d="M5 6a1 1 0 1 1-2 0a1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0a1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0a1 1 0 0 1 2 0z"/></g></svg>''';
//'''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" preserveAspectRatio="xMidYMid meet" viewBox="0 0 16 16"><g fill="currentColor"><path d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H4.414A2 2 0 0 0 3 11.586l-2 2V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/><path d="M5 6a1 1 0 1 1-2 0a1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0a1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0a1 1 0 0 1 2 0z"/></g></svg>''';
//'''<svg xmlns="http://www.w3.org/2000/svg" width="20em" height="20em" viewBox="0 0 320 320"><g fill="currentColor"><path d="M280 20a20 20 0 0 1 20 20v160a20 20 0 0 1-20 20H88.28A40 40 0 0 0 60 231.72l-40 40V40a20 20 0 0 1 20-20h240zM40 0A40 40 0 0 0 0 40v255.86a10 10 0 0 0 17.08 7.06l57.06-57.06A20 20 0 0 1 88.28 240H280a40 40 0 0 0 40-40V40a40 40 0 0 0-40-40H40z"/><path d="M100 120a20 20 0 1 1-40 0 20 20 0 0 1 40 0zm80 0a20 20 0 1 1-40 0 20 20 0 0 1 40 0zm80 0a20 20 0 1 1-40 0 20 20 0 0 1 40 0z"/></g></svg>''';

const String kSvgSuspectMergedPath =
//    '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 160 160" class="bi bi-chat-left-dots" fill="currentColor" width="160" height="160"><path fill-rule="evenodd" d="M140 10H20a10 10 0 0 0-10 10v115.86l20-20A20 20 0 0 1 44.14 110H140a10 10 0 0 0 10-10V20a10 10 0 0 0-10-10zM20 0A20 20 0 0 0 0 20v127.93a5 5 0 0 0 8.54 3.53l28.53-28.53a10 10 0 0 1 7.07-2.93H140a20 20 0 0 0 20-20V20a20 20 0 0 0-20-20H20z"/><path d="M50 60a10 10 0 1 1-20 0 10 10 0 0 1 20 0zm40 0a10 10 0 1 1-20 0 10 10 0 0 1 20 0zm40 0a10 10 0 1 1-20 0 10 10 0 0 1 20 0z"/></svg>''';
//'''<svg viewBox="0 0 160 160" fill="currentColor" xmlns="http://www.w3.org/2000/svg" width="160" height="160"><path fill-rule="evenodd" d="M140 10H20a10 10 0 0 0-10 10v115.86l20-20A20 20 0 0 1 44.14 110H140a10 10 0 0 0 10-10V20a10 10 0 0 0-10-10zM20 0A20 20 0 0 0 0 20v127.93a5 5 0 0 0 8.54 3.53l28.53-28.53a10 10 0 0 1 7.07-2.93H140a20 20 0 0 0 20-20V20a20 20 0 0 0-20-20H20z"/><path d="M50 60a10 10 0 1 1-20 0 10 10 0 0 1 20 0zm40 0a10 10 0 1 1-20 0 10 10 0 0 1 20 0zm40 0a10 10 0 1 1-20 0 10 10 0 0 1 20 0z"/></svg>''';
//'''<svg xmlns="http://www.w3.org/2000/svg" width="120" height="120"><path d="M105 7.5a7.5 7.5 0 0 1 7.5 7.5v60a7.5 7.5 0 0 1-7.5 7.5H33.105A15 15 0 0 0 22.5 86.895l-15 15V15A7.5 7.5 0 0 1 15 7.5zM15 0A15 15 0 0 0 0 15v95.947a3.75 3.75 0 0 0 6.405 2.647l21.398-21.398A7.5 7.5 0 0 1 33.105 90H105a15 15 0 0 0 15-15V15a15 15 0 0 0-15-15z"/><path d="M37.5 45a7.5 7.5 0 1 1-15 0 7.5 7.5 0 0 1 15 0zm30 0a7.5 7.5 0 1 1-15 0 7.5 7.5 0 0 1 15 0zm30 0a7.5 7.5 0 1 1-15 0 7.5 7.5 0 0 1 15 0z"/></svg>''';
    '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" width="32" height="32"><path d="M28 2a2 2 0 0 1 2 2v16a2 2 0 0 1-2 2H8.828A4 4 0 0 0 6 23.172l-4 4V4a2 2 0 0 1 2-2zM4 0a4 4 0 0 0-4 4v25.585a1 1 0 0 0 1.708.705l5.707-5.707A2 2 0 0 1 8.828 24H28a4 4 0 0 0 4-4V4a4 4 0 0 0-4-4z"/><path d="M10 12a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm8 0a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm8 0a2 2 0 1 1-4 0 2 2 0 0 1 4 0z"/></svg>''';

/*  Sequence to "tidy" SVG:
*   Original from https://icon-sets.iconify.design/bi/chat-left-dots/
*   View in https://www.svgviewer.dev/
*
*   Save to file and process thru SVGCleaner app
*   Copy Output from SVG cleaner into https://www.svgviewer.dev/ and optimise (after it prompts to specify resolution...)
*   I had to specify a min resolution of 32(px) and click 'optimise' to get a valid value!
* */

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

  static SvgPicture? displaySvgWithSizing(String rawSvg, String rawColor, double iconHeight, bool applyColor) {
    //print('displaySvgWithSizing size=' + iconHeight.toString() + ' applyColor=' + applyColor.toString());

    // strangely it appears the SvgPicture object retains cached values (when using HTML) so a browser refresh is required
    SvgPicture? sv;
    SvgPicture? svNoColor;

    try {
       sv = applyColor
          ? SvgPicture.string(
              //clipBehavior: Clip.antiAliasWithSaveLayer,
              rawSvg,
              //color: applyColor ? HexColor(rawColor) : null,
              color: HexColor(rawColor),
              fit: BoxFit.cover,
              //fit: BoxFit.fitHeight,
              height: iconHeight,
              //width: iconHeight,
              //allowDrawingOutsideViewBox: true,
              //alignment: Alignment.center,
            )
          : SvgPicture.string(
              rawSvg,
              fit: BoxFit.cover,
              height: iconHeight,
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
