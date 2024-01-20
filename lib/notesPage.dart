import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdsc_app_dev/notes.dart';
import 'package:gdsc_app_dev/routes/routes.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    DateTime date = DateTime.now();

    TextEditingController _titleController = TextEditingController();
    TextEditingController _contentController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.width*0.04),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${date.day}/${date.month}/${date.year}", 
                    style: TextStyle(
                      fontSize: size.width*0.04,
                      color: const Color.fromARGB(255, 95, 94, 94)),
                    ),
                
                    InkWell(
                      child: const Icon(Icons.close,
                        color: Color.fromARGB(255, 95, 94, 94),
                      ),
                              
                      onTap: () {
                        Navigator.pushNamed(context, MyRoutes.homePageRoute);
                      }
                    )
                  ],
                ),
                SizedBox(height: size.height*0.02),
                
                TextFormField(
                  controller: _titleController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Enter Title",
                    hintStyle: const TextStyle(color: Color.fromARGB(255, 95, 94, 94)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(size.width*0.03)
                    )
                  ),
                  style: const TextStyle(color: Colors.white)
                ),

                SizedBox(height: size.height * 0.04),
                
                TextFormField(
                  controller:  _contentController,
                  maxLines: 20,
                  decoration: InputDecoration(
                      hintText: "Enter Content",
                      hintStyle:
                          const TextStyle(color: Color.fromARGB(255, 95, 94, 94)),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.03))),
                  style: const TextStyle(color: Colors.white)
                ),

                SizedBox(height: size.height*0.02),

                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: (){
                      Tasks.addNote(
                        Notes(title: _titleController.toString(), 
                          content: _contentController.toString(), 
                          date: date.toString(), type: "Note")
                      );
                    },
                    child: Text("Done", style: TextStyle(fontSize: size.width*0.04),),
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(size.width*0.3, size.height*0.02))
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