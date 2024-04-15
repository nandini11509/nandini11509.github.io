
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SongListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a song you like!'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('songs').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }


          Map<String, String> songMap = {};
          snapshot.data!.docs.forEach((doc) {
            songMap[doc['amount'].toString()] = doc['name'];
          });


          songMap = sortMapByKeys(songMap);

          User? currentUser = FirebaseAuth.instance.currentUser;
          bool isAdmin = currentUser != null && currentUser.uid == 'HgiC8Qaq7RQJVA298tflsCeUjFD2';
          return ListView.builder(
            itemCount: songMap.length + 1,
            itemBuilder: (context, index) {

              if (index == 0) {

                if (isAdmin) {
                  return ElevatedButton(
                    onPressed: () {
                      // Deleting the top song
                      String amt = songMap.keys.elementAt(index);
                      String nme = songMap[amt] ?? 'Unknown';
                      if (songMap.isNotEmpty) {
                        FirebaseFirestore.instance
                            .collection('songs')
                            .doc(nme)
                            .delete();
                      }
                    },
                    child: Text('Play Top Song'),
                  );
                } else {
                  return Container();
                }
              } else {
                // Adjusting index for accessing songMap
                final adjustedIndex = index - 1;
                String amount = songMap.keys.elementAt(adjustedIndex);
                String name = songMap[amount] ?? 'Unknown';

                return ListTile(
                  title: Text(name),
                  subtitle: Text('Amount: $amount'),
                );
              }
            },
          );

        },
      ),
    );
  }
}


Map<String, String> sortMapByKeys(Map<String, String> map) {
  List<int> sortedKeys = map.keys.map((key) => int.parse(key)).toList()
    ..sort((a, b) => b.compareTo(a)); // Sorting in descending order
  Map<String, String> sortedMap = {};
  sortedKeys.forEach((key) {
    sortedMap[key.toString()] = map[key.toString()]!;
  });
  return sortedMap;
}




