import 'package:flutter/material.dart';
import 'package:zariya/resources/strings.dart';
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

Widget userMsg(BuildContext context, dynamic data) {
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
          child: Text(data['message'],
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 15,
                fontFamily: 'Roboto',
              )),
        ),
        Text(
          getTimeString(data['dateTime']),
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

Widget otherMsg(BuildContext context, dynamic data) {
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
          child: Text(data['message'],
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 15,
                fontFamily: 'Roboto',
              )),
        ),
        Text(
          getTimeString(data['dateTime']),
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

Widget emptyListWidget(String string) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SizedBox(height: 50),
      Text(
        string,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 50),
      zariyaTeam(),
    ],
  );
}

Widget zariyaTeam() {
  return Column(
    children: <Widget>[
      Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(defaultImageIcon), fit: BoxFit.contain)),
      ),
      SizedBox(height: 5),
      Text(
        'zariya Team',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
