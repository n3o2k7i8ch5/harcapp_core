import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

bool __isConnected(List<ConnectivityResult> values) => values.length != 1 || !values.contains(ConnectivityResult.none);

Future<bool> isNetworkAvailable() async {
  var result = await Connectivity().checkConnectivity();
  return __isConnected(result);
}

StreamSubscription<List<ConnectivityResult>> addConnectionListener(void Function(bool hasConnection) onChanged) => Connectivity().onConnectivityChanged.listen(
    (List<ConnectivityResult> result) => onChanged(__isConnected(result))
);

class ConnectivityProvider extends ChangeNotifier{

  late bool _connected;

  bool get connected => _connected;

  late List<void Function(bool)> _onChangedListeners;

  void addChangedListeners_(void Function(bool) listener) => _onChangedListeners.add(listener);
  void removeChangedListeners_(void Function(bool) listener) => _onChangedListeners.remove(listener);

  static void addChangedListeners(BuildContext context, void Function(bool) listener){
    Provider.of<ConnectivityProvider>(context, listen: false).addChangedListeners_(listener);
  }

  static void removeChangedListeners(BuildContext context, void Function(bool) listener){
    Provider.of<ConnectivityProvider>(context, listen: false).removeChangedListeners_(listener);
  }

  ConnectivityProvider(){
    _connected = true;
    _onChangedListeners = [];
    Connectivity().checkConnectivity().then((List<ConnectivityResult> value){
      bool _connectedNew = __isConnected(value);
      if(_connectedNew != _connected){
        _connected = _connectedNew;
        notify();
      }
    });
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      _connected = __isConnected(result);
      notify();
    });
  }

  void notify(){
    notifyListeners();
    for(void Function(bool) listener in _onChangedListeners)
      listener.call(_connected);
  }

}