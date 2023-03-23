import 'package:intl/intl.dart';

class ConfigData{
  static const String IS_AGREE_TERM = "Agree";


  static const String PUBLIC = "PUBLIC";
  static const String AGENT = "AGENT";
  static const String PROMO = "PROMO";

  ///Test mode
  static final  String BASE_URL = "https://internet.eqinsurance.com.sg/test/testwebMobile/eqws.asmx/";
  static const String CONSUMER_KEY = "verz";
  static const String CONSUMER_SECRET = "V3r\$2017";
  static const String EVR_CODE = "TEST";
  static const String callBackLinkMode = 'https://internet.eqinsurance.com.sg/test/SRServer/Login.aspx?key=';

  ///Live mode
  //static final String BASE_URL = "https://internet.eqinsurance.com.sg/eqwap/webmobile/EQWS.asmx/";
  // static final String CONSUMER_KEY = "EQI";
  // static final String CONSUMER_SECRET = "3Q!\$!ng@p0rE";
  //static const String EVR_CODE = "LIVE";
  //static const String callBackLinkMode = 'https://internet.eqinsurance.com.sg/eqwap/SRServer/Login.aspx?key=';


  static final oCcy = new NumberFormat("# ###", "en_US");

  //phone = 8174 0586
}