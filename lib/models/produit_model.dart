class ProductModel {
  List<Produits> produits;

  ProductModel({this.produits});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['produits'] != null) {
      produits = new List<Produits>();
      json['produits'].forEach((v) {
        produits.add(new Produits.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.produits != null) {
      data['produits'] = this.produits.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Produits {
  String produitId;
  String titre;
  String image;
  String unite;
  String produitStatus;
  String dateEnregistrement;
  int prixUnitaire;
  String delaiLivraison;
  String posId;
  String posStockId;

  Produits(
      {this.produitId,
        this.titre,
        this.image,
        this.unite,
        this.produitStatus,
        this.dateEnregistrement,
        this.prixUnitaire,
        this.delaiLivraison,
        this.posId,
        this.posStockId});

  Produits.fromJson(Map<String, dynamic> json) {
    produitId = json['produit_id'];
    titre = json['titre'];
    image = json['image'];
    unite = json['unite'];
    produitStatus = json['produit_status'];
    dateEnregistrement = json['date_enregistrement'];
    prixUnitaire = json['prix_unitaire'];
    delaiLivraison = json['delai_livraison'];
    posId = json['pos_id'];
    posStockId = json['pos_stock_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['produit_id'] = this.produitId;
    data['titre'] = this.titre;
    data['image'] = this.image;
    data['unite'] = this.unite;
    data['produit_status'] = this.produitStatus;
    data['date_enregistrement'] = this.dateEnregistrement;
    data['prix_unitaire'] = this.prixUnitaire;
    data['delai_livraison'] = this.delaiLivraison;
    data['pos_id'] = this.posId;
    data['pos_stock_id'] = this.posStockId;
    return data;
  }
}