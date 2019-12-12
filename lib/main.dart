import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Love Time'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _counter = 0;
  var loveTime = "你是我的一日 三餐 四季";
  var temp = 0;
  Timer timer;
  void getMyTime() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime now = new DateTime.now();
      DateTime pre = new DateTime(2019,9,20,18,0,0,0,0);
      var love = now.difference(pre);
      var inSeconds = love.inSeconds;
      var days = inSeconds/86400;
      var hours = inSeconds%86400/3600;
      var minutes = inSeconds%3600/60;
      var seconds = inSeconds%60;

      if(temp!=seconds){
        temp = seconds;
        setState(() {
          loveTime ="${days.toInt().toString()}天${hours.toInt().toString()}时${minutes.toInt().toString()}分${seconds.toInt().toString()}秒" ;
        });
//        print("${days.toInt().toString()}天${hours.toInt().toString()}时${minutes.toInt().toString()}分${seconds.toInt().toString()}秒");
      }
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void handleTimeout(){
    getMyTime();//callback
  }

@override
  void initState() {
  WidgetsBinding.instance.addObserver(this);
  super.initState();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),handleTimeout);
    return Scaffold(
//      appBar: AppBar(
//        centerTitle: true,
//        title: Text(widget.title),
//      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You are my home my home for all seasons',
            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
            Text(
              '$loveTime',
                style: TextStyle(fontSize: 32.0, color: Colors.black)),
          ],
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.access_alarm),
//      ),
    );
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    if(state==AppLifecycleState.resumed){
    }else if(state==AppLifecycleState.paused){
      SystemNavigator.pop();
    }

    super.didChangeAppLifecycleState(state);
  }
}
