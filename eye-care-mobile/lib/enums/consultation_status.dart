enum ConsultationStatus { pending, approved, completed }

extension ConsultationStatusExtension on ConsultationStatus {
  String get name {
    switch (this) {
      case ConsultationStatus.pending:
        return 'PENDING';
      case ConsultationStatus.approved:
        return 'APPROVED';
      case ConsultationStatus.completed:
        return 'COMPLETED';
      default:
        return "";
    }
  }
}
