class MemeResponse {
  bool success;
  List<Meme> memes;

  MemeResponse({required this.success, required this.memes});

  factory MemeResponse.fromJson(Map<String, dynamic> json) {
    return MemeResponse(
      success: json['success'],
      memes: List<Meme>.from(json['data']['memes'].map((meme) => Meme.fromJson(meme))),
    );
  }
}

class Meme {
  String id;
  String name;
  String url;
  int width;
  int height;
  int boxCount;
  int captions;

  Meme({
    required this.id,
    required this.name,
    required this.url,
    required this.width,
    required this.height,
    required this.boxCount,
    required this.captions,
  });

  factory Meme.fromJson(Map<String, dynamic> json) {
    return Meme(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      width: json['width'],
      height: json['height'],
      boxCount: json['box_count'],
      captions: json['captions'],
    );
  }
}
