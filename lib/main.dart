import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';





void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData( primarySwatch: Colors.blue, ),
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}





class _MyHomePageState extends State<MyHomePage> implements TickerProvider {
  var _alignment = Alignment( 0, -1 ); // x = width   ||   y = height
  double sizeX = 70, sizeY = 70, maxHeight = 0, maxWidth = 0, xx = 0, yy = 0;
  GlobalKey key1 = GlobalKey(),
            key2 = GlobalKey(),
            key3 = GlobalKey(),
            key4 = GlobalKey(),
            key5 = GlobalKey(),
            key6 = GlobalKey();


  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 0), (){
      setState(() {
        maxHeight = MediaQuery.of(context).size.height;
        maxWidth = MediaQuery.of(context).size.width;
      });
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('x: $xx  |  y: $yy', style: TextStyle(fontSize: 12),),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              color: Colors.red,
              alignment: _alignment,
              child: Container(
                color: Colors.yellow,
                width: sizeX, 
                height: sizeY,
                child: Center( child: Text('ups'),
              ) )
            ),

            Column(
              children: <Widget>[

                Expanded( flex: 5, child: identifyContainerSpot(context, 1, key1), ),
                Expanded( flex: 1, child: Container(), ),
                Expanded( flex: 5, child: identifyContainerSpot(context, 2, key2), ),
                Expanded( flex: 1, child: Container(), ),
                Expanded( flex: 5, child: identifyContainerSpot(context, 3, key3), ),
                Expanded( flex: 1, child: Container(), ),
                Expanded( flex: 5, child: identifyContainerSpot(context, 4, key4), ),
                Expanded( flex: 1, child: Container(), ),
                Expanded( flex: 5, child: identifyContainerSpot(context, 5, key5), ),
                Expanded( flex: 1, child: Container(), ),
                Expanded( flex: 5, child: identifyContainerSpot(context, 6, key6), ),

              ],
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            sizeY *= 1.5;
            sizeX *= 1.5;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }



  Widget identifyContainerSpot(BuildContext context, int id, GlobalKey _key){
    return Container(
      key: _key,
      child: InkWell(
        onTap: (){
          print('tapped');
        },
        onTapDown: (TapDownDetails details){

          String x = ((details.globalPosition.dx / maxWidth) * 2 - 1).toStringAsFixed(2),
                 y = ((details.globalPosition.dy / maxHeight) * 2 - 1).toStringAsFixed(2);
          setState(() {
            _alignment = Alignment( double.parse(x), double.parse(y) );
            xx = double.parse(x);
            yy = double.parse(y);
          });    
          print('x => '+ x + '   | y => '+ y); 
        },
        child: Container(
          color: Color.fromRGBO(0, 0, 255, 0.2),
      )));
  }


  @override
  Ticker createTicker(onTick) {
    return null;
  }


}
