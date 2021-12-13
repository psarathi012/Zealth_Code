
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:github_profile/bloc/profile_bloc.dart';
import 'package:github_profile/data/models/NasaImage.dart';
import 'package:github_profile/pages/widgets/SideDrawer.dart';
import 'package:github_profile/utils/DatetoColor.dart';

class ImagePage extends StatefulWidget {
  final NasaImage nasaimage;
  final String base64Str;
  final DateTime date;
  final String ON_BACK_FIXED_DATE = "2000-01-01";
  const ImagePage(this.nasaimage,this.base64Str,this.date);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    print(widget.nasaimage.title);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final blockSize = width / 100;
    final blockSizeVertical =height / 100;
    print("hello ${width}");
    return WillPopScope(
        child: Scaffold(
          backgroundColor: DatetoColor.getColors(widget.date),
          appBar: AppBar(
              title: const Text('Image'),
              backgroundColor: Colors.blueAccent,
              automaticallyImplyLeading: true,
              //`true` if you want Flutter to automatically add Back Button when needed,
              //or `false` if you want to force your own back button every where
              leading: IconButton(icon:Icon(Icons.arrow_back),
                onPressed:() => buildCalendarPage(context, widget.date),
                //onPressed:() => exit(0),
              )

          ),

          body:Column(
            children: <Widget>[
              FlatButton(
                child:Container(
                  alignment: Alignment.center,
                  child: Expanded(
                    child:Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 15.0),
                      width: 400.0,
                      height: 600.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          image: DecorationImage(
                              image: Image.memory(base64Decode(widget.base64Str)).image, fit: BoxFit.cover)
                      ),
                    ),
                  )
                ),
                onLongPress: _selectDate,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 8.0),
                width: 400.0,
                height: 70.0,
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
                    "${widget.nasaimage.title ?? ""}",
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 20,
                      color: Colors.white,
                      height: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              //Text("${widget.nasaimage.title ?? ""}")
            ],
          )
        ),
        onWillPop: _onBackPressed,
    );
  }
  Future<bool> _onBackPressed() {
    DateTime dateTime = DateTime.parse(widget.ON_BACK_FIXED_DATE);
    if ( widget.date != dateTime ) {
      _showPicture(context, dateTime);
    } else {



      //TODO: Give Toast
    }
  }


  void _showPicture(BuildContext context, DateTime dateTime){
    final profileBloc = context.bloc<ProfileBloc>();
    profileBloc.add(GetDateTime(dateTime));
  }

  void _selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: widget.date,
        firstDate: DateTime(1915, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != widget.date)
      {
        _showPicture(context, picked);
      }

  }

  void buildCalendarPage(BuildContext context, DateTime date) {
    final profileBloc = context.bloc<ProfileBloc>();
    profileBloc.add(GetColor(date));
  }




}
