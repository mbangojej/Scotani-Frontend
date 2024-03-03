import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/Widgets/SuccessfulOrderBottomSheet.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Models/MDCartModal.dart';
import 'package:skincanvas/Models/MDCheckoutModal.dart';
import 'package:skincanvas/Models/MDErrorModal.dart';
import 'package:skincanvas/Models/MDOrderDetailModal.dart';
import 'package:skincanvas/Models/MDOrderModal.dart';
import 'package:skincanvas/Models/MDVariationModal.dart';
import 'package:skincanvas/Models/MDWishListModal.dart';
import 'package:skincanvas/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Services/OrdersCheckoutWishlistServices.dart';

class OrderCheckOutWishlistController with ChangeNotifier {
  var homeWatch =
      Provider.of<HomeController>(navigatorkey.currentContext!, listen: false);

  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);

  MDErrorModal mdErrorModal = MDErrorModal();
  MDWishListModal mdWishListModal = MDWishListModal();
  MDOrderModal mdOrderModal = MDOrderModal();
  MDOrderDetailModal mdOrderDetailModal = MDOrderDetailModal();
  MDCartModal mdCartModal = MDCartModal(status: 0, message: '', cart: [
    Cart(
        subTotal: 0,
        grandTotal: 0,
        sId: null,
        customer: '',
        discountTotal: 0,
        isCheckout: false,
        nonSystemProducts: [NonSystemProducts(productId: '', variationId: '')],
        promotionId: null,
        systemProducts: [],
        taxTotal: 0,
        vatPercentage: 0)
  ]);

  MDCheckoutModal mdCheckoutModal = MDCheckoutModal();

  List<Wishlist> wishItemList = [];

  List<Orders> ordersList = [];
  int orderPage = 1;
  int orderSearchPage = 1;

  var utils = AppUtils();
  var themeColor = ThemeColors();
  var static = Statics();
  var routes = Routes();

  ///............... Place Order Screen.............///

  bool isExpand = false;
  bool isExpandDesignImprint = false;

  List<bool> placeOrderTattooBodySelection = [];

  bool isDecrement = false;
  bool isIncrement = false;

  List<bool> placeOrderSelectedImageList = [];
  int placeOrderSelectedImageIndex = 0;
  List<MDVariationData> listOfVariation = [];

  bool buttonLoading = false;

  bool canCouponApply = false;
  double discountAmount = 0.0;

  String selectedSize = "";
  String selectedColor = "";
  late String _variationId = "";
  late String _prodVariId = "";

  void resetQty() {
    listOfVariation.clear();
    selectedColor = "";
    selectedSize = "";
  }

  void selectColor(String color) {
    selectedColor = color;

    notifyListeners();
  }

  void selectSize(size) {
    selectedSize = size;
    notifyListeners();
  }

  void incrementVariationQty(price, productId) {
    _variationId = "${selectedColor}${selectedSize}";
    _prodVariId =
        "${homeWatch.mdProductDetailModal.data?.productID.toString()}${_variationId}";

    int ind = listOfVariation.indexWhere((elm) =>
        elm.prodVariId == _prodVariId && elm.variationId == _variationId);

    if (ind != -1) {
      listOfVariation[ind].variationQuantity =
          (listOfVariation[ind].variationQuantity! + 1);
    } else {
      listOfVariation.add(
        MDVariationData(
          productId: homeWatch.mdProductDetailModal.data!.productID,
          prodVariId: _prodVariId,
          price: price,
          variationId: _variationId,
          color: selectedColor,
          size: selectedSize,
          variationQuantity: 1,
        ),
      );
    }

    notifyListeners();
  }

  void decrementVariationQty() {
    _variationId = "${selectedColor}${selectedSize}";
    _prodVariId =
        "${homeWatch.mdProductDetailModal.data?.productID.toString()}${_variationId}";
    int ind = listOfVariation.indexWhere((elm) =>
        elm.prodVariId == _prodVariId && elm.variationId == _variationId);

    if (ind != -1) {
      if (listOfVariation[ind].variationQuantity! > 0) {
        listOfVariation[ind].variationQuantity =
            (listOfVariation[ind].variationQuantity! - 1);
      }
    }
    notifyListeners();
  }

  void removeVariationQty(colorCode) {
    if (colorCode == "") {
      int index = listOfVariation.indexWhere((element) =>
          element.productId == homeWatch.mdProductDetailModal.data!.productID);
      if (index != -1) {
        listOfVariation.removeAt(index);
      }
    } else {
      _variationId = "${colorCode.substring(1, 7)}${selectedSize}";
      _prodVariId =
          "${homeWatch.mdProductDetailModal.data?.productID.toString()}${_variationId}";

      int ind = listOfVariation.indexWhere((el) {
        return el.prodVariId == _prodVariId;
      });

      if (ind != -1) {
        listOfVariation.removeAt(ind);
      }
    }

    notifyListeners();
  }

  String variationQuantityText() {
    _variationId = "${selectedColor}${selectedSize}";
    _prodVariId =
        "${homeWatch.mdProductDetailModal.data?.productID.toString()}${_variationId}";
    if (listOfVariation.length > 0) {
      int ind = listOfVariation
          .indexWhere((element) => element.prodVariId == _prodVariId);
      if (ind != -1) {
        return listOfVariation[ind].variationQuantity.toString();
      } else {
        return "0";
      }
    } else {
      return "0";
    }
  }

  canCouponApplyUpdate({value = false}) {
    canCouponApply = value;
    notifyListeners();
  }

  updateSubtotal({isFromRemove = false}) {
    if (isFromRemove) {
      isFromOrderDetail
          ? mdOrderDetailModal.order!.first.orderPrice =
              mdOrderDetailModal.order!.first.orderPrice! + discountAmount
          : mdCartModal.cart!.first.subTotal =
              mdCartModal.cart!.first.subTotal!.toDouble() + discountAmount;

      discountAmount = 0.0;
    } else {
      print("Func Run");
      isFromOrderDetail
          ? mdOrderDetailModal.order!.first.orderPrice =
              mdOrderDetailModal.order!.first.orderPrice! - discountAmount
          : mdCartModal.cart!.first.subTotal =
              mdCartModal.cart!.first.subTotal!.toDouble() - discountAmount;

      // print('Subtotal Value ${mdCartModal.cart!.first.subTotal}');
    }

    notifyListeners();
  }

  discountAmountUpdate({value = 0.0}) async {
    // SharedPreferences myPrefs = await SharedPreferences.getInstance();
    discountAmount = value;

    // myPrefs.setString(Statics().discountCouponString, couponCodeController.text);
    // print("The discount Amouunt is: $discountAmount");

    await updateSubtotal();

    notifyListeners();
  }

  buttonLoadingUpdate({value = false}) {
    buttonLoading = value;

    print("button loading Value ${value}");
    notifyListeners();
  }

  // updateIsProductScreen({value}) {
  //   isProductScreen = value;
  //   notifyListeners();
  // }

  updateIsExpand() {
    isExpand = !isExpand;
    print("isExpand");
    notifyListeners();
  }

  updateIsExpandDesignImprint({value, isBackButton = false}) {
    if (isBackButton) {
      isExpandDesignImprint = false;
    } else {
      isExpandDesignImprint = value;
    }
    print("isExpand");
    notifyListeners();
  }

  placeOrderBodySelectionInitialize() {
    placeOrderTattooBodySelection.clear();
    for (int i = 0; i < 8; i++) placeOrderTattooBodySelection.add(false);
    notifyListeners();
  }

  placeOrderBodySelectionUpdate({index}) {
    for (int i = 0; i < placeOrderTattooBodySelection.length; i++) {
      placeOrderTattooBodySelection[i] =
          (i == index) ? !placeOrderTattooBodySelection[i] : false;
    }
    notifyListeners();
  }

  updateDecrementAndIncrement({
    decrement = false,
    increment = false,
  }) {
    isDecrement = decrement;
    isIncrement = increment;

    print("The quantity is" +
        homeWatch.placeOrderDataList[placeOrderSelectedImageIndex].quantity
            .toString());
    print("The price is" +
        homeWatch.placeOrderDataList[placeOrderSelectedImageIndex].productPrice
            .toString());

    if (isDecrement) {
      if (homeWatch.placeOrderDataList[placeOrderSelectedImageIndex].quantity!
              .toInt() >
          1) {
        homeWatch.placeOrderDataList[placeOrderSelectedImageIndex].quantity =
            homeWatch.placeOrderDataList[placeOrderSelectedImageIndex].quantity!
                    .toInt() -
                1;
        homeWatch.placeOrderDataList[placeOrderSelectedImageIndex]
            .productPrice = homeWatch
                .placeOrderDataList[placeOrderSelectedImageIndex].productPrice!
                .toDouble() -
            homeWatch
                .tattoosPriceListAndData[placeOrderSelectedImageIndex].price!
                .toDouble();
      }
    } else if (isIncrement) {
      homeWatch.placeOrderDataList[placeOrderSelectedImageIndex].quantity =
          homeWatch.placeOrderDataList[placeOrderSelectedImageIndex].quantity!
                  .toInt() +
              1;
      homeWatch.placeOrderDataList[placeOrderSelectedImageIndex].productPrice =
          homeWatch.placeOrderDataList[placeOrderSelectedImageIndex]
                  .productPrice!
                  .toDouble() +
              homeWatch
                  .tattoosPriceListAndData[placeOrderSelectedImageIndex].price!
                  .toDouble();
    }

    print("The new quantity is" +
        homeWatch.placeOrderDataList[placeOrderSelectedImageIndex].quantity
            .toString());
    print("The new price is" +
        homeWatch.placeOrderDataList[placeOrderSelectedImageIndex].productPrice
            .toString());

    notifyListeners();
  }

  placeOrderSelectedImageUpdate({index = 0}) {
    placeOrderSelectedImageList.clear();
    placeOrderSelectedImageIndex = index;

    for (int i = 0; i < 3; i++)
      if (i == index) {
        placeOrderSelectedImageList.add(true);
      } else {
        placeOrderSelectedImageList.add(false);
      }

    print("The list is" + placeOrderSelectedImageList.toString());

    notifyListeners();
  }

  ///........................ Cart Screen ..............................................///

  bool onCartFromHome = false;

  int quantityOfCartProduct = 0;
  List<bool> cartProductListSelection = [];

  List<int> quantityList = [];
  List<SystemProducts> listOfSystemProducts = [];
  List<NonSystemProducts> listOfNonSystemProductsTattoo = [];

  List<NonSystemProducts> listOfNonSystemProductsProduct = [];

  List<NonSystemProducts> listOfNonSystemWholeProduct = [];
  List<SystemProducts> listOfNonSystemWholeTattos = [];

  List<bool> systemProductListStatus = [];
  List<bool> nonSystemProductListStatus = [];
  List<String> systemProductListDeleteIDs = [];

  List<String> nonSystemProductTattoosListDeleteIDs = [];
  List<String> nonSystemProductProductsListDeleteIDs = [];

  bool isFromOrderDetail = false;
  String orderStatus = '';
  String orderID = '';
  bool isBack = false;

  onCartFromHomeUpdate({value = false}) {
    onCartFromHome = value;
    notifyListeners();
  }

  orderStatusUpdate({status = '', ID, backToNavigate = false}) {
    orderStatus = status;
    orderID = ID;
    isBack = backToNavigate;
    print("isBack Value ${backToNavigate}");
    print("ordersda status ${orderStatus}");
    notifyListeners();
  }

  productQuantityCartUpdate({type = 0}) {
    if (type == 0) {
      quantityOfCartProduct = 0;
      for (int i = 0; i < listOfSystemProducts.length; i++) {
        quantityOfCartProduct =
            quantityOfCartProduct + listOfSystemProducts[i].quantity!.toInt();
      }

      //.................... For Product .................//
      for (int i = 0; i < listOfNonSystemWholeProduct.length; i++) {
        quantityOfCartProduct = quantityOfCartProduct +
            listOfNonSystemWholeProduct[i].quantity!.toInt();
      }

      //...................... For Tattoo ..................//
      for (int i = 0; i < listOfNonSystemProductsProduct.length; i++) {
        quantityOfCartProduct = quantityOfCartProduct +
            listOfNonSystemProductsProduct[i].quantity!.toInt();
      }
    } else {
      quantityOfCartProduct = quantityOfCartProduct + 1;
    }

    notifyListeners();
  }

  routeFromOrderDetailUpdate({value}) {
    isFromOrderDetail = value;

    notifyListeners();
  }

  cartProductListSelectionInitialize(
      {systemProductLength, nonSystemLengthProduct}) async {
    systemProductListStatus.clear();
    nonSystemProductListStatus.clear();

    systemProductListDeleteIDs.clear();
    nonSystemProductTattoosListDeleteIDs.clear();
    nonSystemProductProductsListDeleteIDs.clear();

    for (int i = 0; i < systemProductLength; i++)
      systemProductListStatus.add(false);

    for (int i = 0; i < nonSystemLengthProduct; i++)
      nonSystemProductListStatus.add(false);

    notifyListeners();
  }

  systemProductCartDeleteListUpdate({index, id, type = 0}) async {
    print("The type is" + type.toString());
    systemProductListStatus[index] = !systemProductListStatus[index];

    // if (type.toString() == '0') {
    //   if (!systemProductListStatus[index]) {
    //     if (systemProductListDeleteIDs.contains(id)) {
    //       systemProductListDeleteIDs.remove(id);
    //     }
    //   } else if (systemProductListStatus[index]) {
    //     if (!systemProductListDeleteIDs.contains(id)) {
    //       systemProductListDeleteIDs.add(id);
    //     }
    //   }
    // }
    //
    // else {
    //   if (!systemProductListStatus[index]) {
    //     if (nonSystemProductListDeleteIDs.contains(id)) {
    //       nonSystemProductListDeleteIDs.remove(id);
    //     }
    //   } else if (systemProductListStatus[index]) {
    //     if (!nonSystemProductListDeleteIDs.contains(id)) {
    //       nonSystemProductListDeleteIDs.add(id);
    //     }
    //   }
    // }

    if (type.toString() == '0') {
      if (!systemProductListStatus[index]) {
        if (systemProductListDeleteIDs.contains(id)) {
          systemProductListDeleteIDs.remove(id);
        }
      } else if (systemProductListStatus[index]) {
        if (!systemProductListDeleteIDs.contains(id)) {
          systemProductListDeleteIDs.add(id);
        }
      }
    } else {
      if (!systemProductListStatus[index]) {
        if (nonSystemProductTattoosListDeleteIDs.contains(id)) {
          nonSystemProductTattoosListDeleteIDs.remove(id);
        }
      } else if (systemProductListStatus[index]) {
        if (!nonSystemProductTattoosListDeleteIDs.contains(id)) {
          nonSystemProductTattoosListDeleteIDs.add(id);
        }
      }
    }

    print(
        "The list of systemPRoduct is" + systemProductListDeleteIDs.toString());
    print("The list of non system Tattos is" +
        nonSystemProductTattoosListDeleteIDs.toString());

    notifyListeners();
  }

  nonSystemProductCartDeleteListUpdate({index, id}) async {
    nonSystemProductListStatus[index] = !nonSystemProductListStatus[index];

    if (!nonSystemProductListStatus[index]) {
      if (nonSystemProductProductsListDeleteIDs.contains(id)) {
        nonSystemProductProductsListDeleteIDs.remove(id);
      }
    } else if (nonSystemProductListStatus[index]) {
      if (!nonSystemProductProductsListDeleteIDs.contains(id)) {
        nonSystemProductProductsListDeleteIDs.add(id);
      }
    }

    print("The list of nonSystem product is" +
        nonSystemProductProductsListDeleteIDs.toString());
    notifyListeners();
  }

  cartProductListSelectionUpdate({index}) {
    cartProductListSelection[index] =
        (index == index) ? !cartProductListSelection[index] : false;
    notifyListeners();
  }

  quantityListSelectionUpdate({index, isDecrement, isIncrement}) {
    if (isDecrement) {
      if (quantityList[index] > 1) {
        quantityList[index] -= 1;
      }
    } else if (isIncrement) {
      quantityList[index] += 1;
    }
    notifyListeners();
  }

  cartQuantityAndPriceUpdate({index, isDecrement, isIncrement}) {
    if (isDecrement) {
      if (quantityList[index] > 1) {
        quantityList[index] -= 1;
      }
    } else if (isIncrement) {
      quantityList[index] += 1;
    }
    notifyListeners();
  }

  ///................................. Check Out Screen ...................................///

  TextEditingController couponCodeController = TextEditingController();

  // updateRadioButton({value, stripeValue=false, googleAndApplePayValue=false,paypalValue=false}) {
  //   isStripeSelected = value;
  //
  //   stripe = stripeValue;
  //   googleAndApplePay = googleAndApplePayValue;
  //   payPal = paypalValue;
  //   notifyListeners();
  // }

  bool stripe = true;
  bool googleAndApplePay = false;
  bool payPal = false;

  updateRadioButton({stripePay = false, googlePay = false, paypal = false}) {
    stripe = stripePay;
    googleAndApplePay = googlePay;
    payPal = paypal;

    notifyListeners();
  }

  ///........................... For Web View Paypal .......................///

  WebViewController? controller;
  bool isShow = true;
  String PayPalRequestId = '';
  String accessToken = '', payerId = '', token = '', OrderID = '';
  bool isShowOverlyLayout = false;

  updateController({value}) {
    controller = value;

    print("controller ${controller}");
    notifyListeners();
  }

  void showProgressDialog(bool isShow) {
    this.isShow = isShow;
    notifyListeners();
  }

  updatePayPalRequestId({value}) {
    PayPalRequestId = '';
    PayPalRequestId = value;
    notifyListeners();
  }

  updateIsShowOverlyLayout({value}) {
    isShowOverlyLayout = value;
    if (value == false) {
      controller = null;
    }
    notifyListeners();
  }

  updateAccestoken({value}) {
    accessToken = value;
    notifyListeners();
  }

  updatePayerId({value}) {
    payerId = value;
    notifyListeners();
  }

  updateToken({value}) {
    token = value;
    notifyListeners();
  }

  updateOrderId({value}) {
    OrderID = value;
    notifyListeners();
  }

  ///............................. Order Fragment............................///

  TextEditingController searchOrderController = TextEditingController();

  bool isLoadingOrderList = false;

  orderSearchPageUpdate({value}) {
    orderSearchPage = value;
    notifyListeners();
  }

  updateIsLoadingOrderList({value}) {
    isLoadingOrderList = value;

    print("Update Func");
    notifyListeners();
  }

  ///............................ Order Detail Screen .........................///

  int indexForOrderDetailImages = 0;

  List<String> combineImagesList = [];

  indexForOrderDetailImageUpdate({index = 0}) {
    indexForOrderDetailImages = index;
    notifyListeners();
  }

  ///............................ EditTattooAndProduct Screen ....................///

  bool isFromTattoo = false;

  updateIsFromTattoo({value}) {
    isFromTattoo = value;
    notifyListeners();
  }

  /// ............................... Create Product Screen .........................///

  TextEditingController productDesireTextController = TextEditingController();

  TextEditingController productDesirePromptController = TextEditingController();

  bool isShowGraphicsContainer = false;
  List<bool> selectGraphics = [];

  updateIsShowGraphicsContainer({isBackButton = false}) {
    if (isBackButton) {
      isShowGraphicsContainer = false;
    } else {
      isShowGraphicsContainer = !isShowGraphicsContainer;
    }
    notifyListeners();
  }

  selectGraphicsStatusInitialize() {
    selectGraphics.clear();
    for (int i = 0; i < 3; i++) selectGraphics.add(false);

    for (int i = 0; i < 3; i++)
      print("selectGraphicsStatus ${selectGraphics[i]}");
    notifyListeners();
  }

  selectGraphicsStatusUpdate({index}) {
    for (int i = 0; i < selectGraphics.length; i++) {
      selectGraphics[i] = (i == index) ? !selectGraphics[i] : false;
    }

    print('Status ${selectGraphics[index]}');
    notifyListeners();
  }

  //................... Apis...................//

  wishListApi(context, {isLoading = true}) async {
    var apis = OrdersCheckoutWishlistServices();

    generalWatch.updateRestrictUserNavigation(value: true);
    if (isLoading) EasyLoading.show(status: 'Getting Wishlist');

    var response = await apis.wishList();
    print('The WishList  Api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        wishItemList.clear();
        mdWishListModal = MDWishListModal.fromJson(response);
        wishItemList.addAll(mdWishListModal.wishlist!.toList());

        if (isLoading)
          utils.apiResponseToast(message: 'Get WishList Successfully');
        if (wishItemList.isNotEmpty) {
          Navigator.pushNamed(context, routes.myWishListScreenRoute);
        } else {
          EasyLoading.showToast('Sorry your wishlist is empty',
              dismissOnTap: true,
              duration: Duration(seconds: 3),
              toastPosition: EasyLoadingToastPosition.bottom);
        }
        generalWatch.updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 3),
            toastPosition: EasyLoadingToastPosition.bottom);
        generalWatch.updateRestrictUserNavigation();

        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 3),
          toastPosition: EasyLoadingToastPosition.bottom);
      generalWatch.updateRestrictUserNavigation();

      return false;
    }
  }

  makeAndRemoveWishListApi(context, {productID = 0, status = false}) async {
    var apis = OrdersCheckoutWishlistServices();

    generalWatch.updateRestrictUserNavigation(value: true);
    if (status)
      EasyLoading.show(status: 'Adding into Wishlist');
    else
      EasyLoading.show(status: 'Removing from Wishlist');

    var data = {
      "productId": "$productID",
    };

    print('The data is:' + data.toString());

    var response = await apis.makeAndRemoveWishList(data: data);
    print('The WishList  Api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        await await homeWatch.favouriteProductUpdator(id: productID);

        if (status) {
          utils.apiResponseToast(
              message: 'Product successfully added into wishlist');
        } else {
          utils.apiResponseToast(
              message: 'Product successfully removed from wishlist');
          wishItemList.removeWhere((wishlist) =>
              wishlist.productId.toString() == productID.toString());
        }

        EasyLoading.dismiss();

        generalWatch.updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 3),
            toastPosition: EasyLoadingToastPosition.bottom);
        generalWatch.updateRestrictUserNavigation();
        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 3),
          toastPosition: EasyLoadingToastPosition.bottom);
      generalWatch.updateRestrictUserNavigation();
      return false;
    }
  }

  orderListingApi(context,
      {isLoading = false, searching = '', page = 1}) async {
    mdOrderModal = MDOrderModal();

    FocusScope.of(context).unfocus();

    updateIsLoadingOrderList(value: false);

    if (page == 1) {
      ordersList.clear();
      orderPage = 1;
    }

    // else if(page ==1 && isFromSearch && searching !=''){
    //   ordersList.clear();
    //   orderSearchPage=1;
    // }

    var apis = OrdersCheckoutWishlistServices();

    generalWatch.updateRestrictUserNavigation(value: true);

    if (isLoading) {
      EasyLoading.show(
        status: 'Fetching Orders List',
      );
    }

    final Map<String, dynamic> data = {
      "querySearch": "$searching",
      "page": page
    };

    print("The data of api is:" + data.toString());

    var response = await apis.orderListing(data);
    print('The orderListing  Api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdOrderModal = MDOrderModal.fromJson(response);
        ordersList.addAll(mdOrderModal.data!.orders!.toList());

        if ((mdOrderModal.data!.pagination!.pages!.toInt() >= page) &&
            searching == '') {
          orderPage = orderPage + 1;
        }

        if (ordersList.length == 0) {
          updateIsLoadingOrderList(value: true);
        }

        // else if((mdOrderModal.data!.pagination!.pages!.toInt() >= page)  searching !=''){
        //   orderSearchPage=orderSearchPage+1;
        // }

        EasyLoading.dismiss();
        generalWatch.updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 3),
            toastPosition: EasyLoadingToastPosition.bottom);
        generalWatch.updateRestrictUserNavigation();

        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 3),
          toastPosition: EasyLoadingToastPosition.bottom);
      generalWatch.updateRestrictUserNavigation();

      return false;
    }
  }

  reOrderApi(context, {orderID, transactionID}) async {
    var apis = OrdersCheckoutWishlistServices();
    generalWatch.updateRestrictUserNavigation(value: true);

    EasyLoading.show(
        status: 'Products reordering', maskType: EasyLoadingMaskType.black);

    var data = {
      "orderId": orderID,
    };

    print(data.toString());

    var response = await apis.reOrder(data: data);
    print('The reOrder  Api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        var id = response['data']['id'];

        EasyLoading.showSuccess('Products reorder successfully');
        await orderStatusUpdate(status: '0', ID: id, backToNavigate: false);
        await confirmTransactionApi(context,
            orderID: "$id", transactionID: "$transactionID");

        generalWatch.updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 3),
            toastPosition: EasyLoadingToastPosition.bottom);
        generalWatch.updateRestrictUserNavigation();
        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 3),
          toastPosition: EasyLoadingToastPosition.bottom);
      generalWatch.updateRestrictUserNavigation();
      return false;
    }
  }

  orderDetailApi(context, {orderID}) async {
    var apis = OrdersCheckoutWishlistServices();
    combineImagesList = [];

    generalWatch.updateRestrictUserNavigation(value: true);
    EasyLoading.show(status: 'Getting Order Detail');

    var response = await apis.orderDetail(id: orderID.toString());
    print('The order Detail Api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdOrderDetailModal = MDOrderDetailModal.fromJson(response);

        for (int i = 0;
            i < mdOrderDetailModal.order!.first.products!.length;
            i++) {
          if (mdOrderDetailModal
              .order!.first.products![i].designs!.isNotEmpty) {
            print(
                "product List length ${mdOrderDetailModal.order!.first.products!.length}");
            for (int j = 0;
                j <
                    mdOrderDetailModal
                        .order!.first.products![i].designs!.length;
                j++) {
              combineImagesList.add(mdOrderDetailModal
                  .order!.first.products![i].designs![j].image!);
            }
          }
        }
        for (int i = 0;
            i < mdOrderDetailModal.order!.first.products!.length;
            i++)
          if (mdOrderDetailModal.order!.first.products![i].productImage != "")
            combineImagesList.add(
                mdOrderDetailModal.order!.first.products![i].productImage!);

        // EasyLoading.showSuccess('Getting Order Detail Successfully');
        for (int i = 0; i < combineImagesList.length; i++)
          print('Image Detail ${combineImagesList[i]}');
        EasyLoading.dismiss();
        generalWatch.updateRestrictUserNavigation();

        Navigator.pushNamed(context, routes.orderDetailScreenRoute);

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 3),
            toastPosition: EasyLoadingToastPosition.bottom);
        generalWatch.updateRestrictUserNavigation();
        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 3),
          toastPosition: EasyLoadingToastPosition.bottom);
      generalWatch.updateRestrictUserNavigation();
      return false;
    }
  }

  deleteOrderApi(context, {orderID}) async {
    var data = {
      "orderId": orderID,
    };

    var apis = OrdersCheckoutWishlistServices();

    generalWatch.updateRestrictUserNavigation(value: true);

    EasyLoading.show(status: 'Deleting Order');

    var response = await apis.deleteOrder(data: data);

    print('The delete Order Api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        await orderListingApi(context, searching: '', isLoading: false);

        EasyLoading.showSuccess('Delete Order Successfully');
        generalWatch.updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 3),
            toastPosition: EasyLoadingToastPosition.bottom);
        generalWatch.updateRestrictUserNavigation();
        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 3),
          toastPosition: EasyLoadingToastPosition.bottom);
      generalWatch.updateRestrictUserNavigation();

      return false;
    }
  }

  cancelOrderApi(context, {orderID}) async {
    var data = {
      "orderId": orderID,
    };

    print("The data is:" + data.toString());

    var apis = OrdersCheckoutWishlistServices();
    Navigator.pop(context);

    EasyLoading.show(
        status: 'Cancelling Order', maskType: EasyLoadingMaskType.black);

    var response = await apis.cancelOrder(data: data);

    print('The cancel Order Api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        await orderListingApi(context, searching: '', isLoading: false);
        EasyLoading.showSuccess('Cancelled Order Successfully');

        if (isBack) {
          Navigator.pop(context);
        } else {
          Navigator.pushNamed(context, routes.bottomNavigationScreenRoute);
        }

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 3),
            toastPosition: EasyLoadingToastPosition.bottom);
        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 3),
          toastPosition: EasyLoadingToastPosition.bottom);
      return false;
    }
  }

  // cartListingApi(context, {isLoading = false, isRoute = true}) async {
  //   listOfSystemProducts.clear();
  //   listOfNonSystemProductsTattoo.clear();
  //   listOfNonSystemProductsProduct.clear();
  //
  //   if (isLoading) {
  //     EasyLoading.show(status: 'Getting Cart List');
  //   }
  //
  //   var apis = OrdersCheckoutWishlistServices();
  //
  //   var response = await apis.cartListing();
  //
  //   print('The Cart Listing  Api response is:' + response.toString());
  //
  //   if (response != null) {
  //     if (response['status'] == 1) {
  //       mdCartModal = MDCartModal.fromJson(response);
  //
  //       listOfSystemProducts.addAll(mdCartModal.cart!.first.systemProducts!);
  //       print("The length of list of system product is:" +
  //           listOfSystemProducts.length.toString());
  //
  //       for (int i = 0;
  //       i < mdCartModal.cart!.first.nonSystemProducts!.length;
  //       i++)
  //         if (mdCartModal
  //             .cart!.first.nonSystemProducts![i].productId!.isNotEmpty) {
  //           print("ADDing for Products");
  //           listOfNonSystemProductsProduct
  //               .add(mdCartModal.cart!.first.nonSystemProducts![i]);
  //         } else {
  //           print("ADDing for tattoo");
  //           listOfNonSystemProductsTattoo
  //               .add(mdCartModal.cart!.first.nonSystemProducts![i]);
  //         }
  //
  //       print("The length of list of non system product product is:" +
  //           listOfNonSystemProductsProduct.length.toString());
  //       print("The length of list of system product tattoo is:" +
  //           listOfNonSystemProductsTattoo.length.toString());
  //
  //       for (int j = 0; j < listOfNonSystemProductsTattoo.length; j++) {
  //         for (int k = 0;
  //         k < listOfNonSystemProductsTattoo[j].designs!.length;
  //         k++)
  //           listOfSystemProducts.add(SystemProducts(
  //               sId: listOfNonSystemProductsTattoo[j].sId,
  //               designID: listOfNonSystemProductsTattoo[j].designs![k].sId,
  //               productName:
  //               listOfNonSystemProductsTattoo[j].designs![k].prompt,
  //               productImage:
  //               listOfNonSystemProductsTattoo[j].designs![k].image,
  //               quantity: listOfNonSystemProductsTattoo[j].designs![k].quantity,
  //               price: listOfNonSystemProductsTattoo[j]
  //                   .designs![k]
  //                   .price!
  //                   .toDouble() *
  //                   listOfNonSystemProductsTattoo[j]
  //                       .designs![k]
  //                       .quantity!
  //                       .toInt(),
  //               subTotal: listOfNonSystemProductsTattoo[j]
  //                   .designs![k]
  //                   .price!
  //                   .toDouble() *
  //                   listOfNonSystemProductsTattoo[j]
  //                       .designs![k]
  //                       .quantity!
  //                       .toInt(),
  //               productId: null,
  //               productType: 1,
  //               productDescription:
  //               listOfNonSystemProductsTattoo[j].designs![k].sizeDetail));
  //       }
  //
  //       print("The length of list of system product is:" +
  //           listOfSystemProducts.length.toString());
  //       productQuantityCartUpdate();
  //
  //       cartProductListSelectionInitialize(
  //           nonSystemLengthProduct: listOfNonSystemProductsProduct.length,
  //           systemProductLength: listOfSystemProducts.length);
  //
  //       if (isLoading) {
  //         if (listOfSystemProducts.isNotEmpty ||
  //             listOfNonSystemProductsProduct.isNotEmpty)
  //           EasyLoading.showToast('${mdCartModal.message} Successfully!',
  //               dismissOnTap: true,
  //               duration: Duration(seconds: 3),
  //               toastPosition: EasyLoadingToastPosition.bottom);
  //         else
  //           EasyLoading.showToast('Cart is Empty!',
  //               dismissOnTap: true,
  //               duration: Duration(seconds: 3),
  //               toastPosition: EasyLoadingToastPosition.bottom);
  //       }
  //
  //       if (isRoute &&
  //           (listOfSystemProducts.isNotEmpty ||
  //               listOfNonSystemProductsProduct.isNotEmpty))
  //         Navigator.pushNamed(context, routes.myCartScreenRoute);
  //
  //       print(isRoute.toString() + " " + mdCartModal.cart.toString());
  //
  //       notifyListeners();
  //       return true;
  //     } else {
  //       mdErrorModal = MDErrorModal.fromJson(response);
  //
  //       if (isLoading)
  //         EasyLoading.showToast('${mdErrorModal.message}',
  //             dismissOnTap: true,
  //             duration: Duration(seconds: 3),
  //             toastPosition: EasyLoadingToastPosition.bottom);
  //       return false;
  //     }
  //   } else {
  //     mdErrorModal = MDErrorModal.fromJson(response);
  //
  //     if (isLoading)
  //       EasyLoading.showToast('${mdErrorModal.message}',
  //           dismissOnTap: true,
  //           duration: Duration(seconds: 3),
  //           toastPosition: EasyLoadingToastPosition.bottom);
  //     return false;
  //   }
  // }

  cartListingApi(context, {isLoading = false, isRoute = true}) async {
    listOfSystemProducts.clear();
    listOfNonSystemProductsTattoo.clear();
    listOfNonSystemProductsProduct.clear();
    listOfNonSystemWholeProduct.clear();
    mdCartModal = MDCartModal();

    generalWatch.updateRestrictUserNavigation(value: true);
    if (isLoading) {
      EasyLoading.show(status: 'Loading...');
    }

    var apis = OrdersCheckoutWishlistServices();

    var response = await apis.cartListing();

    print('The Cart Listing  Api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdCartModal = MDCartModal.fromJson(response);

        if (mdCartModal.cart!.first.systemProducts!.isNotEmpty ||
            mdCartModal.cart!.first.systemProducts != null) {
          listOfSystemProducts.addAll(mdCartModal.cart!.first.systemProducts!);
          print("The length of list of system product is:" +
              listOfSystemProducts.length.toString());
        }

        // for (int i = 0; i < mdCartModal.cart!.first.nonSystemProducts!.length; i++)
        //   if (mdCartModal.cart!.first.nonSystemProducts![i].productId!.isNotEmpty) {
        //     print("ADDing for Products");
        //     listOfNonSystemProductsProduct.add(mdCartModal.cart!.first.nonSystemProducts![i]);
        //   } else {
        //     print("ADDing for tattoo");
        //     listOfNonSystemProductsTattoo.add(mdCartModal.cart!.first.nonSystemProducts![i]);
        //   }

        if (mdCartModal.cart!.first.nonSystemProducts!.isNotEmpty ||
            mdCartModal.cart!.first.nonSystemProducts != null) {
          for (int i = 0;
              i < mdCartModal.cart!.first.nonSystemProducts!.length;
              i++) {
            if (mdCartModal
                    .cart!.first.nonSystemProducts![i].productId!.isEmpty ||
                mdCartModal.cart!.first.nonSystemProducts![i].productId ==
                    null) {
              print("ADDing for tattoo");
              listOfNonSystemProductsTattoo
                  .add(mdCartModal.cart!.first.nonSystemProducts![i]);
            } else {
              print("ADDing for Product");
              listOfNonSystemProductsProduct
                  .add(mdCartModal.cart!.first.nonSystemProducts![i]);
            }
          }
        }

        print("The length of list of non system product product is:" +
            listOfNonSystemProductsProduct.length.toString());
        print("The length of list of system product tattoo is:" +
            listOfNonSystemProductsTattoo.length.toString());

        if (listOfNonSystemProductsTattoo.isNotEmpty ||
            listOfNonSystemProductsTattoo != null) {
          for (int j = 0; j < listOfNonSystemProductsTattoo.length; j++) {
            if (listOfNonSystemProductsTattoo[j].productId == '' ||
                listOfNonSystemProductsTattoo[j].productId == null) {
              for (int k = 0;
                  k < listOfNonSystemProductsTattoo[j].designs!.length;
                  k++)
                listOfSystemProducts.add(SystemProducts(
                    sId: listOfNonSystemProductsTattoo[j].sId,
                    designID: listOfNonSystemProductsTattoo[j].designs![k].sId,
                    productName:
                        listOfNonSystemProductsTattoo[j].designs![k].prompt,
                    productImage:
                        listOfNonSystemProductsTattoo[j].designs![k].image,
                    quantity:
                        listOfNonSystemProductsTattoo[j].designs![k].quantity,
                    price: listOfNonSystemProductsTattoo[j]
                            .designs![k]
                            .price!
                            .toDouble() *
                        listOfNonSystemProductsTattoo[j]
                            .designs![k]
                            .quantity!
                            .toInt(),
                    subTotal: listOfNonSystemProductsTattoo[j]
                            .designs![k]
                            .price!
                            .toDouble() *
                        listOfNonSystemProductsTattoo[j]
                            .designs![k]
                            .quantity!
                            .toInt(),
                    productId: null,
                    productType: 1,
                    productDescription: listOfNonSystemProductsTattoo[j]
                        .designs![k]
                        .sizeDetail));
            }

            // else {
            //   listOfNonSystemWholeProduct.add(listOfNonSystemProductsTattoo[j]);
            // }
          }
          print("The length of list of system product is:" +
              listOfSystemProducts.length.toString());
        }

        await productQuantityCartUpdate();

        cartProductListSelectionInitialize(
            nonSystemLengthProduct: listOfNonSystemProductsProduct.length,
            systemProductLength: listOfSystemProducts.length);

        if (isLoading) {
          if (listOfSystemProducts.isNotEmpty ||
              listOfNonSystemProductsProduct.isNotEmpty)
            EasyLoading.showToast('${mdCartModal.message} successfully',
                dismissOnTap: true,
                duration: Duration(seconds: 3),
                toastPosition: EasyLoadingToastPosition.bottom);
          else
            EasyLoading.showToast('Cart is Empty!',
                dismissOnTap: true,
                duration: Duration(seconds: 3),
                toastPosition: EasyLoadingToastPosition.bottom);
        }

        if (isRoute &&
            (listOfSystemProducts.isNotEmpty ||
                listOfNonSystemProductsProduct.isNotEmpty)) {
          Navigator.pushNamed(context, routes.myCartScreenRoute);
        }
        print(isRoute.toString() + " " + mdCartModal.cart.toString());

        generalWatch.updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);

        if (isLoading)
          EasyLoading.showToast('${mdErrorModal.message}',
              dismissOnTap: true,
              duration: Duration(seconds: 3),
              toastPosition: EasyLoadingToastPosition.bottom);
        generalWatch.updateRestrictUserNavigation();

        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);

      if (isLoading)
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 3),
            toastPosition: EasyLoadingToastPosition.bottom);
      generalWatch.updateRestrictUserNavigation();

      return false;
    }
  }

  addToCartApi(
    context, {
    type = 0,
    SystemProductsSender? systemProduct,
    productImage = '',
    quantity = 0,
    price = 0.0,
    imprintID = '',
    imprintPrice = 0.0,
    color = 0,
    bodyPart = 0,
    subTotal = 0.0,
    List<NonSystemDesigns>? designs,
    productID = null,
    variationID = null,
    isRoute = false,
  }) async {
    print(type.toString() + "\n\n");

    late int totalQty = 0;
    int minQty = homeWatch.mdProductDetailModal.data!.minQty!.toInt();

    systemProduct!.variationData!.forEach((element) {
      totalQty = totalQty + element.variationQuantity!;
    });

    if (totalQty < minQty) {
      EasyLoading.showToast("Minimum Quantity is ${minQty}",
          dismissOnTap: true,
          duration: Duration(seconds: 3),
          toastPosition: EasyLoadingToastPosition.bottom);
    } else {}

    // print(systemProduct!.variationData?.toList());
    // await generalWatch.updateRestrictUserNavigation(value: true);

    // if (type == 1) {
    //   for (int i = 0; i < designs!.length; i++)
    //     print(designs[i].toJson().toString() + "\n\n");
    // } else {
    //   EasyLoading.show(status: "Product adding into cart", dismissOnTap: true);
    // }

    // var apis = OrdersCheckoutWishlistServices();
    // Map<String, dynamic> data = Map();

    // if (type == 0) {
    //   data['type'] = 0;
    //   data['productData'] = systemProduct;
    // } else {
    //   data['type'] = 1;
    //   data['productData'] = {
    //     "productId": productID,
    //     "variationId": variationID,
    //     "designs": designs,
    //     "productImage": '$productImage',
    //     "quantity": quantity,
    //     "price": price,
    //     "designImprintId": imprintID,
    //     "designImprintPrice": imprintPrice,
    //     "color": color,
    //     "bodyPart": bodyPart,
    //     "subTotal": subTotal
    //   };
    // }

    // var response = await apis.addToCart(data: data);
    // print('The Add To Cart Api response is:' + response.toString());

    // if (response != null) {
    //   if (response['status'] == 1) {
    //     if (type == 0) {
    //       homeWatch.addToCartProductUpdator(
    //         id: systemProduct!.productId,
    //       );
    //     }

    //     await productQuantityCartUpdate(type: 1);

    //     if (isRoute) {
    //       await cartListingApi(context, isRoute: true, isLoading: false);
    //     }

    //     EasyLoading.dismiss();
    //     utils.apiResponseToast(message: 'Product added into cart successfully');

    //     homeWatch.desireColorController.text = '';
    //     homeWatch.desireTextController.text = '';
    //     homeWatch.productDesirePromptController.text = '';
    //     homeWatch.productDesireTextController.text = '';

    //     generalWatch.updateRestrictUserNavigation();

    //     notifyListeners();
    //     return true;
    //   } else {
    //     mdErrorModal = MDErrorModal.fromJson(response);
    //     EasyLoading.showToast('${mdErrorModal.message}',
    //         dismissOnTap: true,
    //         duration: Duration(seconds: 3),
    //         toastPosition: EasyLoadingToastPosition.bottom);
    //     generalWatch.updateRestrictUserNavigation();
    //     return false;
    //   }
    // } else {
    //   // mdErrorModal = MDErrorModal.fromJson(response);
    //   EasyLoading.showToast('${mdErrorModal.message}',
    //       dismissOnTap: true,
    //       duration: Duration(seconds: 3),
    //       toastPosition: EasyLoadingToastPosition.bottom);
    //   generalWatch.updateRestrictUserNavigation();

    //   return false;
    // }
  }

  updateCartQuantitApi(
    context, {
    type = 0,
    id,
    quantity,
    designId,
  }) async {
    print(type.toString() + "\n\n");

    var apis = OrdersCheckoutWishlistServices();
    generalWatch.updateRestrictUserNavigation(value: true);
    EasyLoading.show(status: 'Updating Cart');
    Map<String, dynamic> data = Map();

    data['type'] = type;
    data['id'] = id;
    data['quantity'] = quantity;
    data['designId'] = designId;

    print('The data is:' + data.toString());

    var response = await apis.updateCart(data: data);
    print('The Update Cart Api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        listOfSystemProducts.clear();
        listOfNonSystemProductsTattoo.clear();
        listOfNonSystemProductsProduct.clear();

        mdCartModal = MDCartModal.fromJson(response);
        listOfSystemProducts.addAll(mdCartModal.cart!.first.systemProducts!);

        print("The length of list of system product is:" +
            listOfSystemProducts.length.toString());

        for (int i = 0;
            i < mdCartModal.cart!.first.nonSystemProducts!.length;
            i++)
          if (mdCartModal
              .cart!.first.nonSystemProducts![i].productId!.isNotEmpty) {
            print("ADDing for Products");
            listOfNonSystemProductsProduct
                .add(mdCartModal.cart!.first.nonSystemProducts![i]);
          } else {
            print("ADDing for tattoo");
            listOfNonSystemProductsTattoo
                .add(mdCartModal.cart!.first.nonSystemProducts![i]);
          }

        print("The length of list of non system product product is:" +
            listOfNonSystemProductsProduct.length.toString());
        print("The length of list of system product tattoo is:" +
            listOfNonSystemProductsTattoo.length.toString());

        for (int j = 0; j < listOfNonSystemProductsTattoo.length; j++) {
          for (int k = 0;
              k < listOfNonSystemProductsTattoo[j].designs!.length;
              k++)
            listOfSystemProducts.add(SystemProducts(
                sId: listOfNonSystemProductsTattoo[j].sId,
                productName:
                    listOfNonSystemProductsTattoo[j].designs![k].prompt,
                productImage:
                    listOfNonSystemProductsTattoo[j].designs![k].image,
                quantity: listOfNonSystemProductsTattoo[j].designs![k].quantity,
                price: listOfNonSystemProductsTattoo[j]
                        .designs![k]
                        .price!
                        .toDouble() *
                    listOfNonSystemProductsTattoo[j]
                        .designs![k]
                        .quantity!
                        .toInt(),
                subTotal: listOfNonSystemProductsTattoo[j]
                        .designs![k]
                        .price!
                        .toDouble() *
                    listOfNonSystemProductsTattoo[j]
                        .designs![k]
                        .quantity!
                        .toInt(),
                productId: null,
                productType: 1,
                designID: listOfNonSystemProductsTattoo[j].designs![k].sId,
                productDescription:
                    listOfNonSystemProductsTattoo[j].designs![k].sizeDetail));
        }

        print("The length of list of system product is:" +
            listOfSystemProducts.length.toString());

        cartProductListSelectionInitialize(
            nonSystemLengthProduct: listOfNonSystemProductsProduct.length,
            systemProductLength: listOfSystemProducts.length);

        productQuantityCartUpdate();

        utils.apiResponseToast(message: 'Cart Updated Successfully');
        generalWatch.updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 3),
            toastPosition: EasyLoadingToastPosition.bottom);
        generalWatch.updateRestrictUserNavigation();
        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 3),
          toastPosition: EasyLoadingToastPosition.bottom);
      generalWatch.updateRestrictUserNavigation();
      return false;
    }
  }

  removeFromCartApi(context,
      {systemProduct,
      nonSystemProductProducts,
      nonSystemProductTattoos}) async {
    var apis = OrdersCheckoutWishlistServices();
    generalWatch.updateRestrictUserNavigation(value: true);

    EasyLoading.show(status: 'Removing from Cart');

    Map<String, dynamic> data = Map();
    data['systemProducts'] = systemProduct;
    data['nonSystemProductsTattoos'] = nonSystemProductTattoos;
    data['nonSystemProductsProducts'] = nonSystemProductProducts;

    print('The data is:' + data.toString());

    var response = await apis.removeCart(data: data);

    if (response != null) {
      if (response['status'] == 1) {
        if (systemProductListDeleteIDs.length >= 1) {
          homeWatch.productListingApi(context,
              isLoading: false,
              categoryID: homeWatch.selectedCategoryID,
              title: '',
              type: homeWatch.tabIndex == 0
                  ? "0"
                  : homeWatch.tabIndex == 1
                      ? "1"
                      : homeWatch.tabIndex == 2
                          ? "2"
                          : "4");
        }

        listOfSystemProducts.clear();
        listOfNonSystemProductsTattoo.clear();
        listOfNonSystemProductsProduct.clear();

        mdCartModal = MDCartModal.fromJson(response);
        listOfSystemProducts.addAll(mdCartModal.cart!.first.systemProducts!);

        print("The length of list of system product is:" +
            listOfSystemProducts.length.toString());

        for (int i = 0;
            i < mdCartModal.cart!.first.nonSystemProducts!.length;
            i++)
          if (mdCartModal
              .cart!.first.nonSystemProducts![i].productId!.isNotEmpty) {
            print("ADDing for Products");
            listOfNonSystemProductsProduct
                .add(mdCartModal.cart!.first.nonSystemProducts![i]);
          } else {
            print("ADDing for tattoo");
            listOfNonSystemProductsTattoo
                .add(mdCartModal.cart!.first.nonSystemProducts![i]);
          }

        print("The length of list of non system product product is:" +
            listOfNonSystemProductsProduct.length.toString());
        print("The length of list of system product tattoo is:" +
            listOfNonSystemProductsTattoo.length.toString());

        for (int j = 0; j < listOfNonSystemProductsTattoo.length; j++) {
          for (int k = 0;
              k < listOfNonSystemProductsTattoo[j].designs!.length;
              k++)
            listOfSystemProducts.add(SystemProducts(
                sId: listOfNonSystemProductsTattoo[j].sId,
                productName:
                    listOfNonSystemProductsTattoo[j].designs![k].prompt,
                productImage:
                    listOfNonSystemProductsTattoo[j].designs![k].image,
                quantity: listOfNonSystemProductsTattoo[j].designs![k].quantity,
                price: listOfNonSystemProductsTattoo[j]
                        .designs![k]
                        .price!
                        .toDouble() *
                    listOfNonSystemProductsTattoo[j]
                        .designs![k]
                        .quantity!
                        .toInt(),
                subTotal: listOfNonSystemProductsTattoo[j]
                        .designs![k]
                        .price!
                        .toDouble() *
                    listOfNonSystemProductsTattoo[j]
                        .designs![k]
                        .quantity!
                        .toInt(),
                productId: null,
                productType: 1,
                designID: listOfNonSystemProductsTattoo[j].designs![k].sId,
                productDescription:
                    listOfNonSystemProductsTattoo[j].designs![k].sizeDetail));
        }

        print("The length of list of system product is:" +
            listOfSystemProducts.length.toString());

        productQuantityCartUpdate();

        cartProductListSelectionInitialize(
            nonSystemLengthProduct: listOfNonSystemProductsProduct.length,
            systemProductLength: listOfSystemProducts.length);

        utils.apiResponseToast(message: 'Cart Updated Successfully');

        generalWatch.updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 3),
            toastPosition: EasyLoadingToastPosition.bottom);
        generalWatch.updateRestrictUserNavigation();
        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 3),
          toastPosition: EasyLoadingToastPosition.bottom);
      generalWatch.updateRestrictUserNavigation();
      return false;
    }
  }

  checkoutApi(context, {transactionID}) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var apis = OrdersCheckoutWishlistServices();
    generalWatch.updateRestrictUserNavigation(value: true);
    EasyLoading.show(status: 'Check Out', maskType: EasyLoadingMaskType.black);
    Map<String, dynamic> data = Map();

    var response = await apis.checkout();

    if (response != null) {
      if (response['status'] == 1) {
        String orderID = response["order"]["_id"];

        orderStatusUpdate(status: '0', ID: orderID, backToNavigate: false);

        // quantityCartUpdate(value: 0);

        quantityOfCartProduct = 0;

        await confirmTransactionApi(context,
            orderID: "$orderID", transactionID: "$transactionID");

        // myPrefs.remove(static.discountCouponString);
        generalWatch.updateRestrictUserNavigation();
        EasyLoading.dismiss();
        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 3),
            toastPosition: EasyLoadingToastPosition.bottom);
        generalWatch.updateRestrictUserNavigation();
        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 3),
          toastPosition: EasyLoadingToastPosition.bottom);
      generalWatch.updateRestrictUserNavigation();
      return false;
    }
  }

  confirmTransactionApi(context, {orderID, transactionID}) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    var apis = OrdersCheckoutWishlistServices();

    Map<String, dynamic> data = Map();
    data['orderId'] = orderID;
    data['transactionId'] = transactionID;
    data['transactionPlatform'] = stripe
        ? "Stripe"
        : googleAndApplePay
            ? Platform.isAndroid
                ? "Google Pay"
                : "Apple Pay"
            : 'PayPal';

    print("The datas is:" + data.toString());

    var response = await apis.confirmTransaction(data);

    print("The data response of the transaction is:" + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        print("The successfull payment is: done");
        EasyLoading.dismiss();

        couponCodeController.clear();
        updateSubtotal(isFromRemove: true);
        canCouponApplyUpdate(value: false);

        SuccessfulOrderBottomSheet().sheet(navigatorkey.currentContext!);

        myPrefs.setBool(static.canCouponApply, true);
        canCouponApplyUpdate(value: true);

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 3),
            toastPosition: EasyLoadingToastPosition.bottom);
        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 3),
          toastPosition: EasyLoadingToastPosition.bottom);
      return false;
    }
  }

  validateCoupanApi(context, {isFromRemove = false}) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    FocusManager.instance.primaryFocus?.unfocus();

    generalWatch.updateRestrictUserNavigation(value: true);
    var apis = OrdersCheckoutWishlistServices();

    isFromRemove
        ? SizedBox()
        : EasyLoading.show(
            status: "Verifying promo code",
            maskType: EasyLoadingMaskType.black,
            dismissOnTap: false,
          );
    Map<String, dynamic> data = Map();
    data['couponCode'] = isFromRemove ? '' : couponCodeController.text;

    print("The data is:" + data.toString());
    var response = await apis.validateCoupan(data);

    print("The data response of the validateCoupan is:" + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        double discount = response['cart']['discountTotal'] + 0.0;
        await discountAmountUpdate(value: discount);

        // isFromRemove
        //     ? SizedBox()
        //     : EasyLoading.showInfo(
        //         status: "Promo code applied successfully..!",
        //         maskType: EasyLoadingMaskType.black,
        //       );

        EasyLoading.dismiss();

        canCouponApplyUpdate(value: true);
        // myPrefs.setBool(static.canCouponApply, false);
        // myPrefs.setString(
        //     static.discountCouponString, couponCodeController.text);

        // print("Text Value ${couponCodeController.text}");
        // print("canCouponApply ${canCouponApply}");

        //canCouponApplyUpdate(value: false);
        generalWatch.updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        isFromRemove
            ? SizedBox()
            : EasyLoading.showError(
                "${mdErrorModal.message}",
                maskType: EasyLoadingMaskType.black,
              );
        generalWatch.updateRestrictUserNavigation();
        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      isFromRemove
          ? SizedBox()
          : EasyLoading.showError(
              "${mdErrorModal.message}",
              maskType: EasyLoadingMaskType.black,
            );
      generalWatch.updateRestrictUserNavigation();
      return false;
    }
  }
}
