// ignore_for_file: public_member_api_docs, sort_constructors_first

class Tasks{
  String _title = '', _content = '', _date = '', _type = '';
  static List<Tasks> _notesList = [];

  String gettitle(Tasks note) => note._title;
  static void addNote(Notes noteObject) => _notesList.add(noteObject);
  static List<Tasks> getNotesList() => _notesList;
  static int getListSize() => _notesList.length;
}

class Notes extends Tasks{


  Notes({
    required String title,
    required String content, 
    required String date,
    required String type
  })

  {
    this._title = title;
    this._content = content;
    this._date = date;
    this._type = type;
  }


}