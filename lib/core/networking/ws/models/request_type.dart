enum RequestType {
  getAllLists,
  createList;

  String get label {
    switch (this) {
      case RequestType.getAllLists:
        return 'get_all_lists';
      case RequestType.createList:
        return 'new_list';
    }
  }

  static RequestType fromLabel(String label) {
    switch (label) {
      case 'get_all_lists':
        return RequestType.getAllLists;
      case 'new_list':
        return RequestType.createList;
      default:
        throw ArgumentError('Invalid label: $label');
    }
  }
}
