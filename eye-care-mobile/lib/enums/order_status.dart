enum OrderStatus { pending, canceled, delivered, confirmed }

extension OrderStatusExtension on OrderStatus {
  String get name {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.canceled:
        return 'Canceled';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.confirmed:
        return 'Confirmed';
      default:
        return "";
    }
  }
}
