import 'package:connectivity/connectivity.dart';
import 'package:tournament_app/Widgets/toast.dart';


Future<bool> checkConnectivity(context) async {
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.mobile) {
      // showToast(context, 'Connected To Mobile Data');
      return true;
    } else if (result == ConnectivityResult.wifi) {
      // showToast(context, 'Connected To Wifi');
      return true;
    }
    showToast(context : context, msg: 'No Internet Connection');
    return false;
  }