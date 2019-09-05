import 'package:flutter/material.dart';
import 'package:genesis19_publicity/model/event.dart';
import 'package:genesis19_publicity/widgets/participant_form.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Event event = Provider.of<Event>(context);
    return event != null
        ? Container(
      width: MediaQuery
          .of(context)
          .size
          .width * .95,
      padding: EdgeInsets.all(10.0),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        event.title,
                        style: TextStyle(fontSize: 28.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Center(
                        child: Text("Date : ${DateFormat.yMd().format(DateTime
                            .now())}", style: TextStyle(fontSize: 18.0),)),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .25,
                      child: TextField(
                        decoration: const InputDecoration(
                            helperText: "Enter receipt no"),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: createParticipants(event.numParticipants),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    )
        : Center(
      child: CircularProgressIndicator(),
    );
  }

  createParticipants(int num) =>
      List<ParticipantForm>.generate(
          num,
              (i) =>
              ParticipantForm(
                index: i + 1,
              ));
}
