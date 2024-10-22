import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
static const _accessTokenKey='access-token';
  static String?accessTokenKey;
 static Future<void>saveAccessToken(String token)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey,token);
    accessTokenKey=token;

  }
 static Future<String?>getAccessToken()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String?token=sharedPreferences.getString(_accessTokenKey);
    accessTokenKey=token;
    return token;
  }
static  bool isLoggedIn(){
    return accessTokenKey!=null;
  }
 static Future<void>clearUserDate()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance()
;
await sharedPreferences.clear();
accessTokenKey=null;  }

}