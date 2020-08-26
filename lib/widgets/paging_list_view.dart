import 'package:flutter/material.dart';

class PagingListView<T> extends StatefulWidget {
  final List<T> items;
  final bool hasMoreItemsToLoad;
  final Function(BuildContext context, int index, T data) itemBuilder;
  final Widget loadingWidget;
  final VoidCallback onNeedLoadMore;

  const PagingListView({
    this.items,
    this.hasMoreItemsToLoad = true,
    this.itemBuilder,
    this.loadingWidget,
    this.onNeedLoadMore,
  });

  @override
  _PagingListViewState<T> createState() => _PagingListViewState<T>();
}

class _PagingListViewState<T> extends State<PagingListView<T>> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (widget.onNeedLoadMore != null && widget.hasMoreItemsToLoad) {
          widget.onNeedLoadMore();
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: widget.hasMoreItemsToLoad
          ? widget.items.length + 1
          : widget.items.length,
      itemBuilder: (context, index) {
        if (index == widget.items.length) {
          if (widget.hasMoreItemsToLoad) {
            return widget.loadingWidget ?? _buildDefaultLoading();
          } else {
            return const SizedBox();
          }
        } else {
          return widget.itemBuilder(context, index, widget.items[index]);
        }
      },
    );
  }

  Widget _buildDefaultLoading() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
