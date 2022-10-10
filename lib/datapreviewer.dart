import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svgsandbox/svgwrapper.dart';

class PreviewEntry {
  final String infoField;
  final dynamic dataField;

  PreviewEntry(this.infoField, this.dataField);
}

class DataPreviewer extends StatefulWidget {
  final bool applyColor;
  const DataPreviewer({Key? key, required this.applyColor}) : super(key: key);

  @override
  State<DataPreviewer> createState() => _DataPreviewerState();
}

class _DataPreviewerState extends State<DataPreviewer> {
  final List<PreviewEntry> _icons = [];
  List _rawdata = [];
  int _cnt = 0;

  Future<void> readIconsJson() async {
    //final String response = await rootBundle.loadString('assets/svgicons.json');
    final String response = await rootBundle.loadString('assets/svgiconsall.json');
    final data = await json.decode(response);
    _rawdata = data["icons"];

    for (var rawentry in _rawdata) {
      _cnt++;
      //print('Line=' + cnt.toString());
      if (rawentry.length > 0) {
        _icons.add(PreviewEntry('Object $_cnt', rawentry));
      }
    }

    setState(() {
      //_icons = data["icons"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Data Preview [Items=${_cnt}]'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: readIconsJson,
            child: const Text('Load Icon Data'),
          ),
        ),

        // Display the data loaded from sample.json
        _icons.isNotEmpty
            ? Flexible(
                child: ListView.builder(
                  itemCount: _icons.length,
                  itemBuilder: (context, index) {
                    return Card(
                      //key: ValueKey(_icons[index]),
                      margin: const EdgeInsets.all(5),
                      color: Colors.amber.shade100,
                      child: SvgWrapper(
                        infoString: _icons[index].infoField,
                        svgString: _icons[index].dataField,
                        wrapperSize: 50,
                        applyColor: widget.applyColor,
                      ),
                    );
                  },
                ),
              )
            : Container(),
      ],
    );
  }
}
