class RequestDataResponse {
  int? status;
  Data? data;
  String? message;

  RequestDataResponse({this.status, this.data});

  RequestDataResponse.fromJson(Map<String, dynamic> json) {
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
  List<DropdownModel>? accounts;
  List<DropdownModel>? contacts;
  List<DropdownModel>? leadSources;
  List<DropdownModel>? users;
  List<DropdownModel>? opportunitiesStages;
  List<DropdownModel>? opportunities;
  List<DropdownModel>? shippingProvider;
  List<DropdownModel>? quotes;
  List<DropdownModel>? tax;

  Data(
      {this.accounts,
        this.contacts,
        this.leadSources,
        this.users,
        this.opportunitiesStages,
        this.opportunities,
        this.shippingProvider,
        this.quotes,
        this.tax});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['accounts'] != null) {
      accounts = <DropdownModel>[];
      json['accounts'].forEach((v) {
        accounts!.add(new DropdownModel.fromJson(v));
      });
    }
    if (json['contacts'] != null) {
      contacts = <DropdownModel>[];
      json['contacts'].forEach((v) {
        contacts!.add(new DropdownModel.fromJson(v));
      });
    }
    if (json['lead_sources'] != null) {
      leadSources = <DropdownModel>[];
      json['lead_sources'].forEach((v) {
        leadSources!.add(new DropdownModel.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = <DropdownModel>[];
      json['users'].forEach((v) {
        users!.add(new DropdownModel.fromJson(v));
      });
    }
    if (json['opportunities_stages'] != null) {
      opportunitiesStages = <DropdownModel>[];
      json['opportunities_stages'].forEach((v) {
        opportunitiesStages!.add(new DropdownModel.fromJson(v));
      });
    }
    if (json['opportunities'] != null) {
      opportunities = <DropdownModel>[];
      json['opportunities'].forEach((v) {
        opportunities!.add(new DropdownModel.fromJson(v));
      });
    }
    if (json['shipping_provider'] != null) {
      shippingProvider = <DropdownModel>[];
      json['shipping_provider'].forEach((v) {
        shippingProvider!.add(new DropdownModel.fromJson(v));
      });
    }
    if (json['quotes'] != null) {
      quotes = <DropdownModel>[];
      json['quotes'].forEach((v) {
        quotes!.add(new DropdownModel.fromJson(v));
      });
    }
    if (json['tax'] != null) {
      tax = <DropdownModel>[];
      json['tax'].forEach((v) {
        tax!.add(new DropdownModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.accounts != null) {
      data['accounts'] = this.accounts!.map((v) => v.toJson()).toList();
    }
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    if (this.leadSources != null) {
      data['lead_sources'] = this.leadSources!.map((v) => v.toJson()).toList();
    }
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    if (this.opportunitiesStages != null) {
      data['opportunities_stages'] =
          this.opportunitiesStages!.map((v) => v.toJson()).toList();
    }
    if (this.opportunities != null) {
      data['opportunities'] =
          this.opportunities!.map((v) => v.toJson()).toList();
    }
    if (this.shippingProvider != null) {
      data['shipping_provider'] =
          this.shippingProvider!.map((v) => v.toJson()).toList();
    }
    if (this.quotes != null) {
      data['quotes'] = this.quotes!.map((v) => v.toJson()).toList();
    }
    if (this.tax != null) {
      data['tax'] = this.tax!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DropdownModel {
  int? id;
  String? name;
  int? accountId;
  String? accountName;

  DropdownModel({this.id, this.name,this.accountId,this.accountName});

  DropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    accountId = json['account_id'];
    accountName = json['account_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['account_id'] = this.accountId;
    data['account_name'] = this.accountName;
    return data;
  }
}

class Users {
  int? id;
  String? name;

  Users({this.id, this.name});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
class LeadSources {
  int? id;
  String? name;

  LeadSources({this.id, this.name});

  LeadSources.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Accounts {
  int? id;
  String? name;

  Accounts({this.id, this.name});

  Accounts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Contacts {
  int? id;
  String? name;
  String? accountName;

  Contacts({this.id, this.name, this.accountName});

  Contacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    accountName = json['account_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['account_name'] = this.accountName;
    return data;
  }
}

class Quotes {
  int? id;
  String? name;
  String? opportunityName;
  String? accountName;

  Quotes({this.id, this.name, this.opportunityName, this.accountName});

  Quotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    opportunityName = json['opportunity_name'];
    accountName = json['account_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['opportunity_name'] = this.opportunityName;
    data['account_name'] = this.accountName;
    return data;
  }
}
