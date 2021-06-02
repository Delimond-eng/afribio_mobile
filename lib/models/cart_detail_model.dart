class Cart {
  Commande commande;

  Cart({this.commande});

  Cart.fromJson(Map<String, dynamic> json) {
    commande = json['commande'] != null
        ? new Commande.fromJson(json['commande'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commande != null) {
      data['commande'] = this.commande.toJson();
    }
    return data;
  }
}

class Commande {
  String status;
  int posVenteId;
  String delaiLivraison;
  List<Detail> detail;

  Commande({this.status, this.posVenteId, this.delaiLivraison, this.detail});

  Commande.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    posVenteId = json['pos_vente_id'];
    delaiLivraison = json['delai_livraison'];
    if (json['detail'] != null) {
      detail = new List<Detail>();
      json['detail'].forEach((v) {
        detail.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['pos_vente_id'] = this.posVenteId;
    data['delai_livraison'] = this.delaiLivraison;
    if (this.detail != null) {
      data['detail'] = this.detail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  String produitId;
  String image;
  String titre;
  String quantite;
  String prixUnitaire;

  Detail(
      {this.produitId,
        this.image,
        this.titre,
        this.quantite,
        this.prixUnitaire});

  Detail.fromJson(Map<String, dynamic> json) {
    produitId = json['produit_id'];
    image = json['image'];
    titre = json['titre'];
    quantite = json['quantite'];
    prixUnitaire = json['prix_unitaire'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['produit_id'] = this.produitId;
    data['image'] = this.image;
    data['titre'] = this.titre;
    data['quantite'] = this.quantite;
    data['prix_unitaire'] = this.prixUnitaire;
    return data;
  }
}