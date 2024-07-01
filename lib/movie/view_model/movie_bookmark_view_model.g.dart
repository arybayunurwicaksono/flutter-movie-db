// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_bookmark_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MovieBookmarkViewModel on _movieBookmarkViewModel, Store {
  late final _$movieDbAtom =
      Atom(name: '_movieBookmarkViewModel.movieDb', context: context);

  @override
  Box<BookmarkMovieModel>? get movieDb {
    _$movieDbAtom.reportRead();
    return super.movieDb;
  }

  @override
  set movieDb(Box<BookmarkMovieModel>? value) {
    _$movieDbAtom.reportWrite(value, super.movieDb, () {
      super.movieDb = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_movieBookmarkViewModel.status', context: context);

  @override
  bool get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(bool value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$searchQueryAtom =
      Atom(name: '_movieBookmarkViewModel.searchQuery', context: context);

  @override
  String? get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String? value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  @override
  ObservableFuture<Box<BookmarkMovieModel>> getBookmarkWithDb() {
    final _$future = super.getBookmarkWithDb();
    return ObservableFuture<Box<BookmarkMovieModel>>(_$future,
        context: context);
  }

  late final _$removeBookmarkWithDbAsyncAction = AsyncAction(
      '_movieBookmarkViewModel.removeBookmarkWithDb',
      context: context);

  @override
  Future<void> removeBookmarkWithDb(String id, BookmarkRemoveType type) {
    return _$removeBookmarkWithDbAsyncAction
        .run(() => super.removeBookmarkWithDb(id, type));
  }

  late final _$isBookmarkedAsyncAction =
      AsyncAction('_movieBookmarkViewModel.isBookmarked', context: context);

  @override
  Future<bool> isBookmarked(int id) {
    return _$isBookmarkedAsyncAction.run(() => super.isBookmarked(id));
  }

  late final _$addBookmarkWithDbAsyncAction = AsyncAction(
      '_movieBookmarkViewModel.addBookmarkWithDb',
      context: context);

  @override
  Future<void> addBookmarkWithDb(MovieDetailModel movie) {
    return _$addBookmarkWithDbAsyncAction
        .run(() => super.addBookmarkWithDb(movie));
  }

  late final _$saveEncryptedDataAsyncAction = AsyncAction(
      '_movieBookmarkViewModel.saveEncryptedData',
      context: context);

  @override
  Future<void> saveEncryptedData(String key, String value) {
    return _$saveEncryptedDataAsyncAction
        .run(() => super.saveEncryptedData(key, value));
  }

  late final _$getEncryptedDataAsyncAction =
      AsyncAction('_movieBookmarkViewModel.getEncryptedData', context: context);

  @override
  Future<void> getEncryptedData(String key) {
    return _$getEncryptedDataAsyncAction.run(() => super.getEncryptedData(key));
  }

  late final _$deleteEncryptedDataAsyncAction = AsyncAction(
      '_movieBookmarkViewModel.deleteEncryptedData',
      context: context);

  @override
  Future<void> deleteEncryptedData(String key) {
    return _$deleteEncryptedDataAsyncAction
        .run(() => super.deleteEncryptedData(key));
  }

  late final _$_movieBookmarkViewModelActionController =
      ActionController(name: '_movieBookmarkViewModel', context: context);

  @override
  void changeBookmarkStatus() {
    final _$actionInfo = _$_movieBookmarkViewModelActionController.startAction(
        name: '_movieBookmarkViewModel.changeBookmarkStatus');
    try {
      return super.changeBookmarkStatus();
    } finally {
      _$_movieBookmarkViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
movieDb: ${movieDb},
status: ${status},
searchQuery: ${searchQuery}
    ''';
  }
}
