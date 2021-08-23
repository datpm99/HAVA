import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:hava/models/know_model.dart';
import 'package:hava/src/lib_view.dart';
import 'item_knowledge_view.dart';
import 'knowledge_presenter.dart';
import 'less_final/item_less_final_view.dart';

class KnowledgeView extends StatefulWidget {
  final String sub;
  final List listAll;
  final List<KnowModel> listKnow;
  final int idSub;

  const KnowledgeView({
    Key? key,
    required this.sub,
    required this.listAll,
    required this.listKnow,
    required this.idSub,
  }) : super(key: key);

  @override
  _KnowledgeViewState createState() => _KnowledgeViewState();
}

class _KnowledgeViewState extends State<KnowledgeView>
    with SingleTickerProviderStateMixin
    implements Contract {
  late KnowledgePresenter _presenter;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _presenter = KnowledgePresenter(context, this, widget.sub, widget.idSub);
    _tabController = TabController(vsync: this, length: widget.listKnow.length);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Kiến thức')),
      body: Column(
        children: [
          Container(
            width: width,
            color: Styles.colorG8,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ButtonsTabBar(
              controller: _tabController,
              backgroundColor: Styles.colorOr3,
              unselectedBackgroundColor: Styles.colorG8,
              labelStyle: Styles.copyStyle(color: Colors.white),
              unselectedLabelStyle: Styles.copyStyle(color: Styles.colorB2),
              borderWidth: 0.5,
              borderColor: Styles.colorOr3,
              unselectedBorderColor: Styles.colorG6,
              contentPadding: const EdgeInsets.symmetric(horizontal: 18),
              tabs: _genTab(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _genList(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _genTab() {
    List<Tab> con = List<Tab>.generate(widget.listKnow.length, (index) {
      return Tab(text: widget.listKnow[index].title);
    });
    return con;
  }

  List<Widget> _genList() {
    List<ListView> con =
        List<ListView>.generate(widget.listKnow.length, (indexAll) {
      List<KnowModel> listT = widget.listAll[indexAll];
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15),
        itemCount: listT.length,
        itemBuilder: (context, index) {
          if (listT[index].content.isEmpty && listT[index].examId == 0) {
            return ItemKnowledgeView(
                sub: widget.sub, model: listT[index], idSub: widget.idSub);
          } else {
            KnowModel model = listT[index];
            model.content = _presenter.unescape.convert(model.content);
            return ItemLessFinalView(model: model, onExam: _presenter.onAc);
          }
        },
      );
    });
    return con;
  }

  @override
  void updateState() {
    setState(() {});
  }
}
