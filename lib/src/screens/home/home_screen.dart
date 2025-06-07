import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trackit/src/comman/formats.dart';
import 'package:trackit/src/constants/color.dart';
import 'package:trackit/src/controllers/transcation_cottroller.dart';
import 'package:trackit/src/controllers/user_controller.dart';
import 'package:trackit/src/models/transaction_model.dart';
import 'package:trackit/src/screens/add_transaction/add_transaction.dart';
import 'package:trackit/src/screens/home/widgets/track_container.dart';
import 'package:trackit/src/screens/home/widgets/transactiontile.dart';
import 'package:trackit/src/screens/home/widgets/tag_filter_buttons.dart';
import 'package:trackit/src/comman/showsnackbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final UserController userController = Get.put(UserController());
  final TranscationCottroller transcationCottroller =
      Get.put(TranscationCottroller());

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDark = brightness == Brightness.dark;
    final screenwidth = media.size.width;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.bottomLeft,
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  final user = userController.user.value;
                  return Text(
                    user != null ? "Hello, ${user.name} " : "Hello!",
                    style: theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  );
                }),
                SizedBox(height: 4),
                Text(
                  "Track your expenses, save smarter 💸",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(
        () {
          if (userController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final balance = userController.user.value?.balance ?? 0;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              spacing: 20,
              children: [
                TrackContainer(
                  isDark: isDark,
                  theme: theme,
                  title: "Total Balance",
                  value: '₹${formatCurrency(balance)}',
                ),
                Obx(() {
                  final total =
                      transcationCottroller.getIncomeAndExpenseTotals();
                  return Row(
                    spacing: 20,
                    children: [
                      Expanded(
                        child: TrackContainer(
                          isDark: isDark,
                          theme: theme,
                          title: "Income",
                          value: "+₹${formatCurrency(total['income'])}",
                          valuecolor: Colors.green,
                        ),
                      ),
                      Expanded(
                        child: TrackContainer(
                          isDark: isDark,
                          theme: theme,
                          title: "Expense",
                          value: "-₹${formatCurrency(total['expense'])}",
                          valuecolor: Colors.redAccent,
                        ),
                      ),
                    ],
                  );
                }),
                Expanded(
                  child: Obx(() {
                    final transactions = transcationCottroller.transactions;

                    if (transactions.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(height: 50),
                            Image(
                              image: AssetImage("assets/images/nothing.gif"),
                              color: isDark
                                  ? dPrimaryColor
                                  : dSecondaryColor.withOpacity(0.85),
                            ),
                            Text(
                              "No transactions add yet.",
                              style: theme.textTheme.bodyLarge!.copyWith(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 15),
                          child: TagFilterButtons(isDark: isDark),
                        ),
                        Divider(),
                        SizedBox(height: 10),
                        Expanded(
                          child: transcationCottroller
                                  .filteredTransactions.isEmpty
                              ? Center(
                                  child: Text(
                                    "No transactions",
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      fontSize: 20,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.only(bottom: 85),
                                  physics: BouncingScrollPhysics(),
                                  itemCount: transcationCottroller
                                      .filteredTransactions.length,
                                  itemBuilder: (context, index) {
                                    final transaction = transcationCottroller
                                        .filteredTransactions[index];
                                    return Dismissible(
                                      key: ValueKey(transaction),
                                      confirmDismiss: (direction) async {
                                        return await showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                title: Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .warning_amber_rounded,
                                                      color: Colors.redAccent,
                                                      size: 28,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      "Delete Transaction",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                content: SizedBox(
                                                  width: double.maxFinite,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Are you sure you want to delete this transaction?",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: isDark
                                                              ? Colors.white70
                                                              : Colors
                                                                  .grey[600],
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(12),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isDark
                                                              ? Colors.grey[800]
                                                              : Colors
                                                                  .grey[100],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            _buildInfoRow(
                                                                "Title",
                                                                transaction
                                                                    .title,
                                                                isDark: isDark),
                                                            SizedBox(height: 8),
                                                            _buildInfoRow(
                                                              "Amount",
                                                              "${transaction.type == TType.income ? '+' : '-'}₹${formatCurrency(transaction.amount)}",
                                                              valueColor: transaction
                                                                          .type ==
                                                                      TType
                                                                          .income
                                                                  ? Colors.green
                                                                  : Colors
                                                                      .redAccent,
                                                              isDark: isDark,
                                                            ),
                                                            SizedBox(height: 8),
                                                            _buildInfoRow(
                                                                "Category",
                                                                transaction
                                                                    .tag.name
                                                                    .toUpperCase(),
                                                                isDark: isDark),
                                                            SizedBox(height: 8),
                                                            _buildInfoRow(
                                                              "Date",
                                                              DateFormat(
                                                                      'dd MMM yyyy')
                                                                  .format(transaction
                                                                      .createdAt),
                                                              isDark: isDark,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, false);
                                                    },
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                        color: isDark
                                                            ? Colors.white70
                                                            : Colors.grey[600],
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      // Show loading dialog
                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                          content: Row(
                                                            children: [
                                                              CircularProgressIndicator(
                                                                color: isDark
                                                                    ? dPrimaryColor
                                                                    : dSecondaryColor,
                                                              ),
                                                              SizedBox(
                                                                  width: 20),
                                                              Text(
                                                                  "Deleting transaction..."),
                                                            ],
                                                          ),
                                                        ),
                                                      );

                                                      try {
                                                        final amt =
                                                            double.tryParse(
                                                                transaction
                                                                    .amount);
                                                        if (amt == null) {
                                                          Navigator.pop(
                                                              context); // Close loading dialog
                                                          SnackbarHelper
                                                              .showSnackbar(
                                                            title: "Error",
                                                            message:
                                                                "Invalid transaction amount",
                                                            isError: true,
                                                          );
                                                          return;
                                                        }
                                                        final isIncome =
                                                            transaction.type ==
                                                                TType.income;

                                                        await transcationCottroller
                                                            .deleteTransaction(
                                                                transaction.id);
                                                        userController
                                                            .updateBalance(
                                                                amt, !isIncome);

                                                        Navigator.pop(
                                                            context); // Close loading dialog
                                                        Navigator.pop(context,
                                                            true); // Close confirmation dialog
                                                      } catch (e) {
                                                        Navigator.pop(
                                                            context); // Close loading dialog
                                                        SnackbarHelper
                                                            .showSnackbar(
                                                          title: "Error",
                                                          message:
                                                              "Failed to delete transaction",
                                                          isError: true,
                                                        );
                                                      }
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.redAccent,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ) ??
                                            false;
                                      },
                                      onDismissed: (direction) {
                                        // The transaction is already deleted in the dialog
                                      },
                                      background: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25),
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.delete_outline,
                                                size: 30),
                                            Icon(Icons.delete_outline,
                                                size: 30),
                                          ],
                                        ),
                                      ),
                                      child: TransactionTile(
                                        isDark: isDark,
                                        transaction: transaction,
                                        screenwidth: screenwidth,
                                        theme: theme,
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddTransaction());
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value,
      {Color? valueColor, bool isDark = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? Colors.white70 : Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: valueColor ?? (isDark ? dPrimaryColor : dSecondaryColor),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
