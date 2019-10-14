import 'dart:convert';

Loan loanFromJson(String str) => Loan.fromJson(json.decode(str));

String loanToJson(Loan data) => json.encode(data.toJson());

class Loan {
    int id;
    int personId;
    double loanValue;
    double interest;
    int numberFees;
    String date;
    int isActive;

    Loan({
        this.id,
        this.personId,
        this.loanValue,
        this.interest,
        this.numberFees,
        this.date,
        this.isActive,
    });

    factory Loan.fromJson(Map<String, dynamic> json) => Loan(
        id: json["id"],
        personId: json["personId"],
        loanValue: json["loanValue"].toDouble(),
        interest: json["interest"].toDouble(),
        numberFees: json["numberFees"],
        date: json["date"],
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "personId": personId,
        "loanValue": loanValue,
        "interest": interest,
        "numberFees": numberFees,
        "date": date,
        "isActive": isActive,
    };
}