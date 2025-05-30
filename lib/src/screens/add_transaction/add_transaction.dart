// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:trackit/src/constants/color.dart';
import 'package:trackit/src/controllers/transcation_cottroller.dart';
import 'package:trackit/src/controllers/user_controller.dart';
import 'package:trackit/src/models/transaction_model.dart';

class AddTransaction extends StatelessWidget {
  AddTransaction({
    Key? key,
  }) : super(key: key);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TranscationCottroller transcationCottroller =
      Get.put(TranscationCottroller());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final brightness = media.platformBrightness;
    final isDark = brightness == Brightness.dark;
    final screenHeignt = media.size.height;
    final screenWidth = media.size.width;

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Transaction",
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/add.png",
                  height: screenHeignt / 4,
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formkey,
                child: Column(
                  spacing: 20,
                  children: [
                    TextFormField(
                      controller: transcationCottroller.titlecontroller,
                      style:
                          theme.textTheme.headlineSmall!.copyWith(fontSize: 20),
                      decoration: InputDecoration(
                        label: Text(
                          "Title",
                          style: theme.textTheme.bodyLarge,
                        ),
                        prefixIcon: Icon(Icons.edit_note_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a valid title";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: transcationCottroller.amountcontroller,
                      keyboardType: TextInputType.number,
                      style:
                          theme.textTheme.headlineSmall!.copyWith(fontSize: 20),
                      decoration: InputDecoration(
                        label: Text(
                          "Amount",
                          style: theme.textTheme.bodyLarge,
                        ),
                        prefixIcon: Icon(Icons.currency_rupee_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a valid amount";
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Type:", style: theme.textTheme.bodyLarge),
                        Obx(
                          () => DropdownButton<TType>(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(12),
                            menuWidth: screenWidth * 0.40,
                            value: transcationCottroller.selectedType.value,
                            items: TType.values
                                .map(
                                  (type) => DropdownMenuItem(
                                    value: type,
                                    child: Row(
                                      children: [
                                        SizedBox(width: 5),
                                        Icon(
                                          type == TType.income
                                              ? Icons.arrow_downward
                                              : Icons.arrow_upward,
                                          color: type == TType.income
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          type.name.toUpperCase(),
                                          style: TextStyle(
                                            color: type == TType.income
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                transcationCottroller.selectedType(value);
                              }
                            },
                          ),
                        ),
                        Text("Tag:", style: theme.textTheme.bodyLarge),
                        Obx(
                          () => DropdownButton<Tag>(
                            borderRadius: BorderRadius.circular(12),
                            elevation: 1,
                            menuWidth: screenWidth * 0.40,
                            value: transcationCottroller.selectedTag.value,
                            items: Tag.values
                                .map(
                                  (tag) => DropdownMenuItem(
                                    value: tag,
                                    child: Row(
                                      children: [
                                        SizedBox(width: 5),
                                        Icon(
                                          tagIcons[tag],
                                        ),
                                        SizedBox(width: 15),
                                        Text(
                                          tag.name.toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                transcationCottroller.selectedTag(value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: transcationCottroller.notecontroller,
                      style:
                          theme.textTheme.headlineSmall!.copyWith(fontSize: 20),
                      decoration: InputDecoration(
                        label: Text(
                          "Note",
                          style: theme.textTheme.bodyLarge,
                        ),
                        prefixIcon: Icon(Icons.note_alt_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a valid note";
                        }
                        return null;
                      },
                    ),
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: transcationCottroller.isLoading.value
                              ? null
                              : () {
                                  if (_formkey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    transcationCottroller.addTransaction(
                                      transcationCottroller.titlecontroller.text
                                          .trim(),
                                      transcationCottroller
                                          .amountcontroller.text
                                          .trim(),
                                      transcationCottroller.notecontroller.text
                                          .trim(),
                                      userController.user.value!.id,
                                    );
                                    final amountText = transcationCottroller
                                        .amountcontroller.text
                                        .trim();
                                    final double? amt =
                                        double.tryParse(amountText);
                                    final isIncome =
                                        transcationCottroller.selectedType ==
                                            TType.income;
                                    userController.updateBalance(
                                        amt!, isIncome);
                                    Get.back();
                                  }
                                },
                          child: transcationCottroller.isLoading.value
                              ? CircularProgressIndicator(
                                  color:
                                      isDark ? dPrimaryColor : dSecondaryColor,
                                )
                              : Text(
                                  "Add".toUpperCase(),
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800,
                                    color: isDark
                                        ? dSecondaryColor
                                        : dPrimaryColor,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
