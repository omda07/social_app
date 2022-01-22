class PostModel {
  String? name;
  String? dateTime;
  String? text;
  String? uId;
  String? image;
  String? imagePost;

  PostModel({
    this.name,
    this.dateTime,
    this.text,
    this.uId,
    this.image,
    this.imagePost,
  });
  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateTime = json['dateTime'];
    text = json['text'];
    uId = json['uId'];
    image = json['image'];
    imagePost = json['imagePost'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateTime': dateTime,
      'text': text,
      'uId': uId,
      'image': image,
      'imagePost': imagePost,
    };
  }
}
