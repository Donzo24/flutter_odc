
import 'package:floor/floor.dart';

@Entity(
  tableName: "utilisateur"
)
class Utilisateur {

  @PrimaryKey(autoGenerate: true)
  int? id;
  String nom;
  String prenom;
  String telephone;

  Utilisateur({this.id, required this.nom, required this.prenom, required this.telephone});
}

@Entity(
  tableName: "post",
  foreignKeys: [
    ForeignKey(
      childColumns: ["utilisateur_id"], 
      parentColumns: ["id"], 
      entity: Utilisateur
    )
  ]
)
class Post {

  @PrimaryKey(autoGenerate: true)
  int? id;
  String titre;

  int utilisateurId;

  Post({this.id, required this.titre, required this.utilisateurId});
}