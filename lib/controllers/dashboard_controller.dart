import 'package:get/get.dart';
import 'package:shit_grabber/models/document_model.dart';
import 'package:shit_grabber/repo/api_keys.dart';
import 'package:shit_grabber/repo/file_picker_repo.dart';
import 'package:shit_grabber/repo/shared_pref_repo.dart';
import 'package:shit_grabber/utils/subscription_state.dart';

class DashboardController extends SubscriptionState<DashboardController> {
  final FilePickerRepo _filePickerRepo = Get.find<FilePickerRepo>();
  final SharedPrefRepo _sharedPrefRepo = Get.find<SharedPrefRepo>();
  RxList<String> documentTitles = RxList<String>();
  RxList<DocumentModel> documents = RxList<DocumentModel>();

  @override
  void onInit() {
    super.onInit();
    disposeLater(
        _sharedPrefRepo.getStringList(ApiKeys.documentList).listen((titles) {
      if (titles != null) {
        documentTitles.value = titles.isEmpty ? ['no titles'] : titles;
        print(documentTitles);
      } else {
        documentTitles.value = ['no titles'];
        print(documentTitles);
      }
    }));
  }

  void addDocuments() {
    disposeLater(_filePickerRepo.pickFiles().listen((docList) {
      documents.value = docList;
    }));
  }

  @override
  void onDetached() {
    print('onDetached');
  }

  @override
  void onInactive() {
    print('onInactive');
  }

  @override
  void onPaused() {
    print('onPaused');
  }

  @override
  void onResumed() {
    print('onResumed');
  }
}
