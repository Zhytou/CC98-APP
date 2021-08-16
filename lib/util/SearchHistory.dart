class SearchHistory {
  SearchHistory(this._history) {
    _filteredHistory = _history;
  }

  static const int _historyMaxLength = 20;
  List<String> _history;
  List<String> _filteredHistory;

  List<String> get searchHistory {
    return this._filteredHistory;
  }

  void filterSearchRecords(String filter) {
    if (filter != null && filter.isNotEmpty) {
      _filteredHistory = _history.reversed
          .where((record) => record.startsWith(filter))
          .toList();
    }
  }

  void addSearchRecord(String record) {
    if (_history.contains(record)) {
      putSearchRecordFirst(record);
      return;
    }
    _history.add(record);
    if (_history.length > _historyMaxLength) {
      _history.removeRange(0, _history.length - _historyMaxLength);
    }
  }

  void deleteSearchRecord(String record) {
    _history.removeWhere((t) => t == record);
  }

  void putSearchRecordFirst(String record) {
    deleteSearchRecord(record);
    addSearchRecord(record);
  }
}
