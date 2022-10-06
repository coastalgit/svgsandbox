import 'package:flutter/material.dart';
import 'package:svgsandbox/renderhelpers.dart';
import 'package:svgsandbox/svgwrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SVG Sandbox',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        sliderTheme: const SliderThemeData(showValueIndicator: ShowValueIndicator.always),
      ),
      home: const MyHomePage(title: 'Flutter SVG Sandbox'),
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
  bool hasColor = false;
  double sliderValue = kMaxIconFrame / 2;

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
    svg = kSvgSuspect;
    textController = TextEditingController(text: svg);
    textController.addListener(_updateSvgData);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Widget _buildIconPreview(String svgString) {
    return SvgWrapper(
      svgString: svg,
      wrapperSize: sliderValue,
      applyColor: hasColor,
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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'You can edit the SVG string and click the refresh FAB to preview',
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent.shade700,
                          elevation: 8, // Elevation
                        ),
                        onPressed: () => _updateSvgString(kSvgSuspect),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Suspect SVG (original)',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent.shade700,
                          elevation: 8, // Elevation
                        ),
                        onPressed: () => _updateSvgString(kSvgSuspectMergedPath),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Suspect SVG (optimised)',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Theme.of(context).primaryColorDark,
                  ),
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
                        SizedBox(
                          width: 200,
                          child: CheckboxListTile(
                              title: const Text('Apply Color', style: TextStyle(color: Colors.white)),
                              value: hasColor,
                              onChanged: (checked) => setState(() {
                                    hasColor = checked!;
                                  })),
                        ),
                        _buildIconPreview(svg),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        backgroundColor: Colors.blueAccent,
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
