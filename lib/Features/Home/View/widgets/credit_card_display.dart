import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/custom_card_type_icon.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:visit_egypt/Core/Shared/methods.dart';
import 'package:visit_egypt/Features/Home/Model/tourguide_trip.dart';
import 'package:visit_egypt/Features/Home/View/Cubit/trips_cubit.dart';

class CreditCardDisplay extends StatefulWidget {
  final String tripID, tourGuideID;
  final TripModel trip;
  const CreditCardDisplay(
      {required this.tourGuideID,
      required this.trip,
      required this.tripID,
      super.key});

  @override
  State<CreditCardDisplay> createState() => _CreditCardDisplayState();
}

class _CreditCardDisplayState extends State<CreditCardDisplay> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  void _onValidate() {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<TripsCubit>(context)
          .joinTrip(widget.tripID, widget.tourGuideID, widget.trip);
    } else {}
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CreditCardWidget(
        glassmorphismConfig:
            useGlassMorphism ? Glassmorphism.defaultConfig() : null,
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cardHolderName: cardHolderName,
        cvvCode: cvvCode,
        bankName: 'Visa',
        frontCardBorder:
            !useGlassMorphism ? Border.all(color: Colors.grey) : null,
        backCardBorder:
            !useGlassMorphism ? Border.all(color: Colors.grey) : null,
        showBackView: isCvvFocused,
        obscureCardNumber: true,
        obscureCardCvv: true,
        isHolderNameVisible: true,
        cardBgColor: const Color(0xff363636),
        backgroundImage: useBackgroundImage ? 'assets/card_bg.png' : null,
        isSwipeGestureEnabled: true,
        onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {
          print(creditCardBrand.brandName);
        },
        customCardTypeIcons: <CustomCardTypeIcon>[
          CustomCardTypeIcon(
            cardType: CardType.mastercard,
            cardImage: Image.asset(
              'assets/images/mastercard.png',
              height: 48,
              width: 48,
            ),
          ),
        ],
      ),
      Expanded(
          child: SingleChildScrollView(
              child: Column(
        children: <Widget>[
          CreditCardForm(
            onFormComplete: () {
              print('completed');
            },
            formKey: formKey,
            obscureCvv: true,
            obscureNumber: true,
            cardNumber: cardNumber,
            cvvCode: cvvCode,
            isHolderNameVisible: true,
            isCardNumberVisible: true,
            isExpiryDateVisible: true,
            cardHolderName: cardHolderName,
            expiryDate: expiryDate,
            themeColor: Colors.blue,
            textColor: Colors.white,
            cardNumberDecoration: InputDecoration(
              labelText: 'Number',
              hintText: 'XXXX XXXX XXXX XXXX',
              hintStyle: const TextStyle(color: Colors.white),
              labelStyle: const TextStyle(color: Colors.white),
              focusedBorder: border,
              enabledBorder: border,
            ),
            expiryDateDecoration: InputDecoration(
              hintStyle: const TextStyle(color: Colors.white),
              labelStyle: const TextStyle(color: Colors.white),
              focusedBorder: border,
              enabledBorder: border,
              labelText: 'Expired Date',
              hintText: 'XX/XX',
            ),
            cvvCodeDecoration: InputDecoration(
              hintStyle: const TextStyle(color: Colors.white),
              labelStyle: const TextStyle(color: Colors.white),
              focusedBorder: border,
              enabledBorder: border,
              labelText: 'CVV',
              hintText: 'XXX',
            ),
            cardHolderDecoration: InputDecoration(
              hintStyle: const TextStyle(color: Colors.white),
              labelStyle: const TextStyle(color: Colors.white),
              focusedBorder: border,
              enabledBorder: border,
              labelText: 'Card Holder',
            ),
            onCreditCardModelChange: onCreditCardModelChange,
          ),
          BlocConsumer<TripsCubit, TripsState>(
            listener: (context, state) {
              ConstantMethods.showContentToast(
                  context, 'You have joined the trip !');
              Navigator.pop(context);
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: _onValidate,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: <Color>[
                        Color(0xffB58D67),
                        Color(0xffB58D67),
                        Color(0xffE5D1B2),
                        Color(0xffF9EED2),
                        Color(0xffFFFFFD),
                        Color(0xffF9EED2),
                        Color(0xffB58D67),
                      ],
                      begin: Alignment(-1, -4),
                      end: Alignment(1, 4),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: state is JoinTripLoadingState
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : const Text(
                          'Validate',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            package: 'flutter_credit_card',
                          ),
                        ),
                ),
              );
            },
          )
        ],
      ))),
    ]);
  }
}
