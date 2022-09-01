import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:stipra/core/services/validator_service.dart';

import 'data/models/custom_credit_card_model.dart';

class CustomCreditCardForm extends StatefulWidget {
  const CustomCreditCardForm({
    Key? key,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cardIssuerName,
    required this.cvvCode,
    this.obscureCvv = false,
    this.obscureNumber = false,
    required this.onCreditCardModelChange,
    required this.themeColor,
    this.textColor = Colors.black,
    this.cursorColor,
    this.cardHolderDecoration = const InputDecoration(
      labelText: 'Card holder',
    ),
    this.cardIssuerDecoration = const InputDecoration(
      labelText: 'Card issuer',
    ),
    this.cardNumberDecoration = const InputDecoration(
      labelText: 'Card number',
      hintText: 'XXXX XXXX XXXX XXXX',
    ),
    this.expiryDateDecoration = const InputDecoration(
      labelText: 'Expired Date',
      hintText: 'MM/YY',
    ),
    this.cvvCodeDecoration = const InputDecoration(
      labelText: 'CVV',
      hintText: 'XXX',
    ),
    required this.formKey,
    this.cvvValidationMessage = 'Please input a valid CVV',
    this.dateValidationMessage = 'Please input a valid date',
    this.numberValidationMessage = 'Please input a valid number',
    this.isHolderNameVisible = true,
    this.isIssuerNameVisible = true,
    this.isCardNumberVisible = true,
    this.isExpiryDateVisible = true,
    this.autovalidateMode,
  }) : super(key: key);

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cardIssuerName;
  final String cvvCode;
  final String cvvValidationMessage;
  final String dateValidationMessage;
  final String numberValidationMessage;
  final void Function(CustomCreditCardModel) onCreditCardModelChange;
  final Color themeColor;
  final Color textColor;
  final Color? cursorColor;
  final bool obscureCvv;
  final bool obscureNumber;
  final bool isHolderNameVisible;
  final bool isIssuerNameVisible;
  final bool isCardNumberVisible;
  final bool isExpiryDateVisible;
  final GlobalKey<FormState> formKey;

  final InputDecoration cardNumberDecoration;
  final InputDecoration cardHolderDecoration;
  final InputDecoration cardIssuerDecoration;
  final InputDecoration expiryDateDecoration;
  final InputDecoration cvvCodeDecoration;
  final AutovalidateMode? autovalidateMode;

  @override
  _CustomCreditCardFormState createState() => _CustomCreditCardFormState();
}

class _CustomCreditCardFormState extends State<CustomCreditCardForm> {
  late String cardNumber;
  late String expiryDate;
  late String cardHolderName;
  late String cardIssuerName;
  late Color themeColor;

  late void Function(CustomCreditCardModel) onCreditCardModelChange;
  late CustomCreditCardModel creditCardModel;

  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cardIssuerNameController =
      TextEditingController();

  FocusNode expiryDateNode = FocusNode();
  FocusNode cardHolderNode = FocusNode();
  FocusNode cardIssuerNode = FocusNode();
  FocusNode cardNumberNode = FocusNode();

  void textFieldFocusDidChange() {
    onCreditCardModelChange(creditCardModel);
  }

  void createCreditCardModel() {
    cardNumber = widget.cardNumber;
    expiryDate = widget.expiryDate;
    cardHolderName = widget.cardHolderName;
    cardIssuerName = widget.cardIssuerName;

    creditCardModel = CustomCreditCardModel(
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cardIssuerName: cardIssuerName,
    );

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    createCreditCardModel();

    _cardNumberController.text = widget.cardNumber;
    _expiryDateController.text = widget.expiryDate;
    _cardHolderNameController.text = widget.cardHolderName;
    _cardIssuerNameController.text = widget.cardIssuerName;

    onCreditCardModelChange = widget.onCreditCardModelChange;

    _cardNumberController.addListener(() {
      setState(() {
        cardNumber = _cardNumberController.text;
        creditCardModel.cardNumber = cardNumber;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _expiryDateController.addListener(() {
      setState(() {
        expiryDate = _expiryDateController.text;
        creditCardModel.expiryDate = expiryDate;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cardHolderNameController.addListener(() {
      setState(() {
        cardHolderName = _cardHolderNameController.text;
        creditCardModel.cardHolderName = cardHolderName;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cardIssuerNameController.addListener(() {
      setState(() {
        cardIssuerName = _cardIssuerNameController.text;
        creditCardModel.cardIssuerName = cardIssuerName;
        onCreditCardModelChange(creditCardModel);
      });
    });
  }

  @override
  void didUpdateWidget(covariant CustomCreditCardForm oldWidget) {
    if (widget.cardNumber != oldWidget.cardNumber ||
        widget.cardHolderName != oldWidget.cardHolderName ||
        widget.cardIssuerName != oldWidget.cardIssuerName ||
        widget.expiryDate != oldWidget.expiryDate) {
      log('not same with old');
      createCreditCardModel();
      _cardNumberController.text = widget.cardNumber;
      _expiryDateController.text = widget.expiryDate;
      _cardHolderNameController.text = widget.cardHolderName;
      _cardIssuerNameController.text = widget.cardIssuerName;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    cardHolderNode.dispose();
    cardIssuerNode.dispose();
    cardNumberNode.dispose();
    expiryDateNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    themeColor = widget.themeColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: themeColor.withOpacity(0.8),
        primaryColorDark: themeColor,
      ),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: <Widget>[
            Visibility(
              visible: widget.isIssuerNameVisible,
              child: Container(
                padding: const EdgeInsets.only(bottom: 4.0),
                margin: const EdgeInsets.only(left: 16, top: 0, right: 16),
                child: TextFormField(
                  controller: _cardIssuerNameController,
                  cursorColor: widget.cursorColor ?? themeColor,
                  focusNode: cardIssuerNode,
                  style: TextStyle(
                    color: widget.textColor,
                  ),
                  decoration: widget.cardIssuerDecoration,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autofillHints: const <String>[AutofillHints.creditCardName],
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(cardNumberNode);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: ValidatorService().onlyRequired,
                ),
              ),
            ),
            Visibility(
              visible: widget.isCardNumberVisible,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
                child: TextFormField(
                  obscureText: widget.obscureNumber,
                  controller: _cardNumberController,
                  cursorColor: widget.cursorColor ?? themeColor,
                  focusNode: cardNumberNode,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(expiryDateNode);
                  },
                  style: TextStyle(
                    color: widget.textColor,
                  ),
                  decoration: widget.cardNumberDecoration,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  autofillHints: const <String>[AutofillHints.creditCardNumber],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    // Validate less that 13 digits +3 white spaces
                    if (value!.isEmpty) {
                      return ValidatorService().onlyRequired(value);
                    }
                    if (value.length < 12) {
                      return widget.numberValidationMessage;
                    }
                    return null;
                  },
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Visibility(
                  visible: widget.isExpiryDateVisible,
                  child: Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      margin:
                          const EdgeInsets.only(left: 16, top: 8, right: 16),
                      child: TextFormField(
                        controller: _expiryDateController,
                        cursorColor: widget.cursorColor ?? themeColor,
                        focusNode: expiryDateNode,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(cardHolderNode);
                        },
                        style: TextStyle(
                          color: widget.textColor,
                        ),
                        decoration: widget.expiryDateDecoration,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        autofillHints: const <String>[
                          AutofillHints.creditCardExpirationDate
                        ],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return ValidatorService().onlyRequired(value);
                          }
                          final DateTime now = DateTime.now();
                          final List<String> date = value.split(RegExp(r'/'));
                          final int month = int.parse(date.first);
                          final int year = int.parse('20${date.last}');
                          final DateTime cardDate = DateTime(year, month);

                          if (cardDate.isBefore(now) ||
                              month > 12 ||
                              month == 0) {
                            return widget.dateValidationMessage;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: widget.isHolderNameVisible,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
                child: TextFormField(
                  controller: _cardHolderNameController,
                  cursorColor: widget.cursorColor ?? themeColor,
                  focusNode: cardHolderNode,
                  style: TextStyle(
                    color: widget.textColor,
                  ),
                  decoration: widget.cardHolderDecoration,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  autofillHints: const <String>[AutofillHints.creditCardName],
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                    onCreditCardModelChange(creditCardModel);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: ValidatorService().onlyRequired,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
