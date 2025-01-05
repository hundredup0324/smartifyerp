import 'package:attendance/core/controller/attendence/event_controller.dart';
import 'package:attendance/utils/app_color.dart';
import 'package:attendance/utils/helper.dart';
import 'package:attendance/utils/image_path.dart';
import 'package:attendance/utils/ui_text_style.dart';
import 'package:attendance/views/widgets/common_space_divider_widget.dart';
import 'package:attendance/views/widgets/icon_and_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalender extends StatefulWidget {
  @override
  State<EventCalender> createState() => _EventCalenderState();
}

class _EventCalenderState extends State<EventCalender> {

  EventController _controller =Get.put(EventController());


  @override
  void initState() {
    super.initState();
    _controller.eventList.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.fetchEvents(
          _controller.getMonth(), _controller.getYear().toString());
    });
  }

  @override
  Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.cWhite,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text("Event Calender".tr,style: pMedium24),
      ),
      backgroundColor: AppColor.appBackGround,
    body: Obx(
        ()=> _controller.isLoading.value == true
            ? Center(
          child: CircularProgressIndicator(),
        ):SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 1, 1),
                  focusedDay: _controller.focusedDay.value,
                  selectedDayPredicate: (day) =>
                      isSameDay(day, _controller.selectedDay.value),
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month'
                  },
                  headerStyle: HeaderStyle(formatButtonVisible: false,titleCentered: true),
                  calendarStyle: CalendarStyle(
                    markersAlignment: Alignment.bottomRight,

                    defaultTextStyle: TextStyle(color: Colors.blue),
                    weekNumberTextStyle: TextStyle(color: Colors.red),
                    weekendTextStyle: TextStyle(color: Colors.pink),
                  ),
                  eventLoader: (day) {
                    return _controller.eventList
                        .where((event) =>
                    event.startDate == getDateFormmatted(day))
                        .toList();
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    print("selectedDay $focusedDay");
                    if (!isSameDay(
                        _controller.selectedDay.value, selectedDay)) {
                      _controller.selectedDay.value =
                          _controller.focusedDay.value = focusedDay;
                      _controller.updateSelectedEvents(selectedDay);
                    }
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) => events.isNotEmpty
                        ? Container(
                      width: 24,
                      height: 24,
                      alignment: Alignment.center,
                      decoration:  BoxDecoration(
                        color: AppColor.primaryColor,
                      ),
                      child: Text(
                        '${events.length}',
                        style:
                        const TextStyle(color: Colors.white),
                      ),
                    )
                        : null,
                  ),
                  onPageChanged: (focusedDay) {
                    print("focusDay  $focusedDay");
                    _controller.setFocusedDay(focusedDay);
                    String focusDayMonth = DateFormat('MM').format(focusedDay); // 'MM' ensures the month has leading zero if needed

                    _controller.fetchEvents(
                        focusDayMonth,
                        focusedDay.year.toString());
                    // _controller.fetchEventsForMonth(
                    //             focusedDay.year, focusedDay.month);
                  },
                ),
                verticalSpace(10),
                _controller.selectedEvents.isNotEmpty?Text(
                  "Events",
                  style: pMedium24,
                ) :SizedBox(),
                verticalSpace(10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _controller.selectedEvents.length,
                  itemBuilder: (context, index) {
                    final color = _controller
                        .colors[index % _controller.colors.length];

                    var event =
                    _controller.selectedEvents[index];
                    return Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColor.cWhite),
                        child: ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius:
                                BorderRadius.circular(12)),
                            child: assetSvdImageWidget(
                                image: ImagePath.calender,
                                colorFilter: ColorFilter.mode(
                                    AppColor.cWhite, BlendMode.srcIn)),
                          ),
                          title: Text(
                            event.title.toString(),
                            style: pMedium16,
                          ),
                          subtitle: Text(
                            'Start Date: ${event.startDate} - End Date: ${event.endDate}',
                            style: pRegular12.copyWith(
                                color: AppColor.grey),
                          ),
                        ),
                      ),
                    );
                  },
                ),

              ],
            ),
          ),
        )
    ),
    ),
  );
  }
}