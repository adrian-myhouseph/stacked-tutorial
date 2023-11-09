// import 'package:observable_flutter/app/app.bottomsheets.dart';
// import 'package:observable_flutter/app/app.dialogs.dart';
import 'package:observable_flutter/app/app.locator.dart';
import 'package:observable_flutter/app/app.router.dart';
import 'package:observable_flutter/services/api_service.dart';
import 'home_view.form.dart';
// import 'package:observable_flutter/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
// import 'package:stacked_services/stacked_services.dart';

import '../../../models/book.dart';

class HomeViewModel extends FutureViewModel<List<Book>> with FormStateHelper {
  final _apiService = locator<ApiService>();
  final _navigationService = locator<NavigationService>();

  @override
  Future<List<Book>> futureToRun() =>
      _apiService.getBooks(genreType: searchTermValue ?? 'computers');

  Future<void> fetchNewCategoy() async {
    await initialise();
  }

  Future<void> navigateToBook({required Book book}) async {
    await _navigationService.navigateToBookDetailsView(book: book);
  }
}
