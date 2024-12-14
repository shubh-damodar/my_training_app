class TrainingModel {
  TrainingModel({
    required this.status,
    required this.trainings,
  });

  final String status;
  static const String statusKey = "status";

  final List<Training> trainings;
  static const String trainingsKey = "trainings";

  factory TrainingModel.fromJson(Map<String, dynamic> json) {
    return TrainingModel(
      status: json["status"] ?? "",
      trainings: json["trainings"] == null ? [] : List<Training>.from(json["trainings"]!.map((x) => Training.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "trainings": trainings.map((x) => x.toJson()).toList(),
      };
}

class Training {
  Training({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.address,
    required this.highlight,
    required this.trainingName,
    required this.trainer,
    required this.work,
    required this.offerPrice,
    required this.price,
    required this.location,
    required this.profileImage,
    required this.backgroundImage,
    required this.rating,
  });

  final int id;
  final DateTime? date;
  final String startTime;
  final String rating;
  final String endTime;
  final String address;
  final String highlight;
  final String trainingName;
  final String trainer;
  final String work;
  final String offerPrice;
  final String price;
  final String location;
  final String profileImage;
  final String backgroundImage;

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
      id: json["id"] ?? 0,
      date: DateTime.tryParse(json["Date"] ?? ""),
      startTime: json["StartTime"] ?? "",
      endTime: json["EndTime"] ?? "",
      address: json["Address"] ?? "",
      highlight: json["Highlight"] ?? "",
      trainingName: json["TrainingName"] ?? "",
      trainer: json["Trainer"] ?? "",
      work: json["Work"] ?? "",
      offerPrice: json["OfferPrice"] ?? "",
      price: json["Price"] ?? "",
      location: json["Location"] ?? "",
      profileImage: json["profileImage"] ?? "",
      backgroundImage: json["backgroundImage"] ?? "",
      rating: json["Rating"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "Date": date?.toIso8601String(),
        "StartTime": startTime,
        "EndTime": endTime,
        "Address": address,
        "Highlight": highlight,
        "TrainingName": trainingName,
        "Trainer": trainer,
        "Work": work,
        "OfferPrice": offerPrice,
        "Price": price,
        "Location": location,
        "profileImage": profileImage,
        "backgroundImage": backgroundImage,
        "Rating": rating,
      };
}
