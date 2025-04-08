import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connectivity Plus Demo',
      home: ConnectivityDemo(),
    );
  }
}

class ConnectivityDemo extends StatefulWidget {
  @override
  _ConnectivityDemoState createState() => _ConnectivityDemoState();
}

class _ConnectivityDemoState extends State<ConnectivityDemo> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late Stream<ConnectivityResult> _connectivityStream;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivityStream = _connectivity.onConnectivityChanged;
    _connectivityStream.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = result;
      });
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      result = ConnectivityResult.none;
    }
    setState(() {
      _connectionStatus = result;
    });
  }
  String getStatusText(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return "Wi-Fi 已連線";
      case ConnectivityResult.mobile:
        return "行動網路已連線";
      case ConnectivityResult.ethernet:
        return "有線網路已連線";
      case ConnectivityResult.bluetooth:
        return "藍牙網路已連線";
      case ConnectivityResult.none:
      default:
        return "無網路連線";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connectivity Plus Demo"),
      ),
      body: Center(
        child: Text(
          '目前網路狀態: ${getStatusText(_connectionStatus)}',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}