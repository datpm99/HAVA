import 'package:hava/src/lib_view.dart';
import 'search_presenter.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> implements Contract {
  late SearchPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = SearchPresenter(context, this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _buildTextSearch()),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _presenter.txtNotify,
              style: Styles.cusText(color: Styles.colorB2, size: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _presenter.list.length + 1,
                itemBuilder: _presenter.myItemBuilder,
              ),
            )
            //ListView()
          ],
        ),
      ),
    );
  }

  Widget _buildTextSearch() {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: VAll.decoNonShadow(Colors.white, 0.5, Styles.colorG3),
      child: TextField(
        autofocus: true,
        controller: _presenter.txtController,
        decoration: InputDecoration(
          hintText: 'Nhập thông tin...',
          hintStyle: Styles.copyStyle(color: Styles.colorG1),
          border: InputBorder.none,
          suffixIcon: const Icon(Icons.search, color: Colors.black45),
        ),
        onSubmitted: _presenter.onSearch,
      ),
    );
  }

  @override
  void updateState() {
    setState(() {});
  }
}
