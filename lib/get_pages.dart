import 'package:eqinsurance/page/change_sc/controller/change_sc_controller.dart';
import 'package:eqinsurance/page/change_sc/ui/change_sc_page.dart';
import 'package:eqinsurance/page/contact_us/controller/contact_us_controller.dart';
import 'package:eqinsurance/page/contact_us/ui/contact_us_page.dart';
import 'package:eqinsurance/page/forget_sc/controller/forget_sc_controller.dart';
import 'package:eqinsurance/page/forget_sc/ui/forget_sc_page.dart';
import 'package:eqinsurance/page/home/controller/home_controller.dart';
import 'package:eqinsurance/page/home/ui/home_page.dart';
import 'package:eqinsurance/page/input_code/controller/input_code_controller.dart';
import 'package:eqinsurance/page/input_code/ui/input_code_page.dart';
import 'package:eqinsurance/page/login/controller/login_controller.dart';
import 'package:eqinsurance/page/login/ui/login_page.dart';
import 'package:eqinsurance/page/notification/controller/notification_controller.dart';
import 'package:eqinsurance/page/notification/controller/notification_detail_controller.dart';
import 'package:eqinsurance/page/notification/ui/notification_detail_page.dart';
import 'package:eqinsurance/page/notification/ui/notification_page.dart';
import 'package:eqinsurance/page/partner/controller/partner_controller.dart';
import 'package:eqinsurance/page/partner/ui/partner_page.dart';
import 'package:eqinsurance/page/partner_customer/controller/partner_customer_controller.dart';
import 'package:eqinsurance/page/partner_customer/ui/partner_customer_page.dart';
import 'package:eqinsurance/page/public_user/controller/public_user_controller.dart';
import 'package:eqinsurance/page/public_user/ui/public_user_page.dart';
import 'package:eqinsurance/page/register/controller/register_controller.dart';
import 'package:eqinsurance/page/register/ui/register_page.dart';
import 'package:eqinsurance/page/settings/controller/settings_controller.dart';
import 'package:eqinsurance/page/settings/ui/settings_page.dart';
import 'package:eqinsurance/page/term_and_privacy/controller/term_controller.dart';
import 'package:get/get.dart';

import 'page/term_and_privacy/ui/term_page.dart';

class GetListPages{
  static final GetListPages singleton = GetListPages._internal();

  factory GetListPages() {
    return singleton;
  }

  GetListPages._internal();

  String HOME = '/home';
  String LOGIN = '/login';
  String REGISTER = '/register';
  String PARTNER = '/partner';
  String CONTACT_US = '/contact_us';
  String FORGET_SC = '/forget_sc';
  String PUBLIC_USER = '/public_user';
  String SETTINGS = '/settings';
  String NOTIFICATION = '/notification';
  String NOTIFICATION_DETAIL = '/notification_detail';
  String CHANGE_SC = '/change_sc';
  String INPUT_CODE = '/input_code';
  String TERM_AND_PRIVACY = '/term_and_privacy';
  String PARTNER_CUSTOMER = '/partner_customer';

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
        page: () => NotificationPage(),
        binding: NotificationBinding(),
      ),
      GetPage(
        name: CHANGE_SC,
        page: () => ChangeSCPage(),
        binding: ChangeSCBinding(),
      ),
      GetPage(
        name: INPUT_CODE,
        page: () => InputCodePage(),
        binding: InputCodeBinding(),
      ),
      GetPage(
        name: NOTIFICATION_DETAIL,
        page: () => NotificationDetailPage(),
        binding: NotificationDetailBinding(),
      ),
      GetPage(
        name: TERM_AND_PRIVACY,
        page: () => TermPage(),
        binding: TermBinding(),
      ),
      GetPage(
        name: PARTNER_CUSTOMER,
        page: () => PartnerCustomerPage(),
        binding: PartnerCustomerBinding(),
      )
    ];
  }
}