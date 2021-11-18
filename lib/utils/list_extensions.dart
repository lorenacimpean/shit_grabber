import 'package:shit_grabber/models/document_model.dart';

extension ListExtension<E> on List<E> {
  void addAllUniqueElements(Iterable<E> iterable) {
    for (E element in iterable) {
      if (!contains(element)) {
        add(element);
      }
    }
  }
}

extension DocumentModelListExtension on List<DocumentModel> {
  void addAllUniqueDocuments(List<DocumentModel> iterable) {
    for (DocumentModel element in iterable) {
      bool titlesMatch = any((e) => e.name == element.name);
      if (titlesMatch) {
        DocumentModel oldDoc = firstWhere((doc) => doc.name == element.name);
        remove(oldDoc);
        add(element);
      }
    }
  }
}
