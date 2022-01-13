class UserFromDatabase {
  late final String name;
  late final String email;
  late final String uid;
  late final String profilepic;
  late final bool isMentor;
  late final String classstudy;
  late final List? topicEnrolled;
  late final List? topicCreated;

  UserFromDatabase({
    required this.name,
    required this.email,
    required this.uid,
    required this.profilepic,
    required this.isMentor,
    required this.classstudy,
    required this.topicEnrolled,
    required this.topicCreated,
  });

  Map<String, dynamic> toJson() {
    return {
      'topicCreated': topicCreated,
      'name': name,
      'email': email,
      'uid': uid,
      'profilepic': profilepic,
      'isMentor': isMentor,
      'classstudy': classstudy,
      'topicenrolled': topicEnrolled,
    };
  }

  factory UserFromDatabase.fromJson(Map<String, dynamic> data) {
    return UserFromDatabase(
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
