class EndPoints {
  static String get getsongs => 'http://10.0.2.2:8000/api/music/';
  static String get getplaylist => 'http://10.0.2.2:8080/api/playlist/';
  static String get addplaylist => 'http://10.0.2.2:8080/api/add_playlist/';
  static String removeplaylist(String pk) =>
      'http://10.0.2.2:8080/api/playlist_delete/$pk';
}
