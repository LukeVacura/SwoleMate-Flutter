// import 'package:flutter/material.dart';


// class ExpandableListView extends StatelessWidget {

//   TextEditingController weightController = new TextEditingController();
//   TextEditingController repsController = new TextEditingController();
//   TextEditingController exerciseController = new TextEditingController();
//   TextEditingController groupController = new TextEditingController();
//   TextEditingController typeController = new TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     List<ExpansionTile> _listOfExpansions = List<ExpansionTile>.generate(

//       15,
//       (i) => ExpansionTile(
//             title: Text(groups.elementAt(i)),
//             children: exercises.elementAt(i)
//                 .map((data) => ListTile(
                
//                       leading: Text(data.id.toString()),
//                       title: Text(data.name),
//                       onTap: (){
//                         print("Navigate");
//                         // showDialog(
//                         //   context: context,
//                         //   builder: (BuildContext context) => _buildAboutDialog(context, data),);     
//                       }
//                     ))
//                 .toList(),
//           ));


//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Exercises'),
//         actions: <Widget>[
//           IconButton(icon: Icon(Icons.create),
//             tooltip:'Add new exercise',
//             onPressed: (){
//               // showDialog(context: context,
//               // builder: (BuildContext context) => _addNewExercise(context));
//               print("Add exercise");
//             }
//           ),
//         ]
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(8.0),
//         children:
//             _listOfExpansions.map((expansionTile) => expansionTile).toList(),
//       ),
//     );
//   }
// }