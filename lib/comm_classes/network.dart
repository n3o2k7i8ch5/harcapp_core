import 'dart:async';

import 'package:connectivity/connectivity.dart';

Future<bool> isNetworkAvailable() async {
  var result = await Connectivity().checkConnectivity();
  return result != ConnectivityResult.none;
}


addConnectionListener(Function(bool hasConnection) onChanged){
  return Connectivity().onConnectivityChanged.listen(
          (ConnectivityResult result) =>
              onChanged(result != ConnectivityResult.none)
  );
}