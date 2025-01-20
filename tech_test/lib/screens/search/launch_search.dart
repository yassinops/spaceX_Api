// lib/screens/search/launch_search_delegate.dart
import 'package:flutter/material.dart';
import 'package:tech_test/models/launch.dart';
import 'package:tech_test/screens/details/launch_details.dart';

class LaunchSearch extends SearchDelegate<String> {
  final List<Launch> launches;

  LaunchSearch({required this.launches});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null!);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final results = launches
        .where((launch) =>
            launch.missionName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        Launch launch = results[index];
        return Card(
          child: ListTile(
            title: Text(launch.missionName, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            subtitle: Text("date&time : ${launch.launchDateUtc}", style: TextStyle(color: Colors.purple)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LaunchDetailScreen(flightNumber: launch.flightNumber),
                ),
              );
            },
          ),
        );
      },
    );
  }
}