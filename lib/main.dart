import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Calculator(),
    );
  }
}


class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("MyCalculator", style: TextStyle(fontWeight: FontWeight.bold),),
      actions: <Widget>[ FlatButton(onPressed:(){Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Basic()));}, child:Text("Basic", style: TextStyle(fontWeight:FontWeight.w300,color:Colors.white),)),
      FlatButton(onPressed:() {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Interest()));}, child:Text("Interest",style:TextStyle(fontWeight: FontWeight.normal, color: Colors.white)),),Icon(Icons.close, color: Colors.red,)
      ]
    ),
    body:Container(decoration: BoxDecoration(gradient:
    LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors: [Colors.blue,Colors.white,]))
    ,child:Center(child:Column(children:<Widget> [Image.asset("assets/images/calculator.png",height: 400,),
    RaisedButton(color:Colors.blue,shape:RoundedRectangleBorder(side:BorderSide(color:Colors.blueAccent,style:BorderStyle.solid),borderRadius: BorderRadius.circular(10)),onPressed:(){}, 
    child:Text("Download Now",style:TextStyle(fontWeight: FontWeight.bold,fontSize:30)))],)
    )
        )
    
    ); 
  
    
  }
}



class Basic extends StatefulWidget {
  @override
  _BasicState createState() => _BasicState();
}

class _BasicState extends State<Basic> {
   //declaration of some variables
  String expression="";
  String equation="";
  String answer="0";



  Widget buildButton(String name,Color buttonColor, double buttonHeight){
    return(
      Container(
        height:MediaQuery.of(context).size.height*0.1*buttonHeight,
        color: buttonColor,
        child: FlatButton(onPressed:()=>buttonClick(name), shape: RoundedRectangleBorder(side:BorderSide(color: Colors.white, style:BorderStyle.solid ),borderRadius: BorderRadius.circular(1)),child:Text(name,style: TextStyle(color:Colors.white),)),
      )
    );

  }
  
  void buttonClick(String value){
     setState(() {
       
    if(value == "="){
      if(equation=="" || equation=="0"){
        equation="0";
        answer="0";
      }

      else{
        try {
        Parser p = new Parser();
        Expression exp = p.parse(equation);
        ContextModel cm = ContextModel();
        answer = '${exp.evaluate(EvaluationType.REAL, cm)}';
          } 
        catch (e) {
        answer='ERROR';
        }
      }

    }

    else if(value == "CE"){
      equation="0";
      answer = "0";
    }

    else if(value=="<"){
       if(equation=="" || equation=="0"){
        equation="0";
        answer="0";
      }
      else{
        equation=equation.substring(0,equation.length-1);
      }
    }
    else{
      if(equation=="0"){
        equation=value;
      }
      else{

       value=value.replaceAll("x", "*");
      equation=equation+value;

      }
    }


     
     

     });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:Text("Basic Calculator")),
    body:Container(padding: EdgeInsets.fromLTRB(0, 5, 5, 0),child:Column(children:<Widget>[
      Container( padding: EdgeInsets.all(5),alignment: Alignment.topRight,child:Text(equation,style: TextStyle(fontWeight: FontWeight.bold, fontSize:30)),
      ),
      Container(padding: EdgeInsets.all(5),alignment: Alignment.topRight,child: Text(answer,style: TextStyle(fontWeight: FontWeight.bold, fontSize:45),),),
      Expanded(child: Divider()),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [Container(width: MediaQuery.of(context).size.width *0.745,
        padding: EdgeInsets.all(2),child: Table(children: [
        TableRow(children: <Widget>[
        buildButton("CE", Colors.orangeAccent,1),
        buildButton("<", Colors.orangeAccent,1),
        buildButton("/", Colors.blueAccent,1)
      ]),  
        TableRow(children: <Widget>[
        buildButton("7", Colors.blueAccent,1),
        buildButton("8", Colors.blueAccent,1),
        buildButton("9", Colors.blueAccent,1)
      ]),
        TableRow(children: <Widget>[
        buildButton("4", Colors.blueAccent,1),
        buildButton("5", Colors.blueAccent,1),
        buildButton("6", Colors.blueAccent,1)
      ]),
        TableRow(children: <Widget>[
        buildButton("1", Colors.blueAccent,1),
        buildButton("2", Colors.blueAccent,1),
        buildButton("3", Colors.blueAccent,1)
      ]),
      TableRow(children: <Widget>[
        buildButton("0", Colors.blueAccent,1),
        buildButton("00", Colors.blueAccent,1),
        buildButton(".", Colors.blueAccent,1)
      ]),
      ],
      
      ),),
      Container(width: MediaQuery.of(context).size.width*0.24, child: Table(
        children: [TableRow(children:<Widget>[buildButton("x", Colors.red,1)]),
        TableRow(children:<Widget>[buildButton("-", Colors.red,1)]),
        TableRow(children:<Widget>[buildButton("+", Colors.red,1)]),
        TableRow(children:<Widget>[buildButton("=", Colors.red,2)]),
      
      ]))
  
      ])
    ])));
  }
}


class Interest extends StatefulWidget {
  @override
  _InterestState createState() => _InterestState();
}

class _InterestState extends State<Interest> {

  int radioItem;
  String comPeriod="annually";
  String interest;
  String principal;
  String numPeriods;
  num calculated=0;
  String interestCalc="";
  num i=0;
  String interestGained="";
  String newPrincipal="";
void initState(){
  setState(() {
    radioItem=0;
  });
  super.initState();
}

void radioChange(int value){
    setState(() {
      radioItem=value;
      
    });
  }

void periodChange(String value){
  setState(() {
    numPeriods=value;
  });
}

void inputChange(String value){
  setState(() {
    interest=value;
    
  });
}

void buttonPress(String _numPeriods,String _interest,String _principal, String _comPeriod,int _radioItem)
{

setState(() {


var _compoundingPeriod;
var details= {"annually":1, "semiannually":2, "quarterly":4,"monthly":12};

_compoundingPeriod=details[_comPeriod];




if (_radioItem==1 ){
//i=_principal+"*"+_interest+"*"+_numPeriods+"*(1/100)";
//calculated="("+_principal+"*"+_interest+"*"+_numPeriods+"*(1/100))+"+_principal;

try{
  
num convInterest=double.parse(_interest);
num convprincipal=double.parse(_principal);
num convnumPeriods=double.parse(_numPeriods);


    i=(convprincipal*convInterest*convnumPeriods)*(1/100);
    calculated=(convprincipal)*(1+((convInterest*convnumPeriods)*(1/100)));
    
    interestGained=i.toString(); 
    newPrincipal=calculated.toString();
  //  Parser p = new Parser();
    //Expression exp = p.parse(i);
    //ContextModel cm = ContextModel();
    //interestGained= '${exp.evaluate(EvaluationType.REAL, cm)}';

    //Expression exp2 = p.parse(calculated);
    //ContextModel cm2 = ContextModel();
    //newPrincipal= '${exp2.evaluate(EvaluationType.REAL, cm2)}';
    }
    catch(e){
      interestGained="error";
      newPrincipal="error";
    }
}

else if (_radioItem ==2){

num convInterest=double.parse(_interest);
num convprincipal=double.parse(_principal);
num convnumPeriods=double.parse(_numPeriods);
num one=1;

  calculated=convprincipal*(pow((one+(convInterest/(_compoundingPeriod*100))),(_compoundingPeriod*convnumPeriods)));
  i=calculated-convprincipal;
  newPrincipal=calculated.toString();
  interestGained=i.toString();
}

else{
  interestGained="error";
  newPrincipal="error";
}





});

}


void principalChange(String value){
  setState(() {
    principal=value;
  });
}

  List<String> comPeriods = <String>['annually','semiannually','quarterly','monthly'];
  @override



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Interest Calculator"),),
      body:
      ListView(padding: EdgeInsets.all(20),children: [SizedBox(height: 2),
        Text("Type of Interest",style: TextStyle(fontWeight:FontWeight.bold, fontSize: 15,color: Colors.blue)),
        Container(padding: EdgeInsets.all(2),decoration: BoxDecoration(border:Border.all(color: Colors.blue),borderRadius:BorderRadius.circular(10) ),
        child:
        ButtonBar(alignment: MainAxisAlignment.center,children:<Widget> [
          Radio(value: 1,groupValue:radioItem, onChanged: (int value){radioChange(value);}
           , activeColor: Colors.blue),Text("Simple Interest"),Container(width: 70,),
          Radio(value: 2, groupValue:radioItem, onChanged:(int value){radioChange(value);}, activeColor: Colors.blue,),Text("Compound Interest"),
          ]),
        ),
        Container(padding:EdgeInsets.fromLTRB(2,15, 5, 0), child:Row(children: [ Text("Compounding Period:   ", style: TextStyle(fontWeight:FontWeight.bold, fontSize: 15,color: Colors.blue),),
        new DropdownButton<String>(value:comPeriod,isDense: true ,dropdownColor:Colors.blueAccent,elevation: 10,
         onChanged:(String newValue){
           setState(() {
             comPeriod=newValue;
           });},
           items:comPeriods.map((String value){
          return new DropdownMenuItem(value: value,
            child: new Text(value));
        }).toList(),
         )
        ],) ,),

        SizedBox(height: 20,),
        Text("Number of Years",style: TextStyle(fontWeight:FontWeight.bold, fontSize: 15,color: Colors.blue)),
        new TextFormField(decoration: const InputDecoration(hintText: 'No. of Years',enabledBorder:OutlineInputBorder(borderSide:BorderSide(color: Colors.blue) ,borderRadius: BorderRadius.all(Radius.circular(10)))),style: TextStyle(fontSize: 15),keyboardType:TextInputType.number,onChanged: (String value){periodChange(value);},),
        
        
        SizedBox(height: 20,),    
        Text("Principal Amount",textAlign: TextAlign.left, style: TextStyle(fontWeight:FontWeight.bold, fontSize: 15,color: Colors.blue),),
        TextFormField(decoration: const InputDecoration(enabledBorder:OutlineInputBorder(borderSide:BorderSide(color: Colors.blue) ,borderRadius: BorderRadius.all(Radius.circular(10))),hintText: 'Principal Amount'),style: TextStyle(fontSize: 15),
          keyboardType: TextInputType.number,onChanged:(String value){ principalChange(value);},
        ),

        SizedBox(height: 20,),
        Text("Enter Interest Rate", style: TextStyle(fontWeight:FontWeight.bold, fontSize: 15,color: Colors.blue)),        
        TextFormField(decoration: const InputDecoration(enabledBorder:OutlineInputBorder(borderSide:BorderSide(color: Colors.blue) ,borderRadius: BorderRadius.all(Radius.circular(10))) ,hintText: "Enter Interest Precentage"),style: TextStyle(fontSize: 15),
          keyboardType: TextInputType.number,onChanged:(String value){inputChange(value);} ,)
         ,
        SizedBox(height: 10,),
        RaisedButton(color: Colors.blue,onPressed:(){buttonPress(numPeriods, interest, principal, comPeriod, radioItem);},child: Text("Calculate"),),
        SizedBox(height: 10,),
        Container(padding: EdgeInsets.all(2),decoration: BoxDecoration(border:Border.all(color: Colors.blue,),borderRadius:BorderRadius.circular(12) ),
        child:Column(children: [
        Text("Interest Gained : " +interestGained.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        Text("Future Value: "+newPrincipal.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
        ],
        ))
      ]
      )); 
  }
}



