import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musicrec/services/ApiService.dart';
import 'MusicDataResponse.dart';

class ChooseMusic extends StatefulWidget {
  const ChooseMusic({Key? key}) : super(key: key);

  @override
  State<ChooseMusic> createState() => _ChooseMusicState();
}

class _ChooseMusicState extends State<ChooseMusic> {
  List<MusicDataResponse> musicList = [];

  @override
  void initState() {
    super.initState();
    fetchMusicData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music App"),
      ),
      body: customListCard(),
    );
  }

  Future<void> fetchMusicData() async {
    final musiclist = await ApiService().getAllFetchMusicData();
    setState(() {
      musicList = musiclist;
    });
  }

  Widget customListCard() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            _showAmountDialog(context, musicList[index]);
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, bottom: 8, right: 8, top: 4),
                  child: SizedBox(
                    child: FadeInImage.assetNetwork(
                      height: 60,
                      width: 60,
                      placeholder: "lib/assets/images/leo.jpeg",
                      image: musicList[index].image.toString(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      musicList[index].title.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      musicList[index].artist.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
      itemCount: musicList.length,
    );
  }

  Future<void> _showAmountDialog(BuildContext context, MusicDataResponse music) async {
    String amountText = '';
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter Amount"),
          content: TextField(
            onChanged: (value) {
              amountText = value;
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Enter amount"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                int amount = int.tryParse(amountText) ?? 0;
                _addToFirestore(music, amount);
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _addToFirestore(MusicDataResponse music, int amount) async {
    final firestore = FirebaseFirestore.instance;
    final songRef = firestore.collection('songs').doc(music.title);

    final songData = await songRef.get();
    if (songData.exists) {
      final currentAmount = songData.data()?['amount'] ?? 0;
      await songRef.update({'amount': currentAmount + amount});
    } else {
      await songRef.set({'name': music.title, 'amount': amount});
    }
  }

}
