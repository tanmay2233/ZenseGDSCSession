import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app_dev/notes.dart';
import 'package:gdsc_app_dev/routes.dart';

class NotesDetailPage extends StatefulWidget {
  final String docId;

  NotesDetailPage({Key? key, required this.docId}) : super(key: key);

  @override
  _NotesDetailPageState createState() => _NotesDetailPageState();
}

class _NotesDetailPageState extends State<NotesDetailPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  DateTime date = DateTime.now();
  String? username;
  String? userId;

  Future<void> getUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String? displayName = user.displayName;
      if (displayName != null && displayName.isNotEmpty) {
        setState(() {
          username = displayName;
        });
      }

      String? uid = user.uid;
      if (uid.isNotEmpty) {
        userId = uid;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();

    // Fetch and populate the controllers with data using the provided docId
    fetchAndPopulateNoteData(widget.docId);
  }

  Future<void> fetchAndPopulateNoteData(String docId) async {
    // Fetch the note using the provided docId
    DocumentSnapshot noteDocument = await FirebaseFirestore.instance
        .collection('userNotes')
        .doc(userId)
        .collection('notes')
        .doc(docId)
        .get();

    // Populate the controllers with the fetched data
    _titleController.text = noteDocument['title'];
    _contentController.text = noteDocument['content'];
  }

  void updateNote() async {
    // Update the note in Firestore
    await FirebaseFirestore.instance
        .collection('userNotes')
        .doc(userId)
        .collection('notes')
        .doc(widget.docId)
        .update({
      'title': _titleController.text,
      'content': _contentController.text,
      // You can add other fields as needed
    });

    Navigator.pop(context); // Navigate back after updating
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
                          // Save changes back to Firestore
                          updateNote();
                        }
                      },
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                              Size(size.width * 0.3, size.height * 0.02))),
                      child: Text(
                        "Update",
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
