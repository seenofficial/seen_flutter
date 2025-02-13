import 'package:easy_localization/easy_localization.dart';
import 'package:enmaa/core/translation/locale_keys.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:developer';

abstract class BaseBiometricService {
  Future<bool> isBiometricAvailable();
  Future<bool> isDeviceSecure();
  Future<bool> authenticateWithBiometrics();
}

class BiometricService implements BaseBiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  ///  Check if the device supports biometrics
  @override
  Future<bool> isBiometricAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (e, stackTrace) {
      log('Error checking biometrics: $e', stackTrace: stackTrace);
      return false;
    }
  }

  ///  Check if the device has any security setup (PIN, password, pattern)
  @override
  Future<bool> isDeviceSecure() async {
    try {
      return await _localAuth.isDeviceSupported();
    } catch (e, stackTrace) {
      log('Error checking device security: $e', stackTrace: stackTrace);
      return false;
    }
  }

  /// Perform biometric authentication
  @override
  Future<bool> authenticateWithBiometrics() async {
    try {
      final bool canCheckBiometrics = await isBiometricAvailable();
      final bool isSecure = await isDeviceSecure();

      if (!canCheckBiometrics && !isSecure) {
        throw BiometricNotSetupException('Device security is not available.');
      }

      return await _localAuth.authenticate(
        localizedReason: LocaleKeys.authenticateToAccessTheApp.tr(),
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      print("sksksk ${e.message}");
      if (e.code == 'NotAvailable') {
        throw BiometricNotSetupException('No security credentials available.');
      } else {
        log('Authentication error: $e' );
        return false;
      }
    } catch (e, stackTrace) {
      log('Authentication error: $e', stackTrace: stackTrace);
      return false;
    }
  }
}


class BiometricNotSetupException implements Exception {
  final String message;
  BiometricNotSetupException(this.message);

  @override
  String toString() => message;
}
