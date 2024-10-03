import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:review/components/containers.dart';
import 'package:review/components/heders.dart';
import 'package:review/services/service_method.dart';
import 'package:review/services/services.dart';
import 'package:review/src/screens/settings/area.dart';

class PageSettingQualifier extends StatefulWidget {
  final dynamic data;
  const PageSettingQualifier({Key? key, required this.data}) : super(key: key);

  @override
  State<PageSettingQualifier> createState() => _PageSettingQualifierState();
}

class _PageSettingQualifierState extends State<PageSettingQualifier> {
  bool stateLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
            child: Column(children: [
              const HedersComponent(title: 'Sedes'),
              Expanded(
                  child: Center(
                child: SingleChildScrollView(
                    child: Column(children: [
                  for (final item in widget.data['campus'])
                    ContainerComponent(
                      textContainer: item['hdq_name'],
                      onTap: () => nextPage(context, item),
                    ),
                ])),
              ))
            ])));
  }

  nextPage(BuildContext context, dynamic item) async {
    setState(() => stateLoading = !stateLoading);
    var response = await serviceMethod(mounted, context, 'get', null,
        serviceGetAreaSurveys('${item['id']}'), true,true);
    setState(() => stateLoading = !stateLoading);
    if (response != null) {
      if (!mounted) return;
      return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PageArea(
                  areaSurveyList: json.decode(response.body),
                  title: item['hdq_name'],
                )),
      );
    }
  }
}
