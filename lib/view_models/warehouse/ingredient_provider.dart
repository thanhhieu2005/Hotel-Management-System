import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotel_management_system/models/ingredient.dart';
import 'package:hotel_management_system/services/data_provider/warehouse_data_provider.dart';
import 'package:hotel_management_system/services/data_repository/kitchen_data_repository.dart';

class IngredientProvider extends ChangeNotifier {
  bool _isLoad = true;
  List<Ingredient> _listIngredient = [];
  TextEditingController ingreNameText = TextEditingController();
  TextEditingController ingrePriceText = TextEditingController();
  TextEditingController unitText = TextEditingController();

  TextEditingController ingreNewPriceText = TextEditingController();

  IngredientProvider() {
    loadAllIngredient();
  }

  bool get isLoad => _isLoad;

  set isLoad(value) {
    _isLoad = value;
    notifyListeners();
  }

  List<Ingredient> get listIngredient {
    return _listIngredient;
  }

  void loadAllIngredient() async {
    _listIngredient = await KitchenDataRepository.getAllIngre();
    isLoad = false;
  }

  void clearTextAddIngre() {
    ingreNameText.clear();
    ingrePriceText.clear();
    unitText.clear();
  }

  Future addIngredient(Function onSuccess, Function onFail) async {
    if (ingreNameText.text.isNotEmpty &&
        ingrePriceText.text.isNotEmpty &&
        unitText.text.isNotEmpty) {
      try {
        isLoad = true;
        await WarehouseDataProvider().addIngredient(
            ingreName: ingreNameText.text,
            ingrePrice: int.parse(ingrePriceText.text),
            unit: unitText.text);
        onSuccess();
        loadAllIngredient();
        clearTextAddIngre();
      } on DioError catch (err) {
        err.message;
      }
    } else
      onFail();
  }

  Future updateIngredient(
      Function onSuccess, Function onFail, String ingreID) async {
    if (ingreNewPriceText.text.isNotEmpty) {
      try {
        isLoad = true;
        await WarehouseDataProvider().updateIngredient(
            ingreID: ingreID, newPrice: int.parse(ingreNewPriceText.text));
        onSuccess();
        ingreNewPriceText.clear();
        loadAllIngredient();
      } on DioError catch (err) {
        err.message;
      }
    } else
      onFail();
  }

  Future deleteIngredient(String ingreID) async {
    try {
      await WarehouseDataProvider().deleteIngredient(ingreID: ingreID);
      loadAllIngredient();
      notifyListeners();
    } on DioError catch (err) {
      err.message;
    }
  }
}
