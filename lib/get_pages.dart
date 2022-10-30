import 'package:eqinsurance/page/change_sc/controller/change_sc_controller.dart';
import 'package:eqinsurance/page/change_sc/ui/change_sc_page.dart';
import 'package:eqinsurance/page/contact_us/controller/contact_us_controller.dart';
import 'package:eqinsurance/page/contact_us/ui/contact_us_page.dart';
import 'package:eqinsurance/page/forget_sc/controller/forget_sc_controller.dart';
import 'package:eqinsurance/page/forget_sc/ui/forget_sc_page.dart';
import 'package:eqinsurance/page/home/controller/home_controller.dart';
import 'package:eqinsurance/page/home/ui/home_page.dart';
import 'package:eqinsurance/page/login/controller/login_controller.dart';
import 'package:eqinsurance/page/login/ui/login_page.dart';
import 'package:eqinsurance/page/partner/controller/partner_controller.dart';
import 'package:eqinsurance/page/partner/ui/partner_page.dart';
import 'package:eqinsurance/page/public_user/controller/public_user_controller.dart';
import 'package:eqinsurance/page/public_user/ui/public_user_page.dart';
import 'package:eqinsurance/page/register/controller/register_controller.dart';
import 'package:eqinsurance/page/register/ui/register_page.dart';
import 'package:eqinsurance/page/settings/controller/settings_controller.dart';
import 'package:eqinsurance/page/settings/ui/settings_page.dart';
import 'package:get/get.dart';

class GetListPages{
  static final GetListPages singleton = GetListPages._internal();

  factory GetListPages() {
    return singleton;
  }

  GetListPages._internal();

  static String HOME = '/home';
  static String LOGIN = '/login';
  static String REGISTER = '/register';
  static String PARTNER = '/partner';
  static String CONTACT_US = '/contact_us';
  static String FORGET_SC = '/forget_sc';
  static String PUBLIC_USER = '/public_user';
  static String SETTINGS = '/settings';
  static String NOTIFICATION = '/notification';
  static String CHANGE_SC = '/change_sc';

  List<GetPage> listPage(){
    return [
      GetPage(
        name: HOME,
        page: () => HomePage(),
        binding: HomeBinding(),
      ),
      GetPage(
        name: LOGIN,
        page: () => LoginPage(),
        binding: LoginBinding(),
      ),
      GetPage(
        name: REGISTER,
        page: () => RegisterPage(),
        binding: RegisterBinding(),
      ),
      GetPage(
        name: PARTNER,
        page: () => PartnerPage(),
        binding: PartnerBinding(),
      ),
      GetPage(
        name: CONTACT_US,
        page: () => ContactUsPage(),
        binding: ContactUsBinding(),
      ),
      GetPage(
        name: FORGET_SC,
        page: () => ForgetSCPage(),
        binding: ForgetSCBinding(),
      ),
      GetPage(
        name: PUBLIC_USER,
        page: () => PublicUserPage(),
        binding: PublicUserBinding(),
      ),
      GetPage(
        name: SETTINGS,
        page: () => SettingsPage(),
        binding: SettingsBinding(),
      ),
      GetPage(
        name: NOTIFICATION,
        page: () => SettingsPage(),
        binding: SettingsBinding(),
      ),
      GetPage(
        name: CHANGE_SC,
        page: () => ChangeSCPage(),
        binding: ChangeSCBinding(),
      )
    ];
  }
}