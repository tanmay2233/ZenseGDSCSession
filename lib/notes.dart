// ignore_for_file: public_member_api_docs, sort_constructors_first
class Notes{

  String _title = '', _content = '', _type = '';
  DateTime _date = DateTime.now();
  int _id = 0;
  static List<Notes> _notesList = [];

  void updateNoteById(int targetId, String newTitle, String newContent, DateTime newDate) {
    for (int i = 0; i < _notesList.length; i++) {
      if (_notesList[i].getid(_notesList[i]) == targetId) {
        _notesList[i]._title = newTitle;
        _notesList[i]._content = newContent;
        _notesList[i]._date = newDate;
        break; // Stop searching once the note is found and updated
      }
    }
  }

  String getTitle(Notes task) => task._title;
  String getContent(Notes task) => task._content;

  int getid(Notes note) => note._id;

  static void addNote(Notes noteObject){
    _notesList.add(noteObject);
  } 

  static List<Notes> getNotesList() => _notesList;
  static int getListSize() => _notesList.length;

  static int getMaxid(){
    int maximumId = 0;
    for (int i = 0; i < _notesList.length; i++) {
      maximumId = _notesList[i]._id > maximumId ? _notesList[i]._id : maximumId;
    }

    return maximumId;
  }

  static void removeItem(Notes note) => _notesList.remove(note);

  String getType(Notes task) => task._type;
  DateTime getDate(Notes task) => task._date;

  Notes({
    required String title,
    required String content, 
    required DateTime date,
    required String type,
    required int id
  })

  {
    this._title = title;
    this._content = content;
    this._date = date;
    this._type = type;
    this._id = id;
  }
}