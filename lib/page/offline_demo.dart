import 'package:auditdat/common/network_connectivity_listener.dart';
import 'package:auditdat/layout/base_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class ConnectionCheckerDemo extends StatefulWidget {
  const ConnectionCheckerDemo({Key? key}) : super(key: key);
  @override
  State<ConnectionCheckerDemo> createState() => _ConnectionCheckerDemoState();
}
class _ConnectionCheckerDemoState extends State<ConnectionCheckerDemo> {
  // Map _source = {ConnectivityResult.none: false};
  // final NetworkConnectivityListener _networkConnectivity = NetworkConnectivityListener.instance;
  // String string = '';
  // @override
  // void initState() {
  //   super.initState();
  //   _networkConnectivity.initialise();
  //   _networkConnectivity.myStream.listen((source) {
  //     _source = source;
  //     print('source $_source');
  //     // 1.
  //     switch (_source.keys.toList()[0]) {
  //       case ConnectivityResult.mobile:
  //         string =
  //         _source.values.toList()[0] ? 'Mobile: Online' : 'Mobile: Offline';
  //         break;
  //       case ConnectivityResult.wifi:
  //         string =
  //         _source.values.toList()[0] ? 'WiFi: Online' : 'WiFi: Offline';
  //         break;
  //       case ConnectivityResult.none:
  //       default:
  //         string = 'Offline';
  //     }
  //     // 2.
  //     setState(() {});
  //     // 3.
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           string,
  //           style: TextStyle(fontSize: 30),
  //         ),
  //       ),
  //     );
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return BasePage(body: Center(
        child: Text(
          "test",
          style: TextStyle(fontSize: 54),
        ))
    );
  }

  // @override
  // void dispose() {
  //   _networkConnectivity.disposeStream();
  //   super.dispose();
  // }
}