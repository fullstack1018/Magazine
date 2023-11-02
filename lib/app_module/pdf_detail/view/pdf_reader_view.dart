import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magazine/app_module/auth/login/controller/login_controller.dart';
import 'package:magazine/utils/theme/app_color.dart';
import 'package:magazine/utils/widgets/app_text.dart';
import 'package:magazine/utils/widgets/app_text_field.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfReaderView extends StatefulWidget {
  const PdfReaderView({super.key});

  @override
  State<PdfReaderView> createState() => _PdfReaderViewState();
}

class _PdfReaderViewState extends State<PdfReaderView> {
  final registerController = Get.put(LoginControler());

  PdfViewerController _pdfViewerController = PdfViewerController();
  late PdfTextSearchResult _searchResult;
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
    {
      _searchResult.addListener(() {
        if (_searchResult.hasResult) {
          setState(() {});
        }
      });
    }
    super.initState();
  }

  bool isPremium = true;
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    // scr.searchText("the");
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
      appBar: AppBar(
        title: isSearch
            ? AppTextField(
                hint: "Search..",
                controller: search,
                maxLines: 1,
                onChange: (val) {
                  setState(() {
                    _searchResult = _pdfViewerController.searchText(
                      val!,
                    );
                  });
                },
              )
            : Text(Get.arguments[0]),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                isSearch = true;
              });
            },
          ),
          Visibility(
            visible: _searchResult.hasResult,
            child: IconButton(
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  isSearch = false;
                  search.clear();
                  _searchResult.clear();
                });
              },
            ),
          ),
          Visibility(
            visible: _searchResult.hasResult,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.black,
              ),
              onPressed: () {
                _searchResult.previousInstance();
              },
            ),
          ),
          Visibility(
            visible: _searchResult.hasResult,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
              onPressed: () {
                _searchResult.nextInstance();
              },
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Get.back();
          //       },
          //       child: Container(
          //         height: 33,
          //         width: 33,
          //         margin: const EdgeInsets.only(top: 40, left: 16),
          //         decoration: BoxDecoration(
          //             color: AppColors.TRANSPARENT_COLOR,
          //             borderRadius: BorderRadius.circular(8),
          //             border: Border.all(
          //                 color: AppColors.GREY_COLOR.withOpacity(.25))),
          //         child: const Center(
          //             child: Icon(
          //           Icons.arrow_back_ios_new,
          //           size: 18,
          //         )),
          //       ),
          //     ),
          //     appText(text: Get.arguments[0]),
          //     Container(
          //       height: 33,
          //       width: 33,
          //       margin: const EdgeInsets.only(right: 16),
          //     )
          //   ],
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          Expanded(
              child: isPremium == false
                  ? Center(
                      child: appText(text: "Not Premium"),
                    )
                  : SfPdfViewer.network(
                      Get.arguments[1],
                      controller: _pdfViewerController,
                      currentSearchTextHighlightColor: Colors.yellow,
                      otherSearchTextHighlightColor:
                          Colors.yellow.withOpacity(0.3),
                      onPageChanged: (details) {
                        if (details.newPageNumber == 51) {
                          setState(() {
                            isPremium = false;
                          });
                        }
                      },
                    ))
        ],
      ),
    );
  }
}
