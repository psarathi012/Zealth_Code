import 'package:flutter/material.dart';
import 'package:github_profile/bloc/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_profile/pages/widgets/SideDrawer.dart';
import 'package:github_profile/utils/DatetoColor.dart';
import 'package:intl/intl.dart';

class DateScreen extends StatefulWidget {
  //final Color color;
  final DateTime date;
  const DateScreen(this.date);

  @override
  _DateScreenState createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: widget.date,
        firstDate: DateTime(1915, 8),
        lastDate: DateTime(2101));

    // final DateTime picked = widget.date;
    if (picked != null && picked != widget.date) submitWeekday(context, picked);
  }

  void _doneOnPressed(BuildContext context, DateTime dateTime){
    print("Selected:  ${dateTime}");
    submitWeekday(context, dateTime);
    Navigator.pop(context);
  }

  void _cancelOnPressed(BuildContext context){
    Navigator.pop(context);
  }

  void _showModalSheet() {
    DateTime selectedDate = widget.date;
    CalendarDatePicker calender = CalendarDatePicker(
      initialDate: widget.date,
      firstDate: DateTime(1995, 8),
      lastDate: DateTime(2101),
      onDateChanged: (DateTime date) => selectedDate = date,
    );

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        isScrollControlled: true,
//        useRootNavigator: true,
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Container(
                child: Column(
              children: <Widget>[
                Expanded(child: calender),
                Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                      onPressed: () => _cancelOnPressed(context),
                      child: Text(
                          "Cancel",
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 22,
                          color: Colors.black,
                          height: 1,
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () => _doneOnPressed(context,selectedDate),
                      child: Text(
                        "Done",
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 22,
                          color: Colors.black,
                          height: 1,
                        ),
                      ),
                    )
                  ],
                ))
              ],
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      backgroundColor: DatetoColor.getColors(widget.date),
      appBar: AppBar(
        title: Text("Picture of the Day"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 350.0,
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: const Color(0xff2c2c2c),
                // gradient: LinearGradient(
                //     colors: [
                //       const Color(0xFFFFFF ),
                //       const Color(0xFFFFFF),
                //     ],
                //     begin: const FractionalOffset(0.0, 0.0),
                //     end: const FractionalOffset(1.0, 0.0),
                //     stops: [0.0, 1.0],
                //     tileMode: TileMode.clamp),
              ),
              child: Center(
                child: Text(
                  "${widget.date.toLocal()}".split(' ')[0],
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 40,
                    color: Colors.white,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            //Text("${widget.date.toLocal()}".split(' ')[0]),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(130, 50),
                    maximumSize: const Size(130, 50),
                  ),
                  onPressed: () => _showModalSheet(), //_selectDate(context),
                  child: Text(
                    'Select Date ',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 19,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(130, 50),
                    maximumSize: const Size(130, 50),
                  ),
                  onPressed: () => _showPicture(context, widget.date),
                  child: Text(
                      'Show',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 19,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),



          ],
        ),
      ),
    );
  }

  void submitWeekday(BuildContext context, DateTime date) {
    final profileBloc = context.bloc<ProfileBloc>();
    profileBloc.add(GetColor(date));
  }

  void _showPicture(BuildContext context, DateTime dateTime) {
    final profileBloc = context.bloc<ProfileBloc>();
    profileBloc.add(GetDateTime(dateTime));
  }
}
