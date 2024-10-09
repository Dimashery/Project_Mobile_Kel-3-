import 'package:get/get.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/start_to_buy/views/start_to_buy_view.dart';
import '../modules/home/food/views/food_view.dart';
import '../modules/home/drink/views/drink_view.dart';
import '../modules/home/snack/views/snack_view.dart';
import '../modules/home/coffee/views/coffee_view.dart';
import '../modules/home/soft_drink/views/soft_drink_view.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.HOME;

  static final pages = [
    GetPage(name: AppRoutes.HOME, page: () => HomeView()),
    GetPage(name: AppRoutes.START_TO_BUY, page: () => StartToBuyView()),
    GetPage(name: AppRoutes.FOOD, page: () => FoodView()),
    GetPage(name: AppRoutes.DRINK, page: () => DrinkView()),
    GetPage(name: AppRoutes.SNACK, page: () => SnackView()),
    GetPage(name: AppRoutes.COFFEE, page: () => CoffeeView()),
    GetPage(name: AppRoutes.SOFT_DRINK, page: () => SoftDrinkView()),
  ];

  static var routes;
}
