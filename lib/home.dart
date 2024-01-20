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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(size.width*0.02),
                  child: Text("Hello,",  
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width*0.09,
                      fontFamily: 'Poppins'
                    ),)
                ),
                Padding(
                  padding: EdgeInsets.only(right: size.width*0.06),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: size.width*0.09,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.02),
              child: Text(
                "User_Name",
                style: TextStyle(
                    color: const Color(0xFF7973FF),
                    fontSize: size.width * 0.09,
                    fontFamily: 'Poppins'),
              ),
            ),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Padding(
                  padding: EdgeInsets.all(size.width*0.02),
                  child: TextFormField(
                    decoration: InputDecoration(border: 
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                        size.width*0.03)),
                        
                        hintText: "Search Here..",
                        hintStyle: TextStyle(color: Color.fromARGB(255, 95, 94, 94))
                        ),
                    style: TextStyle(color: Colors.white)
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.04),
                  child: Icon(Icons.search,
                    color: const Color.fromARGB(255, 95, 94, 94),
                    size: size.width*0.08,
                  ),
                )
              ],
            ),

            ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) => 
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(notesList[index].gettitle(notesList[index]))
                      ],
                    )
                  ],
                ),
              )
            ),

            FloatingActionButton(onPressed: (){
              Navigator.pushNamed(context, MyRoutes.notesPageRoute);
            },
              shape: CircleBorder(),
              backgroundColor: const Color(0xFF7973FF),
              child: Icon(Icons.add,
                color: Colors.white,
                size: size.width*0.075,
              ),
            )
          ],
        ),
      ),
    );
  }
}