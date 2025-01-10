// Copyright (c) 2021 Simform Solutions. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:flutter/material.dart';

@immutable
class CalendarEventDataMeta {
  final DateTime repeatStart;
  final DateTime? repeatEnd;
  final int? repeatWeekday;
  final int repeatInterval;

  CalendarEventDataMeta({
    required this.repeatStart,
    this.repeatEnd,
    this.repeatWeekday,
    required this.repeatInterval,
  });

  bool occursOnDate(DateTime date) {
    if (repeatStart.isAfter(date)) {
      return false;
    }
    if (repeatEnd != null && repeatEnd!.isBefore(date)) {
      return false;
    }

    if (repeatWeekday != null) {
      if (repeatWeekday != date.weekday) {
        return false;
      }

      final daysDiff = date.difference(repeatStart).inDays;

      if (daysDiff < 0) {
        return false;
      }

      final weeks = (daysDiff / 7).ceil();
      if (weeks % repeatInterval != 0) {
        return false;
      }
    }

    return true;
  }
}
