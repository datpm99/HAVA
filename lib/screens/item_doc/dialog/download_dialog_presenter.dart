import 'package:dio/dio.dart';
import 'package:hava/src/lib_presenter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class DownloadDialogPresenter extends Presenter {
  DownloadDialogPresenter(
      BuildContext context, Contract view, this.urlPath, this.savePath)
      : super(context, view);

  final String urlPath, savePath;

  double progress = 0;
  double value = 0;
  Dio dio = Dio();

  @override
  void init() {
    super.init();
    startDownload();
  }

  Future startDownload() async {
    await dio.download(urlPath, savePath,
        onReceiveProgress: (receivedBytes, totalBytes) {
      progress = receivedBytes / totalBytes * 100;
      value = progress / 100;
      view.updateState();
    });
    final result = await ImageGallerySaver.saveFile(savePath);
    onBack();
    Utils.showToast('Tài liệu đã được tải về thành công!');
  }
}
