import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tournament_app/Models/tournament_model.dart';
import 'package:tournament_app/Ui/Widgets/custom_Button.dart';
import 'package:tournament_app/const.dart';
import 'package:http/http.dart' as http;


List<Tournament> infoList = [];

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController mapController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isNotEmpty = false;

  DateTime selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  

  Future<void> postTournament() async
  {
    String url = '$baseUrl/tournaments';
    var body = {
      'title': titleController.text,
      'roomId': idController.text,
      'roomPass': passController.text,
      'joined': 0,
      'mapType': mapController.text,
      'type': typeController.text,
      'time': _selectedTime.format(context),
      'date': selectedDate.toString().split(' ')[0],
    };
    var header = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    http.Response res = await http.post(url, headers: header, body: json.encode(body));
    if(res.statusCode == 201)
    {
      Map<String, dynamic> jdata = json.decode(res.body);
        Tournament info = Tournament(
          id: jdata['_id'],
          title: jdata['title'],
          roomID: jdata['roomId'],
          roomPass: jdata['roomPass'],
          joined: jdata['joined'],
          map: jdata['mapType'],
          type: jdata['type'],
          time: jdata['time'],
          date: jdata['date'],
        );
        setState(() {
          infoList.add(info);
        });
      
    }
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: ListView(
        children: [
          Center(
            child: Form(
              autovalidate: true,
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    child: Text(
                      'Add Tournament',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
                      autovalidate: isNotEmpty,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter a title';
                        }
                        return null;
                      },
                      controller: titleController,
                      decoration: inputDecoration.copyWith(
                          hintText: 'Enter Title', labelText: 'Title'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        child: TextFormField(
                          autovalidate: isNotEmpty,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter a Room ID';
                            }
                            return null;
                          },
                          controller: idController,
                          decoration: inputDecoration.copyWith(
                              hintText: 'Room ID', labelText: 'Room ID'),
                        ),
                      ),
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        child: TextFormField(
                          autovalidate: isNotEmpty,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter a Password';
                            }
                            return null;
                          },
                          controller: passController,
                          decoration: inputDecoration.copyWith(
                              hintText: 'Room Pass', labelText: 'Room Pass'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        child: TextFormField(
                          autovalidate: isNotEmpty,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter the Map Name';
                            }
                            return null;
                          },
                          controller: mapController,
                          decoration: inputDecoration.copyWith(
                              hintText: 'Name of the Map', labelText: 'Map'),
                        ),
                      ),
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        child: TextFormField(
                          autovalidate: isNotEmpty,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter Type';
                            }
                            return null;
                          },
                          controller: typeController,
                          decoration: inputDecoration.copyWith(
                              hintText: 'e.g Solo', labelText: 'Type'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                                  '${selectedDate.toLocal()}'.split(' ')[0])),
                          margin: EdgeInsets.only(top: 10),
                          height: 50,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: dateTimePickerColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _selectTime(context);
                        },
                        child: Container(
                          child: Center(
                              child: Text('${_selectedTime.format(context)}')),
                          margin: EdgeInsets.only(top: 10),
                          height: 50,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: dateTimePickerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        postTournament().whenComplete(() => Navigator.pop(context));
                        setState(() {
                          isNotEmpty = true;
                        });
                      }
                    },
                    margin: EdgeInsets.only(top: 20),
                    color: buttonColor,
                    lable: 'Save',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
