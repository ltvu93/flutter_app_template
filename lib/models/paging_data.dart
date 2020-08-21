class PagingData<T> {
  final List<T> items;
  final int currentPage;
  final int lastPage;

  bool get hasMoreItemsToLoad => currentPage < lastPage;

  PagingData({this.items, this.currentPage, this.lastPage});
}