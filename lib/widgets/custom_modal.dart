/*import 'package:cajpkg/Util/AppColors.dart';
import 'package:cajpkg/Util/Utils.dart';
import 'package:cajpkg/Widgets/Text.dart';*/
import 'package:flutter_provider_test/widgets/Text.dart';
import 'package:flutter/material.dart';

class CustomModal extends StatelessWidget {

  final String modalTitleTxt;
  final Color modalTitleCor;
  final double modalTitleSz;
  final bool modalTitleBold;
  final bool ellipsis;
  final int maxLines;
  final Widget modalBody;
  late Widget modalFooter;

  final double modalWidth;
  final double modalHeight;

  CustomModal({
    required this.modalTitleTxt,
    this.modalTitleCor = Colors.green,
    this.modalTitleSz = 22,
    this.maxLines = 22,
    this.ellipsis = false,
    this.modalWidth = 0,
    this.modalHeight = 0,
    this.modalTitleBold = true,
    required this.modalBody,
    required this.modalFooter
  });

  Size size = Size(0, 0);
  bool small = false;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return _widget_desktop();
  }


  _widget_desktop() {
    return Center(
        child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(5),
            width: (modalWidth == 0) ? size.width : modalWidth,
            height: (modalHeight == 0) ? size.height : modalHeight,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 16,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    color: Colors.white,
                    width: size.width,
                    height: size.height,
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      appBar: _header_modal(),
                      body: _body_modal(),
                      bottomNavigationBar: modalFooter,
                    ),
                  ),
                )
            )
        )
    );
  }

  _header_modal() {
    return AppBar(
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.green),
        title: text(modalTitleTxt, color: modalTitleCor, bold: modalTitleBold, fontSize: modalTitleSz, ellipsis: ellipsis, maxLines: maxLines, textAlign: TextAlign.left),
        backgroundColor: Colors.white
    );
  }

  _body_modal() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
              width: 1.0,
              color: Colors.green
          ),
        ),
        color: Colors.white,
      ),
      child: Container(
          width: double.infinity,
          child: modalBody
      ),
    );
  }

}