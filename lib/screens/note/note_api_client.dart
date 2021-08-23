import 'package:hava/models/note_model.dart';
import 'package:hava/src/lib_api.dart';

class NoteApiClient extends ApiClient {
  NoteApiClient(BuildContext context) : super(context);

  Future getListNote({bool first = false}) async {
    if (first){
      page = 0;
      nextPage = true;
    }
    if (nextPage) {
      final res = await apiNew.methodGet(api: '${ApiConfig.apiListNote}$page');
      page += 1;
      if (res != null) {
        List list = NoteModelList.fromJson(res).list;
        if (list.length < limit2) nextPage = false;
        return list;
      }
      return errHandle(res);
    } else {
      debugPrint('No More Data');
      return [];
    }
  }

  Future createNote(String body) async {
    return await apiNew.methodPost(api: ApiConfig.apiNote, body: body);
  }

  Future updateNote(String body, int id) async {
    return await apiNew.methodPut(api: '${ApiConfig.apiNote}/$id', body: body);
  }

  Future deleteNote(int id) async {
    return await apiNew.methodDel(api: '${ApiConfig.apiNote}/$id');
  }
}
