class Tracks {
  Tracks({
    required this.music,
  });
  late final List<Music> music;

  Tracks.fromJson(Map<String, dynamic> json) {
    music = List.from(json['music']).map((e) => Music.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['music'] = music.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Music {
  Music({
    required this.id,
    required this.videoLink,
    required this.imgSrc,
    required this.title,
    required this.views,
    required this.time,
    required this.duration,
    required this.exactTime,
    required this.exactViews,
  });
  late final int id;
  late final String videoLink;
  late final String imgSrc;
  late final String title;
  late final String views;
  late final String time;
  late final double duration;
  late final String exactTime;
  late final int exactViews;

  Music.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoLink = json['video_link'];
    imgSrc = json['img_src'];
    title = json['title'];
    views = json['views'];
    time = json['time'];
    duration = json['duration'];
    exactTime = json['exact_time'];
    exactViews = json['exact_views'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['video_link'] = videoLink;
    _data['img_src'] = imgSrc;
    _data['title'] = title;
    _data['views'] = views;
    _data['time'] = time;
    _data['duration'] = duration;
    _data['exact_time'] = exactTime;
    _data['exact_views'] = exactViews;
    return _data;
  }
}
