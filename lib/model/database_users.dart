class UserFromDatabase {
  late final String name;
  late final String email;
  late final String uid;
  late final String profilepic;
  late final bool isMentor;
  late final String classstudy;

  UserFromDatabase({
    required this.name,
    required this.email,
    required this.uid,
    required this.profilepic,
    required this.isMentor,
    required this.classstudy,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'profilepic': profilepic,
      'isMentor': isMentor,
      'classstudy': classstudy,
    };
  }

  factory UserFromDatabase.fromJson(Map<String, dynamic> data) {
    return UserFromDatabase(
        name: data['name'],
        email: data['email'],
        uid: data['uid'],
        profilepic: data['profilepic'],
        isMentor: data['isMentor'],
        classstudy: data['classstudy']);
  }
}
