import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackit/src/comman/formats.dart';
import 'package:trackit/src/constants/color.dart';
import 'package:trackit/src/models/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.isDark,
    required this.transaction,
    required this.screenwidth,
    required this.theme,
  });

  final bool isDark;
  final TransactionModel transaction;
  final double screenwidth;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 90,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isDark ? dSecondaryColor : dPrimaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isDark ? Color(0XFF101010) : Color(0xFFF0F0F0),
                  ),
                  child: Icon(
                    tagIcons[transaction.tag],
                    size: 28,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: screenwidth * 0.38,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        maxLines: 2,
                        transaction.title,
                        style: theme.textTheme.titleLarge!.copyWith(
                          fontSize: 21,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      AutoSizeText(
                        maxLines: 1,
                        transaction.tag.name.toUpperCase(),
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: screenwidth * 0.26,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        maxLines: 1,
                        "${transaction.type == TType.income ? '+' : '-'} ₹${formatCurrency(transaction.amount)}",
                        style: theme.textTheme.titleLarge!.copyWith(
                          fontSize: 23,
                          color: transaction.type == TType.income
                              ? Colors.green
                              : Colors.redAccent,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      AutoSizeText(
                        maxLines: 1,
                        DateFormat('dd-MM-yyyy').format(transaction.createdAt),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
