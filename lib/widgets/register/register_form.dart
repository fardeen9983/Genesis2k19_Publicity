import 'package:flutter/material.dart';
import 'package:genesis19_publicity/model/event.dart';
import 'package:genesis19_publicity/model/participant.dart';
import 'package:genesis19_publicity/widgets/register/participant_form.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RegisterForm extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  Event globalEvent;
  List<ParticipantForm> participants;
  String receiptNo;

  validate() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      List<Participant> temp = List();
      bool error = false;
      participants.forEach((doc) {
        Participant val = doc.validate();
        if (val == null) {
          error = true;
          return;
        }
        val.events = {
          receiptNo: {
            'date': DateFormat.yMd().format(DateTime.now()),
            'code': globalEvent.code,
            'receipt': receiptNo
          }
        };
        temp.add(val);
      });

      return !error
          ? {'list': temp, 'code': globalEvent.code, 'receipt': receiptNo}
          : null;
    }
  }

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  void initState() {
    widget.participants = List();
    widget.participants.add(ParticipantForm(
      index: 1,
      leader: true,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Event event = widget.globalEvent = Provider.of<Event>(context);
    try {
      var credit = event.credit;
    } catch (e) {
      return Center(
        child: Text("No such event exists"),
      );
    }

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
            key: widget._formKey,
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
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Price: ${event.price}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      "Participants: ${event.numParticipants}",
                      style: TextStyle(fontSize: 20.0),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Center(
                        child: Text(
                          "Date : ${DateFormat('d/M/yy').format(DateTime
                              .now())}",
                          style: TextStyle(fontSize: 18.0),
                        )),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .25,
                      child: TextFormField(
                        validator: (val) =>
                        val.isEmpty ? "Enter receipt no" : null,
                        onSaved: (val) => widget.receiptNo = val,
                        decoration: const InputDecoration(
                            helperText: "Enter receipt no"),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: widget.participants,
                  ),
                ),
                widget.participants.length != event.numParticipants
                    ? Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: FlatButton.icon(
                      onPressed: addParticipant,
                      icon: Icon(Icons.add),
                      label: Text("Add Participant")),
                )
                    : Container()
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

  addParticipant() {
    setState(() {
      widget.participants.add(ParticipantForm(
        index: widget.participants.length + 1,
        leader: false,
      ));
    });
  }
}
