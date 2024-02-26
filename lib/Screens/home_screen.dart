// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, non_constant_identifier_names, camel_case_types

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wslc_226_datbase/custom_widgets/custom_widgets.dart';
import 'package:wslc_226_datbase/models/notes_model.dart';
import 'package:wslc_226_datbase/providers/provider.dart';

import '../providers/theme_provider.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});
  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isDark = false;

    ///log(arrNotes.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.watch<ThemeProvider>().themeValue == isDark
            ? Colors.orangeAccent
            : Colors.cyanAccent,
        actions: [
          Switch(
              value: context.watch<ThemeProvider>().themeValue,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false).themeValue =
                    value;
              }),
        ],
      ),
      body: Consumer<NotesProvider>(
        builder: (_, value, __) {
          List<Notes_Model> arrNotes = value.getNotes();
          return ListView.builder(
            itemBuilder: (context, index) {
              TextEditingController updateTitle =
                  TextEditingController(text: arrNotes[index].title);
              TextEditingController updateDesc =
                  TextEditingController(text: arrNotes[index].desc);
              return ListTile(
                ///update
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
                                context.read<NotesProvider>().updateNotes(
                                    Notes_Model(
                                        title: updateTitle.text,
                                        desc: updateDesc.text));
                                Navigator.pop(context);
                              },
                            ),
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
                    context
                        .read<NotesProvider>()
                        .deleteNotes(arrNotes[index].id!);
                  },
                  icon: Icon(Icons.delete),
                ),
              );
            },
            itemCount: value.getNotes().length,
          );
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
                      Custom_Widgets.custom_button(
                        'Add',
                        () {
                          context.read<NotesProvider>().addNotes(Notes_Model(
                              title: titleController.text,
                              desc: descController.text));
                          titleController.clear();
                          descController.clear();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add)),
    );
  }
}
