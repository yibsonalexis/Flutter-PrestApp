import 'dart:convert';

Fees feesFromJson(String str) => Fees.fromJson(json.decode(str));

String feesToJson(Fees data) => json.encode(data.toJson());

class Fees {
    int id;
    int loanId;
    String date;
    double value;
    int isActive;

    Fees({
        this.id,
        this.loanId,
        this.date,
        this.value,
        this.isActive,
    });

    factory Fees.fromJson(Map<String, dynamic> json) => Fees(
        id: json["id"],
        loanId: json["loanId"],
        date: json["date"],
        value: json["value"].toDouble(),
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "loanId": loanId,
        "date": date,
        "value": value,
        "isActive": isActive,
    };
}
