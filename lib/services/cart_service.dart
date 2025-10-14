import 'package:flutter/foundation.dart';
import 'package:shopping_cart_app/models/cart_item.dart';
import 'package:shopping_cart_app/models/product.dart';

class CartService extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  double get total => _cartItems.fold(0, (sum, item) => sum + item.product.price * item.quantity);

  void addItem(Product product) {
    final existingItem = _cartItems.firstWhere((item) => item.product.id == product.id, orElse: () => CartItem(product: Product(id: '', name: '', price: 0.0)));

    if (existingItem.product.id != '') {
      existingItem.quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeItem(Product product) {
    final existingItem = _cartItems.firstWhere((item) => item.product.id == product.id, orElse: () => CartItem(product: Product(id: '', name: '', price: 0.0)));

    if (existingItem.product.id != '') {
      if (existingItem.quantity > 1) {
        existingItem.quantity--;
      } else {
        _cartItems.removeWhere((item) => item.product.id == product.id);
      }
      notifyListeners();
    }
  }

  void clearItem(Product product) {
    _cartItems.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }
}