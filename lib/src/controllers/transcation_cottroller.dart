import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:trackit/src/models/transaction_model.dart' as transaction;
import 'package:trackit/src/models/transaction_model.dart';
import 'package:trackit/src/screens/add_transaction/Services/transaction_service.dart';

class TranscationCottroller extends GetxController {
  static TranscationCottroller get instance => Get.find();
  final TransactionService _transactionService = TransactionService();
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) fetchTransaction(userId);
  }

// handle Dropdown
  final selectedType = transaction.TType.income.obs;
  final selectedTag = transaction.Tag.food.obs;

  void setSelectedType(transaction.TType type) {
    selectedType.value = type;
  }

  void setSelectedTag(transaction.Tag tag) {
    selectedTag.value = tag;
  }

  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController amountcontroller = TextEditingController();
  final TextEditingController notecontroller = TextEditingController();

  void clear() {
    titlecontroller.clear();
    amountcontroller.clear();
    notecontroller.clear();
  }

  var transactions = <TransactionModel>[].obs;

  Future<void> addTransaction(
      String title, String amount, String note, String userid) async {
    try {
      isLoading.value = true;
      TransactionModel transactionModel = TransactionModel(
        id: '',
        title: title,
        amount: amount,
        note: note,
        createdAt: DateTime.now(),
        type: selectedType.value,
        tag: selectedTag.value,
        userId: userid,
      );
      await _transactionService.addTransaction(transactionModel);
      fetchTransaction(userid);
      clear();
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> fetchTransaction(String userid) async {
  //   final fetchedTransactions =
  //       await _transactionService.getTransactionofUser(userid);
  //   transactions.value = fetchedTransactions;
  //   transactions.value = fetchedTransactions
  //     ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  // }
  void fetchTransaction(String userId) {
    _transactionService
        .getTransactionStream(userId)
        .listen((fetchedTransactions) {
      transactions.value = fetchedTransactions;
      transactions.value = fetchedTransactions
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });
  }

  Future<void> deleteTransaction(String transactionId) async {
    await _transactionService.deleteTransaction(transactionId);
  }

  Map<String, dynamic> getIncomeAndExpenseTotals() {
    double totalIncome = 0.0;
    double totalExpense = 0.0;

    for (var transaction in transactions) {
      double amount = double.tryParse(transaction.amount) ?? 0.0;

      if (transaction.type == TType.income) {
        totalIncome += amount;
      } else if (transaction.type == TType.expense) {
        totalExpense += amount;
      }
    }
    return {
      'income': totalIncome,
      'expense': totalExpense,
    };
  }
}
