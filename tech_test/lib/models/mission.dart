// lib/models/mission.dart
class Mission {
  final String missionId;
  final String missionName;
  final List<String> manufacturers;
  final List<String> payloadIds;
  final String? wikipedia;
  final String? website;  
  final String? twitter;  
  final String description;

  Mission({
    required this.missionId,
    required this.missionName,
    required this.manufacturers,
    required this.payloadIds,
    this.wikipedia,         
    this.website,           
    this.twitter,           
    required this.description,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      missionId: json['mission_id'] ?? 'Unknown',
      missionName: json['mission_name'] ?? 'Unknown',
      manufacturers: List<String>.from(json['manufacturers'] ?? []),
      payloadIds: List<String>.from(json['payload_ids'] ?? []),    
      wikipedia: json['wikipedia'],
      website: json['website'],    
      twitter: json['twitter'],    
      description: json['description'] ?? 'No description available', 
    );
  }
}