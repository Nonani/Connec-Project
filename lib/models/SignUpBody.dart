class SignUpBody {
  String? uid;
  String? uuid;
  String? serviceName;
  String? email;
  String? password;
  String? name;
  String? work;
  List<String>? career;
  String? location;
  String? gender;
  String? age;
  double? rate;
  String? profile_image_url;

  SignUpBody(
      {this.uid,
      this.uuid,
      this.serviceName,
      this.email,
      this.password,
      this.name,
      this.work,
      this.location,
      this.gender,
      this.age,
      this.profile_image_url,
      this.rate});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    uuid = json['uuid'];
    serviceName = json['serviceName'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    work = json['work'];
    career = json['career'];
    location = json['location'];
    gender = json['gender'];
    age = json['age'];
    profile_image_url = json['profile_image_url'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = this.uid;
    data['uuid'] = this.uuid;
    data['serviceName'] = this.serviceName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['name'] = this.name;
    data['work'] = this.work;
    data['career'] = this.career;
    data['location'] = this.location;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['profile_image_url'] = this.profile_image_url;
    data['rate'] = this.rate;
    return data;
  }
}
