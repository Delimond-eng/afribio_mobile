class UserCommands {
  List<Commandes> commandes;

  UserCommands({this.commandes});

  UserCommands.fromJson(Map<String, dynamic> json) {
    if (json['commandes'] != null) {
      commandes = new List<Commandes>();
      json['commandes'].forEach((v) {
        commandes.add(new Commandes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commandes != null) {
      data['commandes'] = this.commandes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Commandes {
  String posLivraisonId;
  String posVenteId;
  String acheteurId;
  String delaiLivraison;
  String adresse;
  String posLivraisonStatus;
  String dateEnregistrement;
  List<Details> details;

  Commandes(
      {this.posLivraisonId,
      this.posVenteId,
      this.acheteurId,
      this.delaiLivraison,
      this.adresse,
      this.posLivraisonStatus,
      this.dateEnregistrement,
      this.details});

  Commandes.fromJson(Map<String, dynamic> json) {
    posLivraisonId = json['pos_livraison_id'];
    posVenteId = json['pos_vente_id'];
    acheteurId = json['acheteur_id'];
    delaiLivraison = json['delai_livraison'];
    adresse = json['adresse'];
    posLivraisonStatus = json['pos_livraison_status'];
    dateEnregistrement = json['date_enregistrement'];
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pos_livraison_id'] = this.posLivraisonId;
    data['pos_vente_id'] = this.posVenteId;
    data['acheteur_id'] = this.acheteurId;
    data['delai_livraison'] = this.delaiLivraison;
    data['adresse'] = this.adresse;
    data['pos_livraison_status'] = this.posLivraisonStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String produitId;
  String prixUnitaire;
  String quantite;
  String titre;
  String image;

  Details(
      {this.produitId,
      this.prixUnitaire,
      this.quantite,
      this.titre,
      this.image});

  Details.fromJson(Map<String, dynamic> json) {
    produitId = json['produit_id'];
    prixUnitaire = json['prix_unitaire'];
    quantite = json['quantite'];
    titre = json['titre'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['produit_id'] = this.produitId;
    data['prix_unitaire'] = this.prixUnitaire;
    data['quantite'] = this.quantite;
    data['titre'] = this.titre;
    data['image'] = this.image;
    return data;
  }
}
