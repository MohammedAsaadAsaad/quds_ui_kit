import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

class ViewersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ViewersScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: AppBar(actions: [], title: Text('Viewers')),
    );
  }

  Widget _buildBody() {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(10),
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ..._buildTimeViewer(),
        ],
      ),
    );
  }

  List<Widget> _buildTimeViewer() {
    return [
      Text(
        'Time Viewers',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 5,
      ),
      Text('Any time:'),
      SizedBox(
        height: 5,
      ),
      QudsDigitalTimeViewer(
        hour: 10,
        minute: 59,
        second: 40,
        milliSecond: 10,
      ),
      SizedBox(
        height: 10,
      ),
      Text('Live time'),
      SizedBox(
        height: 5,
      ),
      QudsDigitalClockViewer(
        showTimePeriod: false,
        // showSeconds: true,
        // showMilliSeconds: true,
      ),
      SizedBox(
        height: 5,
      ),
      QudsDigitalClockViewer(
        timePeriodStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        // showSeconds: true,
        // showMilliSeconds: true,
      ),
      SizedBox(
        height: 5,
      ),
      QudsDigitalClockViewer(
        style: TextStyle(color: Colors.yellow, fontSize: 30),
        backgroundColor: Colors.grey[900],
        showTimePeriod: false,
        showSeconds: true,
        // showMilliSeconds: true,
      ),
      SizedBox(
        height: 5,
      ),
      QudsDigitalClockViewer(
        showSeconds: true,
        showMilliSeconds: true,
      )
    ];
  }
}
