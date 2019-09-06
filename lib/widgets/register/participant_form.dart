import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis19_publicity/model/participant.dart';
import 'package:validators/validators.dart';

// ignore: must_be_immutable
class ParticipantForm extends StatefulWidget {
  final int index;
  final _formKey = GlobalKey<FormState>();

  ParticipantForm({Key key, @required this.index}) : super(key: key);
  String DD1 = 'CE', DD2 = '1';

  validate() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      map['branch'] = DD1;
      map['year'] = int.parse(DD2);
      return Participant.fromMap(map);
    } else
      return null;
  }

  Map<String, dynamic> map = {
    'name': null,
    'mobile': null,
    'email': null,
    'branch': null,
    'year': null,
    'events': null
  };

  @override
  _ParticipantFormState createState() => _ParticipantFormState();
}

class _ParticipantFormState extends State<ParticipantForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Card(
        elevation: 3.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.30)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
          child: Form(
            key: widget._formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Participant ${widget.index}",
                  style: TextStyle(fontSize: 20.0),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 2.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Name'),
                          validator: (val) => val.isEmpty
                              ? "Required"
                              : isAlpha(val.replaceAll(' ', 'a'))
                                  ? null
                                  : "Digits not allowed",
                          onSaved: (val) => widget.map['name'] = val,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) => val.isEmpty
                              ? "Required"
                              : isEmail(val) ? null : "Enter a valid email",
                          decoration: InputDecoration(labelText: 'Email'),
                          onSaved: (val) => widget.map['email'] = val,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (val) => val.isEmpty
                              ? "Required"
                              : val.length == 10 && isNumeric(val)
                                  ? null
                                  : "Enter a valid mobile no",
                          decoration: InputDecoration(labelText: 'Mobile no'),
                          onSaved: (val) => widget.map['mobile'] = val,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[branchDD(), yearDD()],
                        )
                      ],
                    ))
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
      ),
    );
  }

  branchDD() => DropdownButton<String>(
      value: widget.DD1,
      items: <String>['CE', 'CP', 'IT', 'EC', 'EL', 'ME', 'PE', 'EE']
          .map<DropdownMenuItem<String>>(
              (String val) => DropdownMenuItem<String>(
                    child: Text(
                      val,
                      textAlign: TextAlign.center,
                    ),
                    value: val,
                  ))
          .toList(),
      onChanged: (val) => this.setState(() {
            this.widget.DD1 = val;
          }));

  yearDD() => DropdownButton<String>(
      value: widget.DD2,
      items: <String>['1', '2', '3', '4']
          .map<DropdownMenuItem<String>>(
              (String val) => DropdownMenuItem<String>(
                    child: Text(
                      val,
                      textAlign: TextAlign.center,
                    ),
                    value: val,
                  ))
          .toList(),
      onChanged: (val) => this.setState(() {
            this.widget.DD2 = val;
          }));
}
