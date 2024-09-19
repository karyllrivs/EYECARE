import 'package:eyecare_mobile/enums/consultation_status.dart';

class ConsultationModel {
  final String userId;
  final String? slotId;
  final String mobile;
  final String date;
  final String time;
  final String? status;

  ConsultationModel({
    required this.userId,
    this.slotId,
    required this.mobile,
    required this.date,
    required this.time,
    this.status,
  });

  factory ConsultationModel.fromJsonFetch(Map<String, dynamic> json) {
    return ConsultationModel(
      userId: json["user_id"],
      mobile: json["mobile"],
      date: json["date"],
      time: json["time"],
      status: json["status"],
    );
  }

  factory ConsultationModel.fromJsonCreate(Map<String, dynamic> json) {
    return ConsultationModel(
      userId: json["consultation"]["user_id"],
      mobile: json["consultation"]["mobile"],
      date: json["consultation"]["date"],
      time: json["consultation"]["time"],
      status: json["consultation"]["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        'flutter_user_id': userId,
        'slotId': slotId,
        'mobile': mobile,
        'date': date,
        'time': time,
        'status': ConsultationStatus.pending.name,
      };
}

class ConsultationSlotModel {
  final String id;
  final String date;
  final String time;
  final bool isAvailable;

  const ConsultationSlotModel(
      {required this.id,
      required this.date,
      required this.time,
      required this.isAvailable});

  factory ConsultationSlotModel.fromJsonFetch(Map<String, dynamic> json) {
    return ConsultationSlotModel(
      id: json["_id"],
      date: json["date"],
      time: json["time"],
      isAvailable: json["isAvailable"],
    );
  }
}
