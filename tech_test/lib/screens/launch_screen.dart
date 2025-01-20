// lib/screens/launch_list_screen.dart
import 'package:flutter/material.dart';
import 'package:tech_test/models/launch.dart';
import 'package:tech_test/screens/details/launch_details.dart';
import 'package:tech_test/screens/search/launch_search.dart';
import 'package:tech_test/services/spacex.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  
  final SpaceXService _spaceXService = SpaceXService();
  final List<Launch> _launches = [];
  int _offset = 0;
  final int _limit = 10;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadLaunches();
  }

  Future<void> _loadLaunches() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Launch> newLaunches =
          await _spaceXService.getLaunches(limit: _limit, offset: _offset);
      setState(() {
        _launches.addAll(newLaunches);
        _offset += _limit;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "check your internet ",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('SpaceX Launches'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: LaunchSearch(launches: _launches),
              );
            },
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!_isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _loadLaunches();
          }
          return true;
        },
        child: ListView.builder(
          itemCount: _launches.length + (_isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _launches.length) {
              return Center(child: CircularProgressIndicator());
            }
            Launch launch = _launches[index];
            return Card(
              child: ListTile(
                title: Text(launch.missionName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                subtitle: Text(
                  "date&time  ${launch.launchDateUtc}",
                  style: TextStyle(color: Colors.purple),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LaunchDetailScreen(flightNumber: launch.flightNumber),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
