import 'package:flutter/material.dart';
import 'package:zariya/widgets/functions.dart';
import 'package:zariya/resources/colors.dart';
class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(themeColor),
        ),
      ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}

Widget otherMsg(BuildContext context, dynamic data) {
  return Align(
    alignment: Alignment.bottomRight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          width: MediaQuery.of(context).size.width * 0.65,
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Color(0x40FF808C),
          ),
          child: Text(
              data['text'],
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 15,
                fontFamily: 'Roboto',
              )),
        ),
        Text(
          getTimeString(data['dateAndTime']),
          textAlign: TextAlign.end,
          style: TextStyle(
              color: Colors.grey,
              fontSize: 11,
              fontFamily: 'Inter',
              letterSpacing: -0.24),
        ),
      ],
    ),
  );
}

Widget myMsg(BuildContext context, dynamic data) {
  return Align(
    alignment: Alignment.bottomLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          width: MediaQuery.of(context).size.width * 0.65,
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            color: Color(0x404E4CAC),
          ),
          child: Text(data['text'],
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 15,
                fontFamily: 'Roboto',
              )),
        ),
        Text(
          getTimeString(data['dateAndTime']),
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.grey,
              fontSize: 11,
              fontFamily: 'Inter',
              letterSpacing: -0.24),
        ),
      ],
    ),
  );
}

