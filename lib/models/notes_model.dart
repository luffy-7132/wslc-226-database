// ignore_for_file: camel_case_types

import 'package:wslc_226_datbase/app_database/app_database.dart';

class Notes_Model {
  int? id;
  String title;
  String desc;

  Notes_Model({this.id, required this.title, required this.desc});

  ///2 func tomap , frommap
  factory Notes_Model.fromMap(Map<String, dynamic> map) {
    return Notes_Model(
      id: map[DbHelper.Column_Id],
      title: map[DbHelper.Column_Title],
      desc: map[DbHelper.Column_Desc],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.Column_Id: id,
      DbHelper.Column_Title: title,
      DbHelper.Column_Desc: desc
    };
  }
}
