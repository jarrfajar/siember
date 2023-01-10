class News {
  String? link;
  String? title;
  String? pubDate;
  String? description;
  String? thumbnail;

  News({this.link, this.title, this.pubDate, this.description, this.thumbnail});

  News.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    title = json['title'];
    pubDate = json['pubDate'];
    description = json['description'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['title'] = this.title;
    data['pubDate'] = this.pubDate;
    data['description'] = this.description;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
