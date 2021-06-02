class UserLogin {
  Reponse reponse;

  UserLogin({this.reponse});

  UserLogin.fromJson(Map<String, dynamic> json) {
    reponse =
    json['reponse'] != null ? new Reponse.fromJson(json['reponse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reponse != null) {
      data['reponse'] = this.reponse.toJson();
    }
    return data;
  }
}

class Reponse {
  String status;
  String message;
  DataUser dataUser;

  Reponse({this.status, this.message, this.dataUser});

  Reponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    dataUser = json['data_user'] != null
        ? new DataUser.fromJson(json['data_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.dataUser != null) {
      data['data_user'] = this.dataUser.toJson();
    }
    return data;
  }
}

class DataUser {
  String acheteurId;
  String nomComplet;
  String email;
  String telephone;
  String pass;
  String codeVerificationId;
  String acheteurStatus;
  String dateEnregistrement;

  DataUser(
      {this.acheteurId,
        this.nomComplet,
        this.email,
        this.telephone,
        this.pass,
        this.codeVerificationId,
        this.acheteurStatus,
        this.dateEnregistrement});

  DataUser.fromJson(Map<String, dynamic> json) {
    acheteurId = json['acheteur_id'];
    nomComplet = json['nom_complet'];
    email = json['email'];
    telephone = json['telephone'];
    pass = json['pass'];
    codeVerificationId = json['code_verification_id'];
    acheteurStatus = json['acheteur_status'];
    dateEnregistrement = json['date_enregistrement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acheteur_id'] = this.acheteurId;
    data['nom_complet'] = this.nomComplet;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['pass'] = this.pass;
    data['code_verification_id'] = this.codeVerificationId;
    data['acheteur_status'] = this.acheteurStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    return data;
  }
}