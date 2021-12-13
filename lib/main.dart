import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_profile/bloc/profile_bloc.dart';
import 'package:github_profile/data/DataRepository.dart';

import 'package:github_profile/pages/Home.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/globals.dart';


void main()  {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {


  @override
  _MyAppstate createState()=> _MyAppstate();

}
dynamic weekday=null;
var colors={"Wednesday":Colors.green};

class _MyAppstate extends State<MyApp>{

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        scaffoldBackgroundColor: (weekday==null?Colors.orange:colors[weekday]),
        //primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => ProfileBloc(DataRepository()),
        child: Master(),
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        weekday=DateFormat('EEEE').format(picked);
      });
    print("weekday is ${DateFormat('EEEE').format(picked)}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: weekday==null?Colors.orange:colors[weekday],
      appBar: AppBar(
        title:(weekday==null?Text(widget.title):Text(weekday)) ,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("${selectedDate.toLocal()}".split(' ')[0]),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select date'),
            ),
          ],
        ),
      ),
    );
  }
}

