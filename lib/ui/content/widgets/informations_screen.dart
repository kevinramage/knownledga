import 'package:flutter/material.dart';
import 'package:knownledga/data/repositories/core/log.dart';
import 'package:knownledga/ui/content/widgets/log_screen.dart';
import 'package:knownledga/data/services/api.dart';

class ContentInformationsScreen extends StatefulWidget {

  final Api api;

  const ContentInformationsScreen({super.key, required this.api});

  @override
  State<StatefulWidget> createState() {
    return _ContentInformationsScreen();
  }
}

class _ContentInformationsScreen extends State<ContentInformationsScreen> {

  List<ApplicationLog> logs = [];

  @override
  void initState() {
    super.initState();
    widget.api.log.registerGetLogs(() { return logs; });
    widget.api.log.registerSetLogs((list) { setState(() { logs = list; }); });
  }

  @override
  Widget build(BuildContext context) {
    return Container(width: double.infinity, height: 200, color: Colors.grey.shade800, child: DefaultTabController(
      length: 1, 
      child: Column(children: [
        const TabBar(labelStyle: TextStyle(color: Colors.white, decoration: TextDecoration.none), isScrollable: true, indicatorColor: Colors.white, tabs: [
          Tab(text: "LOG", )
        ]),
        Expanded(child: TabBarView(children: [ 
          ContentLogScreen(logs: logs)
        ]))
      ]))
    );
  }
}