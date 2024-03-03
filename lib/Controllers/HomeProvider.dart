import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Models/MDColorFromSizeModal.dart';
import 'package:skincanvas/Models/MDDesignImprint.dart';
import 'package:skincanvas/Models/MDErrorModal.dart';
import 'package:skincanvas/Models/MDHomeCategoryModal.dart';
import 'package:skincanvas/Models/MDOrderModal.dart';
import 'package:skincanvas/Models/MDProductDetail.dart';
import 'package:skincanvas/Models/MDProductModal.dart';
import 'package:skincanvas/Models/MDSizeGroup.dart';
import 'package:skincanvas/Models/MDTattooGenerationModal.dart';
import 'package:skincanvas/Models/MDVariationModal.dart';
import 'package:skincanvas/Services/GeneralServices.dart';
import 'package:skincanvas/Services/HomeServices.dart';
import 'package:skincanvas/Services/OrdersCheckoutWishlistServices.dart';
import 'package:skincanvas/main.dart';

class HomeController with ChangeNotifier {
  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);

  MDCategoriesModal mdCategoriesModal = MDCategoriesModal();
  MDErrorModal mdErrorModal = MDErrorModal();
  MDProductModal mdProductModal = MDProductModal();
  MDDesignImprint mdDesignImprint = MDDesignImprint();

  MDProductDetailModal mdProductDetailModal = MDProductDetailModal(
      message: '',
      status: 0,
      data: MDProductDetailData(
          productName: '',
          productImage: '',
          productID: '',
          isFeatured: false,
          isProductIntoCart: false,
          productDescription: '',
          productPrice: 0));
  MDTattooAndGraphicsGenerationModal mdTattooAndGraphicsGenerationModal =
      MDTattooAndGraphicsGenerationModal();

  MDSizeGroup mdSizeGroup = MDSizeGroup();
  MDSizeGroup mdSizeGroupText = MDSizeGroup();

  MDVariationModal mdVariationModal = MDVariationModal();
  MDColorFromSizeModal mdColorFromSizeModal = MDColorFromSizeModal();

  List<Categories> inspirationalDataList = [];
  List<Categories> discoverDataList = [];
  List<Categories> tattooDataList = [];
  List<Categories> fashionDataList = [];
  List<Categories> configureDataList = [];
  List<Categories> categoryList = [];

  List<Products> inspirationProductList = [];
  List<Products> discoverProductList = [];
  List<Products> tattooProductList = [];
  List<Products> fashionProductList = [];

  List<Products> configurableProductList = [];
  List<Products> productList = [];

  int configurablePage = 1;
  int productPage = 1;

//  List<Uint8List> selectableTattoosAndGraphicList = [];
  List<String> selectableTattoosAndGraphicList = [];

  List<String> listOfTattos = [];

  bool loadingApi = false;
  bool configurableLoading = false;
  bool productLoading = false;
  int count = 0;

  var utils = AppUtils();
  var themeColor = ThemeColors();
  var static = Statics();
  var routes = Routes();

  loadingStatus({status = false}) {
    loadingApi = status;

    print("Loading Api Status ${loadingApi}");
    notifyListeners();
  }

  configurableLoadingStatus({status = false}) {
    configurableLoading = status;
    notifyListeners();
  }

  productLoadingStatus({status = false, value = 0}) {
    productLoading = status;

    count = value;
    notifyListeners();
  }

  //.................... Home Fragment ....................//

  TextEditingController homeSearchController = TextEditingController();

  int tabIndex = 0;
  int selectedCategoryIndex = 0;
  String selectedCategoryID = '';
  String selectedCategoryType = '0';

  int selectedConfigurableCategoryIndex = 0;
  String selectedConfigurableCategoryID = '';
  String selectedConfigurableCategoryType = '3';

  tabIndexUpdator(context, {index = 0}) async {
    tabIndex = index;
    selectedCategoryIndex = 0;
    // categoryList.clear();

    // if(index == tabIndex && isFromOnTap == false){
    //   await updateIsFromOnTap(value: true);
    // }

    if (index == 0) {
      print("run Time ${index}");
      if (isFirstTime == 1) {
        await updateIsFirstTime(value: 0);
        await categoryListingApi(context,
            type: '0', title: '', isLoading: true);
        selectedCategoryID = inspirationalDataList[0].sId.toString();
        selectedCategoryType = "0";
        print("Category List length ${categoryList.length}");
      }
      // categoryList.addAll(inspirationalDataList);
      // selectedCategoryID = inspirationalDataList[0].sId.toString();
      // selectedCategoryType = "0";
      //
      // print(tabIndex.toString());
      // if (productLoading == false && isFirstTime == 2)
      //   productListingApi(context,
      //       type: "0",
      //       title: '',
      //       categoryID: inspirationalDataList[0].sId,
      //       isLoading: false);
    } else if (index == 1) {
      print("run Time ${index}");

      if (isFirstTime == 1) {
        await updateIsFirstTime(value: 0);
        await categoryListingApi(context,
            type: '1', title: '', isLoading: true);
        selectedCategoryID = discoverDataList[0].sId.toString();
        selectedCategoryType = "1";
        print("Category List length ${categoryList.length}");
      }
      // categoryList.addAll(discoverDataList);
      // selectedCategoryID = discoverDataList[0].sId.toString();
      // selectedCategoryType = "1";
      //
      // if (productLoading == false)
      //   productListingApi(context,
      //       type: "1",
      //       title: '',
      //       categoryID: discoverDataList[0].sId,
      //       isLoading: false);

      print(tabIndex.toString());
    } else if (index == 2) {
      if (isFirstTime == 1) {
        await updateIsFirstTime(value: 0);
        await categoryListingApi(context,
            type: '2', title: '', isLoading: true);
        selectedCategoryID = tattooDataList[0].sId.toString();
        selectedCategoryType = "2";
      }
      // categoryList.addAll(tattooDataList);
      // selectedCategoryID = tattooDataList[0].sId.toString();
      // selectedCategoryType = "2";
      //
      // print(tabIndex.toString());
      //
      // if (productLoading == false)
      //   productListingApi(context,
      //       type: "2",
      //       title: '',
      //       categoryID: tattooDataList[0].sId,
      //       isLoading: false);
    } else {
      if (isFirstTime == 1) {
        await updateIsFirstTime(value: 0);
        await categoryListingApi(context,
            type: '4', title: '', isLoading: true);
        selectedCategoryID = fashionDataList[0].sId.toString();
        selectedCategoryType = "4";
      }

      // categoryList.addAll(fashionDataList);
      // selectedCategoryID = fashionDataList[0].sId.toString();
      // selectedCategoryType = "4";
      //
      // print(tabIndex.toString());
      //
      // if (productLoading == false)
      //   productListingApi(context,
      //       type: "4",
      //       title: '',
      //       categoryID: fashionDataList[0].sId,
      //       isLoading: false);
    }

    print('The Tab Index is:' + tabIndex.toString());
    notifyListeners();
  }

  selectedCategoryUpdator({index, ID, type = '0'}) {
    selectedCategoryIndex = index;
    selectedCategoryID = ID.toString();
    selectedCategoryType = type;

    notifyListeners();
  }

  selectedCategoryForConfigurableUpdator({index = 0, ID, type = '3'}) {
    selectedConfigurableCategoryIndex = index;
    selectedConfigurableCategoryID = ID.toString();
    selectedConfigurableCategoryType = type;

    notifyListeners();
  }

  ///.............. Bottom Navigation Bar....................///

  int screenIndex = 0;

  screenIndexUpdate({index = 0}) {
    screenIndex = index;
    print('The Screen Index is:' + screenIndex.toString());
    notifyListeners();
  }

  ///............... Choose to Create Bottom sheet.............///

  bool isTattooSelect = false;
  bool isProductSelect = false;

  categorySelectionToCreate({tattoo = false, product = false}) {
    isTattooSelect = tattoo;
    isProductSelect = product;
    notifyListeners();
  }

  ///.................... Create Tattoo .......................///

  TextEditingController designPromptController = TextEditingController();
  TextEditingController desireTextController = TextEditingController();
  TextEditingController desireColorController = TextEditingController();

  List<bool> createTattooBodySelection = [];

  List<bool> createTattooDesignSelection = [];

  List<bool> selectGraphics = [];

  List<String> selectedColors = [];

  bool isShowGraphicsContainer = false;

  int bodyPartIndexUpdate = 0;

  String mixedColors = '';

  List<String> colorNames = [
    'Red',
    'Green',
    'Blue',
    'Yellow',
    'Purple',
    'Orange',
    'Pink',
    'Cyan',
    'Magenta',
    'Lime',
    'Brown',
    'Teal',
    'Indigo',
    'Grey',
    'Black',
    'White',
  ];

  selectRandomColorFunc() {
    final random = Random();
    selectedColors.clear();

    for (int i = 0; i < 3; i++) {
      int randomIndex = random.nextInt(colorNames.length);
      selectedColors.add(colorNames[randomIndex]);
    }

    for (int i = 0; i < selectedColors.length; i++) {
      print('Selected colors: ${selectedColors[i]}');
    }

    mixedColors = selectedColors.join(', ');
    print('mixed Colors ${mixedColors}');
    notifyListeners();
  }

  updateIsShowGraphicsContainer({isBackButton = false}) {
    if (isBackButton) {
      productDesirePromptController.clear();
      productDesireTextController.clear();
      selectedDesignImprint = '';
      isShowGraphicsContainer = false;
      mdTattooAndGraphicsGenerationModal.imagesList = [];
      selectGraphics = [];
      desireColorController.clear();
    } else {
      isShowGraphicsContainer = true;
    }
    notifyListeners();
  }

  selectGraphicsStatusInitialize() {
    // mdTattooAndGraphicsGenerationModal = MDTattooAndGraphicsGenerationModal(created: 0, imagesList: [
    //   MDTattooGenerationData(
    //       url:
    //           'https://res.cloudinary.com/dn5nxxh9f/image/upload/v1694158906/img-kY2joqKdthNp35NQZimy1BGk-removebg-preview_xov3xl.png'),
    //   MDTattooGenerationData(
    //       url:
    //           'https://res.cloudinary.com/dn5nxxh9f/image/upload/v1694502030/png-clipart-cat-tattoo-drawing-wolf-cat-mammal-animals-removebg-preview_yetj7s.png'),
    //   MDTattooGenerationData(
    //       url:
    //       "https://res.cloudinary.com/dn5nxxh9f/image/upload/v1694502030/178-1789705_tribal-tattoo-tribal-spider-tattoo-designs-removebg-preview_d5j3md.png")
    // ]);
    selectGraphics.clear();
    for (int i = 0; i < 3; i++) {
      selectGraphics.add(false);
    }

    notifyListeners();
  }

  selectGraphicsStatusUpdate({index}) {
    for (int i = 0; i < selectGraphics.length; i++) {
      selectGraphics[i] = (i == index) ? !selectGraphics[i] : selectGraphics[i];
    }

    print('Status ${selectGraphics[index]}');
    notifyListeners();
  }

  createTattooBodySelectionInitialize() {
    createTattooBodySelection.clear();
    for (int i = 0; i < 8; i++)
      if (i == 0) {
        createTattooBodySelection.add(true);
      } else {
        createTattooBodySelection.add(false);
      }
    notifyListeners();
  }

  createTattooDesignSelectionInitialize() {
    createTattooDesignSelection.clear();
    for (int i = 0; i < 3; i++) {
      if (i == 0) {
        createTattooDesignSelection.add(true);
      } else {
        createTattooDesignSelection.add(false);
      }
    }
    notifyListeners();
  }

  createTattooBodySelectionUpdate({index}) async {
    bool anyItemIsTrue = false;

    for (int i = 0; i < createTattooBodySelection.length; i++) {
      if (i == index) {
        createTattooBodySelection[i] = true;
        anyItemIsTrue = true;
      } else {
        createTattooBodySelection[i] = false;
      }
    }

    bodyPartIndexUpdate = index;
    if (!anyItemIsTrue && createTattooBodySelection.isNotEmpty) {
      createTattooBodySelection[0] = true;
      bodyPartIndexUpdate = 0;
    }

    notifyListeners();
  }

  selectableTattoosAndGraphicListUpdate() async {
    selectableTattoosAndGraphicList.clear();

    print(
        "The images are:" + imagesListAfterBackgroundRemoval.length.toString());

    for (int i = 0; i < selectGraphics.length; i++)
      if (selectGraphics[i]) {
        // print("The images are:" + imagesListAfterBackgrohomundRemoval[i].toString());
        selectableTattoosAndGraphicList
            .add(imagesListAfterBackgroundRemoval[i]);
        // selectableTattoosAndGraphicList.add(
        //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuNc5rLuQmULUsXKZqVo1XCVrpdC7ue8vHiH0pgKqqqLiXA1XdoHnCtsuXRU9Cwvt4lPE&usqp=CAU');
      }

    print("The selectable tattoo:" +
        selectableTattoosAndGraphicList.length.toString());

    await initializeImageOffsets();
    notifyListeners();
  }

  initializeImageOffsets() {
    imageOffSetList.clear();
    imageColorList.clear();
    imageSizeList.clear();
    tattooRotationalAngleList.clear();

    imageColorSliderPositionList.clear();
    imageShadeSliderPositionList.clear();
    imageCurrentColorList.clear();

    for (int i = 0; i < selectableTattoosAndGraphicList.length; i++) {
      imageOffSetList.add(Offset(0.0, 0.0));
      imageColorList.add(Color(0xffffffff));
      // isFromTattoo
      //     ?
      print(
          'Size Group for tattoo end value ${mdSizeGroup.mdSizeGroupData!.sizeLimits!.end}');
      imageSizeList
          .add(mdSizeGroup.mdSizeGroupData!.sizeLimits!.end!.toDouble());
      // : imageSizeList.add(250 / 2);
      tattooRotationalAngleList.add(0.0);
      imageColorSliderPositionList.add(0.0);
      imageShadeSliderPositionList.add(0.0);
      imageCurrentColorList.add(Color(0xffffffff));
    }
    selectableImageIndex = 0;

    notifyListeners();
  }

  /// ............................... Create Product Screen .........................///

  TextEditingController productDesireTextController = TextEditingController();

  TextEditingController productDesirePromptController = TextEditingController();

  ///.................................. Edit Tattoo And Product Screen .....................................................///

  bool isTattooShowForSS = false;

  bool isTattooRotate = false;
  bool isSwipeClick = false;

  bool imagePreview = false;
  bool isIncreaseTextSize = false;

  bool editScreenFromTattooRoute = false;
  bool isFromTattoo = false;

  int selectedFontFamilyIndex = 0;

  updateSelectedFontFamilyIndex({index}) {
    selectedFontFamilyIndex = index;
    notifyListeners();
  }

  updateIsFromTattoo({value}) {
    isFromTattoo = value;
    notifyListeners();
  }

  routingForEditScreenFromTattoo({value}) {
    editScreenFromTattooRoute = value;
    notifyListeners();
  }

  tattooShowForSSUpdate({value = false}) {
    isTattooShowForSS = value;

    print("isTattooShowForSS:::::>" + isTattooShowForSS.toString());
    notifyListeners();
  }

  ///............................. For Change Image Color ..........................///

  List<double> imageColorSliderPositionList = [];
  List<double> imageShadeSliderPositionList = [];
  List<Color> imageCurrentColorList = [];

  updateImageColorSliderPosition({position}) {
    imageColorSliderPositionList[selectableImageIndex] = position;
    notifyListeners();
  }

  updateImageShadeSliderPosition({position}) {
    imageShadeSliderPositionList[selectableImageIndex] = position;
    notifyListeners();
  }

  updateImageCurrentColor({color}) {
    imageCurrentColorList[selectableImageIndex] = color;

    print(
        'updateImageCurrentColor ${imageCurrentColorList[selectableImageIndex]}');
    notifyListeners();
  }

  ///............................ For Change Text Color .......................///

  double textColorSliderPosition = 0;
  double? textShadeSliderPosition = 0;
  Color? textCurrentColor = Color(0xffffffff);

  updateTextColorSliderPosition({position}) {
    textColorSliderPosition = position;
    notifyListeners();
  }

  updateTextShadeSliderPosition({position}) {
    textShadeSliderPosition = position;
    notifyListeners();
  }

  updateTextCurrentColor({color}) {
    textCurrentColor = color;
    notifyListeners();
  }

  // double imageSize = 250 / 2;

  double textSize = 10.0;
  double rotationAngleForText = 0.0;

  double previousSize = 0.0;

  //double rotationAngleForTattoo = 0.0;
  //Color? imageColor = Color(0xffffffff);

  Color? textColor = Color(0xffffffff);

  List<Color> imageColorList = [];

  List<double> imageSizeList = [];

  List<double> tattooRotationalAngleList = [];

  int selectableImageIndex = 0;

  List<bool> editTattooBodySelection = [];

  selectableImageStatusUpdate({index}) {
    selectableImageIndex = index;
    // imageColorSliderPositionList[selectableImageIndex] = 0.0;
    // imageShadeSliderPositionList[selectableImageIndex] =0.0;
    // imageCurrentColorList[selectableImageIndex] = Colors.r;
    print('The list status is:' + selectableImageIndex.toString());
    notifyListeners();
  }

  updateColor(color) {
    if (isIncreaseTextSize) {
      textColor = color;
    } else {
      imageColorList[selectableImageIndex] = color;
      print(
          'image Current Color ${imageColorList[selectableImageIndex]}  ===  index = ${selectableImageIndex}');
    }
    notifyListeners();
  }

  updateBaseColorIniatlize(color) {
    textColor = color;

    imageColorList = [];

    print("Text Color ${textColor}");

    notifyListeners();
  }

  updateTattooRotate() {
    if (isImage) {
      if (tattooRotationalAngleList[selectableImageIndex] == 360.0) {
        tattooRotationalAngleList[selectableImageIndex] = 0.0;
      }

      tattooRotationalAngleList[selectableImageIndex] += 45.0;
      print("rotationAngle for Image" +
          tattooRotationalAngleList[selectableImageIndex].toString());
    } else {
      if (rotationAngleForText == 360.0) {
        rotationAngleForText = 0.0;
      }

      rotationAngleForText += 45.0;
      print("rotationAngle for Text $rotationAngleForText");
    }

    notifyListeners();
  }

  updateSwipeClick() {
    isSwipeClick = !isSwipeClick;
    notifyListeners();
  }

  updateIsIncreaseTextSize({value}) {
    isIncreaseTextSize = value;
    notifyListeners();
  }

  updateImageSize({size, index}) {
    imageSizeList[index] = size;
    print('image size ${imageSizeList[index]}');

    // previousSize = imageSizeList[index];

    notifyListeners();
  }

  updateTextSize({size}) {
    textSize = size;
    notifyListeners();
  }

  editTattooBodySelectionInitialize() {
    editTattooBodySelection.clear();
    for (int i = 0; i < 8; i++) editTattooBodySelection.add(false);
    notifyListeners();
  }

  editTattooBodySelectionUpdate({index}) {
    for (int i = 0; i < editTattooBodySelection.length; i++) {
      editTattooBodySelection[i] =
          (i == index) ? !editTattooBodySelection[i] : false;
    }
    notifyListeners();
  }

  updateImagePreview() {
    imagePreview = !imagePreview;
    notifyListeners();
  }

  ///.............................. For Drag Tattoo and Graphic ......................................///

  //Offset imageOffset = Offset(0.0, 0.0);
  List<Offset> imageOffSetList = [];
  Offset textOffset = Offset(0.0, 0.0);

  double imageCurrentRotation = 0.0;
  bool isImageRotating = false;

  bool isTextRotating = false;
  double textCurrentRotation = 0.0;

  bool isImage = false;

  Uint8List? capturedSampleImage;
  Uint8List? capturedActualImage;

  String finalSampleImage = '';
  String finalActualImage = '';

  Uint8List? previewFinalImage;

  // List<Uint8List> imagesListAfterBackgroundRemoval = [];
  List<String> imagesListAfterBackgroundRemoval = [];
  List addToCartImagesFromServer = [];

  updateCapturedImage(context, {Uint8List? image}) async {
    if (!isTattooShowForSS) {
      finalSampleImage = '';

      capturedSampleImage = image;
      print('Sample Image = ${capturedSampleImage}');

      final tempDirectory = await getTemporaryDirectory();
      final imageFile = File('${tempDirectory.path}/sampleImage.png');
      await imageFile.writeAsBytes(capturedSampleImage!);

      EasyLoading.show(
        status: "Preview Image",
        maskType: EasyLoadingMaskType.black,
      );

      await uploadImageApi(context, type: 'sample', file: imageFile);
      print('The final Sample Image is:' + finalSampleImage);

      await tattooShowForSSUpdate(value: true);
    } else {
      capturedActualImage = image;
      print('Actual Image = ${capturedActualImage}');

      final tempDirectory = await getTemporaryDirectory();
      final imageFile = File('${tempDirectory.path}/actualImage.png');
      await imageFile.writeAsBytes(capturedActualImage!);
      await uploadImageApi(context, type: 'actual', file: imageFile);

      print('The final Actual Image is:' + finalActualImage);

      await tattooShowForSSUpdate(value: false);

      // EasyLoading.dismiss();
    }

    notifyListeners();
  }

  addToCartFromServerURLGenerator(context) async {
    addToCartImagesFromServer.clear();
    List listOfImages = [];

    for (int i = 0; i < imagesListAfterBackgroundRemoval.length; i++) {
      if (navigatorkey.currentContext!
          .read<HomeController>()
          .selectGraphics[i]) {
        addToCartImagesFromServer.add(imagesListAfterBackgroundRemoval[i]);
      }
    }

    // addToCartImagesFromServer = await utils.updateCapturedImage(context, images: imagesListAfterBackgroundRemoval,);
    notifyListeners();
  }

  updateOffset({List<Offset>? imageOffsetValue, textOffsetValue}) {
    imageOffSetList = imageOffsetValue!;
    textOffset = textOffsetValue;
    print('imageoffsetList ${imageOffSetList}');

    notifyListeners();
  }

  isImageOrTextUpdation({value}) {
    isImage = value;
    isIncreaseTextSize = !value;

    notifyListeners();
  }

  //................... close ........ //

  updateRotationTattooAngle({tattoo, text}) {
    rotationAngleForText = text;
    tattooRotationalAngleList = tattoo;
    notifyListeners();
  }

  updateIsRotating({value, isImage}) {
    if (isImage) {
      isImageRotating = value;
    } else {
      isTextRotating = value;
    }
    notifyListeners();
  }

  updateCurrentRotation({value, isImage}) {
    if (isImage) {
      imageCurrentRotation = value;
    } else {
      textCurrentRotation = value;
    }
    notifyListeners();
  }

  ///........................ For Showing Tattoo And Product Creation Lottie ......................................///

  bool isCreatingGraphic = false;

  updateCreatingGraphic({value = false}) {
    isCreatingGraphic = value;
    notifyListeners();
  }

  ///........... Select Category...........///

  List<bool> categoryStatus = [];
  List<bool> isFavouriteProduct = [];

  List<bool> selectConfigurableCategoriesStatus = [];
  int configurableCategoryIndex = 0;
  int selectedcategorystatusindex = 0;

  Products? selectedProduct;
  int selectedProductColorImageIndex = 0;
  String selectedProductColorValue = '';

  List<bool> sizesActivationList = [];
  String sizesActivationValue = '';

  bool sizeChangeLoading = false;

  sizeChangeLoadingUpdate({value = false}) {
    sizeChangeLoading = value;
    notifyListeners();
  }

  selectedProductUpdate({value}) {
    selectedProduct = value;

    sizesActivationListUpdate(index: 0);
    notifyListeners();
  }

  sizesActivationListUpdate({index = 0}) {
    sizesActivationList.clear();
    for (int i = 0; i < selectedProduct!.attributes![1].size!.length; i++) {
      if (i == index) {
        sizesActivationList.add(true);
        sizesActivationValue =
            selectedProduct!.attributes![1].size![index].value.toString();
      } else {
        sizesActivationList.add(false);
      }
    }

    notifyListeners();
  }

  selectedProductColorImageIndexUpdate({index = 0}) {
    selectedProductColorImageIndex = index;
    selectedProductColorValue =
        mdColorFromSizeModal.colorFromSizeDataList![index].color.toString();

    print("the index is:" + selectedProductColorImageIndex.toString());
    print("the color Value is:" + selectedProductColorValue.toString());

    notifyListeners();
  }

  categoryStatusInitialize() {
    categoryStatus.clear();
    isFavouriteProduct.clear();
    for (int i = 0; i < configurableProductList.length; i++) {
      categoryStatus.add(false);
      isFavouriteProduct.add(false);
    }

    for (int i = 0; i < categoryStatus.length; i++)
      print("categoryStatus ${categoryStatus[i]}");
    notifyListeners();
  }

  selectConfigurableCategoriesInitialize({length}) {
    selectConfigurableCategoriesStatus.clear();
    for (int i = 0; i < length; i++)
      i == 0
          ? selectConfigurableCategoriesStatus.add(true)
          : selectConfigurableCategoriesStatus.add(false);

    configurableCategoryIndex = 0;

    for (int i = 0; i < length; i++)
      print("selectGenderStatus ${selectConfigurableCategoriesStatus[i]}");

    notifyListeners();
  }

  selectConfigurableCategoriesStatusUpdate({index}) {
    // Check if the selected index is already true, if yes, just return.
    if (selectConfigurableCategoriesStatus[index]) {
      return;
    }

    for (int i = 0; i < selectConfigurableCategoriesStatus.length; i++) {
      if (i == index) {
        selectConfigurableCategoriesStatus[i] = true; // Directly set to true
      } else {
        selectConfigurableCategoriesStatus[i] = false;
      }
    }

    configurableCategoryIndex = index;

    print('Status ${selectConfigurableCategoriesStatus[index]}');
    notifyListeners();
  }

  categoryStatusUpdate({index}) {
    for (int i = 0; i < categoryStatus.length; i++) {
      categoryStatus[i] = (i == index) ? !categoryStatus[i] : false;
    }

    selectedcategorystatusindex = index;
    print('Status ${categoryStatus[index]}');
    print('Fix ${categoryStatus[index]}');
    notifyListeners();
  }

  favouriteProductUpdator({id}) {
    productList
        .where((product) => product.sId.toString() == id.toString())
        .forEach((product) {
      product.isFeatured =
          !product.isFeatured!; // Toggle the 'isFeature' property
      mdProductDetailModal.data!.isFeatured = product.isFeatured;
    });

    notifyListeners();
  }

  addToCartProductUpdator({id}) {
    productList
        .where((product) => product.sId.toString() == id.toString())
        .forEach((product) {
      product.isProductIntoCart = true;
      mdProductDetailModal.data!.isProductIntoCart = true;

      print(
          "The proudct ID is: ${product.sId.toString()}   and status is: ${product.isProductIntoCart.toString()}");
    });

    notifyListeners();
  }

  createTattooDesignSelectionUpdate({index}) {
    bool anyItemIsTrue = false;

    for (int i = 0; i < createTattooDesignSelection.length; i++) {
      if (i == index) {
        createTattooDesignSelection[i] = true;
        anyItemIsTrue = true;
      } else {
        createTattooDesignSelection[i] = false;
      }
    }

    if (!anyItemIsTrue && createTattooDesignSelection.isNotEmpty) {
      createTattooDesignSelection[0] = true;
    }

    notifyListeners();
  }

  ///....................... For Calculate Size Group Price ................///

  double totalPrice = 0.0;
  int totalQuantity = 0;
  String textSizeId = '';

  List<SelectedTattoosData> tattoosPriceListAndData = [];
  List<OrderProducts> placeOrderDataList = [];

  calculateSizeGroupPriceFunc() {
    tattoosPriceListAndData.clear();
    placeOrderDataList.clear();

    for (int i = 0; i < imageSizeList.length; i++)
      print("imageSizeList Length ${imageSizeList[i] / 8}");

    for (int i = 0; i < mdSizeGroup.mdSizeGroupData!.sizeGroups!.length; i++)
      print(
          "Size Group Prices ${mdSizeGroup.mdSizeGroupData!.sizeGroups![i].prices!.mixed!}");

    for (int i = 0; i < imageSizeList.length; i++) {
      for (int j = 0;
          j < mdSizeGroup.mdSizeGroupData!.sizeGroups!.length;
          j++) {
        if ((imageSizeList[i] / 8).floor() >=
                mdSizeGroup.mdSizeGroupData!.sizeGroups![j].startingWidth! &&
            (imageSizeList[i] / 8).floor() <=
                mdSizeGroup.mdSizeGroupData!.sizeGroups![j].endingWidth!) {
          if (isFromTattoo) {
            if (createTattooDesignSelection[0]) {
              tattoosPriceListAndData.add(SelectedTattoosData(
                  price: mdSizeGroup
                      .mdSizeGroupData!.sizeGroups![j].prices!.blackNWhite!
                      .toDouble(),
                  id: mdSizeGroup.mdSizeGroupData!.sizeGroups![j].sId));
            } else if (createTattooDesignSelection[1]) {
              tattoosPriceListAndData.add(SelectedTattoosData(
                  price: mdSizeGroup
                      .mdSizeGroupData!.sizeGroups![j].prices!.colored!
                      .toDouble(),
                  id: mdSizeGroup.mdSizeGroupData!.sizeGroups![j].sId));
            } else if (createTattooDesignSelection[2]) {
              tattoosPriceListAndData.add(SelectedTattoosData(
                  price: mdSizeGroup
                      .mdSizeGroupData!.sizeGroups![j].prices!.mixed!
                      .toDouble(),
                  id: mdSizeGroup.mdSizeGroupData!.sizeGroups![j].sId));
            }
            break;
          } else {
            tattoosPriceListAndData.add(SelectedTattoosData(
                price: mdSizeGroup
                    .mdSizeGroupData!.sizeGroups![j].prices!.mixed!
                    .toDouble(),
                id: mdSizeGroup.mdSizeGroupData!.sizeGroups![j].sId));
          }
        }
      }
    }

    print("List Length ${tattoosPriceListAndData.length}");

    for (int i = 0; i < tattoosPriceListAndData.length; i++) {
      print("index ${tattoosPriceListAndData[i].price}");
      placeOrderDataList.add(OrderProducts(
        quantity: 1,
        productPrice: tattoosPriceListAndData[i].price,
        productImage: selectableTattoosAndGraphicList[i].toString(),
        productID: tattoosPriceListAndData[i].id,
        bodyPart: bodyPartIndexUpdate + 1,
        color: createTattooDesignSelection[0]
            ? 1
            : createTattooDesignSelection[1]
                ? 2
                : 3,
      ));
    }

    for (int i = 0; i < placeOrderDataList.length; i++)
      print('Qunatity ${placeOrderDataList[i].quantity}');

    calculatePriceByQuantity();

    notifyListeners();
  }

  calculatePriceByQuantity() {
    totalPrice = 0.0;
    totalQuantity = 0;
    // totalPrice = placeOrderDataList.map((item) => item.productPrice! * item.quantity!) // Calculate price for each item (price * quantity)
    //     .reduce((value, element) => value + element); // Calculate the sum of all item prices

    placeOrderDataList.map((item) => item.productPrice! * item.quantity!);
    for (int i = 0; i < placeOrderDataList.length; i++) {
      print("The $i is:" + placeOrderDataList[i].productPrice.toString());
      totalPrice = totalPrice + placeOrderDataList[i].productPrice!.toDouble();
      totalQuantity = totalQuantity + placeOrderDataList[i].quantity!.toInt();
    }

    print("The The sum of the total is:" + totalPrice.toString());
    print("The quantity of the total is:" + totalQuantity.toString());

    notifyListeners();
  }

  getTextSizeGroupId() {
    for (int j = 0; j < mdSizeGroup.mdSizeGroupData!.sizeGroups!.length; j++) {
      if ((textSize / 8).floor() >=
              mdSizeGroup.mdSizeGroupData!.sizeGroups![j].startingWidth! &&
          (textSize / 8).floor() <=
              mdSizeGroup.mdSizeGroupData!.sizeGroups![j].endingWidth!) {
        textSizeId = mdSizeGroup.mdSizeGroupData!.sizeGroups![j].sId.toString();
        break;
      }
    }
    return textSizeId;
  }

  //............................... Place Order ...............//

  List<bool> selectDesignImprint = [];
  String selectedDesignImprint = '';

  MDDesignImprintData selectImprintDataDetail = MDDesignImprintData();

  double previousPrice = 0.0;
  double currentPrice = 0.0;

  selectDesignImprintUpdate({index = 0, price = 0.0}) {
    selectDesignImprint.clear();
    for (int i = 0; i < mdDesignImprint.mdDesignImprintData!.length; i++) {
      if (i == index) {
        selectDesignImprint.add(true);
        selectedDesignImprint =
            mdDesignImprint.mdDesignImprintData![i].title.toString();
        selectImprintDataDetail = MDDesignImprintData(
            title: selectedDesignImprint,
            price: mdDesignImprint.mdDesignImprintData![i].price,
            sId: mdDesignImprint.mdDesignImprintData![i].sId);
        updatePriceFunction(price: price);
      } else {
        selectDesignImprint.add(false);
      }
    }
    notifyListeners();
  }

  updatePriceFunction({price = 0.0}) {
    totalPrice = ((totalPrice - previousPrice) + price);
    previousPrice = price;
    notifyListeners();
  }

  uploadImage(
    context, {
    Uint8List? images,
  }) async {
    print("Before Product Image Update ${selectedProduct!.image}");

    selectedProduct!.image = '';

    final tempDirectory = await getTemporaryDirectory();
    final imageFile = File('${tempDirectory.path}/sampleImage.png');
    await imageFile.writeAsBytes(images!);

    var image = await navigatorkey.currentContext!
        .read<HomeController>()
        .uploadImageApi(context, type: '', file: imageFile);
    selectedProduct!.image = image;

    print("Product Image Update ${selectedProduct!.image}");

    notifyListeners();
  }

  //......................... apis.......................//

  int isFirstTime = 0;
  bool isFromOnTap = false;

  updateIsFirstTime({value = 0}) {
    isFirstTime = value;

    print("isFirstTime Value ${isFirstTime}");
    notifyListeners();
  }

  updateIsFromOnTap({value = false}) {
    isFromOnTap = value;

    print("isFormontap value ${isFromOnTap} ");
    notifyListeners();
  }

  categoryListingApi(context,
      {type = '0', title = '', isLoading = false, isFirstTime = false}) async {
    apiResponse = 0;

    if (type == '3') {
      configurableLoadingStatus(status: true);
      EasyLoading.show(
          status: 'Loading products...', maskType: EasyLoadingMaskType.black);
    } else {
      loadingStatus(status: true);
    }

    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var apis = HomeApisServices();

    Map<String, dynamic> data = Map();
    data['title'] = "${title}";
    data['type'] = int.parse(type);

    print(data.toString());

    var response = await apis.categoryListing(data: data);
    print('The Category Listing  Api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        if (isLoading) {
          categoryList.clear();
          print("categoryList ${categoryList}");
        }

        print("The selected Tab index is:" + tabIndex.toString());

        //....................... For Home Fragment ....................//

        if (type == '0') {
          inspirationalDataList.clear();

          mdCategoriesModal = MDCategoriesModal.fromJson(response);
          inspirationalDataList.addAll(mdCategoriesModal.data!.categories!);

          if (inspirationalDataList.isNotEmpty) {
            categoryList.addAll(inspirationalDataList);
            if (tabIndex == 0 &&
                categoryList.length == inspirationalDataList.length &&
                categoryList[0].sId == inspirationalDataList[0].sId) {
              await productListingApi(context,
                  type: type,
                  title: '',
                  categoryID: categoryList[0].sId,
                  isLoading: false);
            }
            print('The length of inspiration Data:' +
                inspirationalDataList.length.toString());
          }
        } else if (type == '1') {
          discoverDataList.clear();
          mdCategoriesModal = MDCategoriesModal.fromJson(response);
          discoverDataList.addAll(mdCategoriesModal.data!.categories!);

          print('The length of discovery Data:' +
              discoverDataList.length.toString());

          if (discoverDataList.isNotEmpty) {
            categoryList.addAll(discoverDataList);
            if (tabIndex == 1 &&
                categoryList.length == discoverDataList.length &&
                categoryList[0].sId == discoverDataList[0].sId) {
              await productListingApi(context,
                  type: type,
                  title: '',
                  categoryID: categoryList[0].sId,
                  isLoading: false);
            }
          }
        } else if (type == '2') {
          tattooDataList.clear();
          mdCategoriesModal = MDCategoriesModal.fromJson(response);
          tattooDataList.addAll(mdCategoriesModal.data!.categories!);
          print(
              'The length of tattoo Data:' + tattooDataList.length.toString());

          if (tattooDataList.isNotEmpty) {
            categoryList.addAll(tattooDataList);
            if (tabIndex == 2 &&
                categoryList.length == tattooDataList.length &&
                categoryList[0].sId == tattooDataList[0].sId) {
              await productListingApi(context,
                  type: type,
                  title: '',
                  categoryID: categoryList[0].sId,
                  isLoading: false);
            }
          }
        } else if (type == '4') {
          fashionDataList.clear();

          mdCategoriesModal = MDCategoriesModal.fromJson(response);
          fashionDataList.addAll(mdCategoriesModal.data!.categories!);
          print('The length of fashion Data:' +
              fashionDataList.length.toString());

          if (fashionDataList.isNotEmpty) {
            categoryList.addAll(fashionDataList);
            if (tabIndex == 3 &&
                categoryList.length == fashionDataList.length &&
                categoryList[0].sId == fashionDataList[0].sId) {
              await productListingApi(context,
                  type: type,
                  title: '',
                  categoryID: categoryList[0].sId,
                  isLoading: false);
            }
          }
        }

        if (type != '3') {
          loadingStatus(status: false);
          tabIndexUpdator(context, index: tabIndex);
        }
        //............................... ####### ...............................//

        if (type == '3') {
          configureDataList.clear();
          mdCategoriesModal = MDCategoriesModal.fromJson(response);
          configureDataList.addAll(mdCategoriesModal.data!.categories!);
          print('The length of fashion Data:' +
              configureDataList.length.toString());
          configurableLoadingStatus(status: false);

          if (configureDataList.isNotEmpty) {
            if (configureDataList[0].subCategories!.isNotEmpty) {
              productListingApi(context,
                  type: type,
                  title: '',
                  categoryID: configureDataList[0].subCategories![0].sId,
                  isLoading: false,
                  isLoadingFromConfigurable: true);

              selectedCategoryForConfigurableUpdator(
                index: 0,
                ID: configureDataList[0].subCategories![0].sId,
                type: '3',
              );
            }
          }
        }

        notifyListeners();
        return true;
      } else {
        // mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('Failed to fetch categories',
            dismissOnTap: true,
            duration: Duration(seconds: 1),
            toastPosition: EasyLoadingToastPosition.bottom);
        return false;
      }
    } else {
      // mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('Failed to fetch categories',
          dismissOnTap: true,
          duration: Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.bottom);
      return false;
    }
  }

  // productListingApi(context,
  //     {categoryID, title = '', type, isLoading = true,page}) async {
  //   apiResponse = 0;
  //
  //   if (type == '3' ) {
  //     configurableProductList.clear();
  //   }
  //
  //   else {
  //     productList.clear();
  //   }
  //
  //   SharedPreferences myPrefs = await SharedPreferences.getInstance();
  //   var apis = HomeApisServices();
  //
  //   productLoadingStatus(status: true);
  //
  //   if (isLoading) {
  //     EasyLoading.show(status: 'Fetching Product');
  //   }
  //
  //   Map<String, dynamic> data = Map();
  //   data['title'] = "${title}";
  //   data['categoryId'] = categoryID;
  //   data['type'] = int.parse(type);
  //   data['page'] = page;
  //
  //   print(data.toString());
  //
  //   var response = await apis.productListing(data: data);
  //   print('The Product Listing  Api response is:' + response.toString());
  //
  //   if (response != null) {
  //     if (response['status'] == 1) {
  //       mdProductModal = MDProductModal.fromJson(response);
  //
  //       if (type == '3') {
  //         configurableProductList.clear();
  //         configurableProductList.addAll(mdProductModal.data!.products!);
  //         await categoryStatusInitialize();
  //
  //         print('The length of Data:' +
  //             configurableProductList.length.toString());
  //       } else {
  //         if (tabIndex == 0) {
  //           inspirationProductList.clear();
  //           inspirationProductList.addAll(mdProductModal.data!.products!);
  //           productList.addAll(mdProductModal.data!.products!);
  //           print('The length of Data 0:' +
  //               inspirationProductList.length.toString());
  //         } else if (tabIndex == 1) {
  //           discoverProductList.clear();
  //           discoverProductList.addAll(mdProductModal.data!.products!);
  //           productList.addAll(mdProductModal.data!.products!);
  //           print('The length of Data 1:' +
  //               discoverProductList.length.toString());
  //         } else if (tabIndex == 2) {
  //           tattooProductList.clear();
  //           tattooProductList.addAll(mdProductModal.data!.products!);
  //           productList.addAll(mdProductModal.data!.products!);
  //           print(
  //               'The length of Data 2:' + tattooProductList.length.toString());
  //         } else {
  //           fashionProductList.clear();
  //           fashionProductList.addAll(mdProductModal.data!.products!);
  //           productList.addAll(mdProductModal.data!.products!);
  //           print(
  //               'The length of Data 4:' + fashionProductList.length.toString());
  //         }
  //       }
  //
  //       productLoadingStatus(status: false);
  //       EasyLoading.dismiss();
  //
  //       notifyListeners();
  //       return true;
  //     } else {
  //       mdErrorModal = MDErrorModal.fromJson(response);
  //       // EasyLoading.showToast('${mdErrorModal.message}',dismissOnTap: true,duration: Duration(seconds: 1),toastPosition: EasyLoadingToastPosition.bottom);
  //       return false;
  //     }
  //   } else {
  //     mdErrorModal = MDErrorModal.fromJson(response);
  //     //  EasyLoading.showToast('${mdErrorModal.message}',dismissOnTap: true,duration: Duration(seconds: 1),toastPosition: EasyLoadingToastPosition.bottom);
  //     return false;
  //   }
  // }

  productListingApi(context,
      {categoryID,
      title = '',
      type,
      isLoading = true,
      isLoadingFromConfigurable = false,
      page = 1}) async {
    apiResponse = 0;

    FocusScope.of(context).unfocus();

    if (type == '3' && page == 1) {
      configurableProductList.clear();
      configurablePage = 1;
    } else if (type != '3' && page == 1) {
      productList.clear();
      productPage = 1;
    }

    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var apis = HomeApisServices();

    generalWatch.updateRestrictUserNavigation(value: true);

    productLoadingStatus(status: true, value: 1);

    if (isLoading) {
      EasyLoading.show(
          status:
              productPage > 1 ? 'Loading more products' : 'Loading products',
          maskType: EasyLoadingMaskType.black);
    }

    if (isLoadingFromConfigurable) {
      EasyLoading.show(
          status: configurablePage > 1
              ? 'Loading more products'
              : 'Loading products...',
          maskType: EasyLoadingMaskType.black);
    }

    Map<String, dynamic> data = Map();
    data['title'] = "${title}";
    data['categoryId'] = categoryID;
    data['type'] = int.parse(type);
    data['page'] = page;

    print(data.toString());

    var response = await apis.productListing(data: data);
    print('The Product listing  Api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdProductModal = MDProductModal.fromJson(response);
        if (type == '3') {
          if (configurablePage == 1) {
            configurableProductList.clear();

            print('object ${configurableProductList}');
          }
          if (count == 1) {
            configurableProductList.addAll(mdProductModal.data!.products!);
            await categoryStatusInitialize();

            print('The length of Data:' +
                configurableProductList.length.toString());
            if (mdProductModal.data!.pagination!.pages!.toInt() >= page) {
              configurablePage = configurablePage + 1;
              print("the configurable page is:" + configurablePage.toString());
            }
          }
        } else {
          if (tabIndex == 0) {
            if (productPage == 1) {
              inspirationProductList.clear();
            }
            if (count == 1) {
              inspirationProductList.addAll(mdProductModal.data!.products!);
              productList.addAll(mdProductModal.data!.products!);
              print('The length of Data 0:' +
                  inspirationProductList.length.toString());
            }
            print("count Value ${count}");
          } else if (tabIndex == 1) {
            if (productPage == 1) {
              discoverProductList.clear();
            }
            if (count == 1) {
              discoverProductList.addAll(mdProductModal.data!.products!);
              productList.addAll(mdProductModal.data!.products!);
              print('The length of Data 1:' +
                  discoverProductList.length.toString());
            }
          } else if (tabIndex == 2) {
            if (productPage == 1) {
              tattooProductList.clear();
            }
            if (count == 1) {
              tattooProductList.addAll(mdProductModal.data!.products!);
              productList.addAll(mdProductModal.data!.products!);
              print('The length of Data 2:' +
                  tattooProductList.length.toString());
            }
          } else {
            if (productPage == 1) {
              fashionProductList.clear();
            }
            if (count == 1) {
              fashionProductList.addAll(mdProductModal.data!.products!);
              productList.addAll(mdProductModal.data!.products!);
              print('The length of Data 4:' +
                  fashionProductList.length.toString());
            }
          }

          if (count == 1) {
            if (mdProductModal.data!.pagination!.pages!.toInt() >= page) {
              productPage = productPage + 1;
              print("the product page is:" + productPage.toString());
            }
          }
        }

        productLoadingStatus(status: false);

        generalWatch.updateRestrictUserNavigation();

        EasyLoading.dismiss();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        // EasyLoading.showToast('${mdErrorModal.message}',dismissOnTap: true,duration: Duration(seconds: 1),toastPosition: EasyLoadingToastPosition.bottom);
        generalWatch.updateRestrictUserNavigation();
        productLoadingStatus(status: false);

        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      generalWatch.updateRestrictUserNavigation();
      //  EasyLoading.showToast('${mdErrorModal.message}',dismissOnTap: true,duration: Duration(seconds: 1),toastPosition: EasyLoadingToastPosition.bottom);
      productLoadingStatus(status: false);

      return false;
    }
  }

  productDetailApi(context, {productID}) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var apis = HomeApisServices();

    generalWatch.updateRestrictUserNavigation(value: true);

    EasyLoading.show(status: 'Getting Product Detail');

    Map<String, dynamic> data = Map();
    data['productId'] = "${productID}";

    var response = await apis.productDetail(data: data);
    print('The Product Listing  Api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdProductDetailModal = MDProductDetailModal.fromJson(response);

        Navigator.pushNamed(context, routes.productDetailScreenRoute);

        EasyLoading.dismiss();

        generalWatch.updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        generalWatch.updateRestrictUserNavigation();
        // EasyLoading.showToast('${mdErrorModal.message}',dismissOnTap: true,duration: Duration(seconds: 1),toastPosition: EasyLoadingToastPosition.bottom);
        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      generalWatch.updateRestrictUserNavigation();
      //  EasyLoading.showToast('${mdErrorModal.message}',dismissOnTap: true,duration: Duration(seconds: 1),toastPosition: EasyLoadingToastPosition.bottom);
      return false;
    }
  }

  uploadImageApi(context, {file, type = '', isLoading = false}) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    var apis = GeneralApisServices();

    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        file!.path,
        filename:
            'image.jpg', // Replace with the desired filename on the server
      ),
    });

    var response = await apis.uploadingImage(formData);

    if (response != null) {
      if (response['status'] == 1) {
        String apiData = response['imageURL'];

        if (type == 'actual') {
          finalActualImage = apiData;
        } else if (type == 'sample') {
          finalSampleImage = apiData;
        } else {
          var image = apiData;
          return image;
        }

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        utils.apiResponseToast(message: 'Failed to Get Response');
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      utils.apiResponseToast(message: 'Failed to Get Response');
      return false;
    }
  }

  tattooAndGraphicGenerationAPi(context, {color, isFromProduct = false}) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    FocusManager.instance.primaryFocus?.unfocus();

    var apis = HomeApisServices();

    generalWatch.updateRestrictUserNavigation(value: true);
    // EasyLoading.show(
    //     status: isFromProduct ? "Generating Graphic" : "Generating Tattoo",
    //     maskType: EasyLoadingMaskType.black);

    updateCreatingGraphic(value: true);

    var data = json.encode({
      "prompt":
          "Surrealism tattoo style, ${isFromProduct ? productDesirePromptController.text : designPromptController.text}, ${color}, white background, --no skin 3x3 png image",
      "n": 3,
      "size": "1024x1024",
    });

    print(data.toString());

    var response = await apis.tattooAndGraphicGeneration(data: data);

    print('Image Generation Response:' + response.toString());

    if (response != null) {
      listOfTattos.clear();
      mdTattooAndGraphicsGenerationModal =
          MDTattooAndGraphicsGenerationModal.fromJson(jsonDecode(response));

      for (int i = 0;
          i < mdTattooAndGraphicsGenerationModal.imagesList!.length;
          i++) {
        final tattoo =
            mdTattooAndGraphicsGenerationModal.imagesList![i].url.toString();
        // print('Base64 Encoded Image: $tattoo');
        listOfTattos.add(tattoo);
      }

      // print("The list is::::"+ listOfTattoos.length.toString());
      await pythonBackGroundRemoverApi(context, list: listOfTattos);
      await backGroundRemoverApi(context,
          list: imagesListAfterBackgroundRemoval);

      // await sizeGroupAPi(context, isLoading: false, isFromProduct: isFromProduct);
      // if (desireTextController.text.isNotEmpty ||
      //     productDesireTextController.text.isNotEmpty)
      //   await sizeGroupAPi(context, isLoading: false, isDesireText: true);
      selectGraphicsStatusInitialize();
      updateIsShowGraphicsContainer();
      imagePreview = false;

      updateCreatingGraphic(value: false);
      generalWatch.updateRestrictUserNavigation();
      // EasyLoading.dismiss();

      notifyListeners();
      return true;
    } else {
      EasyLoading.showError("Cannot Generate Tattoos");
      generalWatch.updateRestrictUserNavigation();
      return false;
    }

    // await selectGraphicsStatusInitialize(imagesLength: 3);
    // await updateIsShowGraphicsContainer();

    //EasyLoading.dismiss();

    // notifyListeners();
  }

  backGroundRemoverApi(context, {list}) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var apis = GeneralApisServices();

    final Map<String, dynamic> data = {
      "imageUrls": list,
      "removeBg": 0,
    };

    print("The form data is:" + data.toString());

    var response = await apis.backGroundRemover(data: data);
    print("the Response is:" + response.toString());

    if (response != null) {
      imagesListAfterBackgroundRemoval.clear();
      List apiData = response['images'];
      print("The data after background remover is:" + apiData.toString());

      for (int i = 0; i < apiData.length; i++) {
        imagesListAfterBackgroundRemoval.add(apiData[i]);
      }

      notifyListeners();
      return true;
    } else {
      // mdErrorModal = MDErrorModal.fromJson(response);
      utils.apiResponseToast(message: 'Failed to Get Response');
      return false;
    }
  }

  pythonBackGroundRemoverApi(context, {list}) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var apis = GeneralApisServices();

    final Map<String, dynamic> data = {
      "image_urls": list,
    };

    print("The form data is:" + data.toString());

    var response = await apis.pythonBackGroundRemover(data: data);
    print("the Response is:" + response.toString());

    if (response != null) {
      imagesListAfterBackgroundRemoval.clear();
      List apiData = response['images'];
      print(
          "The data after python background remover is:" + apiData.toString());

      for (int i = 0; i < apiData.length; i++) {
        imagesListAfterBackgroundRemoval.add(apiData[i]);
      }

      notifyListeners();
      return true;
    } else {
      // mdErrorModal = MDErrorModal.fromJson(response);
      utils.apiResponseToast(message: 'Failed to Get Response');
      return false;
    }
  }

  edgesCuttingApi(context, {previewImage, referenceImage}) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var apis = GeneralApisServices();
    FormData formData = FormData.fromMap({
      'preview_image_url': '${previewImage}',
      'reference_image_url': '${referenceImage}'
    });

    print("The form data is:" + formData.toString());

    var response = await apis.edgesCutting(data: formData);

    print("the Response is:" + response.toString());

    if (response != null) {
      if (response['status']) {
        String apiData = response['result_image'];
        print("The data after edges cutting is:" + apiData.toString());

        previewFinalImage = utils.base64ToBytes(apiData);

        print("The preview Image is:" + previewFinalImage.toString());

        updateImagePreview();

        EasyLoading.dismiss();
        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        utils.apiResponseToast(message: 'Failed to Get Response');
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      utils.apiResponseToast(message: 'Failed to Get Response');
      return false;
    }
  }

  sizeGroupAPi(context,
      {isLoading = true, isDesireText = false, isFromProduct = false}) async {
    print('bool Value ${isDesireText} + ${isFromProduct} + ${isLoading}');

    var apis = OrdersCheckoutWishlistServices();
    isDesireText
        ? mdSizeGroupText = MDSizeGroup()
        : mdSizeGroup = MDSizeGroup();

    generalWatch.updateRestrictUserNavigation(value: true);

    if (isLoading)
      EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.black);

    final Map<String, dynamic> data = isDesireText
        ? {"bodyPart": 0, "type": 2}
        : isFromProduct
            ? {"bodyPart": 0, "type": 1}
            : {"bodyPart": bodyPartIndexUpdate + 1, "type": 0};
    print(data.toString());

    var response = await apis.sizeGroup(
      data: data,
    );

    print('Size Group Response:' + response.toString());

    if (response != null) {
      isDesireText
          ? mdSizeGroupText = MDSizeGroup.fromJson(response)
          : mdSizeGroup = MDSizeGroup.fromJson(response);

      if (isDesireText) {
        if (mdSizeGroupText.mdSizeGroupData!.sizeLimits!.start != null &&
            mdSizeGroupText.mdSizeGroupData!.sizeLimits!.end != null) {
          mdSizeGroupText.mdSizeGroupData!.sizeLimits!.start =
              mdSizeGroupText.mdSizeGroupData!.sizeLimits!.start! * 8;
          mdSizeGroupText.mdSizeGroupData!.sizeLimits!.end =
              mdSizeGroupText.mdSizeGroupData!.sizeLimits!.end! * 8;

          // for (int i = 0;
          //     i < mdSizeGroupText.mdSizeGroupData!.sizeGroups!.length;
          //     i++) {
          //   await initializeImageOffsets();
          // }
          textSize =
              mdSizeGroupText.mdSizeGroupData!.sizeLimits!.end!.toDouble();

          print(
              'SizeLimitText start ${mdSizeGroupText.mdSizeGroupData!.sizeLimits!.start}');
          print(
              'SizeLimitText end ${mdSizeGroupText.mdSizeGroupData!.sizeLimits!.end}');

          if (isLoading) ;
          EasyLoading.dismiss();
          generalWatch.updateRestrictUserNavigation();

          notifyListeners();
          return true;
        }
      } else if (mdSizeGroup.mdSizeGroupData!.sizeLimits!.start != null &&
          mdSizeGroup.mdSizeGroupData!.sizeLimits!.end != null) {
        mdSizeGroup.mdSizeGroupData!.sizeLimits!.start =
            mdSizeGroup.mdSizeGroupData!.sizeLimits!.start! * 8;
        mdSizeGroup.mdSizeGroupData!.sizeLimits!.end =
            mdSizeGroup.mdSizeGroupData!.sizeLimits!.end! * 8;

        // for (int i = 0;
        //     i < mdSizeGroup.mdSizeGroupData!.sizeGroups!.length;
        //     i++) {
        await initializeImageOffsets();
        // }
        print(
            'SizeLimit start ${mdSizeGroup.mdSizeGroupData!.sizeLimits!.start}');

        print('SizeLimit end ${mdSizeGroup.mdSizeGroupData!.sizeLimits!.end}');

        print(
            "Size Group Api Length${mdSizeGroup.mdSizeGroupData!.sizeGroups!.length}");

        if (isLoading) ;
        EasyLoading.dismiss();
        generalWatch.updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        EasyLoading.showError("Cannot fetch data");
        generalWatch.updateRestrictUserNavigation();

        return false;
      }
    }
  }

  variationGroupApi(context) async {
    var apis = HomeApisServices();
    generalWatch.updateRestrictUserNavigation(value: true);
    EasyLoading.show(
        status: "Loading",
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false);

    Map<String, dynamic> data = Map();
    data['productId'] = "${selectedProduct!.sId}";
    data['color'] = selectedProductColorValue;
    data['size'] = sizesActivationValue;

    print("The data is:" + data.toString());

    var response = await apis.variationGroup(data: data);

    print("the Response of variation Price is:" + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdVariationModal = MDVariationModal.fromJson(response);

        await uploadImage(context, images: previewFinalImage!);

        await designImprintApi(context);
        generalWatch.updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        utils.apiResponseToast(message: 'Failed to Get Response');
        generalWatch.updateRestrictUserNavigation();
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      utils.apiResponseToast(message: 'Failed to Get Response');
      generalWatch.updateRestrictUserNavigation();
      return false;
    }
  }

  designImprintApi(context) async {
    var apis = OrdersCheckoutWishlistServices();

    var response = await apis.designImprint();

    print("The design Imprint Response is:" + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdDesignImprint = MDDesignImprint.fromJson(response);

        var length = mdDesignImprint.mdDesignImprintData!.length;
        selectDesignImprint.clear();

        for (int i = 0; i < length; i++) {
          // if (i == 0) {
          //   selectDesignImprint.add(true);
          //   selectedDesignImprint =
          //       mdDesignImprint.mdDesignImprintData![i].title.toString();
          //   selectImprintDataDetail = MDDesignImprintData(
          //       title: selectedDesignImprint,
          //       price: mdDesignImprint.mdDesignImprintData![i].price,
          //       sId: mdDesignImprint.mdDesignImprintData![i].sId);
          //   totalPrice =
          //       mdDesignImprint.mdDesignImprintData![i].price!.toDouble() +
          //           totalPrice;
          //   previousPrice =
          //       mdDesignImprint.mdDesignImprintData![i].price!.toDouble();
          // } else {
          selectDesignImprint.add(false);
          // }
        }

        EasyLoading.dismiss();
        Navigator.pushNamed(context, routes.placeOrderScreenRoute);

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showError(
          "${mdErrorModal.message}",
          maskType: EasyLoadingMaskType.black,
        );

        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showError(
        "${mdErrorModal.message}",
        maskType: EasyLoadingMaskType.black,
      );
      return false;
    }
  }

  getColorFromSizeApi(context, {loadingMessage, isRoute = false, size}) async {
    var apis = OrdersCheckoutWishlistServices();

    generalWatch.updateRestrictUserNavigation(value: true);
    EasyLoading.show(
        status: loadingMessage, maskType: EasyLoadingMaskType.black);
    Map<String, dynamic> data = Map();
    data['productId'] = "${selectedProduct!.sId.toString()}";
    data['size'] = size;

    print(data.toString());

    var response = await apis.getColorFromSize(data);

    print("The Get Color From Size is:" + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdColorFromSizeModal = MDColorFromSizeModal.fromJson(response);
        EasyLoading.dismiss();
        selectedProductColorImageIndexUpdate(index: 0);
        sizeChangeLoadingUpdate(value: true);

        if (isRoute) {
          Navigator.pushNamed(context, routes.createProductScreenRoute);
        }
        generalWatch.updateRestrictUserNavigation();
        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        sizeChangeLoadingUpdate(value: false);
        EasyLoading.dismiss();
        EasyLoading.showError(
          "${mdErrorModal.message}",
          maskType: EasyLoadingMaskType.black,
        );
        generalWatch.updateRestrictUserNavigation();
        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      sizeChangeLoadingUpdate(value: false);
      EasyLoading.dismiss();
      EasyLoading.showError(
        "${mdErrorModal.message}",
        maskType: EasyLoadingMaskType.black,
      );
      generalWatch.updateRestrictUserNavigation();

      return false;
    }
  }
}
