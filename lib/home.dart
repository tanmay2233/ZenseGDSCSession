import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app_dev/notesDetailPage.dart';
import 'package:gdsc_app_dev/notes.dart';
import 'package:gdsc_app_dev/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? username;

  @override
  void initState() {
    super.initState();
    // Initialize the user's name when the widget is created
    getUserDisplayName();
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, MyRoutes.loginPageRoute);
  }

  Future<void> getUserDisplayName() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String? displayName = user.displayName;
      if (displayName != null && displayName.isNotEmpty) {
        setState(() {
          username = displayName;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Notes> notesList = Notes.getNotesList();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(size.width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.all(size.width * 0.02),
                      child: Text(
                        "Hello,",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.09,
                            fontFamily: 'Poppins'),
                      )),
                  InkWell(
                    onTap: signOut,
                    child: Icon(Icons.logout_sharp,
                        color: Colors.white, size: size.width * 0.09),
                  )
                ],
              ),
              Text(
                username ?? "User_Name",
                style: TextStyle(
                    color: const Color(0xFF7973FF),
                    fontSize: size.width * 0.09,
                    fontFamily: 'Poppins'),
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Padding(
                      padding: EdgeInsets.all(size.width * 0.02),
                      child: TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.03)),
                              hintText: "Search Here..",
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 95, 94, 94))),
                          style: const TextStyle(color: Colors.white))),
                  Padding(
                    padding: EdgeInsets.all(size.width * 0.04),
                    child: Icon(
                      Icons.search,
                      color: const Color.fromARGB(255, 95, 94, 94),
                      size: size.width * 0.08,
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: Notes.getListSize(),
                    itemBuilder: (context, index) {
                      Notes currentNote = notesList[index];
                      return Column(children: [
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NotesDetailPage(initialNote: currentNote),
                              ),
                            );
                          },
                          child: Container(
                            height: size.height * 0.1,
                            decoration: BoxDecoration(
                                color: const Color(0xFF1E1E1E),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.height * 0.03))),
                            child: Padding(
                              padding: EdgeInsets.all(size.height * 0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${notesList[index].getDate(notesList[index]).day}/${notesList[index].getDate(notesList[index]).month}/${notesList[index].getDate(notesList[index]).year}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          notesList[index]
                                              .getTitle(notesList[index]),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width * 0.035)),
                                      InkWell(
                                          child: const Icon(Icons.delete,
                                              color: Colors.white),
                                          onTap: () => setState(() {
                                                Notes.removeItem(
                                                    notesList[index]);
                                              }))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]);
                    }),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.notesPageRoute);
                  },
                  shape: CircleBorder(),
                  backgroundColor: const Color(0xFF7973FF),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: size.width * 0.075,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
