import 'package:flutter/material.dart';
import 'package:review/components/button.dart';
import 'package:review/components/heders.dart';
import 'package:review/src/screens/settings/tab_question.dart';

class ModalInsideModal extends StatefulWidget {
  final List questions;
  final Function() confirm;
  const ModalInsideModal({Key? key, required this.questions, required this.confirm}) : super(key: key);

  @override
  State<ModalInsideModal> createState() => _ModalInsideModalState();
}

class _ModalInsideModalState extends State<ModalInsideModal>
    with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: widget.questions.length);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: Scaffold(
            body: Padding(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                child: Column(children: [
                  HedersComponent(title: '${widget.questions.length} Preguntas'),
                  Expanded(
                    child: DefaultTabController(
                      initialIndex: 0,
                      length: widget.questions.length,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          for (var item in widget.questions)
                            TabQuestion(
                              question:
                                  '${item['serv_question']['qst_question']}',
                              idTypeAnswer: item['serv_question']
                                  ['id_type_answer'],
                            )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonComponent(
                      text: 'Establecer encuesta',
                      onPressed: () =>widget.confirm(),
                    ),
                  )
                ]))));
  }
}
