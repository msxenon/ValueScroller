import 'package:flutter/material.dart';
import 'package:scrollervaluepicker/ValueScroller.dart';

void main (){
  runApp(MaterialApp(
    home: MainTest(),
    debugShowCheckedModeBanner: false,
  ));
}
class MainTest extends StatefulWidget {
  MainTest({Key key}) : super(key: key);

  @override
  _MainTestState createState() {
    return _MainTestState();
  }
}

class _MainTestState extends State<MainTest> {

  var valueResult = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black38,
        body:
        Stack(children: [
          Positioned.fill(top:250,child: Align(alignment: Alignment.topCenter,child: Text(valueResult.roundToDouble().toString()+"%",style: TextStyle(fontSize: 50,color: Colors.white),))),
          Center(child: SizedBox(width:400,height: 50,child:
          ValueScroller(MediaQuery.of(context).size.width,onChangeValue: (result){
            setState(() {
              valueResult = result;
            });
          },min: 0,max: 100,initalValue: 0,divisions: 5,bigTickColor: Colors.white,smallTickColor: Colors.grey,)
          )
          ),
          Center(child: Container(height: 50,width: 1,color: Colors.green,),),

        ],)

    );
  }
}
