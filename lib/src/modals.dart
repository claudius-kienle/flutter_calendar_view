// Copyright (c) 2021 Simform Solutions. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:rrule/rrule.dart';

import '../calendar_view.dart';

/// Settings for hour lines
class HourIndicatorSettings {
  final double height;
  final Color color;
  final double offset;
  final LineStyle lineStyle;
  final double dashWidth;
  final double dashSpaceWidth;
  final int startHour;

  /// Settings for hour lines
  const HourIndicatorSettings(
      {this.height = 1.0,
      this.offset = 0.0,
      this.color = Colors.grey,
      this.lineStyle = LineStyle.solid,
      this.dashWidth = 4,
      this.dashSpaceWidth = 4,
      this.startHour = 0})
      : assert(height >= 0, "Height must be greater than or equal to 0.");

  factory HourIndicatorSettings.none() => HourIndicatorSettings(
        color: Colors.transparent,
        height: 0.0,
      );
}

/// Settings for live time line
class LiveTimeIndicatorSettings {
  /// Color of time indicator.
  final Color color;

  /// Height of time indicator.
  final double height;

  /// offset of time indicator.
  final double offset;

  /// StringProvider for time string
  final StringProvider? timeStringBuilder;

  /// Flag to show bullet at left side or not.
  final bool showBullet;

  /// Flag to show time on live time line.
  final bool showTime;

  /// Flag to show time background view.
  final bool showTimeBackgroundView;

  /// Radius of bullet.
  final double bulletRadius;

  /// Width of time backgroud view.
  final double timeBackgroundViewWidth;

  /// Function that provides the DateTime to be used for the live time indicator.
  ///
  /// If not provided, [DateTime.now] will be used as the default behavior.
  ///
  /// Example usage:
  /// ```dart
  /// // Show time for New York timezone (UTC-4)
  /// currentTimeProvider: () {
  ///   final utcNow = DateTime.now().toUtc();
  ///   return utcNow.subtract(Duration(hours: 4));
  /// }
  /// ```
  final DateTime Function()? currentTimeProvider;

  /// Flag to show only today's events.
  final bool onlyShowToday;

  /// Settings for live time line
  const LiveTimeIndicatorSettings({
    this.height = 1.0,
    this.offset = 5.0,
    this.color = Colors.grey,
    this.timeStringBuilder,
    this.showBullet = true,
    this.showTime = false,
    this.showTimeBackgroundView = false,
    this.bulletRadius = 5.0,
    this.timeBackgroundViewWidth = 60.0,
    this.currentTimeProvider,
    this.onlyShowToday = false,
  }) : assert(height >= 0, "Height must be greater than or equal to 0.");

  factory LiveTimeIndicatorSettings.none() => LiveTimeIndicatorSettings(
        color: Colors.transparent,
        height: 0.0,
        offset: 0.0,
        showBullet: false,
      );
}

/// Set `frequency = RepeatFrequency.daily` to repeat every day
/// starting from event date (Inclusive).
///
/// Set `frequency = RepeatFrequency.weekly` & provide list of weekdays
/// to repeat on.
///
/// [startDate]: Defines start date of repeating events.
/// [endDate]: Defines end date of repeating events.
/// [occurrence]: Defines repetition of an event for the given number of
/// occurrences.
///
/// [frequency]: Defines mode of repetition like repeat daily, weekly, monthly
/// or yearly.
///
/// [weekdays]: Contains list of weekdays to repeat starting from 0 index.
/// By default selected weekday is the start date of an event.
///
/// Note: Use constructor .withCalculatedEndDate to calculate
/// end date of recurring event automatically.
class RecurrenceSettings {
  RecurrenceSettings({
    required this.recurrenceRule,
    this.excludeDates,
  });

  final RecurrenceRule recurrenceRule;
  final List<DateTime>? excludeDates;

  @override
  String toString() {
    return 'rrule: $recurrenceRule, '
        'exclude dates: $excludeDates';
  }

  RecurrenceSettings copyWith({
    RecurrenceRule? recurrenceRule,
    List<DateTime>? excludeDates,
  }) {
    return RecurrenceSettings(
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      excludeDates: excludeDates ?? this.excludeDates,
    );
  }
}
