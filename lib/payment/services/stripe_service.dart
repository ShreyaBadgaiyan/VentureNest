// import 'package:dio/dio.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:ui/payment/consts.dart';

// class StripeService {
//   StripeService._();

//   static final StripeService instance = StripeService._();

//   Future<void> makePayment() async {
//     try {
//       String? paymentIntentClientSecret = await _createPaymentIntent(investmentAskController, "usd");
//       if (paymentIntentClientSecret == null) return;
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentIntentClientSecret,
//           merchantDisplayName: "Saamarth Sitholey",
//         ),
//       );
//       await _processPayment();
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<String?> _createPaymentIntent(int amount, String currency) async {
//     try {
//       final Dio dio = Dio();
//       Map<String, dynamic> data = {
//         "amount": _calculateAmount(amount),
//         "currency": currency,
//       };
//       var response = await dio.post(
//         "https://api.stripe.com/v1/payment_intents",
//         data: data,
//         options: Options(
//           contentType: Headers.formUrlEncodedContentType,
//           headers: {
//             "Authorization": "Bearer $stripeSecretKey",
//             "Content-Type": "application/x-www-form-urlencoded",
//           },
//         ),
//       );
//       if (response.data != null) {
//         return response.data["client_secret"];
//       }
//       return null;
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }

//   Future<void> _processPayment() async {
//     try {
//       await Stripe.instance.presentPaymentSheet();
//       await Stripe.instance.confirmPaymentSheetPayment();
//     } catch (e) {
//       print(e);
//     }
//   }

//   String _calculateAmount(int amount) {
//     final calculatedAmount = amount * 100;
//     return calculatedAmount.toString();
//   }
// }

// // import 'package:dio/dio.dart';
// // import 'package:flutter_stripe/flutter_stripe.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:ui/payment/consts.dart';

// // class StripeService {
// //   StripeService._();

// //   static final StripeService instance = StripeService._();

// //   Future<void> makePayment() async {
// //     try {
// //       final int? investmentAsk = await _fetchInvestmentAsk();
// //       if (investmentAsk == null) {
// //         print("Investment ask not found.");
// //         return;
// //       }

// //       String? paymentIntentClientSecret =
// //           await _createPaymentIntent(investmentAsk, "usd");
// //       if (paymentIntentClientSecret == null) return;

// //       await Stripe.instance.initPaymentSheet(
// //         paymentSheetParameters: SetupPaymentSheetParameters(
// //           paymentIntentClientSecret: paymentIntentClientSecret,
// //           merchantDisplayName: "Saamarth Sitholey",
// //         ),
// //       );

// //       await _processPayment();
// //     } catch (e) {
// //       print("Error in makePayment: $e");
// //     }
// //   }

// //   Future<int?> _fetchInvestmentAsk() async {
// //     try {
// //       final uid = FirebaseAuth.instance.currentUser!.uid;

// //       DocumentSnapshot doc = await FirebaseFirestore.instance
// //           .collection('companies')
// //           .doc(uid)
// //           .get();

// //       if (doc.exists && doc.data() != null) {
// //         final rawValue = doc.get('investmentAsk');

// //         // Convert to int if it's a string or already an int
// //         int investmentAsk;
// //         if (rawValue is int) {
// //           investmentAsk = rawValue;
// //         } else if (rawValue is String) {
// //           investmentAsk = int.tryParse(rawValue) ?? 0;
// //         } else {
// //           throw Exception("Unexpected type for investmentAsk");
// //         }

// //         print('Investment Ask from Firestore: $investmentAsk');
// //         return investmentAsk;
// //       } else {
// //         print('No company found for this user');
// //         return null;
// //       }
// //     } catch (e) {
// //       print("Error fetching investment ask: $e");
// //       return null;
// //     }
// //   }

// //   Future<String?> _createPaymentIntent(int amount, String currency) async {
// //     try {
// //       final Dio dio = Dio();
// //       Map<String, dynamic> data = {
// //         "amount": _calculateAmount(amount),
// //         "currency": currency,
// //       };
// //       var response = await dio.post(
// //         "https://api.stripe.com/v1/payment_intents",
// //         data: data,
// //         options: Options(
// //           contentType: Headers.formUrlEncodedContentType,
// //           headers: {
// //             "Authorization": "Bearer $stripeSecretKey",
// //             "Content-Type": "application/x-www-form-urlencoded",
// //           },
// //         ),
// //       );
// //       if (response.data != null) {
// //         return response.data["client_secret"];
// //       }
// //       return null;
// //     } catch (e) {
// //       print("Error creating payment intent: $e");
// //       return null;
// //     }
// //   }

// //   Future<void> _processPayment() async {
// //     try {
// //       await Stripe.instance.presentPaymentSheet();
// //       print("Payment completed successfully!");
// //     } catch (e) {
// //       print("Error during payment: $e");
// //     }
// //   }

// // import 'package:dio/dio.dart';
// // import 'package:flutter_stripe/flutter_stripe.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:ui/investor_screens/ifunded.dart';
// // import 'package:ui/payment/consts.dart';

// // class StripeService {
// //   StripeService._();

// //   static final StripeService instance = StripeService._();

// //   Future<void> makePayment({
// //     required BuildContext context,
// //     required Map<String, dynamic> companyData,
// //   }) async {
// //     try {
// //       final int investmentAsk =
// //           _parseInvestmentAsk(companyData['investmentAsk']);
// //       String? paymentIntentClientSecret =
// //           await _createPaymentIntent(investmentAsk, "usd");
// //       if (paymentIntentClientSecret == null) return;

// //       await Stripe.instance.initPaymentSheet(
// //         paymentSheetParameters: SetupPaymentSheetParameters(
// //           paymentIntentClientSecret: paymentIntentClientSecret,
// //           merchantDisplayName: "VentureNest",
// //         ),
// //       );

// //       await _processPayment();

// //       // Save Investment & Update Company Status
// //       await _handlePostPayment(companyData);

// //       // Redirect Investor to My Investments
// //       Navigator.pushAndRemoveUntil(
// //         context,
// //         MaterialPageRoute(builder: (_) => const MyInvestmentsScreen()),
// //         (route) => false,
// //       );
// //     } catch (e) {
// //       print("Payment Error: $e");
// //       ScaffoldMessenger.of(context)
// //           .showSnackBar(SnackBar(content: Text("Payment failed: $e")));
// //     }
// //   }

// //   int _parseInvestmentAsk(dynamic value) {
// //     if (value is int) return value;
// //     if (value is String) return int.tryParse(value) ?? 0;
// //     return 0;
// //   }

// //   Future<void> _handlePostPayment(Map<String, dynamic> companyData) async {
// //     final investorId = FirebaseAuth.instance.currentUser!.uid;
// //     final companyId = companyData['companyId'];

// //     // Save Full Company Details under investor
// //     await FirebaseFirestore.instance
// //         .collection('investors')
// //         .doc(investorId)
// //         .collection('investments')
// //         .doc(companyId)
// //         .set({
// //       'companyId': companyId,
// //       'companyName': companyData['companyName'],
// //       'industry': companyData['industry'],
// //       'equityOffered': companyData['equityOffered'],
// //       'investmentAsk': companyData['investmentAsk'],
// //       'timestamp': FieldValue.serverTimestamp(),
// //     });

// //     // Mark Company as Acquired
// //     await FirebaseFirestore.instance
// //         .collection('companies')
// //         .doc(companyId)
// //         .update({'investmentAcquired': true});
// //   }

// //   Future<String?> _createPaymentIntent(int amount, String currency) async {
// //     try {
// //       final Dio dio = Dio();
// //       final data = {"amount": _calculateAmount(amount), "currency": currency};

// //       var response = await dio.post(
// //         "https://api.stripe.com/v1/payment_intents",
// //         data: data,
// //         options: Options(
// //           contentType: Headers.formUrlEncodedContentType,
// //           headers: {
// //             "Authorization": "Bearer $stripeSecretKey",
// //             "Content-Type": "application/x-www-form-urlencoded",
// //           },
// //         ),
// //       );
// //       return response.data?["client_secret"];
// //     } catch (e) {
// //       print("Create PaymentIntent Error: $e");
// //       return null;
// //     }
// //   }

// //   Future<void> _processPayment() async {
// //     await Stripe.instance.presentPaymentSheet();
// //     print("Payment Success!");
// //   }

// //   String _calculateAmount(int amount) => (amount * 100).toString();
// // }

// import 'package:dio/dio.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ui/payment/consts.dart';

// class StripeService {
//   StripeService._();

//   static final StripeService instance = StripeService._();

//   Future<void> makePayment() async {
//     try {
//       final int? investmentAsk = await _fetchInvestmentAsk();
//       if (investmentAsk == null) {
//         print("Investment ask not found.");
//         return;
//       }

//       String? paymentIntentClientSecret =
//           await _createPaymentIntent(investmentAsk, "usd");
//       if (paymentIntentClientSecret == null) return;

//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentIntentClientSecret,
//           merchantDisplayName: "Saamarth Sitholey",
//         ),
//       );

//       await _processPayment();
//     } catch (e) {
//       print("Error in makePayment: $e");
//     }
//   }

//   // Future<int?> _fetchInvestmentAsk() async {
//   //   try {
//   //     final uid = FirebaseAuth.instance.currentUser!.uid;

//   //     DocumentSnapshot doc = await FirebaseFirestore.instance
//   //         .collection('companies')
//   //         .doc(uid)
//   //         .get();

//   //     if (doc.exists && doc.data() != null) {
//   //       final investmentAsk = doc.get('investmentAsk');
//   //       print('Investment Ask from Firestore: $investmentAsk');
//   //       return investmentAsk;
//   //     } else {
//   //       print('No company found for this user');
//   //       return null;
//   //     }
//   //   } catch (e) {
//   //     print("Error fetching investment ask: $e");
//   //     return null;
//   //   }
//   // }

//   Future<int?> _fetchInvestmentAsk() async {
//     try {
//       final uid = FirebaseAuth.instance.currentUser!.uid;

//       DocumentSnapshot doc = await FirebaseFirestore.instance
//           .collection('companies')
//           .doc(uid)
//           .get();

//       if (doc.exists && doc.data() != null) {
//         final rawValue = doc.get('investmentAsk');

//         // Convert to int if it's a string or already an int
//         int investmentAsk;
//         if (rawValue is int) {
//           investmentAsk = rawValue;
//         } else if (rawValue is String) {
//           investmentAsk = int.tryParse(rawValue) ?? 0;
//         } else {
//           throw Exception("Unexpected type for investmentAsk");
//         }

//         print('Investment Ask from Firestore: $investmentAsk');
//         return investmentAsk;
//       } else {
//         print('No company found for this user');
//         return null;
//       }
//     } catch (e) {
//       print("Error fetching investment ask: $e");
//       return null;
//     }
//   }

//   Future<String?> _createPaymentIntent(int amount, String currency) async {
//     try {
//       final Dio dio = Dio();
//       Map<String, dynamic> data = {
//         "amount": _calculateAmount(amount),
//         "currency": currency,
//       };
//       var response = await dio.post(
//         "https://api.stripe.com/v1/payment_intents",
//         data: data,
//         options: Options(
//           contentType: Headers.formUrlEncodedContentType,
//           headers: {
//             "Authorization": "Bearer $stripeSecretKey",
//             "Content-Type": "application/x-www-form-urlencoded",
//           },
//         ),
//       );
//       if (response.data != null) {
//         return response.data["client_secret"];
//       }
//       return null;
//     } catch (e) {
//       print("Error creating payment intent: $e");
//       return null;
//     }
//   }

//   Future<void> _processPayment() async {
//     try {
//       await Stripe.instance.presentPaymentSheet();
//       print("Payment completed successfully!");
//     } catch (e) {
//       print("Error during payment: $e");
//     }
//   }

//   String _calculateAmount(int amount) {
//     final calculatedAmount = amount * 100; // Stripe expects amount in cents
//     return calculatedAmount.toString();
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui/investor_screens/ifunded.dart';
import 'package:ui/payment/consts.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayment({
    required BuildContext context,
    required Map<String, dynamic> companyData,
  }) async {
    try {
      final int investmentAsk =
          _parseInvestmentAsk(companyData['investmentAsk']);

      // 1. Create payment intent with Stripe
      String? paymentIntentClientSecret =
          await _createPaymentIntent(investmentAsk, "usd");
      if (paymentIntentClientSecret == null) return;

      // 2. Initialize payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "VentureNest",
        ),
      );

      // 3. Process payment
      await _processPayment();

      // 4. Post-payment actions (Save investment & mark acquired)
      await _handlePostPayment(companyData);

      // 5. Redirect to "My Investments" screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const InvestmentDoneScreen()),
        (route) => false,
      );
    } catch (e) {
      print("Payment Error: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Payment failed: $e")));
    }
  }

  // Convert investmentAsk to int
  int _parseInvestmentAsk(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  // Save investment record & mark company as acquired
  Future<void> _handlePostPayment(Map<String, dynamic> companyData) async {
    final investorId = FirebaseAuth.instance.currentUser!.uid;
    final companyId = companyData['companyId'];

    // Save Investment under investor's record
    await FirebaseFirestore.instance
        .collection('investors')
        .doc(investorId)
        .collection('investments')
        .doc(companyId)
        .set({
      'companyId': companyId,
      'companyName': companyData['companyName'],
      'industry': companyData['industry'],
      'equityOffered': companyData['equityOffered'],
      'investmentAsk': companyData['investmentAsk'],
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Mark Company as Investment Acquired
    await FirebaseFirestore.instance
        .collection('companies')
        .doc(companyId)
        .update({'investmentAcquired': true});
  }

  // Create Stripe PaymentIntent
  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };

      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.data != null) {
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      print("Error creating payment intent: $e");
      return null;
    }
  }

  // Present Payment Sheet UI
  Future<void> _processPayment() async {
    await Stripe.instance.presentPaymentSheet();
    print("Payment completed successfully!");
  }

  // Convert amount to cents
  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100; // Stripe uses cents
    return calculatedAmount.toString();
  }
}
