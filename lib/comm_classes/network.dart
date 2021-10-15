import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/widgets.dart';

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

class ConnectivityProvider extends ChangeNotifier{

  late bool _connected;

  bool get connected => _connected;

  ConnectivityProvider(){
    _connected = true;
    Connectivity().checkConnectivity().then((ConnectivityResult value){
      bool _connectedNew = value != ConnectivityResult.none;
      if(_connectedNew != _connected){
        _connected = _connectedNew;
        notifyListeners();
      }
    });
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _connected = result != ConnectivityResult.none;
      notifyListeners();
    });
  }

}