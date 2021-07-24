import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

class PageTransitionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<PageTransitionsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: AppBar(title: Text('Page Transitions')),
    );
  }

  Widget _buildBody() {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(10),
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ..._buildFade(),
          ..._buildRotate(),
          ..._buildZoom(),
          ..._buildBlur(),
          ..._buildSlide(),
          ..._buildCombinedTransition()
        ],
      ),
    );
  }

  List<Widget> _buildRotate() {
    var alignment = Alignment.bottomLeft;
    return [
      Text('Rotate transitions'),
      SizedBox(
        height: 5,
      ),
      Wrap(
        children: [
          ElevatedButton(
            child: Text('Fast'),
            onPressed: () => Navigator.push(
                context,
                QudsRotatePageRoute(
                    alignment: alignment,
                    builder: (c) => _SecondScreen(),
                    duration: Duration(milliseconds: 250))),
          ),
          SizedBox(
            width: 5,
          ),
          ElevatedButton(
            child: Text('Slow'),
            onPressed: () => Navigator.push(
                context,
                QudsRotatePageRoute(
                    transitionColor: Colors.transparent,
                    alignment: alignment,
                    builder: (c) => _SecondScreen(),
                    duration: Duration(milliseconds: 700))),
          )
        ],
      ),
      Divider()
    ];
  }

  List<Widget> _buildFade() {
    return [
      Text('Fade transitions'),
      SizedBox(
        height: 5,
      ),
      Wrap(
        children: [
          ElevatedButton(
            child: Text('Fast'),
            onPressed: () => Navigator.push(
                context,
                QudsFadePageRoute(
                  builder: (c) => _SecondScreen(),
                )),
          ),
          SizedBox(
            width: 5,
          ),
          ElevatedButton(
            child: Text('Slow'),
            onPressed: () => Navigator.push(
                context,
                QudsFadePageRoute(
                    builder: (c) => _SecondScreen(),
                    duration: Duration(milliseconds: 1000))),
          )
        ],
      ),
      Divider()
    ];
  }

  List<Widget> _buildZoom() {
    Alignment alignment = Alignment.center;
    return [
      Text('Zoom transitions'),
      SizedBox(
        height: 5,
      ),
      Wrap(
        children: [
          ElevatedButton(
            child: Text('In'),
            onPressed: () => Navigator.push(
                context,
                QudsZoomPageRoute(
                  zoomType: ZoomType.In,
                  alignment: alignment,
                  builder: (c) => _SecondScreen(),
                )),
          ),
          SizedBox(
            width: 5,
          ),
          ElevatedButton(
            child: Text('Out'),
            onPressed: () => Navigator.push(
                context,
                QudsZoomPageRoute(
                  zoomType: ZoomType.Out,
                  alignment: alignment,
                  builder: (c) => _SecondScreen(),
                )),
          )
        ],
      ),
      Divider()
    ];
  }

  List<Widget> _buildBlur() {
    return [
      Text('Blur transitions'),
      SizedBox(
        height: 5,
      ),
      Wrap(
        children: [
          ElevatedButton(
            child: Text('Fast'),
            onPressed: () => Navigator.push(
                context,
                QudsBlurPageRoute(
                  builder: (c) => _SecondScreen(),
                )),
          ),
          SizedBox(
            width: 5,
          ),
          ElevatedButton(
            child: Text('Slow'),
            onPressed: () => Navigator.push(
                context,
                QudsBlurPageRoute(
                    builder: (c) => _SecondScreen(),
                    duration: Duration(milliseconds: 1000))),
          )
        ],
      ),
      Divider()
    ];
  }

  List<Widget> _buildSlide() {
    return [
      Text('Slide transitions'),
      SizedBox(
        height: 5,
      ),
      Wrap(
        children: [
          ElevatedButton(
            child: Text('Up'),
            onPressed: () => Navigator.push(
                context,
                QudsSlidePageRoute(
                  builder: (c) => _SecondScreen(),
                  slideDirection: SlideDirection.Up,
                )),
          ),
          SizedBox(
            width: 5,
          ),
          ElevatedButton(
            child: Text('Down'),
            onPressed: () => Navigator.push(
                context,
                QudsSlidePageRoute(
                    builder: (c) => _SecondScreen(),
                    slideDirection: SlideDirection.Down)),
          ),
          SizedBox(
            width: 5,
          ),
          ElevatedButton(
            child: Text('Start'),
            onPressed: () => Navigator.push(
                context,
                QudsSlidePageRoute(
                    builder: (c) => _SecondScreen(),
                    slideDirection: SlideDirection.Start)),
          ),
          SizedBox(
            width: 5,
          ),
          ElevatedButton(
            child: Text('End'),
            onPressed: () => Navigator.push(
                context,
                QudsSlidePageRoute(
                    builder: (c) => _SecondScreen(),
                    slideDirection: SlideDirection.End)),
          ),
          SizedBox(
            width: 5,
          ),
          ElevatedButton(
            child: Text('Right'),
            onPressed: () => Navigator.push(
                context,
                QudsSlidePageRoute(
                    builder: (c) => _SecondScreen(),
                    slideDirection: SlideDirection.Right)),
          ),
          SizedBox(
            width: 5,
          ),
          ElevatedButton(
            child: Text('Left'),
            onPressed: () => Navigator.push(
                context,
                QudsSlidePageRoute(
                    builder: (c) => _SecondScreen(),
                    slideDirection: SlideDirection.Left)),
          )
        ],
      ),
      Divider()
    ];
  }

  bool _withFade = true;
  bool _withSlide = true;
  bool _withRotate = true;
  bool _withZoom = true;
  bool _isFast = true;

  List<Widget> _buildCombinedTransition() {
    return [
      Text('Combined Transition'),
      SizedBox(),
      Wrap(
        children: [
          QudsCheckboxWithText(
            value: _withFade,
            text: (_withFade ? 'With' : 'Without') + ' ' + 'Fade',
            onChanged: (v) => setState(() => _withFade = v),
          ),
          QudsCheckboxWithText(
            value: _withRotate,
            text: (_withRotate ? 'With' : 'Without') + ' ' + 'Rotate',
            onChanged: (v) => setState(() => _withRotate = v),
          ),
          QudsCheckboxWithText(
            value: _withZoom,
            text: (_withZoom ? 'With' : 'Without') + ' ' + 'Zoom',
            onChanged: (v) => setState(() => _withZoom = v),
          ),
          QudsCheckboxWithText(
            value: _withSlide,
            text: (_withSlide ? 'With' : 'Without') + ' ' + 'Slide',
            onChanged: (v) => setState(() => _withSlide = v),
          ),
          QudsCheckboxWithText(
            value: _isFast,
            text: _isFast ? 'Fast' : 'Slow',
            onChanged: (v) => setState(() => _isFast = v),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      ElevatedButton(
          onPressed: () => Navigator.push(
              context,
              QudsTransitionPageRoute(
                  builder: (c) => _SecondScreen(),
                  withFade: _withFade,
                  withRotate: _withRotate,
                  withZoom: _withZoom,
                  withSlide: _withSlide,
                  duration: _isFast
                      ? const Duration(milliseconds: 250)
                      : const Duration(milliseconds: 700))),
          child: Text('To second page'))
    ];
  }
}

class _SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Second Page'),
          SizedBox(
            height: 10,
          ),
          IconButton(
              iconSize: 40,
              onPressed: () => Navigator.maybePop(context),
              icon: Icon(
                Icons.arrow_back,
              ))
        ]),
      ),
    );
  }
}
