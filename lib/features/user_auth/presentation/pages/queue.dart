// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'priority_queue.dart';
//
// class PriorityQueueWidget extends StatefulWidget {
//   @override
//   _PriorityQueueWidgetState createState() => _PriorityQueueWidgetState();
// }
//
// class _PriorityQueueWidgetState extends State<PriorityQueueWidget> {
//   late PriorityQueue _priorityQueue;
//   late Future<void> _loadDataFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _priorityQueue = PriorityQueue();
//     _loadDataFuture = _loadDataFromFirestore();
//   }
//
//   Future<void> _loadDataFromFirestore() async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> snapshot =
//       await FirebaseFirestore.instance.collection('songs').get();
//       snapshot.docs.forEach((doc) {
//         String name = doc.data()['name'];
//         int amount = doc.data()['amount'];
//         _priorityQueue.add(Node(name, amount));
//         print('Added: ($name, $amount)'); // Print statement for adding to queue
//       });
//       print('Queue contents after loading: $_priorityQueue'); // Print statement for queue contents after loading
//     } catch (e) {
//       print('Error loading data from Firestore: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Priority Queue Widget'),
//       ),
//       body: FutureBuilder(
//         future: _loadDataFuture,
//         builder: (context, AsyncSnapshot<void> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             return ListView.builder(
//               itemCount: _priorityQueue.isNotEmpty ? _priorityQueue.length : 0,
//               itemBuilder: (context, index) {
//                 Node? song = _priorityQueue.remove();
//                 if (song != null) {
//                   print('Removed: ($song)'); // Print statement for removed song
//                   return ListTile(
//                     title: Text(song.string),
//                     subtitle: Text('Amount: ${song.amount}'),
//                   );
//                 } else {
//                   return SizedBox(); // Placeholder widget if queue is empty
//                 }
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SongListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Song List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('songs').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // Convert Firestore data to map
          Map<String, String> songMap = {};
          snapshot.data!.docs.forEach((doc) {
            songMap[doc['amount'].toString()] = doc['name'];
          });

          // Sort the map by keys
          songMap = sortMapByKeys(songMap);

          // Create list view
          return ListView.builder(
            itemCount: songMap.length,
            itemBuilder: (context, index) {
              String amount = songMap.keys.elementAt(index);
              String name = songMap[amount] ?? 'Unknown';

              // Get the currently signed-in user
              User? currentUser = FirebaseAuth.instance.currentUser;

              // Check if the user is an admin
              bool isAdmin = currentUser != null && currentUser.uid == 'HgiC8Qaq7RQJVA298tflsCeUjFD2';

              return ListTile(
                title: Text(name),
                subtitle: Text('Amount: $amount'),
                // Allow admin user to delete songs
                onTap: isAdmin
                    ? () {
                  // Prompt user for confirmation
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Play Song'),
                        content: Text('Are you sure you want to play $name?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Delete song from Firestore
                              // if(songMap[index] != null ){
                              //   String? songId = songMap[index].;
                              //   if(songId != null ){
                              //     FirebaseFirestore.instance.collection('songs').doc(songId).delete();
                              //   }
                              // }
                              // // FirebaseFirestore.instance.collection('songs').doc(songMap[index].id).delete();
                              // Navigator.pop(context);
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                }
                    : null, // Disable delete functionality for non-admin users
              );
            },
          );
        },
      ),
    );
  }
}

// Utility function to sort map by keys
Map<String, String> sortMapByKeys(Map<String, String> map) {
  List<int> sortedKeys = map.keys.map((key) => int.parse(key)).toList()
    ..sort((a, b) => b.compareTo(a)); // Sorting in descending order
  Map<String, String> sortedMap = {};
  sortedKeys.forEach((key) {
    sortedMap[key.toString()] = map[key.toString()]!;
  });
  return sortedMap;
}



// void main() {
//   runApp(MaterialApp(
//     home: SongListWidget(),
//   ));
// }


// void main() {
//   runApp(MaterialApp(
//     home: SongListWidget(),
//   ));
// }
