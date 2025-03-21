import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import '../components/custom_snack_bar.dart';
import '../translation/locale_keys.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        return ServerFailure(LocaleKeys.requestCancelled.tr());

      case DioExceptionType.connectionTimeout:
        return ServerFailure(LocaleKeys.connectionTimeout.tr());

      case DioExceptionType.receiveTimeout:
        return ServerFailure(LocaleKeys.receiveTimeout.tr());

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
          dioException.response?.data,
        );

      case DioExceptionType.sendTimeout:
        return ServerFailure(LocaleKeys.sendTimeout.tr());

      case DioExceptionType.unknown:
        return ServerFailure(LocaleKeys.noInternet.tr());

      default:
        return ServerFailure(LocaleKeys.somethingWentWrong.tr());
    }
  }

  factory ServerFailure.fromResponse(
      int? statusCode,
      dynamic error,
      Map<String, dynamic>? messageError,
      ) {

    String errorMessage = LocaleKeys.somethingWentWrong.tr();


    if (messageError is Map<String, dynamic>) {
      final errors = messageError['errors'];

      if (errors is List && errors.isNotEmpty) {
        final firstError = errors.first;
        if (firstError is Map<String, dynamic>) {
          errorMessage = firstError['detail']?.toString() ?? errorMessage ;
        } else if (firstError is String) {
          errorMessage = firstError;
        }
      }
    }

    CustomSnackBar.show( message: errorMessage, type: SnackBarType.error);

    return ServerFailure(errorMessage);


    switch (statusCode) {
      case 400:
        return ServerFailure(
          messageError?['message'] ?? LocaleKeys.badRequest.tr(),
        );

      case 401:
        return ServerFailure(
          messageError?['message'] ?? LocaleKeys.unauthorized.tr(),
        );

      case 403:
        return ServerFailure(
          messageError?['message'] ?? LocaleKeys.forbidden.tr(),
        );

      case 404:
        return ServerFailure(
          messageError?['message'] ?? error['message'] ?? LocaleKeys.notFound.tr(),
        );

      case 422:
        return ServerFailure(
          messageError?['message'] ??
              messageError?.values
                  .join(' , ')
                  .replaceAll(RegExp(r'[^\w\s]+'), ''),
        );

      case 500:
        return ServerFailure(
          messageError?['message'] ?? LocaleKeys.internalServerError.tr(),
        );

      case 502:
        return ServerFailure(
          messageError?['message'] ?? LocaleKeys.badGateway.tr(),
        );

      default:
        return ServerFailure(
          messageError?['message'] ?? LocaleKeys.somethingWentWrong.tr(),
        );
    }
  }
}

class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure(super.message);

  factory LocalDatabaseFailure.fromError(String error) {
    return LocalDatabaseFailure(error);
  }
}