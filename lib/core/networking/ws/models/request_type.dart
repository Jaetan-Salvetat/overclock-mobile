enum RequestType {
  newList,
  getAllLists,
  createList;

  String get label {
    switch (this) {
      case RequestType.getAllLists:
        return 'get_all_lists';
      case RequestType.createList:
        return 'create_list';
      case RequestType.newList:
        return 'new_list';
    }
  }

  static RequestType fromLabel(String label) {
    switch (label) {
      case 'new_list':
        return RequestType.createList;
      default:
        throw ArgumentError('Invalid label: $label');
    }
  }
}
