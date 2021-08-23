import 'package:hava/src/lib_presenter.dart';
import 'package:hava/screens/ebook/ebook_view.dart';
import 'package:hava/screens/video/video_view.dart';

class GiftPresenter extends Presenter {
  GiftPresenter(BuildContext context, Contract view) : super(context, view);
  bool isShow = true;

  void onVideo() {
    Utils.navigatePage(context, const VideoView());
  }

  void onEbook() {
    Utils.navigatePage(context, const EbookView());
  }

  void onHideView() {
    isShow = false;
    view.updateState();
  }
}
