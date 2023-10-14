class ImageModel{
  final String? id;
  final String? url;

  ImageModel({this.id, this.url});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'url': this.url,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'] as String,
      url: map['url'] as String,
    );
  }

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json["id"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "url": this.url,
    };
  }
}
