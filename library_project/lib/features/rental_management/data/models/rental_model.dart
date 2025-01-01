import 'package:cloud_firestore/cloud_firestore.dart';

class RentalModel {
  final String bookId;
  final String userId;
  final DateTime rentedDate;
  final DateTime returnDate;
  final String status; // Active, Overdue, Returned

  RentalModel({
    required this.bookId,
    required this.userId,
    required this.rentedDate,
    required this.returnDate,
    required this.status,
  });

  factory RentalModel.fromMap(Map<String, dynamic> map) {
    return RentalModel(
      bookId: map['book_id'],
      userId: map['user_id'],
      rentedDate: (map['rented_date'] as Timestamp).toDate(),
      returnDate: (map['return_date'] as Timestamp).toDate(),
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'book_id': bookId,
      'user_id': userId,
      'rented_date': rentedDate,
      'return_date': returnDate,
      'status': status,
    };
  }
}
