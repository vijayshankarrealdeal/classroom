class UserFromDatabase {
  late final String name;
  late final String email;
  late final String uid;
  late final String profilepic;
  late final bool isMentor;
  late final String classstudy;
  late final List? topicEnrolled;
  late final List topicCreated;
  late final List weekreport;
  late final int? totalclass;
  late final String level;
  late final List circleChart;
  late final String bio;

  UserFromDatabase({
    required this.name,
    required this.bio,
    required this.circleChart,
    required this.email,
    required this.level,
    required this.uid,
    required this.profilepic,
    required this.isMentor,
    required this.classstudy,
    required this.topicEnrolled,
    required this.topicCreated,
    required this.weekreport,
    required this.totalclass,
  });

  Map<String, dynamic> toJson() {
    return {
      'circleChart': circleChart,
      'level': level,
      'bio': bio,
      'topicCreated': topicCreated,
      'name': name,
      'email': email,
      'uid': uid,
      'profilepic': profilepic,
      'isMentor': isMentor,
      'classstudy': classstudy,
      'topicenrolled': topicEnrolled,
      'weekreport': weekreport,
    };
  }

  factory UserFromDatabase.fromJson(Map<String, dynamic> data) {
    return UserFromDatabase(
        bio: data['bio'] ?? '',
        circleChart: data['circleChart'] ??
            [
              {'class': 'No Data', 'discussion': -1}
            ],
        level: data['level'] ?? 'Novice',
        weekreport: data['weekreport'] ?? [],
        totalclass: data['totalclass'] ?? 0,
        topicCreated: data['topicCreated'] ?? [],
        topicEnrolled: data['topicenrolled'] ?? [],
        name: data['name'],
        email: data['email'],
        uid: data['uid'],
        profilepic: data['profilepic'],
        isMentor: data['isMentor'],
        classstudy: data['classstudy']);
  }
}
