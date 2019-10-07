class Person {
    int id;
    int adminId;
    String name;
    String lname;
    String identification;
    String addres;
    String landline;
    String cellPhone;
    String email;
    String date;
    String img;
    int isActive;

    Person({
        this.id,
        this.adminId,
        this.name,
        this.lname,
        this.identification,
        this.addres,
        this.landline,
        this.cellPhone,
        this.email,
        this.date,
        this.img,
        this.isActive,
    });

    factory Person.fromJson(Map<String, dynamic> json) => new Person(
        id           : json["id"],
        adminId      : json["adminId"],
        name         : json["name"],
        lname        : json["lname"],
        identification: json["identification"],
        addres       : json["addres"],
        landline     : json["landline"],
        cellPhone    : json["cellPhone"],
        email        : json["email"],
        date         : json["date"],
        img          : json["imgs"],
        isActive     : json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "adminId": adminId,
        "name": name,
        "lname": lname,
        "identification": identification,
        "addres": addres,
        "landline": landline,
        "cellPhone": cellPhone,
        "email": email,
        "date": date,
        "img": img,
        "isActive": isActive,
    };
}
