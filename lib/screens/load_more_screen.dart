import 'package:flutter/material.dart';
import 'package:flutter_app_template/bloc/app_bloc.dart';
import 'package:flutter_app_template/data/remote/user_service.dart';
import 'package:flutter_app_template/dialog_manager.dart';
import 'package:flutter_app_template/models/api_error.dart';
import 'package:flutter_app_template/models/paging_data.dart';
import 'package:flutter_app_template/models/user.dart';
import 'package:flutter_app_template/screen_navigator.dart';
import 'package:flutter_app_template/widgets/paging_list_view.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class LoadMoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<bool>(
          initialData: true,
          stream: Provider.of<LoadMoreBloc>(context)
              .firstTimeUsersLoadingSubject
              .stream,
          builder: (context, snapshot) {
            final firstTimeLoading = snapshot.data;

            if (firstTimeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return _buildUserList(context);
            }
          },
        ),
      ),
    );
  }

  Widget _buildUserList(BuildContext context) {
    return StreamBuilder<PagingData<User>>(
      stream: Provider.of<LoadMoreBloc>(context).pagingUsersSubject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final pagingUser = snapshot.data;

          return PagingListView<User>(
            items: pagingUser.items,
            hasMoreItemsToLoad: pagingUser.hasMoreItemsToLoad,
            onNeedLoadMore: () {
              context
                  .read<LoadMoreBloc>()
                  .getUsers(currentPage: pagingUser.currentPage + 1);
            },
            itemBuilder: (_, __, user) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  user.fullName,
                ),
              );
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class LoadMoreBloc extends AppBloc {
  final ScreenNavigator screenNavigator;
  final DialogManager dialogManager;

  final UserService userService;

  LoadMoreBloc(this.screenNavigator, this.dialogManager, this.userService) {
    getUsers();
  }

  final firstTimeUsersLoadingSubject = BehaviorSubject<bool>.seeded(true);
  final pagingUsersSubject = BehaviorSubject<PagingData<User>>();
  bool _isPagingCustomersLoading = false;

  @override
  void dispose() {
    super.dispose();

    firstTimeUsersLoadingSubject.close();
    pagingUsersSubject.close();
  }

  Future<void> getUsers({int currentPage = 1}) async {
    if (_isPagingCustomersLoading) {
      return;
    }

    try {
      if (currentPage == 1) {
        firstTimeUsersLoadingSubject.add(true);
      } else {
        _isPagingCustomersLoading = true;
      }

      final usersPagingData =
          await userService.getPagingUsers(page: currentPage);

      if (currentPage == 1) {
        pagingUsersSubject.add(usersPagingData);
      } else {
        pagingUsersSubject.add(PagingData<User>(
          items: [...pagingUsersSubject.value.items, ...usersPagingData.items],
          currentPage: usersPagingData.currentPage,
          lastPage: usersPagingData.lastPage,
        ));
      }
    } on ApiError catch (error) {
      dialogManager.showError(error);
    } finally {
      firstTimeUsersLoadingSubject.add(false);
      _isPagingCustomersLoading = false;
    }
  }
}
