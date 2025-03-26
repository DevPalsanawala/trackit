import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackit/src/comman/showsnackbar.dart';
import 'package:trackit/src/models/transaction_model.dart';

class TransactionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      final docRef =
          await _firestore.collection('transactions').add(transaction.toMap());
      // Update the transaction with its ID
      await docRef.update({'id': docRef.id});
      SnackbarHelper.showSnackbar(
        title: "Success",
        message: "Added successfully.",
      );
    } catch (e) {
      SnackbarHelper.showSnackbar(
        title: "Error",
        message: "Failed to add transaction: $e",
        isError: true,
      );
    }
  }

  Future<void> deleteTransaction(String transactionId) async {
    try {
      await _firestore.collection('transactions').doc(transactionId).delete();
      SnackbarHelper.showSnackbar(
        title: "Success",
        message: "Transaction deleted successfully.",
      );
    } catch (e) {
      SnackbarHelper.showSnackbar(
        title: "Error",
        message: "Failed to delete transaction: $e",
        isError: true,
      );
    }
  }

  // Future<List<TransactionModel>> getTransactionofUser(String userid) async {
  //   try {
  //     final querySnapshot = await _firestore
  //         .collection('transactions')
  //         .where('userId', isEqualTo: userid)
  //         .get();

  //     var transaction = querySnapshot.docs
  //         .map((doc) => TransactionModel.fromMap(doc.data()))
  //         .toList();

  //     return transaction;
  //   } catch (e) {
  //     SnackbarHelper.showSnackbar(
  //       title: "Error",
  //       message: "Failed to fetch transactions: $e",
  //       isError: true,
  //     );
  //     return [];
  //   }
  // }
  Stream<List<TransactionModel>> getTransactionStream(String userId) {
    return _firestore
        .collection('transactions')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) =>
                TransactionModel.fromMap({...doc.data(), 'id': doc.id}))
            .toList());
  }
}
