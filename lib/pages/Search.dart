import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../model/Index.dart';
import '../util/DataUtils.dart';
import '../util/SearchHistory.dart';
import '../widgets/SearchResponseCell.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Topic> _topics = [];
  List<String> _loadedSearchHistory = [];
  SearchHistory _filteredSearchHistory;
  FloatingSearchBarController _controller;

  Map<String, dynamic> _params = {'keyword': '', 'from': 0, 'size': 20};

  getData() {
    DataUtils.getSearchTopicList(_params).then((resultList) {
      setState(() {
        _topics = resultList;
      });
    });
  }

  renderSearchResponse(context, num) {
    if (_topics.isNotEmpty && num < _topics?.length)
      return SearchResponseCell(
        this._topics[num],
      );
  }

  @override
  void initState() {
    super.initState();
    _controller = FloatingSearchBarController();
    _filteredSearchHistory = SearchHistory(_loadedSearchHistory);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar(
        controller: _controller,
        body: FloatingSearchBarScrollNotifier(
          child: ListView.separated(
            padding: EdgeInsets.only(top: 60),
            itemCount: _topics == null ? 0 : _topics.length,
            itemBuilder: (context, num) => renderSearchResponse(context, num),
            separatorBuilder: (context, num) {
              return Divider(thickness: 1);
            },
          ),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: BouncingScrollPhysics(),
        hint: 'Search and find out...',
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) {
          setState(() {
            _filteredSearchHistory.filterSearchRecords(query);
          });
        },
        onSubmitted: (query) {
          _filteredSearchHistory.addSearchRecord(query);
          _params['keyword'] = query;
          getData();
          _controller.close();
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4,
              child: Builder(builder: (context) {
                if (_filteredSearchHistory.searchHistory.isEmpty &&
                    _controller.query.isEmpty) {
                  return Container(
                    height: 56,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Start searching',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  );
                } else if (_filteredSearchHistory.searchHistory.isEmpty) {
                  return ListTile(
                    title: Text(_controller.query),
                    leading: const Icon(Icons.search),
                    onTap: () {
                      setState(() {
                        _filteredSearchHistory
                            .addSearchRecord(_controller.query);
                        _params['keyword'] = _controller.query;
                        getData();
                      });
                      _controller.close();
                    },
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _filteredSearchHistory.searchHistory
                        .map(
                          (record) => ListTile(
                            title: Text(
                              record,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: const Icon(Icons.history),
                            trailing: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _filteredSearchHistory
                                      .deleteSearchRecord(record);
                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                _filteredSearchHistory
                                    .putSearchRecordFirst(record);
                                _params['keyword'] = record;
                                getData();
                              });
                              _controller.close();
                            },
                          ),
                        )
                        .toList(),
                  );
                }
              }),
            ),
          );
        },
      ),
    );
  }
}
