class LoginResponse {
  int? status;
  String? message;
  Data? data;


  LoginResponse({
     this.status,
      this.message,
     this.data,
  });
  LoginResponse.fromJson(Map<String, dynamic> json) {
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
  String? token;
  User? user;
  List<String>? role;
  List<workspace>? workspaces;

  Data({
    required this.token,
    required this.user,
    required this.role,
    required this.workspaces,
  });



  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];

    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['workspaces'] != null) {
      workspaces = <workspace>[];
      json['workspaces'].forEach((v) {
        workspaces!.add(new workspace.fromJson(v));
      });
    }
    if (json['role'] != null) {
      role = <String>[];
      json['role'].forEach((v) {
        role!.add(v);
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['role'] = this.role;

    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.workspaces != null) {
      data['workspaces'] = this.workspaces!.map((v) => v.toJson()).toList();
    }
    if (this.role != null) {
      data['role'] = this.role!.map((v) => v.toString()).toList();
    }

    return data;
  }
}



class User {
  int? id;
  String? name;
  String? email;
  String? mobileNo;
  String? type;
  int? activeworkspace;
  String? avatar;
  String? lang;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.type,
    required this.activeworkspace,
    required this.avatar,
    required this.lang,
  });

  User.fromJson(Map<String, dynamic> json) {
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

class workspace {
  int? id;
  String? name;
  String? slug;
  String? status;
  int? createdBy;

  workspace({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    required this.createdBy,
  });

  workspace.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    status = json['status'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    return data;
  }

}
