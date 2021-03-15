class PagingData<T> {
  final List<T> items;
  final int currentPage;
  final int lastPage;

  bool get hasMoreItemsToLoad => currentPage < lastPage;

  PagingData({
    required this.items,
    required this.currentPage,
    required this.lastPage,
  });
}
