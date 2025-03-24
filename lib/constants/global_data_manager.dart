import 'package:xiandun/bean/user_info.dart';
import 'package:xiandun/constants/constants.dart';
import 'package:xiandun/utils/share_perferences_util.dart';

class GlobalDataManager {
  //静态属性——该类的实例
  static GlobalDataManager? _instance;

  //私有的命名构造函数，确保类不能从外部被实例化
  GlobalDataManager._internal();

  static GlobalDataManager getInstance() {
    _instance ??= GlobalDataManager._internal();
    return _instance!;
  }

  UserInfo? _userInfo;

  String _token = 'GnTi8AVRkgyhrr86ubshywBg695USrXfYP4dcz8eAsg=';
  String _token1 = '';
  String _aaId = 'EBA0#0001';
  String _keyId = 'YW5pY2VydC1taWFubWkta2V5LUpESmhKREV3SkhSdFNrUlhSV0pvU1hGRFREUkpOSGsyU3pNdlFuVQ';
  String _userId = '';

  String anmiID = 'aOJ1BufizgQtwJMAPeobFmMygmUEUQ9cDK4QTorasRo=';

  String getKeyId() {
    return '$_aaId#$_keyId';
  }

  String getUserId() {
    return _userId;
  }

  void _updateUserId(String userId) {
    _userId = userId;
    SharedPreferencesUtil.getInstance().setString(Constants.spUserId, userId);
  }

  void _updateAAId(String aaId) {
    _aaId = aaId;
    SharedPreferencesUtil.getInstance().setString(Constants.spAAId, aaId);
  }

  void _updateKeyId(String keyId) {
    _keyId = keyId;
    SharedPreferencesUtil.getInstance().setString(Constants.spKeyId, keyId);
  }

  void _updateToken(String token) {
    _token = token;
    SharedPreferencesUtil.getInstance().setString(Constants.spToken, token);
  }

  void _updateToken1(String token) {
    _token1 = token;
    SharedPreferencesUtil.getInstance().setString(Constants.spToken1, token);
  }

  bool isLogin() {
    return _token.isNotEmpty;
  }

  void updateUserData(String userId,String token,String aaId,String keyId,String token1) {
    _updateUserId(userId);
    _updateAAId(aaId);
    _updateKeyId(keyId);
    _updateToken(token);
    _updateToken1(token);
  }

  void cleanLoginState() {
    updateUserData('','','','','');
  }

  UserInfo? getUserInfo() {
    return _userInfo;
  }

  void updateUserInfo(UserInfo? userInfo) {
    _userInfo = userInfo;
  }
}