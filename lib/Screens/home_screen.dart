// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, non_constant_identifier_names, camel_case_types

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wslc_226_datbase/app_database/app_database.dart';
import 'package:wslc_226_datbase/custom_widgets/custom_widgets.dart';
import 'package:wslc_226_datbase/models/notes_model.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});
  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

enum Fruit { apple, banana }

class _Home_ScreenState extends State<Home_Screen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  late DbHelper db;
  List<Notes_Model> arrNotes = [];
  bool isComplete = false;

  @override
  void initState() {
    super.initState();
    db = DbHelper.db;
    getAllNotes();
  }

  getAllNotes() async {
    arrNotes = await db.fetchAllData();
    setState(() {});
  }

  addNotes(String title, desc) async {
    await db.addNotes(
      Notes_Model(title: title, desc: desc),
    );
    arrNotes = await db.fetchAllData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    log(arrNotes.toString());
    return Scaffold(
      body: ListView.builder(
        itemCount: arrNotes.length,
        itemBuilder: (context, index) {
          TextEditingController updateTitle =
              TextEditingController(text: arrNotes[index].title);
          TextEditingController updateDesc =
              TextEditingController(text: arrNotes[index].desc);

          return ListTile(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Custom_Widgets.custom_textField(
                              updateTitle, 'Enter Title'),
                          Custom_Widgets.custom_textField(
                              updateDesc, 'Enter Desc'),
                          SizedBox(height: 20),
                          Custom_Widgets.custom_button(
                            'Update',
                            () {
                              db.updateNotes(
                                Notes_Model(
                                  id: arrNotes[index].id,
                                  title: updateTitle.text,
                                  desc: updateDesc.text,
                                ),
                              );
                              getAllNotes();
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              leading: Text(index.toString()),
              title: Text(arrNotes[index].title),
              subtitle: Text(arrNotes[index].desc),
              trailing: IconButton(
                onPressed: () {
                  db.deleteNotes(arrNotes[index].id!);
                  getAllNotes();
                },
                icon: Icon(Icons.delete),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Custom_Widgets.custom_textField(
                        titleController, 'Enter Title'),
                    Custom_Widgets.custom_textField(
                        descController, 'Enter Desc'),
                    SizedBox(height: 20),
                    Custom_Widgets.custom_button('Add', () {
                      addNotes(titleController.text, descController.text);
                      titleController.clear();
                      descController.clear();
                      Navigator.pop(context);
                    })
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
