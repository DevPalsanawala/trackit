// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum TType { income, expense }

enum Tag { food, travel, leisure, work, money }

const tagIcons = {
  Tag.food: Icons.lunch_dining_outlined,
  Tag.travel: Icons.flight_takeoff_outlined,
  Tag.work: Icons.work_outlined,
  Tag.leisure: Icons.movie_outlined,
  Tag.money: Icons.currency_rupee_sharp,
};

class TransactionModel {
  final String id;
  final String userId;
  final String title;
  final String amount;
  final TType type;
  final Tag tag;
  final String note;
  final DateTime createdAt;
  TransactionModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.amount,
    required this.type,
    required this.tag,
    required this.note,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'title': title,
      'amount': amount,
      'type': type.name,
      'tag': tag.name,
      'note': note,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      title: map['title'] as String,
      amount: map['amount'] as String,
      type: TType.values.firstWhere((e) => e.name == map['type']),
      tag: Tag.values.firstWhere((e) => e.name == map['tag']),
      note: map['note'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
