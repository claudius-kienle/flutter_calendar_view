// Copyright (c) 2021 Simform Solutions. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'dart:collection';

import 'calendar_event_data.dart';
import 'typedefs.dart';

class EventController<T extends Object?> {
  /// Calendar controller to control all the events related operations like,
  /// adding event, removing event, etc.
  EventController({
    /// This method will provide list of events on particular date.
    ///
    /// This method is use full when you have recurring events.
    /// As of now this library does not support recurring events.
    /// You can implement same behaviour in this function.
    /// This function will overwrite default behaviour of [getEventsOnDay]
    /// function which will be used to display events on given day in
    /// [MonthView], [DayView] and [WeekView].
    ///
    required List<CalendarEventData<T>> eventList,
  }) : _eventList = UnmodifiableListView(eventList);

  /// Store all calendar event data
  final UnmodifiableListView<CalendarEventData<T>> _eventList;

  //#endregion

  //#region Public Fields

  UnmodifiableListView<CalendarEventData<T>> get allEvents => _eventList;

  /// Returns events on given day.
  ///
  /// To overwrite default behaviour of this function,
  /// provide [eventFilter] argument in [EventController] constructor.
  ///
  /// if [includeFullDayEvents] is true, it will include full day events
  /// as well else, it will exclude full day events.
  ///
  /// NOTE: If [eventFilter] is set i.e, not null, [includeFullDayEvents] will
  /// have no effect. As what events to be included will be decided
  /// by the [eventFilter].
  ///
  /// To get full day events exclusively, check [getFullDayEvent] method.
  ///
  List<CalendarEventData<T>> getEventsOnDay(DateTime date,
      {bool includeFullDayEvents = true}) {
    final events = allEvents
        .where((e) =>
            (includeFullDayEvents || !e.isFullDayEvent) && e.occursOnDate(date))
        .toList();
    return events;
  }

  /// Returns full day events on given day.
  List<CalendarEventData<T>> getFullDayEvent(DateTime date) {
    final events = getEventsOnDay(date, includeFullDayEvents: true)
        .where((e) => e.isFullDayEvent)
        .toList();
    return events;
  }
}
