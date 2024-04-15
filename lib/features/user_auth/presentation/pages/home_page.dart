import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beat Blend"),
        backgroundColor: Colors.grey,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                "It's party time🥳",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/choosemusic");
                  },
                  child: Text("Choose Music"),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/delete");
                  },
                  child: Text("Delete your account"),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, "/login");
                  },
                  child: Text("Logout"),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/queue");
                  },
                  child: Text("Queue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
