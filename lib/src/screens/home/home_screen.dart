import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackit/src/comman/formats.dart';
import 'package:trackit/src/constants/color.dart';
import 'package:trackit/src/controllers/transcation_cottroller.dart';
import 'package:trackit/src/controllers/user_controller.dart';
import 'package:trackit/src/models/transaction_model.dart';
import 'package:trackit/src/screens/add_transaction/add_transaction.dart';
import 'package:trackit/src/screens/home/widgets/track_container.dart';
import 'package:trackit/src/screens/home/widgets/transactiontile.dart';
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
                          child: Text(
                            "Recent Transactions",
                            style: theme.textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Divider(),
                        SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.only(bottom: 85),
                            physics: BouncingScrollPhysics(),
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = transactions[index];
                              return Dismissible(
                                key: ValueKey(transaction),
                                onDismissed: (direction) async {
                                  try {
                                    final amt =
                                        double.tryParse(transaction.amount);
                                    if (amt == null) {
                                      SnackbarHelper.showSnackbar(
                                        title: "Error",
                                        message: "Invalid transaction amount",
                                        isError: true,
                                      );
                                      return;
                                    }
                                    final isIncome =
                                        transaction.type == TType.income;

                                    // First delete the transaction
                                    await transcationCottroller
                                        .deleteTransaction(transaction.id);

                                    // Then update the balance
                                    userController.updateBalance(
                                        amt, !isIncome);
                                  } catch (e) {
                                    SnackbarHelper.showSnackbar(
                                      title: "Error",
                                      message: "Failed to delete transaction",
                                      isError: true,
                                    );
                                  }
                                },
                                background: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.delete_outline, size: 30),
                                      Icon(Icons.delete_outline, size: 30),
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
}
