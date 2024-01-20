import 'package:flutter/material.dart';
import 'package:gdsc_app_dev/notes.dart';
import 'package:gdsc_app_dev/routes.dart';

class NotesDetailPage extends StatefulWidget {
  final Notes initialNote;

  NotesDetailPage({Key? key, required this.initialNote}) : super(key: key);

  @override
  _NotesDetailPageState createState() => _NotesDetailPageState();
}

class _NotesDetailPageState extends State<NotesDetailPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();

    // Populate the controllers with initial values
    _titleController.text = widget.initialNote.getTitle(widget.initialNote);
    _contentController.text = widget.initialNote.getContent(widget.initialNote);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${date.day}/${date.month}/${date.year}",
                        style: TextStyle(
                            fontSize: size.width * 0.04,
                            color: const Color.fromARGB(255, 95, 94, 94)),
                      ),
                      InkWell(
                        child: const Icon(
                          Icons.close,
                          color: Color.fromARGB(255, 95, 94, 94),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, MyRoutes.homePageRoute);
                        },
                      )
                    ],
                  ),

                  SizedBox(height: size.height * 0.02),

                  TextFormField(
                    controller: _titleController,
                    maxLines: 3,
                    decoration: InputDecoration(
                        hintText: "Enter Title",
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 95, 94, 94)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.03))),
                    style: const TextStyle(color: Colors.white),
                  ),

                  SizedBox(height: size.height * 0.04),

                  TextFormField(
                    controller: _contentController,
                    maxLines: 20,
                    decoration: InputDecoration(
                        hintText: "Enter Content",
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 95, 94, 94)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.03))),
                    style: const TextStyle(color: Colors.white),
                  ),

                  SizedBox(height: size.height * 0.02),
                  
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                         if (_formKey.currentState!.validate()) {
                          // Save changes back to the initialNote object
                          widget.initialNote.updateNoteById(
                            widget.initialNote.getid(widget.initialNote),
                            _titleController.text,
                            _contentController.text,
                            date,
                          );

                          Navigator.pushNamed(context, MyRoutes.homePageRoute);
                        }
                      },
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              Size(size.width * 0.3, size.height * 0.02))),
                      child: Text(
                        "Done",
                        style: TextStyle(fontSize: size.width * 0.04),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
