import 'package:flutter/material.dart';
import 'package:tech_test/components/row_detail.dart';
import 'package:tech_test/models/mission.dart';
import 'package:tech_test/services/spacex.dart';

class MissionDetailScreen extends StatelessWidget {
  final String missionId;
  final SpaceXService spaceXService = SpaceXService();

  MissionDetailScreen({required this.missionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('Mission Details'),
      ),
      body: FutureBuilder<Mission>(
        future: spaceXService.getMissionById(missionId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No details found'));
          } else {
            Mission mission = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Mission Name
                      Text(
                        'Mission: ${mission.missionName}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Mission ID
                      RowDetail(
                        label: 'Mission ID',
                        value: mission.missionId,
                      ),

                      // Manufacturers
                      RowDetail(
                        label: 'Manufacturers',
                        value: mission.manufacturers.join(", "),
                      ),

                      // Payload IDs
                      RowDetail(
                        label: 'Payload IDs',
                        value: mission.payloadIds.join(", "),
                      ),

                      // Description
                      RowDetail(
                        label: 'Description',
                        value: mission.description,
                      ),

                      // Wikipedia
                      RowDetail(
                        label: 'Wikipedia',
                        value: '${mission.wikipedia}',
                      ),

                      // Website
                      RowDetail(
                        label: 'Website',
                        value: '${mission.website}',
                      ),

                      // Twitter
                      RowDetail(
                        label: 'Twitter',
                        value: '${mission.twitter}',
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}