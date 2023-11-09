import 'package:flutter/material.dart';
import 'package:observable_flutter/ui/views/home/home_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
// import 'package:observable_flutter/ui/common/app_colors.dart';
// import 'package:observable_flutter/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'searchTerm'),
])
class HomeView extends StackedView<HomeViewModel> with $HomeView {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.fetchNewCategoy,
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: !viewModel.dataReady // viewModel.isBusy
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextField(
                          controller: searchTermController,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: viewModel.data?.length,
                          itemBuilder: (context, index) {
                            final book = viewModel.data?[index];
                            return Card(
                              child: ListTile(
                                title: Text(book?.title ?? ''),
                                onTap: () =>
                                    viewModel.navigateToBook(book: book!),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
            )),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }
}
