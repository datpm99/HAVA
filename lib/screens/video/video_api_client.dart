import 'package:hava/src/lib_api.dart';
import 'package:hava/models/video_model.dart';

class VideoApiClient extends ApiClient {
  VideoApiClient(BuildContext context) : super(context);

  Future getVideo() async {
    final res = await apiNew.methodGet(api: ApiConfig.apiVideo);
    if (res != null) return VideoModelList.fromJson(res).list;
    return errHandle(res);
  }
}
