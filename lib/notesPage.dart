// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:gdsc_app_dev/notes.dart';
import 'package:gdsc_app_dev/routes.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  //Dont place them in the build method
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.04),
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
                  maxLines: 2,
                  decoration: InputDecoration(
                      hintText: "Enter Title",
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(255, 95, 94, 94),
                          fontSize: size.width*0.05
                          ),
                      ),
                  style: TextStyle(color: Colors.white,
                  fontSize: size.width * 0.05
                  ),
                  onChanged: (value) {
                    // Save the entered text to the controller
                    _titleController.text = value;
                  },
                ),
                SizedBox(height: size.height * 0.04),
                TextFormField(
                  controller: _contentController,
                  maxLines: 20,
                  decoration: const InputDecoration(
                      hintText: "Enter Content",
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 95, 94, 94)),
                    ),
                  style: const TextStyle(color: Color(0xFFA9A9A9)),

                  onChanged: (value) {
                    _contentController.text = value;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Notes.addNote(
                        Notes(
                          title: _titleController.text,
                          content: _contentController.text,
                          date: date,
                          type: "Note",
                          id: Notes.getMaxid() + 1,
                        ),
                      );

                      Navigator.pushNamed(context, MyRoutes.homePageRoute);
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
    );
  }
}