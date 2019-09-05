import 'package:flutter/material.dart';
import 'package:genesis19_publicity/model/event.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Event event = Provider.of<Event>(context);
    return event != null
        ? Container(
      padding: EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Text(event.title)],
        ),
      ),
    )
        : Center(
      child: CircularProgressIndicator(),
    );
  }
}
