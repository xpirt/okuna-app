import 'package:Okuna/services/localization.dart';
import 'package:Okuna/services/toast.dart';
import 'package:flutter/material.dart';
import 'package:permission/permission.dart';

class PermissionsService {
  ToastService _toastService;
  LocalizationService _localizationService;

  void setToastService(toastService) {
    _toastService = toastService;
  }

  void setLocalizationService(localizationService) {
    _localizationService = localizationService;
  }

  Future<bool> requestStoragePermissions(
      {@required BuildContext context}) async {
    return _requestPermissionWithErrorMessage(
        permission: PermissionName.Storage,
        errorMessage:
            _localizationService.permissions_service__storage_permission_denied,
        context: context);
  }

  Future<bool> requestCameraPermissions(
      {@required BuildContext context}) async {
    return _requestPermissionWithErrorMessage(
        permission: PermissionName.Camera,
        errorMessage:
            _localizationService.permissions_service__camera_permission_denied,
        context: context);
  }

  Future<bool> _requestPermissionWithErrorMessage(
      {@required PermissionName permission,
      @required String errorMessage,
      @required BuildContext context}) async {
    PermissionStatus permissionStatus =
        await Permission.getSinglePermissionStatus(permission);
    if (permissionStatus == PermissionStatus.notDecided) {
      permissionStatus = await Permission.requestSinglePermission(permission);
    }

    if (permissionStatus == PermissionStatus.deny ||
        permissionStatus == PermissionStatus.notAgain) {
      _toastService.error(message: errorMessage, context: context);
      return false;
    }

    return true;
  }
}
