import 'package:flutter/material.dart';
import 'package:tech_test/components/row_detail.dart';
import 'package:tech_test/models/launch.dart';
import 'package:tech_test/services/spacex.dart';

class LaunchDetailScreen extends StatefulWidget {
  final int flightNumber;

  LaunchDetailScreen({required this.flightNumber});
  @override
  State<LaunchDetailScreen> createState() => _LaunchDetailScreenState();
}

class _LaunchDetailScreenState extends State<LaunchDetailScreen> {
  final SpaceXService _spaceXService = SpaceXService();
  late Future<Launch> _launchFuture;

  @override
  void initState() {
    super.initState();
    _launchFuture = _spaceXService.getLaunchByFlightNumber(widget.flightNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('Launch Details'),
      ),
      body: FutureBuilder<Launch>(
        future: _launchFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No details found'));
          } else {
            Launch launch = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mission: ${launch.missionName}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      RowDetail(
                        label: 'Launch Year',
                        value: launch.launchYear,
                      ),
                      RowDetail(
                        label: 'Date',
                        value: '${launch.launchDateUtc}',
                      ),
                      RowDetail(
                        label: 'Rocket',
                        value: '${launch.rocket.rocketName} (${launch.rocket.rocketType})',
                      ),
                      RowDetail(
                        label: 'Launch Site',
                        value: launch.launchSite.siteNameLong,
                      ),
                      RowDetail(
                        label: 'Success',
                        value: launch.launchSuccess ? 'Yes' : 'No',
                      ),
                      RowDetail(
                        label: 'Details',
                        value: launch.details,
                      ),
                      if (launch.links.missionPatchSmall.isNotEmpty)
                        Center(
                          child: Image.network(
                            launch.links.missionPatchSmall,
                            width: 150,
                            height: 150,
                          ),
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