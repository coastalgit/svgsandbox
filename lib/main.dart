import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:svgsandbox/renderhelpers.dart';
import 'package:svgsandbox/svgwrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SVG Sandbox',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        sliderTheme: const SliderThemeData(showValueIndicator: ShowValueIndicator.always),
      ),
      home: const MyHomePage(title: 'SVG Sandbox'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String svg = '';
  double sliderValue = kMaxIconFrame / 2;

  //TextEditingController textController = TextEditingController();
  late TextEditingController textController;

  void _updateSvgString(String svgData) {
    setState(() {
      svg = svgData;
      textController.text = svgData;
    });
  }

  @override
  void initState() {
    super.initState();
    svg = kSvgValid;
    textController = TextEditingController(text: svg);
    textController.addListener(_updateSvgData);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Widget _buildIconPreview(String svgString) {
    //SvgPicture sp = RenderHelpers.displaySvgWithSizing(svgString, '#FFFFFF', sliderValue);

/*
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SvgWrapper(
          svgString: svg,
          wrapperSize: sliderValue,
        ),
      ],
    );
*/
    return SvgWrapper(
      svgString: svg,
      wrapperSize: sliderValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                //onChanged: (newval) => textController.text = newval,
                maxLines: null,
                controller: textController,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).primaryColor,
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(4)),
                  contentPadding: const EdgeInsets.all(20.0),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    elevation: 8, // Elevation
                  ),
                  onPressed: () => _updateSvgString(kSvgValid),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Valid SVG',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.shade700,
                    elevation: 8, // Elevation
                  ),
                  onPressed: () => _updateSvgString(kSvgSuspect),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Suspect SVG',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).primaryColorDark,
                ),

                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     SizedBox(
                //       height: 200,
                //       width: 200,
                //       child: _buildIconPreview(svg),
                //     ),
                //   ],
                // ),
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Slider(
                          label: 'Icon Size',
                          min: 10,
                          max: kMaxIconFrame,
                          thumbColor: Colors.white,
                          value: sliderValue,
                          onChanged: (value) => setState(() {
                                sliderValue = value;
                              })),
                      _buildIconPreview(svg),
                    ],
                  ),
                ),
              ),
            ),
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$svgString',
            //   style: Theme.of(context).textTheme.headline2,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () => setState(() {}),
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _updateSvgData() {
    svg = textController.text;
  }
}
