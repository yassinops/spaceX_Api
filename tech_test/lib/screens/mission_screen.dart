import 'package:flutter/material.dart';
import 'package:tech_test/models/mission.dart';
import 'package:tech_test/screens/details/mission_details.dart';
import 'package:tech_test/services/spacex.dart';

class MissionScreen extends StatelessWidget {
  final SpaceXService spaceXService = SpaceXService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('SpaceX Missions'),
      ),
      body: FutureBuilder<List<Mission>>(
        future: spaceXService.getMissions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: Check your Internet',style: TextStyle(color: Colors.red),),);
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No missions found'));
          } else {
            List<Mission> missions = snapshot.data!;
            return ListView.builder(
              itemCount: missions.length,
              itemBuilder: (context, index) {
                Mission mission = missions[index];
                return Card(
                  shadowColor: Colors.yellow,
                  child: ListTile(
                    title: Text(mission.missionName,style:TextStyle(fontWeight: FontWeight.bold,color: Colors.black) ,),
                    subtitle: Text(mission.missionId,style: TextStyle(color: Colors.grey),),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MissionDetailScreen(
                            missionId: mission.missionId,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}