import 'item_guide_view.dart';
import 'guide_api_client.dart';
import 'package:hava/themes/styles.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:hava/models/guide_model.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class GuidePresenter extends Presenter {
  GuidePresenter(BuildContext context, Contract view) : super(context, view);
  late GuideApiClient _guideApiClient;
  late YoutubePlayerController controllerYT;

  @override
  void init() {
    super.init();
    _guideApiClient = GuideApiClient(context);
    controllerYT = YoutubePlayerController(
      initialVideoId:
          YoutubePlayerController.convertUrlToId(Const.videoYGuide) ?? '',
      params: const YoutubePlayerParams(
        autoPlay: false,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void loadData() async {
    super.loadData();
    list = await _guideApiClient.getGuide();
    list.removeAt(0);
    view.updateState();
  }

  @override
  Widget itemBuild(BuildContext context, int index) {
    if (index == 0) {
      return _itemFirst();
    }
    if (index < list.length) {
      GuideModel model = list[index];
      return ItemGuideView(model: model);
    }
    return super.itemBuild(context, index);
  }

  Widget _itemFirst() {
    return Card(
      elevation: 1.5,
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding:
              const EdgeInsets.only(left: 20, bottom: 20, right: 20),
          title: Text('Hướng dẫn Học thử và Sử dụng website Hava',
              style: Styles.cusText(color: Styles.colorB2)),
          leading: Image.asset('assets/icons/ic_qs.png', width: 30, height: 30),
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: YoutubePlayerIFrame(
                controller: controllerYT,
                aspectRatio: 16 / 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
