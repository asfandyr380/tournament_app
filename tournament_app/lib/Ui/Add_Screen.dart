import 'package:flutter/material.dart';
import 'package:tournament_app/Services/connectivity.dart';
import 'package:tournament_app/Services/network.dart';
import 'package:tournament_app/Services/storage.dart';
import 'package:tournament_app/Widgets/custom_Button.dart';
import 'package:tournament_app/const.dart';

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

  Network _network = Network();

  String username;
  String id;
  bool isNotEmpty = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
  void initState() {
    super.initState();
    read('admin').then((value) {
      setState(() {
        username = value;
      });
    });
    read('adminId').then((value) {
      setState(() {
        id = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    idController.dispose();
    passController.dispose();
    mapController.dispose();
    typeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgorundColor,
      body: Builder(
        builder: (context) => ListView(
          children: [
            Center(
              child: Form(
                autovalidate: isNotEmpty,
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 100),
                      child: Text(
                        'Add Tournament',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: TextFormField(
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
                            top: 20,
                          ),
                          child: TextFormField(
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
                            top: 20,
                          ),
                          child: TextFormField(
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
                            top: 20,
                          ),
                          child: TextFormField(
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
                            top: 20,
                          ),
                          child: TextFormField(
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
                                child:
                                    Text('${_selectedTime.format(context)}')),
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
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: CustomButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            FocusScope.of(context).unfocus();
                            if (await checkConnectivity(
                                context)) if (await _network.postTournament(
                                    context,
                                    titleController.text,
                                    idController.text,
                                    passController.text,
                                    mapController.text,
                                    typeController.text,
                                    _selectedTime,
                                    selectedDate,
                                    id) !=
                                null) {
                              Navigator.pop(context, true);
                              setState(() {
                                isNotEmpty = true;
                              });
                            } else {
                              SnackBar(content: Text('Network Problem'));
                            }
                          }
                        },
                        color: buttonColor,
                        lable: 'Save',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
