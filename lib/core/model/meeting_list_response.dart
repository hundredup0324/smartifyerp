class MeetingListResponse {
  int? status;
  Data? data;
  String? message;

  MeetingListResponse({this.status, this.data,this.message});

  MeetingListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<MeetingData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <MeetingData>[];
      json['data'].forEach((v) {
        data!.add(MeetingData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class MeetingData {
  int? id;
  String? name;
  String? parent;
  String? description;
  String? status;
  String? account;
  String? startDate;
  String? endDate;
  String? attendeesUser;
  String? attendeesContact;
  String? attendeesLead;
  String? assignedUser;
  int? assignUserId;
  int? attendeesUserId;
  int? attendeescontactId;
  int? attendeesLeadId;
  int? accountId;

  MeetingData(
      {this.id,
        this.name,
        this.parent,
        this.description,
        this.status,
        this.account,
        this.startDate,
        this.endDate,
        this.attendeesUser,
        this.attendeesContact,
        this.attendeesLead,
        this.assignedUser,
        this.assignUserId,
        this.attendeesUserId,
        this.attendeescontactId,
        this.attendeesLeadId,
        this.accountId});

  MeetingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parent = json['parent'];
    description = json['description'];
    status = json['status'];
    account = json['account'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    attendeesUser = json['attendees_user'];
    attendeesContact = json['attendees_contact'];
    attendeesLead = json['attendees_lead'];
    assignedUser = json['assigned_user'];
    assignUserId = json['assign_user_id'];
    attendeesUserId = json['attendees_user_id'];
    attendeescontactId = json['attendeescontact_id'];
    attendeesLeadId = json['attendees_lead_id'];
    accountId = json['account_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent'] = this.parent;
    data['description'] = this.description;
    data['status'] = this.status;
    data['account'] = this.account;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['attendees_user'] = this.attendeesUser;
    data['attendees_contact'] = this.attendeesContact;
    data['attendees_lead'] = this.attendeesLead;
    data['assigned_user'] = this.assignedUser;
    data['assign_user_id'] = this.assignUserId;
    data['attendees_user_id'] = this.attendeesUserId;
    data['attendeescontact_id'] = this.attendeescontactId;
    data['attendees_lead_id'] = this.attendeesLeadId;
    data['account_id'] = this.accountId;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
