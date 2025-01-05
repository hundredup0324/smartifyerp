class OpportunityResponse {
  int? status;
  Data? data;
  String? message;

  OpportunityResponse({this.status, this.data});

  OpportunityResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<OpportunityData>? data;
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
      data = <OpportunityData>[];
      json['data'].forEach((v) {
        data!.add(new OpportunityData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class OpportunityData {
  int? id;
  String? name;
  String? account;
  String? stage;
  String? amount;
  String? probability;
  String? closeDate;
  String? contacts;
  LeadSource? leadSource;
  String? description;
  String? assignUser;
  int? accountId;
  int? contactId;
  int? assignUserId;
  int? opportunityStageId;

  OpportunityData(
      {this.id,
        this.name,
        this.account,
        this.stage,
        this.amount,
        this.probability,
        this.closeDate,
        this.contacts,
        this.leadSource,
        this.description,
        this.assignUser,
      this.accountId,
      this.contactId,
      this.opportunityStageId,
      this.assignUserId});

  OpportunityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    account = json['account'];
    accountId = json['account_id'];
    contactId = json['contact_id'];
    opportunityStageId = json['opportunity_stage_id'];
    assignUserId = json['assign_user_Id'];
    stage = json['stage'];
    amount = json['amount'];
    probability = json['probability'];
    closeDate = json['close_date'];
    contacts = json['contacts'];
    leadSource = json['lead_source'] != null
        ? new LeadSource.fromJson(json['lead_source'])
        : null;
    description = json['description'];
    assignUser = json['assign_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['account'] = this.account;
    data['account_id'] = this.accountId;
    data['assign_user_Id'] = this.assignUserId;
    data['opportunity_stage_id'] = this.opportunityStageId;
    data['contact_id'] = this.contactId;
    data['stage'] = this.stage;
    data['amount'] = this.amount;
    data['probability'] = this.probability;
    data['close_date'] = this.closeDate;
    data['contacts'] = this.contacts;
    if (this.leadSource != null) {
      data['lead_source'] = this.leadSource!.toJson();
    }
    data['description'] = this.description;
    data['assign_user'] = this.assignUser;
    return data;
  }
}

class LeadSource {
  int? id;
  String? name;
  int? createdBy;
  int? workspaceId;
  String? createdAt;
  String? updatedAt;

  LeadSource(
      {this.id,
        this.name,
        this.createdBy,
        this.workspaceId,
        this.createdAt,
        this.updatedAt});

  LeadSource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdBy = json['created_by'];
    workspaceId = json['workspace_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_by'] = this.createdBy;
    data['workspace_id'] = this.workspaceId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
