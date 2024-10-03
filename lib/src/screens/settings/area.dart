import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:review/components/containers.dart';
import 'package:review/components/heders.dart';
import 'package:review/main.dart';
import 'package:review/services/service_method.dart';
import 'package:review/services/services.dart';
import 'package:review/services/update.dart';
import 'package:review/src/screens/settings/modal_inside_modal.dart';
import 'package:review/src/screens/surveys/questions.dart';

class PageArea extends StatefulWidget {
  final List areaSurveyList;
  final String title;
  const PageArea({Key? key, required this.areaSurveyList, required this.title})
      : super(key: key);

  @override
  State<PageArea> createState() => _PageAreaState();
}

class _PageAreaState extends State<PageArea> {
  bool stateLoading = false;
  @override
  void initState() {
    super.initState();
    for (var item in widget.areaSurveyList) {
      setState(() =>
          item['key'] = GlobalKey(debugLabel: '${item['serv_area']['id']}'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
            child: Column(children: [
              HedersComponent(
                  title: 'Areas de ${widget.title}', stateBack: true),
              Expanded(
                  child: Center(
                child: SingleChildScrollView(
                    child: Column(children: [
                  for (final item in widget.areaSurveyList)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: double.infinity,
                        elevation: 0,
                        focusElevation: 0,
                        autofocus: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 4.0,
                            )),
                        child: ExpansionTileCard(
                          baseColor: const Color(0xfff2f2f2),
                          // expandedColor: Colors.amber,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                          key: item['key'],
                          trailing: const Text(''),
                          expandedTextColor: Colors.black,
                          title: Center(
                              child: Text('${item['serv_area']['ars_name']}')),
                          onExpansionChanged: (expand) {
                            if (expand) {
                              for (var element in widget.areaSurveyList) {
                                if (element['key'] != item['key']) {
                                  element['key'].currentState?.collapse();
                                }
                              }
                            }
                          },
                          children: [
                            for (final item2 in item['survey'])
                              ContainerComponent(
                                textContainer: '${item2['srv_name']}',
                                onTap: () => _showModalInside(
                                    item2['questions'], '${item2['id']}'),
                              ),
                          ],
                        ),
                      ),
                    ),
                ])),
              ))
            ])));
  }

  _showModalInside(dynamic questions, String idSurvey) async {
    return showBarModalBottomSheet(
      enableDrag: false,
      expand: false,
      context: context,
      builder: (context) => ModalInsideModal(
        questions: questions,
        confirm: () {
          createSurvey(context, idSurvey);
        },
      ),
    );
  }

  createSurvey(BuildContext context, String idSurvey) async {
    setState(() => stateLoading = !stateLoading);
    final Map<String, dynamic> body = {
      'id_survey': idSurvey,
      'id_terminal': prefs!.getString('deviceId'),
    };
    prefs!.setString('idSurvey', idSurvey);
    var response = await serviceMethod(
        mounted, context, 'post', body, serviceRegisterTerminalSurvey(), true,true);
    setState(() => stateLoading = !stateLoading);
    if (response != null) {
      if (!mounted) return;
      if (await update(context)) {
        if (!mounted) return;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PageQuestions()));
      }
    }
  }
}
