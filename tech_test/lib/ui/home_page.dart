import 'package:flutter/material.dart';
import 'package:tech_test/screens/launch_screen.dart';
import 'package:tech_test/screens/mission_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 80),
          color: const Color.fromARGB(255, 248, 246, 246),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/spacex.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "SpaceX designs, manufactures and launches advanced rockets and spacecraft,",
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 102, 42, 118),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LaunchScreen()),
                  );
                  print('button pressed');
                },
                child: const Text("Launches"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(90, 0, 0, 0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 85),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MissionScreen(),
                    ),
                  );
                },
                child: const Text("Missions"),
              ),
              const SizedBox(height: 40),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: "By Entering to our Application, You have to Agreed to ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                  children: [
                    TextSpan(
                        text: "the terms And Conditions",
                        style: TextStyle(color: Color.fromARGB(90, 0, 0, 0))),
                    TextSpan(
                        text: " And ",
                        style: TextStyle(color: Colors.black, fontSize: 10)),
                    TextSpan(
                        text: "Privacy Policy",
                        style: TextStyle(
                            color: Color.fromARGB(90, 0, 0, 0), fontSize: 10)),
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}