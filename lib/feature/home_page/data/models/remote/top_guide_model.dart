class TopGuideResponseModel {
  List<GuideModel>? topGuides;

  TopGuideResponseModel({this.topGuides});

  TopGuideResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['Top_Guides'] != null) {
      topGuides = <GuideModel>[];
      json['Top_Guides'].forEach((v) {
        topGuides!.add(new GuideModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topGuides != null) {
      data['Top_Guides'] = this.topGuides!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GuideModel {
  int? id;
  String? name;
  String? email;
  String? gender;
  String? age;
  int? yearsofExperience;
  String? image;
  String? location;
  String? bio;
  String? createdAt;
  String? updatedAt;
  int? rating;

  GuideModel(
      {this.id,
      this.name,
      this.email,
      this.gender,
      this.age,
      this.yearsofExperience,
      this.image,
      this.location,
      this.bio,
      this.createdAt,
      this.updatedAt,
      this.rating});

  GuideModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    age = json['age'];
    yearsofExperience = json['yearsofExperience'];
    image = json['image'];
    location = json['location'];
    bio = json['bio'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['yearsofExperience'] = this.yearsofExperience;
    if (this.image != null) {
      data['image'] = this.image;
    }
    data['location'] = this.location;
    data['bio'] = this.bio;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['rating'] = this.rating;
    return data;
  }
}

class UseImage {
  String? image;

  UseImage({this.image});

  UseImage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}
