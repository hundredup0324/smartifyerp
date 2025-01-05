class EditProfileResponse {
  int? status;
  String? message;
  Data? data;

  EditProfileResponse({this.status, this.message, this.data});

  EditProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? mobileNo;
  String? type;
  int? activeworkspace;
  String? avatar;
  String? lang;

  Data(
      {this.id,
        this.name,
        this.email,
        this.mobileNo,
        this.type,
        this.activeworkspace,
        this.avatar,
        this.lang});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    type = json['type'];
    activeworkspace = json['active_workspace'];
    avatar = json['avatar'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['type'] = this.type;
    data['active_workspace'] = this.activeworkspace;
    data['avatar'] = this.avatar;
    data['lang'] = this.lang;
    return data;
  }
}