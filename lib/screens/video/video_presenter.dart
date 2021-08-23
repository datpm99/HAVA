import 'package:hava/src/lib_presenter.dart';
import 'package:hava/models/video_model.dart';
import 'item_video_view.dart';
import 'video_api_client.dart';

class VideoPresenter extends Presenter {
  VideoPresenter(BuildContext context, Contract view) : super(context, view);
  bool isShow = true;
  late VideoApiClient _videoApiClient;

  @override
  void init() {
    super.init();
    _videoApiClient = VideoApiClient(context);
  }

  @override
  void loadData() async {
    super.loadData();
    list = await _videoApiClient.getVideo();
    view.updateState();
  }

  @override
  Widget itemBuild(BuildContext context, int index) {
    if (index < list.length) {
      VideoModel model = list[index];
      return ItemVideoView(margin: 0, model: model, type: 2);
    }
    return super.itemBuild(context, index);
  }

  void onHideView() {
    isShow = false;
    view.updateState();
  }
}
