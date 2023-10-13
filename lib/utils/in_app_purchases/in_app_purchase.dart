// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:memo_neet/MVVM/viewmodels/User/user_view_model.dart';
import 'package:memo_neet/MVVM/views/plans/after_success.dart';
import 'package:memo_neet/utils/widgets/snackbar/show_snackbar.dart';
import 'package:provider/provider.dart';

class InAppPurchaseManager with ChangeNotifier {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];
  bool _isPurchaseLoading = false;
  get isPurchaseLoading => _isPurchaseLoading;

  List<ProductDetails> get products => _products;

  int expiryDateTime = 0;

  Future<void> initialize(BuildContext context) async {
    if (await _inAppPurchase.isAvailable()) {
      log("********************* Loading Products");
      await _loadProducts();
      _listenToPurchaseUpdated(context);
    }
  }

  Future<void> _loadProducts() async {
    Set<String> productIds = {'memoneetsub_1year'};
    ProductDetailsResponse productDetailsResponse =
        await _inAppPurchase.queryProductDetails(productIds);
    if (productDetailsResponse.error != null) {
      for (var element in productDetailsResponse.productDetails) {
        products.add(element);
      }
      log('Failed to fetch product details: ${productDetailsResponse.error}');
      return;
    }
    _products = productDetailsResponse.productDetails;
    log("saved products");
  }

  void _listenToPurchaseUpdated(BuildContext context) {
    _subscription = _inAppPurchase.purchaseStream.listen(
      (List<PurchaseDetails> purchases) {
        log("listening to purchase");
        _handlePurchaseUpdated(context, purchases);
      },
      onError: (error) {
        log('Purchase stream error: $error');
      },
      onDone: () {},
      cancelOnError: true,
    );
  }

  void _handlePurchaseUpdated(
      BuildContext context, List<PurchaseDetails> purchases) {
    for (PurchaseDetails purchase in purchases) {
      log("handling purchase");
      if (purchase.status == PurchaseStatus.purchased) {
        consumePurchase(context);
        _inAppPurchase.completePurchase(purchase);
        log("purchase successful");
        _isPurchaseLoading = false;
        notifyListeners();
      } else if (purchase.status == PurchaseStatus.error) {
        showSnackBar(
            context: context, message: 'Purchase error: ${purchase.error}');
        _inAppPurchase.completePurchase(purchase);
        log("purchase error");
        _isPurchaseLoading = false;
        notifyListeners();
      } else if (purchase.status == PurchaseStatus.pending) {
        showSnackBar(context: context, message: 'Purchasing...');
        log("purchase pending");
        _isPurchaseLoading = true;
        notifyListeners();
      } else if (purchase.status == PurchaseStatus.restored) {
        showSnackBar(
            context: context,
            message: "Only one purchase is allowed, please contact support");
        _isPurchaseLoading = false;
      }
      if (purchase.status != PurchaseStatus.pending) {
        _isPurchaseLoading = false;
        notifyListeners();
      }
      _inAppPurchase.completePurchase(purchase);
    }
  }

  void consumePurchase(BuildContext context) async {
    expiryDateTime = context.read<UserViewModel>().serverTime;
    String price = products[0].price;
    DatabaseReference paymentDetails = FirebaseDatabase.instance
        .ref("users/${FirebaseAuth.instance.currentUser!.uid}/payment_details");

    await paymentDetails.set(
      {"all_bcp": price, "datetime": expiryDateTime},
    ).then((value) {
      showSnackBar(context: context, message: "Purchase Successful");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  AfterPayment(data: {"price": price})));
    });
  }

  Future<void> buyProduct(BuildContext context, ProductDetails product) async {
    _isPurchaseLoading = true;
    notifyListeners();
    PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    try {
      await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      log(e.toString());
      showSnackBar(context: context, message: 'buyProduct error: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}
