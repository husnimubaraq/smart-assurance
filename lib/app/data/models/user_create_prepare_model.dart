class UserCreatePrepare {
  UserTypeOptions? userTypeOptions;

  UserCreatePrepare({this.userTypeOptions});

  UserCreatePrepare.fromJson(Map<String, dynamic> json) {
    userTypeOptions = json['user_type_options'] != null
        ? UserTypeOptions?.fromJson(json['user_type_options'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (userTypeOptions != null) {
      data['user_type_options'] = userTypeOptions!.toJson();
    }
    return data;
  }
}

class UserTypeOptions {
  ADMIN? aDMIN;
  ROC? rOC;
  TEAMLEADER? tEAMLEADER;

  UserTypeOptions({this.aDMIN, this.rOC, this.tEAMLEADER});

  UserTypeOptions.fromJson(Map<String, dynamic> json) {
    aDMIN = json['ADMIN'] != null ? ADMIN?.fromJson(json['ADMIN']) : null;
    rOC = json['ROC'] != null ? ROC?.fromJson(json['ROC']) : null;
    tEAMLEADER = json['TEAM LEADER'] != null
        ? TEAMLEADER?.fromJson(json['TEAM LEADER'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (aDMIN != null) {
      data['ADMIN'] = aDMIN!.toJson();
    }
    if (rOC != null) {
      data['ROC'] = rOC!.toJson();
    }
    if (tEAMLEADER != null) {
      data['TEAM LEADER'] = tEAMLEADER!.toJson();
    }
    return data;
  }
}

class ADMIN {
  List<UplineUserOptions>? uplineUserOptions;

  ADMIN({this.uplineUserOptions});

  ADMIN.fromJson(Map<String, dynamic> json) {
    if (json['upline_user_options'] != null) {
      uplineUserOptions = <UplineUserOptions>[];
      json['upline_user_options'].forEach((v) {
        uplineUserOptions!.add(UplineUserOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (uplineUserOptions != null) {
      data['upline_user_options'] =
          uplineUserOptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TEAMLEADER {
  List<UplineUserOptions>? uplineUserOptions;

  TEAMLEADER({this.uplineUserOptions});

  TEAMLEADER.fromJson(Map<String, dynamic> json) {
    if (json['upline_user_options'] != null) {
      uplineUserOptions = <UplineUserOptions>[];
      json['upline_user_options'].forEach((v) {
        uplineUserOptions?.add(UplineUserOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (uplineUserOptions != null) {
      data['upline_user_options'] =
          uplineUserOptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ROC {
  List<UplineUserOptions>? uplineUserOptions;

  ROC({this.uplineUserOptions});

  ROC.fromJson(Map<String, dynamic> json) {
    if (json['upline_user_options'] != null) {
      uplineUserOptions = <UplineUserOptions>[];
      json['upline_user_options'].forEach((v) {
        uplineUserOptions?.add(UplineUserOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (uplineUserOptions != null) {
      data['upline_user_options'] =
          uplineUserOptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UplineUserOptions {
  int? id;
  String? userType;
  String? name;

  UplineUserOptions({this.id, this.userType, this.name});

  UplineUserOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['name'] = name;
    return data;
  }
}
