import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';
import 'dart:core';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // register route table
      routes: {
        "new_page": (context) => NewRoute(),
        "tip_route": (context) => TipRoute(text: "!SDAS",),
        // "/": (context) => MyHomePage(title: "home page"),
      },
      // onGenerateRoute 路由生成钩子,对于没有在 routes 中定义的 route，会走此方法
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          String routeName = settings.name;
          // switch (routeName) {
          //   case:
          // }
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
      home: TestListViewRoute(),
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
            children: str.split("")
                .map((c) => Text(c, textScaleFactor: 2.0,))
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
              avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
              label: new Text('Lafayette'),
            ),
            Chip(
              avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
              label: new Text('Mulligan'),
            ),
            Chip(
              avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
              label: new Text('Laurens'),
            ),
            Chip(
              avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
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
  _AnonymousEvent({Function run}): _run = run;
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
                       color:Theme.of(context).primaryColor,
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
              child: Text("\uE000",
                style: TextStyle(
                  fontFamily: "MaterialIcons",
                  fontSize: 24.0,
                  color: Colors.yellowAccent,
                ),
              ),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
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
                prefixIcon: Icon(Icons.person)
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "密码",
                hintText: "您的登录密码",
                prefixIcon: Icon(Icons.lock)
              ),
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
              textColor:Colors.yellow),
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
      appBar: AppBar(
        title: Text("提示")
      ),
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
              MaterialPageRoute(
                builder: (context) {
                  return TipRoute(
                    text: "我是提示！！！！",
                  );
                }
              ),
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
  const CounterWidget ({
    Key key,
    this.initValue: 0
});

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
        child: Builder(builder: (context) {
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
        },),
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
          border: _highlight ? new Border.all(
            color: Colors.teal[700],
            width: 10.0) : null,
        ),
      )
    );
  }
}
