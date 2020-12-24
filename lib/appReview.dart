import 'package:flutter/cupertino.dart';
import 'package:in_app_review/in_app_review.dart';

class appReview {
  final InAppReview _inAppReview = InAppReview.instance;
  String _appStoreId = '';
  String _microsoftStoreId = '';

  void setAppStoreId(String id) => _appStoreId = id;

  void setMicrosoftStoreId(String id) => _microsoftStoreId = id;

  requestReview() async {
    _inAppReview.requestReview();
  }

  widgetBinding() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inAppReview.isAvailable();
    });
  }

  openStoreListing() async {
    _inAppReview.openStoreListing(
      appStoreId: _appStoreId,
      microsoftStoreId: _microsoftStoreId,
    );
  }
}
