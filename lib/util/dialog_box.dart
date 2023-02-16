import 'package:flutter/material.dart';
import 'package:taskapp/util/my_button.dart';

class DialogBox extends StatelessWidget {

  final conroller;
  VoidCallback onSave;
  VoidCallback onCancel;
   DialogBox({
    super.key, 
  required this.conroller,
  required this.onSave,
  required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.indigo[400],
      content:  Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: conroller ,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add new Task"
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              
                //save button
                MyButton(text: "save", onPressed: onSave),

                const SizedBox( width: 10,),

                //cancel button
                MyButton( text: "Cancel", onPressed: onCancel)
              ],
            )
            //buttons
          ],
        ),
      ),

    );
  }
}