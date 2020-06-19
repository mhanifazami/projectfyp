class Residents{
  String residentid;
  String name;
  String houseno;
  String roadno;
  String contactno;

  Residents({this.residentid, this.name, this.houseno, this.roadno, this.contactno});

  factory Residents.fromJson(Map<String, dynamic> json){
    return Residents(
      residentid: json["ResidentId"] as String,
      name: json["Name"] as String,
      roadno: json["RoadNo"] as String,
      houseno: json["HouseNo"] as String,
      contactno: json["ContactNo"] as String
    );
  }
}