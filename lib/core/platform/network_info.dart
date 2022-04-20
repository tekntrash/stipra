import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../presentation/widgets/overlay/snackbar_overlay.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;

  Future<bool> get isConnectedForUpload;

  void onInternetChange({
    required Function() onConnect,
    required Function() onDisconnect,
  }) {}
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;
  final List<ConnectivityResult> allowedConnections;

  NetworkInfoImpl(this.connectionChecker, this.allowedConnections);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  Future<bool> get isConnectedForUpload async {
    final isHaveInternet = await connectionChecker.hasConnection;
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if (allowedConnections.contains(result) && isHaveInternet) {
      return true;
    }
    return false;
  }

  @override
  void onInternetChange({
    required Function() onConnect,
    required Function() onDisconnect,
  }) {
    InternetConnectionStatus? lastStatus;
    connectionChecker.onStatusChange.listen((status) async {
      if (status == InternetConnectionStatus.connected) {
        ConnectivityResult result = await Connectivity().checkConnectivity();
        if (allowedConnections.contains(result)) {
          onConnect();
        } else if (lastStatus == status) {
          /*SnackbarOverlay()
              .show(text: 'You are using mobile data.', buttonText: 'OK');*/
          onDisconnect();
        } else {
          /*SnackbarOverlay().show(
            addFrameCallback: true,
            onTap: () {
              SnackbarOverlay().closeCustomOverlay();
            },
            text: 'You are using mobile data.',
            buttonText: 'OK',
          );
          Future.delayed(Duration(seconds: 3), () {
            SnackbarOverlay().closeCustomOverlay();
          });*/
        }
      } else {
        onDisconnect();
      }
      lastStatus = status;
    });
  }
}
