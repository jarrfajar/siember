class Category {
  String? name;
  List<Paths>? paths;

  Category({this.name, this.paths});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['paths'] != null) {
      paths = <Paths>[];
      json['paths'].forEach((v) {
        paths!.add(new Paths.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.paths != null) {
      data['paths'] = this.paths!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Paths {
  String? name;
  String? path;

  Paths({this.name, this.path});

  Paths.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['path'] = this.path;
    return data;
  }
}
