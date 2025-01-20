class Launch {
  final int flightNumber;
  final String missionName;
  final String launchYear;
  final DateTime launchDateUtc;
  final Rocket rocket;
  final LaunchSite launchSite;
  final bool launchSuccess;
  final Links links;
  final String details;

  Launch({
    required this.flightNumber,
    required this.missionName,
    required this.launchYear,
    required this.launchDateUtc,
    required this.rocket,
    required this.launchSite,
    required this.launchSuccess,
    required this.links,
    required this.details,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      flightNumber: json['flight_number'],
      missionName: json['mission_name'],
      launchYear: json['launch_year'],
      launchDateUtc: DateTime.parse(json['launch_date_utc']),
      rocket: Rocket.fromJson(json['rocket']),
      launchSite: LaunchSite.fromJson(json['launch_site']),
      launchSuccess: json['launch_success'] ?? false,
      links: Links.fromJson(json['links']),
      details: json['details'] ?? 'No details available',
    );
  }
}

class Rocket {
  final String rocketId;
  final String rocketName;
  final String rocketType;

  Rocket({
    required this.rocketId,
    required this.rocketName,
    required this.rocketType,
  });

  factory Rocket.fromJson(Map<String, dynamic> json) {
    return Rocket(
      rocketId: json['rocket_id'],
      rocketName: json['rocket_name'],
      rocketType: json['rocket_type'],
    );
  }
}

class LaunchSite {
  final String siteId;
  final String siteName;
  final String siteNameLong;

  LaunchSite({
    required this.siteId,
    required this.siteName,
    required this.siteNameLong,
  });

  factory LaunchSite.fromJson(Map<String, dynamic> json) {
    return LaunchSite(
      siteId: json['site_id'],
      siteName: json['site_name'],
      siteNameLong: json['site_name_long'],
    );
  }
}

class Links {
  final String missionPatch;
  final String missionPatchSmall;
  final String articleLink;
  final String videoLink;

  Links({
    required this.missionPatch,
    required this.missionPatchSmall,
    required this.articleLink,
    required this.videoLink,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      missionPatch: json['mission_patch'] ?? '',
      missionPatchSmall: json['mission_patch_small'] ?? '',
      articleLink: json['article_link'] ?? '',
      videoLink: json['video_link'] ?? '',
    );
  }
}