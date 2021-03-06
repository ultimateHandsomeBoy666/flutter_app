import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/user.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en", "US"),
        const Locale("zh", "CN"),
      ],
      title: 'Flutter Demo',
      initialRoute: "/",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // register route table
      routes: {
        "new_page": (context) => NewRoute(),
        "tip_route": (context) => TipRoute(
              text: "!SDAS",
            ),
        // "/": (context) => MyHomePage(title: "home page"),
      },
      // onGenerateRoute 路由生成钩子,对于没有在 routes 中定义的 route，会走此方法
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          String routeName = settings.name;
          return new TapboxA();
        });
      },
      // home: FindAncestorRoute(),
      // home: CounterWidget(),
      // home: CupertinoTestRoute(),
      // home: ParentWidgetC()
      // home: ButtonWidget(text : "yoyoyoyoyo")
      // home: ImageWidget()
      // home: FocusTestRoute()
      // home: FormTestRoute()
      // home: IndicatorRoute()
      // home: ProgressRoute()
      // home: FlexLayoutTestRoute()
      // home: WrapRoute()
      // home: ContainerRoute()
      // home: SingleChildScrollViewTestRoute()
      // home: TestListViewRoute(),
      // home: InfiniteListView(),
      // home: TestHeaderListViewRoute(),
      // home: TestGridView(),
      // home: InfiniteGridView(),
      // home: CustomScrollViewTestRoute(),
      // home: ScrollControllerTestRoute(),
      // home: ScrollNotificationTestRoute(),
      // home: WillPopScopeTestRoute(),
      // home: InheritedWidgetTestRoute(),
      // home: ThemeTestRoute(),
      // home: FutureBuilderRoute(),
      // home: StreamBuilderRoute(),
      // home: PointerRoute(),
      // home: PointerTranslucentRoute(),
      // home: GestureDetectorTestRoute(),
      // home: _Drag(),
      // home: _DragVertical(),
      // home: _ScaleTestRoute(),
      // home: _GestureRecognizer(),
      // home: BothDirectionTestRoute(),
      // home: GestureConflictTestRoute(),
      // home: ListenerNoConflictRoute(),
      // home: NotificationRoute(),
      // home: ScaleAnimationRoute(),
      // home: ScaleAnimationRoute1(),
      // home: AnimateBuilderRoute(),
      // home: Route1(),
      // home: StaggerRoute(),
      // home: HeroAnimationRoute(),
      // home: AnimatedSwitcherCounterRoute(),
      // home: AnimatedSwitcherCounterRoute(),
      // home: AnimatedDecoratedBoxRoute(),
      // home: AnimatedWidgetTestRoute(),
      // home: FileOperationRoute(),
      // home: HttpTestRoute(),
      // home: FutureBuilderRoute1(),
      // home: ChunkDownloadRoute(),
      // home: WebSocketRoute(),
      // home: GradientButtonRoute(),
      // home: TurnBoxRoute(),
      // home: CustomPaintRoute(),
      // home: GradientCircularProgressRoute(),
      home: AnimationPage(),
    );
  }
}

class AnimationPage extends StatefulWidget {
  AnimationPage({Key key}) : super(key: key);
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> with TickerProviderStateMixin {

  double progress = 0;

  bool isFinalState = false;
  AnimationController _controller;
  Animation<double> _animation;

  _toggle(){
    setState(() {
      isFinalState = !isFinalState;
      if(!isFinalState) _controller.reverse(from : 1.0);
      else _controller.forward(from: 0.0);
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation =  CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: _controller,
            builder: (context, animation) {
              final double progress = _animation.value;
              final double heightScaling = 0.405 ;
              final double curHeight = height * heightScaling;
              return ClipPath(
                clipper: BezierClipper(progress),
                child: Container(
                  color : Color.fromRGBO(255, 91, 53, 1),
                  height: curHeight,
                ),
              );
            },
          ),
          Container(
              padding: EdgeInsets.only(top: height * 0.8),
              child : Center(
                child: RaisedButton(
                  child: Text("Toggle"),
                  onPressed: _toggle,
                ),
              )
          )
        ],
      ),
    );
  }
}

class BezierClipper extends CustomClipper<Path>{

  final double progress;
  BezierClipper(this.progress);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  @override
  Path getClip(Size size) {
    Path path = Path();
    final double artboardW = 414+ (0) * progress;
    final double artboardH = 363.15+ (-61.45999999999998) * progress;
    final double _xScaling = size.width / artboardW;
    final double _yScaling = size.height / artboardH;
    path.lineTo((0+ (0) * progress) * _xScaling,(341.78499999999997+ (-123.94399999999996) * progress) * _yScaling);
    path.cubicTo((0+ (0) * progress) * _xScaling,(341.78499999999997+ (-123.94399999999996) * progress) * _yScaling,(23.465+ (-4.3210000000000015) * progress) * _xScaling,(363.15099999999995+ (-97.231) * progress) * _yScaling,(71.55699999999999+ (-4.319999999999993) * progress) * _xScaling,(363.15099999999995+ (-97.231) * progress) * _yScaling,);
    path.cubicTo((119.649+ (-4.319000000000017) * progress) * _xScaling,(363.15099999999995+ (-97.231) * progress) * _yScaling,(142.221+ (-29.465000000000003) * progress) * _xScaling,(300.186+ (-65.57499999999999) * progress) * _yScaling,(203.299+ (-29.462000000000018) * progress) * _xScaling,(307.21+ (-65.57499999999999) * progress) * _yScaling,);
    path.cubicTo((264.377+ (-29.45900000000003) * progress) * _xScaling,(314.234+ (-65.57499999999999) * progress) * _yScaling,(282.66999999999996+ (-9.799999999999955) * progress) * _xScaling,(333.47299999999996+ (-31.781999999999982) * progress) * _yScaling,(338.412+ (-9.800000000000011) * progress) * _xScaling,(333.47299999999996+ (-31.781999999999982) * progress) * _yScaling,);
    path.cubicTo((394.154+ (-9.800000000000068) * progress) * _xScaling,(333.47299999999996+ (-31.781999999999982) * progress) * _yScaling,(414+ (0) * progress) * _xScaling,(254.199+ (-52.22200000000001) * progress) * _yScaling,(414+ (0) * progress) * _xScaling,(254.199+ (-52.22200000000001) * progress) * _yScaling,);
    path.cubicTo((414+ (0) * progress) * _xScaling,(254.199+ (-52.22200000000001) * progress) * _yScaling,(414+ (0) * progress) * _xScaling,(0+ (0) * progress) * _yScaling,(414+ (0) * progress) * _xScaling,(0+ (0) * progress) * _yScaling,);
    path.cubicTo((414+ (0) * progress) * _xScaling,(0+ (0) * progress) * _yScaling,(2.1316282072803006e-14+ (0) * progress) * _xScaling,(0+ (0) * progress) * _yScaling,(2.1316282072803006e-14+ (0) * progress) * _xScaling,(0+ (0) * progress) * _yScaling,);
    path.cubicTo((2.1316282072803006e-14+ (0) * progress) * _xScaling,(0+ (0) * progress) * _yScaling,(0+ (0) * progress) * _xScaling,(341.78499999999997+ (-123.94399999999996) * progress) * _yScaling,(0+ (0) * progress) * _xScaling,(341.78499999999997+ (-123.94399999999996) * progress) * _yScaling,);
    return path;
  }
}


class GradientCircularProgressRoute extends StatefulWidget {
  @override
  GradientCircularProgressRouteState createState() {
    return new GradientCircularProgressRouteState();
  }
}

class GradientCircularProgressRouteState
    extends State<GradientCircularProgressRoute> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
    new AnimationController(vsync: this, duration: Duration(seconds: 3));
    bool isForward = true;
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var body =  SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: <Widget>[
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 16.0,
                        children: <Widget>[
                          GradientCircularProgressIndicator(
                            // No gradient
                            colors: [Colors.blue, Colors.blue],
                            radius: 50.0,
                            strokeWidth: 3.0,
                            value: _animationController.value,
                          ),
                          GradientCircularProgressIndicator(
                            colors: [Colors.red, Colors.orange],
                            radius: 50.0,
                            strokeWidth: 3.0,
                            value: _animationController.value,
                          ),
                          GradientCircularProgressIndicator(
                            colors: [Colors.red, Colors.orange, Colors.red],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            value: _animationController.value,
                          ),
                          GradientCircularProgressIndicator(
                            colors: [Colors.teal, Colors.cyan],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            strokeCapRound: true,
                            value: CurvedAnimation(
                                parent: _animationController,
                                curve: Curves.decelerate)
                                .value,
                          ),
                          TurnBox(
                            turns: 1 / 8,
                            child: GradientCircularProgressIndicator(
                                colors: [Colors.red, Colors.orange, Colors.red],
                                radius: 50.0,
                                strokeWidth: 5.0,
                                strokeCapRound: true,
                                backgroundColor: Colors.red[50],
                                totalAngle: 1.5 * pi,
                                value: CurvedAnimation(
                                    parent: _animationController,
                                    curve: Curves.ease)
                                    .value),
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: GradientCircularProgressIndicator(
                                colors: [Colors.blue[700], Colors.blue[200]],
                                radius: 50.0,
                                strokeWidth: 3.0,
                                strokeCapRound: true,
                                backgroundColor: Colors.transparent,
                                value: _animationController.value),
                          ),
                          GradientCircularProgressIndicator(
                            colors: [
                              Colors.red,
                              Colors.amber,
                              Colors.cyan,
                              Colors.green[200],
                              Colors.blue,
                              Colors.red
                            ],
                            radius: 50.0,
                            strokeWidth: 5.0,
                            strokeCapRound: true,
                            value: _animationController.value,
                          ),
                        ],
                      ),
                      GradientCircularProgressIndicator(
                        colors: [Colors.blue[700], Colors.blue[200]],
                        radius: 100.0,
                        strokeWidth: 20.0,
                        value: _animationController.value,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: GradientCircularProgressIndicator(
                          colors: [Colors.blue[700], Colors.blue[300]],
                          radius: 100.0,
                          strokeWidth: 20.0,
                          value: _animationController.value,
                          strokeCapRound: true,
                        ),
                      ),
                      //剪裁半圆
                      ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          heightFactor: .5,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox(
                              //width: 100.0,
                              child: TurnBox(
                                turns: .75,
                                child: GradientCircularProgressIndicator(
                                  colors: [Colors.teal, Colors.cyan[500]],
                                  radius: 100.0,
                                  strokeWidth: 8.0,
                                  value: _animationController.value,
                                  totalAngle: pi,
                                  strokeCapRound: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 104.0,
                        width: 200.0,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Positioned(
                              height: 200.0,
                              top: .0,
                              child: TurnBox(
                                turns: .75,
                                child: GradientCircularProgressIndicator(
                                  colors: [Colors.teal, Colors.cyan[500]],
                                  radius: 100.0,
                                  strokeWidth: 8.0,
                                  value: _animationController.value,
                                  totalAngle: pi,
                                  strokeCapRound: true,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                "${(_animationController.value * 100).toInt()}%",
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      body: body,
    );
  }
}

class GradientCircularProgressIndicator extends StatelessWidget {
  GradientCircularProgressIndicator({
    this.strokeWidth = 2.0,
    @required this.radius,
    @required this.colors,
    this.stops,
    this.strokeCapRound = false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.totalAngle = 2 * pi,
    this.value
});

  final double strokeWidth;
  final double radius;
  final bool strokeCapRound;
  final double value;
  final Color backgroundColor;
  final double totalAngle;
  final List<Color> colors;
  final List<double> stops;

  @override
  Widget build(BuildContext context) {
    double _offset = 0.0;
    if (strokeCapRound) {
      _offset = asin(strokeWidth / radius * 2 - strokeWidth);
    }
    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context)
          .accentColor;
      _colors = [color, color];
    }
    return Transform.rotate(
      angle: -pi / 2.0 - _offset,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
          strokeWidth: strokeWidth,
          strokeCapRound: strokeCapRound,
          backgroundColor: backgroundColor,
          value: value,
          total: totalAngle,
          radius: radius,
          colors: _colors,
        ),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter({
    this.strokeWidth = 10.0,
    this.strokeCapRound = false,
    this.value,
    this.backgroundColor = const Color(0xFFEEEEEE),
    @required this.colors,
    this.total = 2 * pi,
    this.radius,
    this.stops,
  });


  final double strokeWidth;
  final bool strokeCapRound;
  final double value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double radius;
  final List<double> stops;

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius);
    }
    double _offset = strokeWidth / 2.0;
    double _value = (value ?? .0);
    _value = _value.clamp(.0, 1.0) * total;
    double _start = .0;

    if (strokeCapRound) {
     _start = asin(strokeWidth / (size.width - strokeWidth));
    }

    Rect rect = Offset(_offset, _offset) & Size(
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    var paint = Paint()
    ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true
    ..strokeWidth = strokeWidth;

    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(
        rect,
        _start,
        total,
        false,
        paint
      );
    }

    if (_value > 0) {
      paint.shader = SweepGradient(
        startAngle: 0.0,
        endAngle: _value,
        colors: colors,
        stops: stops,
      ).createShader(rect);
    }

    canvas.drawArc(
        rect,
        _start,
        _value,
        false,
        paint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomPaintRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(300, 300),
        painter: MyPainter(),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 15;
    double eHeight = size.height / 15;

    var paint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.fill
    ..color = Color(0x77cdb175);

    canvas.drawRect(Offset.zero & size, paint);

    paint
    ..style = PaintingStyle.stroke
    ..color = Colors.black87
    ..strokeWidth = 1.0;

    for (int i = 0; i <= 15; i++) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i <= 15; i++) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    paint
    ..style = PaintingStyle.fill
    ..color = Colors.black;

    canvas.drawCircle(
      Offset(size.width / 2 - eWidth / 2, size.height / 2 - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );

    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(size.width / 2 + eWidth / 2, size.height / 2 - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class TurnBoxRoute extends StatefulWidget {
  @override
  _TurnBoxRouteState createState() => new _TurnBoxRouteState();
}

class _TurnBoxRouteState extends State<TurnBoxRoute> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TurnBox"),),
      body: Center(
        child: Column(
          children: <Widget>[
            TurnBox(
              turns: _turns,
              speed: 500,
              child: Icon(Icons.refresh, size: 50,),
            ),
            TurnBox(
              turns: _turns,
              speed: 1000,
              child: Icon(Icons.refresh, size: 150.0,),
            ),
            RaisedButton(
              child: Text("顺时针旋转1/5圈"),
              onPressed: () {
                setState(() {
                  _turns += .2;
                });
              },
            ),
            RaisedButton(
              child: Text("逆时针旋转1/5圈"),
              onPressed: () {
                setState(() {
                  _turns -= .2;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class TurnBox extends StatefulWidget {
  const TurnBox({
    Key key,
    this.turns = .0, //旋转的“圈”数,一圈为360度，如0.25圈即90度
    this.speed = 200, //过渡动画执行的总时长
    this.child
  }) :super(key: key);

  final double turns;
  final int speed;
  final Widget child;

  @override
  _TurnBoxState createState() => new _TurnBoxState();
}

class _TurnBoxState extends State<TurnBox>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this,
        lowerBound: -double.infinity,
        upperBound: double.infinity
    );
    _controller.value = widget.turns;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    //旋转角度发生变化时执行过渡动画
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.speed??200),
        curve: Curves.easeOut,
      );
    }
  }
}

class GradientButtonRoute extends StatefulWidget {
  @override
  _GradientButtonRouteState createState() => _GradientButtonRouteState();
}

class _GradientButtonRouteState extends State<GradientButtonRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GradientButton(
            colors: [Colors.orange, Colors.red],
            height: 50.0,
            child: Text("Submit"),
            onPressed: onTap,
          ),
          GradientButton(
            height: 50.0,
            colors: [Colors.lightGreen, Colors.green[700]],
            child: Text("Submit"),
            onPressed: onTap,
          ),
          GradientButton(
            height: 50.0,
            colors: [Colors.lightBlue[300], Colors.blueAccent],
            child: Text("Submit"),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
  onTap() {
    print("button click");
  }
}

class GradientButton extends StatelessWidget {
  GradientButton({
    this.colors,
    this.width,
    this.height,
    this.onPressed,
    this.borderRadius,
    @required this.child,
  });

  // 渐变色数组
  final List<Color> colors;

  // 按钮宽高
  final double width;
  final double height;

  final Widget child;
  final BorderRadius borderRadius;

  //点击回调
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    //确保colors数组不空
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark ?? theme.primaryColor];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors),
        borderRadius: borderRadius,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WebSocketRoute extends StatefulWidget {
  @override
  _WebSocketRouteState createState() => _WebSocketRouteState();
}

class _WebSocketRouteState extends State<WebSocketRoute> {
  TextEditingController _controller = new TextEditingController();
  IOWebSocketChannel channel;
  String _text = "";

  @override
  void initState() {
    channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("webScoket"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: "Send a message"),
              ),
            ),
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  _text = "connect error";
                } else if (snapshot.hasData) {
                  _text = "echo: " + snapshot.data;
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(_text),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: "Send Message",
        child: Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}

class ChunkDownloadRoute extends StatefulWidget {
  @override
  ChunkDownloadState createState() {
    return ChunkDownloadState();
  }
}

class ChunkDownloadState extends State<ChunkDownloadRoute> {
  String _url = "https://dldir1.qq.com/weixin/Windows/WeChatSetup.exe";

  double _progress = 0;

  Future<String> _getLocalFileDir() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    print("dir = $dir");
    return dir;
  }

  downloadWithChunks(
    url, {
    ProgressCallback onReceiveProgress,
  }) async {
    const firstChunkSize = 102;
    const maxChunk = 3;

    int total = 0;
    var dio = Dio();
    var progress = <int>[];

    // async 和 await 是可以嵌套的
    // 这里就嵌套了好几层
    String savePath = await _getLocalFileDir();

    // 这里函数没有明确写明返回类型，会被判断为 dynamic 类型。如果没有返回值，则会被隐式地添加 return null；
    func(no) {
      return (int received, _) {
        progress[no] = received;
        if (onReceiveProgress != null && total != 0) {
          onReceiveProgress(progress.reduce((a, b) => a + b), total);
        }
      };
    }

    Future<Response> downloadChunk(url, start, end, no) async {
      progress.add(0);
      --end;
      return dio.download(
        url,
        savePath + "temp$no",
        onReceiveProgress: func(no),
        options: Options(
          headers: {"range": "bytes=$start-$end"},
        ),
      );
    }

    Future mergeTempFiles(chunk) async {
      File f = File(savePath + "temp0");
      IOSink ioSink = f.openWrite(mode: FileMode.writeOnlyAppend);
      for (int i = 1; i < chunk; ++i) {
        File _f = File(savePath + "temp$i");
        await ioSink.addStream(_f.openRead());
        await _f.delete();
      }
      await ioSink.close();
      await f.rename(savePath + "YEEE");
    }

    Response response = await downloadChunk(url, 0, firstChunkSize, 0);
    if (response.statusCode == 206) {
      total = int.parse(response.headers
          .value(HttpHeaders.contentRangeHeader)
          .split("/")
          .last);
      int reserved = total -
          int.parse(response.headers.value(HttpHeaders.contentLengthHeader));
      int chunk = (reserved / firstChunkSize).ceil() + 1;
      if (chunk > 1) {
        int chunkSize = firstChunkSize;
        if (chunk > maxChunk + 1) {
          chunk = maxChunk + 1;
          chunkSize = (reserved / maxChunk).ceil();
        }
        var futures = <Future>[];
        for (int i = 0; i < maxChunk; ++i) {
          int start = firstChunkSize + i * chunkSize;
          futures.add(downloadChunk(url, start, start + chunkSize, i + 1));
        }
        await Future.wait(futures);
      }
      await mergeTempFiles(chunk);
    }
  }

  Future _future;

  @override
  void initState() {
    super.initState();
    _future = downloadWithChunks(_url, onReceiveProgress: (received, total) {
      setState(() {
        _progress = received / total;
      });
      // print("progress = ${received / total}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chunkDownloadRoute"),
      ),
      body: Center(
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            print("state = ${snapshot.connectionState}");
            if (snapshot.hasError) {
              print("connect error: ${snapshot.error}");
              return Text("Woops! connect failed");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return CircularProgressIndicator(
                value: 100.0,
              );
            } else {
              return CircularProgressIndicator(
                value: _progress,
              );
            }
          },
        ),
      ),
    );
  }
}

class FutureBuilderRoute1 extends StatefulWidget {
  @override
  _FutureBuilderRoute1State createState() => _FutureBuilderRoute1State();
}

class _FutureBuilderRoute1State extends State<FutureBuilderRoute1> {
  Dio _dio = Dio();
  String _path = "https://api.github.com/orgs/flutterchina/repos";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FutureBuilderRoute"),
      ),
      body: Center(
        child: FutureBuilder(
          future: _dio.get(_path),
          builder: (context, asyncSnapShot) {
            if (asyncSnapShot.connectionState == ConnectionState.done) {
              Response response = asyncSnapShot.data;
              if (asyncSnapShot.hasError) {
                return Text(asyncSnapShot.error.toString());
              }
              print("data type = ${response.data.runtimeType}");
              return ListView(
                children: response.data
                    .map<Widget>((e) => ListTile(title: Text(e["full_name"])))
                    .toList(),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class HttpTestRoute extends StatefulWidget {
  @override
  _HttpTestRouteState createState() => _HttpTestRouteState();
}

class _HttpTestRouteState extends State<HttpTestRoute> {
  bool _loading = false;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HttpTestRoute"),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              RaisedButton(
                child: Text("获取百度"),
                onPressed: _loading
                    ? null
                    : () async {
                        setState(() {
                          _loading = true;
                          _text = "正在请求。。。";
                        });
                        try {
                          HttpClient httpclient = HttpClient();
                          httpclient.idleTimeout = Duration(seconds: 50);
                          HttpClientRequest request = await httpclient
                              .getUrl(Uri.parse("https://www.baidu.com"));
                          request.headers.add("user-agent",
                              "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
                          HttpClientResponse response = await request.close();
                          _text = await response.transform(utf8.decoder).join();
                          print(response.headers);

                          httpclient.close();
                        } catch (e) {
                          _text = "请求失败: $e";
                        } finally {
                          setState(() {
                            _loading = false;
                          });
                        }
                      },
              ),
              Container(
                width: MediaQuery.of(context).size.width - 50.0,
                child: Text(_text.replaceAll(RegExp(r"</title>"), "fuck")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FileOperationRoute extends StatefulWidget {
  FileOperationRoute({Key key}) : super(key: key);

  @override
  _FileOperationRouteState createState() => _FileOperationRouteState();
}

class _FileOperationRouteState extends State<FileOperationRoute> {
  int _counter;

  @override
  void initState() {
    super.initState();
    _readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File("$dir/counter.txt");
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  Future<Null> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await (await _getLocalFile()).writeAsString("$_counter");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("文件操作"),
      ),
      body: Center(
        child: Text("点击了$_counter次"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class AnimatedWidgetTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatedWidgetTestRoute"),
      ),
      body: AnimatedWidgetTest(),
    );
  }
}

class AnimatedWidgetTest extends StatefulWidget {
  @override
  _AnimatedWidgetTestState createState() => _AnimatedWidgetTestState();
}

class _AnimatedWidgetTestState extends State<AnimatedWidgetTest> {
  double _padding = 10;
  var _align = Alignment.topRight;
  double _height = 100;
  double _left = 0;
  Color _color = Colors.red;
  TextStyle _style = TextStyle(color: Colors.black);
  Color _decorationColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    var duration = Duration(seconds: 5);
    return SingleChildScrollView(
      child: Column(
        children: [
          RaisedButton(
            onPressed: () {
              setState(() {
                _padding = 20;
              });
            },
            child: AnimatedPadding(
              duration: duration,
              padding: EdgeInsets.all(_padding),
              child: Text("AnimatedPadding"),
            ),
          ),
          SizedBox(
            height: 50,
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: duration,
                  left: _left,
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _left = 100;
                      });
                    },
                    child: Text("AnimatedPositioned"),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            color: Colors.grey,
            child: AnimatedAlign(
              duration: duration,
              alignment: _align,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    _align = Alignment.center;
                  });
                },
                child: Text("AnimatedAlign"),
              ),
            ),
          ),
          AnimatedContainer(
            duration: duration,
            height: _height,
            color: _color,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _height = 150;
                  _color = Colors.blue;
                });
              },
              child: Text("AnimatedContainer",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          AnimatedDefaultTextStyle(
            child: GestureDetector(
              child: Text("hello world"),
              onTap: () {
                setState(() {
                  _style = TextStyle(
                    color: Colors.blue,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: Colors.blue,
                  );
                });
              },
            ),
            style: _style,
            duration: duration,
          ),
          AnimatedDecoratedBox1(
            duration: duration,
            decoration: BoxDecoration(color: _decorationColor),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  _decorationColor = Colors.red;
                });
              },
              child: Text(
                "AnimatedDecoratedBox",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ].map((e) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: e,
          );
        }).toList(),
      ),
    );
  }
}

class AnimatedDecorBox extends ImplicitlyAnimatedWidget {
  AnimatedDecorBox({
    Key key,
    @required this.decoration,
    this.child,
    Curve curve = Curves.linear,
    @required Duration duration,
    Duration reverseDuration,
  }) : super(
          key: key,
          curve: curve,
          duration: duration,
        );

  final BoxDecoration decoration;
  final Widget child;

  @override
  _AnimatedDecoratedBoxState createState() {
    return _AnimatedDecoratedBoxState();
  }
}

class _AnimatedDecoratedBoxState
    extends AnimatedWidgetBaseState<AnimatedDecorBox> {
  DecorationTween _decorationTween;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _decorationTween.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    _decorationTween = visitor(_decorationTween, widget.decoration,
        (value) => DecorationTween(begin: value));
  }
}

class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hero"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: InkWell(
          child: Hero(
            tag: "avatar",
            child: ClipOval(
              child: Image.asset(
                "./images/nightsky.jpeg",
                width: 50.0,
              ),
            ),
          ),
          onTap: () {
            // Navigator.push(context, PageRouteBuilder(
            //   pageBuilder: (context, animation, secAnimation) {
            //     return FadeTransition(
            //       opacity: animation,
            //       child: Scaffold(
            //         appBar: AppBar(title: Text("原图")),
            //         body: HeroAnimationRouteB(),
            //       ),
            //     );
            //   },
            // ));
            Navigator.push(context, CupertinoPageRoute(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(title: Text("原图")),
                  body: HeroAnimationRouteB(),
                );
              },
            ));
          },
        ),
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "avatar",
        child: Image.asset("./images/nightsky.jpeg"),
      ),
    );
  }
}

class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    Key key,
    @required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    this.child,
  })  : assert(position != null),
        super(key: key, listenable: position) {
    // 偏移在内部处理
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
    }
  }

  Animation<double> get position => listenable;
  final bool transformHitTests;
  final Widget child;
  final AxisDirection direction;
  Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, -offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }

    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

class MySlideTransition extends AnimatedWidget {
  MySlideTransition({
    Key key,
    @required Animation<Offset> position,
    this.transformHitTests = true,
    this.child,
  })  : assert(position != null),
        super(key: key, listenable: position);

  Animation<Offset> get position => listenable;
  final bool transformHitTests;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

class AnimatedDecoratedBoxRoute extends StatefulWidget {
  @override
  _AnimatedDecoratedBoxRouteState createState() =>
      _AnimatedDecoratedBoxRouteState();
}

class _AnimatedDecoratedBoxRouteState extends State<AnimatedDecoratedBoxRoute> {
  Color _decorationColor = Colors.blue;
  var duration = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatedDecoratedBoxRoute"),
      ),
      body: Center(
        child: AnimatedDecorBox(
          duration: duration,
          decoration: BoxDecoration(color: _decorationColor),
          child: FlatButton(
            onPressed: () {
              setState(() {
                _decorationColor = Colors.red;
              });
            },
            child: Text(
              "AnimatedDecorBox",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedDecoratedBox1 extends StatefulWidget {
  AnimatedDecoratedBox1({
    Key key,
    @required this.decoration,
    this.child,
    this.curve = Curves.linear,
    @required this.duration,
    this.reverseDuration,
  });

  final BoxDecoration decoration;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration reverseDuration;

  @override
  _AnimatedDecoratedBox1State createState() => _AnimatedDecoratedBox1State();
}

class _AnimatedDecoratedBox1State extends State<AnimatedDecoratedBox1>
    with SingleTickerProviderStateMixin {
  @protected
  AnimationController get controller => _controller;
  AnimationController _controller;

  Animation<double> get animation => _animation;
  Animation<double> _animation;

  DecorationTween _tween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
      vsync: this,
    );
    _tween = DecorationTween(begin: widget.decoration);
    _updateCurve();
  }

  void _updateCurve() {
    if (widget.curve != null) {
      _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    } else {
      _animation = _controller;
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedDecoratedBox1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.curve != oldWidget.curve) {
      _updateCurve();
    }
    _controller.duration = widget.duration;
    _controller.reverseDuration = widget.reverseDuration;
    if (widget.decoration != (_tween.end ?? _tween.begin)) {
      _tween
        ..begin = _tween.evaluate(_animation)
        ..end = widget.decoration;
      _controller
        ..value = 0.0
        ..forward();
    }

    @override
    void dispose() {
      super.dispose();
      _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        child: widget.child,
        builder: (context, child) {
          return DecoratedBox(
            decoration: _tween.animate(_animation).value,
            child: child,
          );
        });
  }
}

class AnimatedSwitcherCounterRoute extends StatefulWidget {
  @override
  _AnimatedSwitcherCounterRouteState createState() =>
      _AnimatedSwitcherCounterRouteState();
}

class _AnimatedSwitcherCounterRouteState
    extends State<AnimatedSwitcherCounterRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatedSwitcher"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 400.0,
                height: 100.0,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SlideTransitionX(
                        child: child,
                        direction: AxisDirection.up,
                        position: animation);
                  },
                  child: Text(
                    "$_count",
                    //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                    key: ValueKey<int>(_count),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
            ),
            RaisedButton(
              child: const Text("+1"),
              onPressed: () {
                setState(() {
                  _count += 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StaggerRoute extends StatefulWidget {
  @override
  _StaggerRouteState createState() => _StaggerRouteState();
}

class _StaggerRouteState extends State<StaggerRoute>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  }

  Future<Null> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StaggerRoute"),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            child: StaggerAnimation(
              controller: _controller,
            ),
          ),
        ),
      ),
    );
  }
}

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key key, this.controller}) : super(key: key) {
    height = Tween<double>(
      begin: 0,
      end: 300.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 0.6, curve: Curves.ease),
    ));

    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 0.6, curve: Curves.ease),
    ));

    padding = Tween<EdgeInsets>(
      begin: EdgeInsets.only(left: .0),
      end: EdgeInsets.only(left: 100.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.6, 1.0, //间隔，后40%的动画时间
          curve: Curves.ease,
        ),
      ),
    );
  }

  final Animation<double> controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}

class FadeRoute extends PageRoute {
  FadeRoute({
    @required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }
}

class Route1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route1"),
      ),
      body: Center(
        child: CupertinoButton(
          color: Colors.blue,
          child: Text("to Route2 ->"),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return RotationTransition(
                    turns: animation,
                    child: Route2(),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class Route2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route2"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Container(
            width: double.infinity,
            child: CupertinoButton(
              color: Colors.blue,
              child: Text("<- back"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return Container(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}

class AnimateBuilderRoute extends StatefulWidget {
  @override
  _AnimateBuilderRouteState createState() => _AnimateBuilderRouteState();
}

class _AnimateBuilderRouteState extends State<AnimateBuilderRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GrowTransition(
      child: Image.asset("./images/nightsky.jpeg"),
      animation: animation,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}

class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    // final Animation<double> animation = listenable;
    return Center(
      child: Image.asset(
        "./images/nightsky.jpeg",
        width: (listenable as Animation<double>).value,
        height: (listenable as Animation<double>).value,
      ),
    );
  }
}

class ScaleAnimationRoute1 extends StatefulWidget {
  @override
  _ScaleAnimationRoute1State createState() => _ScaleAnimationRoute1State();
}

class _ScaleAnimationRoute1State extends State<ScaleAnimationRoute1>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedImage(
      animation: animation,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => _ScaleAnimationRouteState();
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(seconds: 3), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("./images/nightsky.jpeg",
          width: animation.value, height: animation.value),
    );
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);
  final String msg;
}

class NotificationRoute extends StatefulWidget {
  @override
  _NotificationRouteState createState() => _NotificationRouteState();
}

class _NotificationRouteState extends State<NotificationRoute> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        setState(() {
          _msg += notification.msg + " ";
        });
        return true;
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 这个不起作用，因为 context 是 widget 树的根 context
            RaisedButton(
              onPressed: () => MyNotification("Hi").dispatch(context),
              child: Text("Send Notification"),
            ),
            Builder(
              builder: (context) {
                return RaisedButton(
                  onPressed: () => MyNotification("Hi").dispatch(context),
                  child: Text("send notification"),
                );
              },
            ),
            Text(_msg),
          ],
        ),
      ),
    );
  }
}

class ListenerNoConflictRoute extends StatefulWidget {
  @override
  _ListenerNoConflictRouteState createState() =>
      _ListenerNoConflictRouteState();
}

class _ListenerNoConflictRouteState extends State<ListenerNoConflictRoute> {
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ListenerNoConflictRoute")),
      body: Stack(
        children: [
          Positioned(
            top: 80.0,
            left: _left,
            child: Listener(
              onPointerDown: (details) {
                print("down");
              },
              onPointerUp: (details) {
                print("up");
              },
              child: GestureDetector(
                child: CircleAvatar(
                  child: Text("B"),
                ),
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _left += details.delta.dx;
                  });
                },
                onHorizontalDragEnd: (details) {
                  print("onHorizontalDragEnd");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 手势识别会有冲突，遇到冲突可以识别原始 Pointer 事件
class GestureConflictTestRoute extends StatefulWidget {
  @override
  _GestureConflictTestRouteState createState() =>
      _GestureConflictTestRouteState();
}

class _GestureConflictTestRouteState extends State<GestureConflictTestRoute> {
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GestureConflictTestRoute"),
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              left: _left,
              child: GestureDetector(
                child: CircleAvatar(
                  child: Text("A"),
                ),
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _left += details.delta.dx;
                  });
                },
                onHorizontalDragEnd: (details) {
                  print("onHorizontalDragEnd");
                },
                onTapDown: (details) {
                  print("down");
                },
                onTapUp: (details) {
                  print("up");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BothDirectionTestRoute extends StatefulWidget {
  @override
  _BothDirectionTestRouteState createState() => _BothDirectionTestRouteState();
}

class _BothDirectionTestRouteState extends State<BothDirectionTestRoute> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BothDirection"),
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: _top,
              left: _left,
              child: GestureDetector(
                child: CircleAvatar(child: Text("A")),
                // onPanUpdate: (details) {
                //   setState(() {
                //     _top += details.delta.dy;
                //     _left += details.delta.dx;
                //   });
                // },
                onVerticalDragUpdate: (details) {
                  setState(() {
                    _top += details.delta.dy;
                  });
                },
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _left += details.delta.dx;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GestureRecognizer extends StatefulWidget {
  @override
  __GestureRecognizerState createState() => __GestureRecognizerState();
}

class __GestureRecognizerState extends State<_GestureRecognizer> {
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false;

  @override
  void dispose() {
    // 用到 GestureRecognizer 一定要调用 dispose 释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tapGestureRecognizer.onTap = () {
      setState(() {
        _toggle = !_toggle;
      });
    };
    return Scaffold(
      appBar: AppBar(
        title: Text("GestureRecognizer"),
      ),
      body: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "你好世界"),
              TextSpan(
                text: "点我变色",
                style: TextStyle(
                    fontSize: 30.0, color: _toggle ? Colors.blue : Colors.red),
                recognizer: _tapGestureRecognizer,
              ),
              TextSpan(text: "你好世界"),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScaleTestRoute extends StatefulWidget {
  @override
  __ScaleTestRouteState createState() => __ScaleTestRouteState();
}

class __ScaleTestRouteState extends State<_ScaleTestRoute> {
  double _width = 200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scale"),
      ),
      body: Center(
          child: GestureDetector(
        child: Image.asset(
          "./images/nightsky.jpeg",
          width: _width,
        ),
        onScaleUpdate: (details) {
          setState(() {
            _width = 200.0 * details.scale.clamp(0.8, 20.0);
          });
        },
      )),
    );
  }
}

class _DragVertical extends StatefulWidget {
  @override
  __DragVerticalState createState() => __DragVerticalState();
}

class __DragVerticalState extends State<_DragVertical> {
  double _top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DragVertical"),
      ),
      body: Stack(
        children: [
          Positioned(
            top: _top,
            child: GestureDetector(
              child: CircleAvatar(child: Text("A")),
              onVerticalDragUpdate: (details) {
                setState(() {
                  _top += details.delta.dy;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Drag extends StatefulWidget {
  @override
  __DragState createState() => __DragState();
}

class __DragState extends State<_Drag> {
  double _top = 0.0;
  double _left = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drag"),
      ),
      body: Stack(
        children: [
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(
                child: Text("A"),
              ),
              onPanDown: (DragDownDetails e) {
                print("用户手指按下： ${e.globalPosition}");
              },
              onPanUpdate: (DragUpdateDetails e) {
                setState(() {
                  _left += e.delta.dx;
                  _top += e.delta.dy;
                });
              },
              onPanEnd: (DragEndDetails e) {
                print(e.velocity);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GestureDetectorTestRoute extends StatefulWidget {
  @override
  _GestureDetectorTestRouteState createState() =>
      _GestureDetectorTestRouteState();
}

class _GestureDetectorTestRouteState extends State<GestureDetectorTestRoute> {
  String _operation = "No Gesture detected!";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GestureDetector"),
      ),
      body: Center(
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            width: 200.0,
            height: 100.0,
            child: Text(
              _operation,
              style: TextStyle(color: Colors.white),
            ),
          ),
          onTap: () => updateText("Tap"),
          onDoubleTap: () => updateText("DoubleTap"),
          onLongPress: () => updateText("LongPress"),
        ),
      ),
    );
  }

  void updateText(String text) {
    setState(() {
      _operation = text;
    });
  }
}

class PointerTranslucentRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Listener(
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(300.0, 200.0)),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.blue),
                ),
              ),
              onPointerDown: (event) => print("down0"),
            ),
            Listener(
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(200.0, 100.0)),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey),
                  child: Center(
                    child: Text("左上角 200 * 100 区域非文本点击区域"),
                  ),
                ),
              ),
              onPointerDown: (event) => print("down1"),
              behavior: HitTestBehavior.opaque,
            ),
          ],
        ),
      ),
    );
  }
}

class PointerRoute extends StatefulWidget {
  @override
  _PointerRouteState createState() => _PointerRouteState();
}

class _PointerRouteState extends State<PointerRoute> {
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        width: 300.0,
        height: 150.0,
        child: Text(
          _event?.toStringFull() ?? "",
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      ),
      onPointerDown: (PointerDownEvent event) => setState(() => _event = event),
      onPointerMove: (PointerMoveEvent event) => setState(() => _event = event),
      onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
    );
  }
}

Stream<int> counter() {
  return Stream.periodic(Duration(seconds: 1), (i) {
    return i;
  });
}

class StreamBuilderRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<int>(
          stream: counter(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.hasError) return Text("Error: ${snapshot.error}");
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('没有Stream');
              case ConnectionState.waiting:
                return Text('等待数据...');
              case ConnectionState.active:
                return Text('active: ${snapshot.data}');
              case ConnectionState.done:
                return Text('Stream已关闭');
            }
            return null;
          },
        ),
      ),
    );
  }
}

Future<String> mockNetworkData() async {
  return Future.delayed(Duration(seconds: 2), () => "我的从互联网上获取的数据");
}

class FutureBuilderRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<String>(
            future: mockNetworkData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return Text("Contents: ${snapshot.data}");
                }
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}

class ThemeTestRoute extends StatefulWidget {
  @override
  _ThemeTestRouteState createState() => _ThemeTestRouteState();
}

class _ThemeTestRouteState extends State<ThemeTestRoute> {
  Color _themeColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
          primarySwatch: _themeColor,
          iconTheme: IconThemeData(color: _themeColor)),
      child: Scaffold(
        appBar: AppBar(title: Text("主题测试")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite),
                Icon(Icons.airport_shuttle),
                Text("颜色跟随主题"),
              ],
            ),
            Theme(
              data: themeData.copyWith(
                  iconTheme: themeData.iconTheme.copyWith(color: Colors.black)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text("颜色固定黑色")
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                _themeColor =
                    _themeColor == Colors.teal ? Colors.blue : Colors.teal;
              });
            },
            child: Icon(Icons.palette)),
      ),
    );
  }
}

class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  final T data;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

typedef VoidCallback = void Function();

class ChangeNotifier implements Listenable {
  List listeners = [];

  @override
  void addListener(VoidCallback listener) {
    listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    listeners.remove(listener);
  }

  void notifyListeners() {
    listeners.forEach((item) => item());
  }
}

class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({@required this.data, Widget child}) : super(child: child);

  final int data;

  static ShareDataWidget of(BuildContext context) {
    return context
        .getElementForInheritedWidgetOfExactType<ShareDataWidget>()
        .widget;
  }

  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    // 只有这里返回 true，成功 notify 才会调用 didChangeDependencies
    return oldWidget.data != data;
  }
}

class _TestWidget extends StatefulWidget {
  @override
  __TestWidgetState createState() => __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(ShareDataWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("dependencies change");
  }
}

class InheritedWidgetTestRoute extends StatefulWidget {
  @override
  _InheritedWidgetTestRouteState createState() =>
      _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("InheritedWidget"),
      ),
      body: Center(
        child: ShareDataWidget(
          data: count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: _TestWidget(),
              ),
              RaisedButton(
                child: Text("Increment"),
                onPressed: () => setState(() => ++count),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WillPopScopeTestRoute extends StatefulWidget {
  @override
  _WillPopScopeTestRouteState createState() => _WillPopScopeTestRouteState();
}

class _WillPopScopeTestRouteState extends State<WillPopScopeTestRoute> {
  DateTime _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          _lastPressedAt = DateTime.now();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Text("1 秒内连续按两次返回键退出"),
        ),
      ),
    );
  }
}

class ScrollNotificationTestRoute extends StatefulWidget {
  @override
  _ScrollNotificationTestRouteState createState() =>
      _ScrollNotificationTestRouteState();
}

class _ScrollNotificationTestRouteState
    extends State<ScrollNotificationTestRoute> {
  String _progress = "0%";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            double progress = notification.metrics.pixels /
                notification.metrics.maxScrollExtent;
            setState(() {
              _progress = "${(progress * 100).toInt()}";
            });
            print("BottomEdge: ${notification.metrics.extentAfter == 0}");
            // 返回 true 代表消耗掉这个通知
            return true;
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              ListView.builder(
                itemCount: 100,
                itemExtent: 50.0,
                itemBuilder: (context, index) {
                  return ListTile(title: Text("#index"));
                },
              ),
              CircleAvatar(
                radius: 30.0,
                child: Text(_progress),
                backgroundColor: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScrollControllerTestRoute extends StatefulWidget {
  @override
  _ScrollControllerTestRouteState createState() =>
      _ScrollControllerTestRouteState();
}

class _ScrollControllerTestRouteState extends State<ScrollControllerTestRoute> {
  ScrollController _controller = new ScrollController();
  bool showToTopBtn = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      print(_controller.offset);
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("scroll controller"),
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: 100,
          itemExtent: 50.0,
          controller: _controller,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("$index"),
            );
          },
        ),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _controller.animateTo(.0,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.bounceInOut);
              },
            ),
    );
  }
}

class CustomScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Demo"),
              background: Image.asset(
                "./images/nightsky.jpeg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: new SliverGrid(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: new Text("grid item"),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
          // List
          new SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return new Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: new Text('list item $index'),
                );
              },
              childCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}

class InfiniteGridView extends StatefulWidget {
  @override
  _InfiniteGridViewState createState() => _InfiniteGridViewState();
}

class _InfiniteGridViewState extends State<InfiniteGridView> {
  List<IconData> _icons = [];

  @override
  void initState() {
    super.initState();
    _retrieveIcons();
  }

  void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((e) => {
          setState(() {
            _icons.addAll([
              Icons.ac_unit,
              Icons.airport_shuttle,
              Icons.all_inclusive,
              Icons.beach_access,
              Icons.cake,
              Icons.free_breakfast
            ]);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("IGV")),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
          ),
          itemCount: _icons.length,
          itemBuilder: (context, index) {
            if (index == _icons.length - 1 && _icons.length < 200) {
              _retrieveIcons();
            }
            return Icon(_icons[index]);
          }),
    );
  }
}

class TestGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView"),
      ),
      body: Center(
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
          ),
          children: [
            Icon(Icons.ac_unit),
            Icon(Icons.airport_shuttle),
            Icon(Icons.all_inclusive),
            Icon(Icons.beach_access),
            Icon(Icons.cake),
            Icon(Icons.free_breakfast)
          ],
        ),
      ),
    );
  }
}

class TestHeaderListViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ListTile(
              title: Text("商品列表"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemExtent: 50.0,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(title: Text("$index"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfiniteListView extends StatefulWidget {
  @override
  _InfiniteListViewState createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = "##loading##";
  var _words = <String>[loadingTag];

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        _words.insertAll(_words.length - 1,
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.separated(
            itemBuilder: (context, index) {
              if (_words[index] == loadingTag) {
                if (_words.length - 1 < 100) {
                  _retrieveData();
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 24.0,
                      height: 24.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      ),
                    ),
                  );
                } else {
                  return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "没有更多了",
                        style: TextStyle(color: Colors.grey),
                      ));
                }
              }
              return ListTile(
                  leading: FlutterLogo(),
                  trailing: Icon(Icons.more_vert),
                  subtitle: Text("This is second line----"),
                  title: Text(_words[index]));
            },
            separatorBuilder: (context, index) => Divider(
                  height: .0,
                ),
            itemCount: _words.length),
      ),
    );
  }
}

class TestListViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: 100,
          itemExtent: 50.0,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("$index"));
          },
        ),
      ),
    );
  }
}

class SingleChildScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String str = "QWERTYUIOPASDFGHJKLZXCMX,CNAKSD";
    return Scrollbar(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: str
                .split("")
                .map((c) => Text(
                      c,
                      textScaleFactor: 2.0,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class ContainerRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 2.0,
            colors: [Colors.red, Colors.orange],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(2.0, 2.0),
              blurRadius: 4.0,
            ),
          ],
          borderRadius: BorderRadius.circular(24.0),
        ),
        transform: Matrix4.rotationZ(0.2),
        alignment: Alignment.center,
        child: Text(
          "5.20",
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      ),
    );
  }
}

class WrapRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
          child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            alignment: WrapAlignment.start,
            children: [
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.yellowAccent,
                  child: Text("A"),
                ),
                label: Text("Alex"),
              ),
              Chip(
                avatar: new CircleAvatar(
                    backgroundColor: Colors.blue, child: Text('M')),
                label: new Text('Lafayette'),
              ),
              Chip(
                avatar: new CircleAvatar(
                    backgroundColor: Colors.blue, child: Text('H')),
                label: new Text('Mulligan'),
              ),
              Chip(
                avatar: new CircleAvatar(
                    backgroundColor: Colors.blue, child: Text('J')),
                label: new Text('Laurens'),
              ),
              Chip(
                avatar: new CircleAvatar(
                    backgroundColor: Colors.blue, child: Text('J')),
                label: new Text('Laurens'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FlexLayoutTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 30.0,
                color: Colors.red,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 30.0,
                color: Colors.green,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SizedBox(
            height: 100.0,
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30.0,
                    color: Colors.red,
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30.0,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class IndicatorRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        // child: CupertinoActivityIndicator(),
        child: LinearProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation(Colors.teal),
        ),
      ),
    );
  }
}

class Example {
  // 注意，在函数声明中，[] 是可选的意思， 不是指列表类型
  // [] 在表达式中指的是列表类型
  Example([String s]);
  Example.alt(List<String> l);
}

abstract class Event {
  void run();
}

class _AnonymousEvent implements Event {
  _AnonymousEvent({Function run}) : _run = run;
  // 这里即使加了 void，和没加效果一样，void Function() 和 Function() 指的都是 dynamic Function() 类型
  final void Function() _run;

  @override
  void run() => _run();
}

class ProgressRoute extends StatefulWidget {
  @override
  _ProgressRouteState createState() => _ProgressRouteState();
}

class _ProgressRouteState extends State<ProgressRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    Event event = _AnonymousEvent(run: () {
      return false;
    });
    //动画执行时间3秒
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: LinearProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
              .animate(_animationController), // 从灰色变成蓝色
          value: _animationController.value,
        ),
      ),
    );
  }
}

class FormTestRoute extends StatefulWidget {
  @override
  _FormTestRouteState createState() => _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _unameContorller = TextEditingController();
  TextEditingController _pwdContorller = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                controller: _unameContorller,
                decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  icon: Icon(Icons.person),
                ),
                validator: (v) {
                  return v.trim().length > 0 ? null : "用户名不能为空";
                },
              ),
              TextFormField(
                controller: _pwdContorller,
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (v) {
                  return v.trim().length > 5 ? null : "密码不能少于6位";
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("登录"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          // 在这里不能通过 Form.of(context) 获取 state，context 不对
                          // print(Form.of(context));

                          if ((_formKey.currentState as FormState).validate()) {
                            print("验证通过！！！");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FocusTestRoute extends StatefulWidget {
  @override
  _FocusTestRouteState createState() => _FocusTestRouteState();
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: CupertinoTextField(
                padding: EdgeInsets.all(16.0),
                autofocus: true,
                focusNode: focusNode1,
                placeholder: "sdsadsa",
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(colors: [Colors.yellowAccent, Colors.lightGreen]),
                // ),
              ),
            ),
            TextField(
              focusNode: focusNode2,
              decoration: InputDecoration(
                labelText: "input2",
              ),
            ),
            Builder(builder: (ctx) {
              return Column(
                children: [
                  RaisedButton(
                    child: Text("移动焦点"),
                    onPressed: () {
                      if (null == focusScopeNode) {
                        focusScopeNode = FocusScope.of(context);
                      }
                      focusScopeNode.requestFocus(focusNode2);
                    },
                  ),
                  RaisedButton(
                    child: Text("隐藏键盘"),
                    onPressed: () {
                      focusNode1.unfocus();
                      focusNode2.unfocus();
                    },
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  TextEditingController _controller = TextEditingController();

  ButtonWidget({Key key, this.text}) : super(key: key) {
    _controller.addListener(() {
      print(_controller.text);
    });
    _controller.text = "text!!!";
    _controller.selection = TextSelection(
      baseOffset: 2,
      extentOffset: _controller.text.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text(text),
              onPressed: () {},
            ),
            FlatButton(
              child: Text(text),
              onPressed: () {},
            ),
            OutlineButton(
              child: Text(text),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: () {},
            ),
            RaisedButton.icon(
              icon: Icon(Icons.add),
              label: Text("添加"),
              onPressed: () {},
            ),
            FlatButton(
              onPressed: () {},
              color: Colors.lightGreen,
              highlightColor: Colors.lightGreen[700],
              colorBrightness: Brightness.light,
              child: Text(
                "\uE000",
                style: TextStyle(
                  fontFamily: "MaterialIcons",
                  fontSize: 24.0,
                  color: Colors.yellowAccent,
                ),
              ),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0)),
            ),
            TextField(
              autofocus: true,
              controller: _controller,
              onChanged: (value) {
                print("onChange: $value");
              },
              decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或密码",
                  prefixIcon: Icon(Icons.person)),
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock)),
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  ImageWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage("images/nightsky.jpeg"),
          fit: BoxFit.scaleDown,
          width: 300.0,
          color: Colors.greenAccent,
          colorBlendMode: BlendMode.difference,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, "tip_route");
                },
                child: Text("open new route"),
                textColor: Colors.yellow),
            RandomWordsWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Route"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("This is  new route"),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({
    Key key,
    @required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("提示")),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                child: Text("返回"),
                onPressed: () => Navigator.pop(context, "我是返回值"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          print("！2@@#@@");
          // 这里的 await 会把当前线程阻塞，有点类似于 java 的 Future
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return TipRoute(
                text: "我是提示！！！！",
              );
            }),
          );
          print("路由返回值：$result");
          print("!!!!!asdasda");
        },
        child: Text("打开提示页"),
      ),
    );
  }
}

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }
}

// StatefulWidget example
class CounterWidget extends StatefulWidget {
  const CounterWidget({Key key, this.initValue: 0});

  final int initValue;

  _CounterWidgetState createState() => new _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter;

  @override
  void initState() {
    _counter = widget.initValue;
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text("$_counter"),
          onPressed: () => setState(() => ++_counter),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}

// 获取父 widget 的 State 对象
class FindAncestorRoute extends StatelessWidget {
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("子树中获取对象"),
      ),
      body: Center(
        child: Builder(
          builder: (context) {
            return RaisedButton(
              onPressed: () {
                // 通过 context 获取父级 widget 的 state
                // ScaffoldState _state = context.findAncestorStateOfType<ScaffoldState>();

                // 通过 of 静态方法获取
                // ScaffoldState _state = Scaffold.of(context);

                // 通过 globalKey 获取
                ScaffoldState _state = _globalKey.currentState;

                // _state.showSnackBar(
                //   SnackBar(content: Text("我是snack bar"))
                // );
                print("hasDrawer = ${_state.hasDrawer}");
                _state.openDrawer();
              },
              child: Text("显示 snackbar"),
            );
          },
        ),
      ),
    );
  }
}

class CupertinoTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: CupertinoButton(
          color: CupertinoColors.activeGreen,
          child: Text("press"),
          onPressed: () {},
        ),
      ),
      navigationBar: CupertinoNavigationBar(
        middle: Text("Cupertino Demo"),
      ),
    );
  }
}

class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);

  @override
  _TapboxAState createState() => new _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            _active ? "Active" : "Inactive",
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => new _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("parent build called");
    return new Container(
      // 所谓父组件管理状态，就是把子组件需要的参数，在父组件中构造然后传入
      // 很好奇，这个 active 的 bool 值，是值传递还是引用传递？
      // 个人觉得和 java 一样是值传递，但是传递的是对象的引用值拷贝，
      // 因为 dart 也是万物皆对象
      child: new TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

class TapboxB extends StatelessWidget {
  TapboxB({Key key, this.active: false, @required this.onChanged})
      : super(key: key) {
    print("TapboxB created");
  }

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    print("tapBox B build called");
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            active ? "Active" : "Inactive",
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

class ParentWidgetC extends StatefulWidget {
  @override
  _ParentWidgetCState createState() => new _ParentWidgetCState();
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

class TapboxC extends StatefulWidget {
  TapboxC({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  _TapboxCState createState() => new _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    print("tapBoxC build called");
    return new GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTap: _handleTap,
        onTapCancel: _handleTapCancel,
        child: new Container(
          child: new Center(
            child: new Text(
              widget.active ? "Active" : "Inactive",
              style: new TextStyle(fontSize: 32.0, color: Colors.white),
            ),
          ),
          width: 200.0,
          height: 200.0,
          decoration: new BoxDecoration(
            color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
            border: _highlight
                ? new Border.all(color: Colors.teal[700], width: 10.0)
                : null,
          ),
        ));
  }
}
