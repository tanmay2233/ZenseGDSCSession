import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app_dev/notes.dart';
import 'package:gdsc_app_dev/routes/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Tasks> notesList = Tasks.getNotesList();

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
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: size.width * 0.09,
                  )
                ],
              ),
              Text(
                "User_Name",
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
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 95, 94, 94))),
                          style: TextStyle(color: Colors.white))),
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
                    itemCount: Tasks.getListSize(),
                    itemBuilder: (context, index) => Column(children: [
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          Container(
                            height: size.height * 0.08,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 95, 94, 94),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(size.width * 0.03))),
                            child: Padding(
                              padding: EdgeInsets.all(size.width * 0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: (notesList[index].getType(
                                                    notesList[index]) ==
                                                'Note')
                                            ? Color(0xFF7DB634)
                                            : Color(0xFF873AB6),
                                        size: size.width * 0.03,
                                      ),
                                      SizedBox(width: size.width * 0.02),
                                      Text(
                                        "${notesList[index].getDate(notesList[index]).day}/${notesList[index].getDate(notesList[index]).month}/${notesList[index].getDate(notesList[index]).year}",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  Text(
                                      notesList[index]
                                          .gettitle(notesList[index]),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: size.width * 0.035)),
                                ],
                              ),
                            ),
                          ),
                        ])),
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
