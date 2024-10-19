import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawi_hub_owner/generated/l10n.dart';
import 'package:hawi_hub_owner/src/core/common_widgets/common_widgets.dart';
import 'package:hawi_hub_owner/src/core/error/remote_error.dart';
import 'package:hawi_hub_owner/src/core/routing/navigation_manager.dart';
import 'package:hawi_hub_owner/src/core/utils/color_manager.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/components.dart';
import 'package:hawi_hub_owner/src/modules/main/view/widgets/screen_backround.dart';
import 'package:hawi_hub_owner/src/modules/places/bloc/place_cubit.dart';
import 'package:hawi_hub_owner/src/modules/places/data/models/booking.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AddBookingScreen extends StatefulWidget {
  final int placeId;

  const AddBookingScreen({super.key, required this.placeId});

  @override
  State<AddBookingScreen> createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 0, minute: 0);
  List<Booking> bookings = [];

  @override
  void initState() {
    print("place id : ${widget.placeId}");
    _fetchBookings();
    super.initState();
  }

  Future<void> _fetchBookings() async {
    await PlaceCubit.get().getPlaceBookings(placeId: widget.placeId);
  }

  Future<void> _selectStartTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: startTime,
      cancelText: S.of(context).cancel,
      confirmText: S.of(context).confirm,
    );
    if (pickedTime != null) {
      setState(() {
        startTime = pickedTime;
      });
    }
  }

  Future<void> _selectEndTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: endTime,
      cancelText: S.of(context).cancel,
      confirmText: S.of(context).confirm,
    );
    if (pickedTime != null) {
      setState(() {
        endTime = pickedTime;
      });
    }
  }

  Future<void> _makeBooking() async {
    DateTime start = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, startTime.hour, startTime.minute);
    DateTime end = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, endTime.hour, endTime.minute);
    for (Booking booking in bookings) {
      // Check if the new booking overlaps with any existing booking
      if (booking.isConflicting(Booking(startTime: start, endTime: end))) {
        errorToast(msg: S.of(context).bookingConflict);
        return;
      }
    }
    // Add the booking to the list (simulate the addition)
    setState(() {
      PlaceCubit.get().addOfflineReservation(
          placeId: widget.placeId,
          booking: Booking(startTime: start, endTime: end));
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        "bookings: ${bookings.map((e) => "start: ${e.startTime}, end: ${e.endTime}").toString()}");
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: ScreenBackground(
                  screenImage: PlaceCubit.get().currentPlace!.images.first,
                  screenTitle: S.of(context).addBooking,
                  child: BlocListener<PlaceCubit, PlaceState>(
                    bloc: PlaceCubit.get(),
                    listener: (context, state) {
                      if (state is GetPlaceBookingsSuccess) {
                        setState(() {
                          debugPrint(state.bookings
                              .map((e) =>
                                  "start: ${e.startTime}, end: ${e.endTime}")
                              .toString());
                          bookings = state.bookings;
                        });
                      }
                      if (state is PlaceError) {
                        print("error: ${state.exception}");
                        errorToast(
                            msg: ExceptionManager(state.exception)
                                .translatedMessage());
                      }
                      if (state is AddOfflineReservationSuccess) {
                        defaultToast(msg: S.of(context).bookingCreated);
                        context.pop();
                      }
                    },
                    child: BlocBuilder<PlaceCubit, PlaceState>(
                      bloc: PlaceCubit.get(),
                      builder: (context, state) {
                        return state is GetPlaceBookingsLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Column(
                                  children: [
                                    SizedBox(height: 3.h),
                                    SizedBox(
                                      height: 50.h,
                                      child: Stack(
                                        children: [
                                          Card(
                                            color: ColorManager.white,
                                            elevation: 5,
                                            child: Column(
                                              children: [
                                                Container(
                                                  color: ColorManager.primary,
                                                  height: 10.h,
                                                  width: double.infinity,
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .bottomStart,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TitleText(
                                                        color:
                                                            ColorManager.white,
                                                        DateFormat.yMMMMEEEEd()
                                                            .format(
                                                                selectedDate),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CalendarDatePicker(
                                                    initialCalendarMode:
                                                        DatePickerMode.day,
                                                    currentDate: selectedDate,
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime.now()
                                                        .add(const Duration(
                                                            days: 365)),
                                                    initialDate: selectedDate,
                                                    onDateChanged:
                                                        (DateTime value) {
                                                      setState(() {
                                                        selectedDate = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50.h,
                                      width: 90.w,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 43.w,
                                            child: Stack(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SubTitle(
                                                        S.of(context).from),
                                                    FittedBox(
                                                      child: TimePickerDialog(
                                                        initialTime: startTime,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Positioned.fill(
                                                    child: InkWell(
                                                        onTap:
                                                            _selectStartTime))
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            width: 43.w,
                                            child: Stack(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SubTitle(S.of(context).to),
                                                    FittedBox(
                                                      child: TimePickerDialog(
                                                        initialTime: endTime,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Positioned.fill(
                                                    child: InkWell(
                                                        onTap: _selectEndTime))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),
                  )),
            ),
          ),
          BlocBuilder<PlaceCubit, PlaceState>(
            bloc: PlaceCubit.get(),
            builder: (context, state) {
              return state is GetPlaceBookingsLoading
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: DefaultButton(
                          isLoading: state is AddOfflineReservationLoading,
                          text: S.of(context).save,
                          onPressed: () {
                            _makeBooking();
                          }),
                    );
            },
          )
        ],
      ),
    );
  }
}
