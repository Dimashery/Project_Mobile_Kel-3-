// ignore_for_file: prefer_typing_uninitialized_variables, constant_identifier_names

import 'package:get/get.dart';

//LOGIN
import '../modules/login/login_page/views/login_page.dart';
import '../modules/login/page_start/views/page_start.dart';
import '../modules/login/sign_up/views/sign_up_page.dart';
import '../modules/login/sign_up_success/views/sign_up_success_page.dart';
import '../modules/login/welcome_page/views/welcome_page.dart';

//FORGET PASSWORD
import '../modules/forget_password/change_password/views/change_password_page.dart';
import '../modules/forget_password/forget_password/views/forget_password_page.dart';
import '../modules/forget_password/password_changed/views/password_changed_page.dart';
import '../modules/forget_password/verify_code/views/verify_code_page.dart';

//MAIN MENU
import '../modules/notification/views/notification_view.dart';
import '../modules/food/views/food_view.dart';
import '../modules/drink/views/drink_view.dart';
import '../modules/snack/views/snack_view.dart';
import '../modules/coffee/views/coffee_view.dart';
import '../modules/soft_drink/views/soft_drink_view.dart';
import '../modules/start_to_buy/start_to_buy1/views/start_to_buy_view.dart';
import '../modules/home/views/home_view.dart';

//TRANSAKSI , MYORDER
import '../modules/start_to_buy/start_to_buy2/views/start_to_buy2_page.dart';
import '../modules/transaction_success/views/transaction_success_page.dart';
import '../modules/payment/views/payment_page.dart';
import '../modules/order/views/my_order_page.dart';

//PROFILE
import '../modules/profile/views/profile_view.dart';
import '../modules/account_security/views/account_security_view.dart';
import '../modules/account_settings/views/account_settings_view.dart';
import '../modules/check_order/views/check_order_page.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/free_voucher/views/free_voucher_view.dart';
import '../modules/give_rating/views/give_rating_view.dart';
import '../modules/history/views/history_view.dart';
import '../modules/language/views/language_view.dart';

//Routes
import 'app_routes.dart';



class AppPages {
  static const INITIAL = AppRoutes.PAGE_START;

  static final pages = [

    GetPage(name: AppRoutes.PAGE_START, page: () => const PageStart()),
    GetPage(name: AppRoutes.WELCOME_PAGE, page: () => const WelcomePage()),
    GetPage(name: AppRoutes.LOGIN_PAGE, page: () => LoginPage()),
    // ignore: prefer_const_constructors
    GetPage(name: AppRoutes.SIGNUP_PAGE, page: () => SignUpPage()),
    GetPage(name: AppRoutes.SIGNUP_SUCCESS_PAGE, page: () => const SignUpSuccessPage()),

    
    GetPage(name: AppRoutes.FORGET_PASSWORD,page: () => EnterEmailView(),),
    GetPage(name: AppRoutes.VERIFY_CODE,page: () => VerifyOTPView(),),
    GetPage(name: AppRoutes.CHANGE_PASSWORD,page: () => NewPasswordView(),),
    GetPage(name: AppRoutes.PASSWORD_CHANGED,page: () => PasswordChangedScreen(),),


    GetPage(name: AppRoutes.HOME, page: () => const HomeView()),
    GetPage(name: AppRoutes.START_TO_BUY, page: () => const StartToBuyView()),
    GetPage(name: AppRoutes.FOOD, page: () => const FoodView()),
    GetPage(name: AppRoutes.DRINK, page: () => const DrinkView()),
    GetPage(name: AppRoutes.SNACK, page: () => const SnackView()),
    GetPage(name: AppRoutes.COFFEE, page: () => const CoffeeView()),
    GetPage(name: AppRoutes.SOFT_DRINK, page: () => const SoftDrinkView()),


   GetPage(name: AppRoutes.MY_ORDER, page: () => const MyOrderPage()),
   GetPage(name: AppRoutes.START_TO_BUY2, page: () => const StartToBuy2Page()),
   GetPage(name: AppRoutes.PAYMENT, page: () => const PaymentPage()),
   GetPage(name: AppRoutes.TRANSACTION_SUCCESS, page: () => const TransactionSuccessPage()),
   GetPage(name: AppRoutes.CHECK_ORDER, page: () => const CheckOrderPage()),
   
  GetPage(name: AppRoutes.PROFILE, page: () => const ProfileView()),
    GetPage(name: AppRoutes.FAVORITE, page: () => const FavoriteView()),
    GetPage(name: AppRoutes.HISTORY, page: () => const HistoryView()),
    GetPage(name: AppRoutes.LANGUAGE, page: () => const LanguageView()),
    GetPage(name: AppRoutes.NOTIFICATION, page: () => const NotificationView()),
    GetPage(name: AppRoutes.ACCOUNT_SECURITY, page: () => const AccountSecurityView()),
    GetPage(name: AppRoutes.FREE_VOUCHER, page: () => const FreeVoucherView()),
    GetPage(name: AppRoutes.GIVE_RATING, page: () => const GiveRatingView()),
    GetPage(name: AppRoutes.ACCOUNT_SETTINGS, page: () => const AccountSettingsView()),


  ];

  static var routes;
}
