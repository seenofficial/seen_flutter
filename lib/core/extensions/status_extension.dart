import 'package:easy_localization/easy_localization.dart';

import '../translation/locale_keys.dart';
import '../utils/enums.dart';

extension StatusExtension on Status {
  bool get isActive => this == Status.active;
  bool get isCompleted => this == Status.completed;
  bool get isCancelled => this == Status.cancelled;

  String get name {
    switch (this) {
      case Status.completed:
        return LocaleKeys.completed.tr();
      case Status.cancelled:
        return LocaleKeys.cancelled.tr();
      case Status.active:
        return LocaleKeys.active.tr();
    }
  }

  String toJson() => name.toLowerCase();
}
