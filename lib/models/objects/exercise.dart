class Exercise {
  String id;
  String name;
  String equip;
  int type;
  int pref;
  int suf;
  String desc;

  Exercise({
    this.id,
    this.name,
    this.equip,
    this.type,
    this.pref,
    this.suf,
    this.desc,
  });

  factory Exercise.fromMap(Map<String, dynamic> json) => new Exercise(
        id: json["id"],
        name: json["name"],
        equip: json["equip"],
        type: json["type"],
        pref: json["pref"],
        suf: json["suf"],  
        desc: json["desc"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "equip": equip,
        "type": type,
        "pref": pref,
        "suf": suf,
        "desc": desc,
    };
    get exercise{
      return Exercise;
    }

    @override
    String toString() {
      return 'Exercise{id: $id, name: $name, equip: $equip, type: $type, pref: $pref, suf: $suf}';
    }
}