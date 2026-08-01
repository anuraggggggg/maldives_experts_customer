import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier {
  int _selectedSearchCategory = 0;

  int get selectedSearchCategory => _selectedSearchCategory;

  void selectSearchCategory(int index) {
    if (_selectedSearchCategory == index) return;
    _selectedSearchCategory = index;
    notifyListeners();
  }
}
