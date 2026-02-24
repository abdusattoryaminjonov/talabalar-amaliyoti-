import 'dart:convert';
import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../constands/appcolors.dart';
import '../../languages/app_localizations.dart';
import '../../models/login_users_model/internship_model.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';
import '../../widgets/dialogs/mock_location_dialog.dart';
import '../../widgets/dialogs/show_dialog.dart';

class AttendancePageController extends GetxController {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  Map<String, dynamic> attendancesMap = {};

  late Box<InternshipModel> internshipBox;
  final httpService = HttpService();
  final RefreshController refreshController = RefreshController();

  List<Map<String, dynamic>> logsByDateList = [];
  String expectedLat = "41.27238966350865";
  String expectedLon = "69.20522773343085";
  String checkInLat = "";
  String checkInLon = "";
  String checkOutLat = "";
  String checkOutLon = "";

  DateTime? kirishVaqti;
  String interName = "";
  int interId = -1;

  bool isCheckInLoading = false;
  bool isCheckOutLoading = false;
  bool isPageLoading = true;

  String locationMessage = "GPS ruxsati doimiy rad etilgan!";
  String lat = '';
  String lng = '';



  void showMessage(BuildContext context, String message, AnimatedSnackBarType type) {
    AnimatedSnackBar.material(
        message,
        type: type,
        duration: const Duration(seconds: 2)
    ).show(context);
  }

  Future<bool> checkLocationPermission(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationDialog(
        context,
        message: AppLocalizations.of(context)!.pleaseOnLoc,
      );
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {

      _showLocationDialog(
        context,
        message:
        AppLocalizations.of(context)!.locationMessageDesc,
        openSettings: true,
      );
      return false;
    }

    if (permission == LocationPermission.denied) {
      return false;
    }

    await _getCurrentLocation();
    return true;
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    LogService.i("${position.latitude} \n${position.longitude}");
    lat = position.latitude.toString();
    lng = position.longitude.toString();
  }

  void _showLocationDialog(
      BuildContext context, {
        required String message,
        bool openSettings = false,
      }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:  Text(AppLocalizations.of(context)!.location,textAlign: TextAlign.center,),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message,textAlign: TextAlign.center,),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          child: InteractiveViewer(
                            child: Image.asset(
                              Platform.isIOS
                                  ? "assets/images/imgL2.jpg"
                                  : "assets/images/androidImg2.jpg",
                            ),
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        Platform.isIOS
                            ? "assets/images/imgL2.jpg"
                            : "assets/images/androidImg2.jpg",
                        fit: BoxFit.contain,
                        height: 150,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          child: InteractiveViewer(
                            child: Image.asset(
                              Platform.isIOS
                                  ? "assets/images/imgL1.jpg"
                                  : "assets/images/androidImg1.jpg",
                            ),
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        Platform.isIOS
                            ? "assets/images/imgL1.jpg"
                            : "assets/images/androidImg1.jpg",
                        fit: BoxFit.contain,
                        height: 150,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:  Text(AppLocalizations.of(context)!.cancelText),
          ),
          if (openSettings)
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await Geolocator.openAppSettings();
              },
              child:  Text(AppLocalizations.of(context)!.goToSettings),
            ),
        ],
      ),
    );
  }

  Widget notData(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.notChoseInter,
            style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            textAlign: TextAlign.center,
            AppLocalizations.of(context)!.quotaDesc,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text("1"),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            child: InteractiveViewer(
                              child: Image.asset(
                                Platform.isIOS
                                    ? "assets/images/home.png"
                                    : "assets/images/home.png",
                              ),
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          Platform.isIOS
                              ? "assets/images/home.png"
                              : "assets/images/home.png",
                          fit: BoxFit.contain,
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    Text("2"),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            child: InteractiveViewer(
                              child: Image.asset(
                                Platform.isIOS
                                    ? "assets/images/drawerimage.jpg"
                                    : "assets/images/drawerimage.jpg",
                              ),
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          Platform.isIOS
                              ? "assets/images/drawerimage.jpg"
                              : "assets/images/drawerimage.jpg",
                          fit: BoxFit.contain,
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    Text("3"),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            child: InteractiveViewer(
                              child: Image.asset(
                                Platform.isIOS
                                    ? "assets/images/clickImage.jpg"
                                    : "assets/images/clickImage.jpg",
                              ),
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          Platform.isIOS
                              ? "assets/images/clickImage.jpg"
                              : "assets/images/clickImage.jpg",
                          fit: BoxFit.contain,
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> isMockLocation() async {
    bool mock = false;
    Position position = await Geolocator.getCurrentPosition();
    if (position.isMocked) {
      mock = true;
    }
    return mock;
  }

  Future<void> loadData(int interId, String token) async {
    isPageLoading = true;
    update();

    try {
      final res = await httpService.getAttendance(token, interId);


      if (res.statusCode != 200) {
        attendancesMap.clear();
        logsByDateList.clear();
        isPageLoading = false;
        update();
        return;
      }

      final json = jsonDecode(res.body);
      
      LogService.w(json.toString());

      final attendances =
          json["data"]?["studentSchedule"]?["attendances"] ?? [];

      attendancesMap.clear();
      logsByDateList.clear();

      for (var item in attendances) {

        final dateStr = item["date"];
        attendancesMap[dateStr] = item;
        update();

        if (dateStr == null || dateStr.isEmpty) continue;

        expectedLat = item["expectedLat"].toString();
        expectedLon = item["expectedLon"].toString();

        final isInput = item["isInput"];
        final isOutput = item["isOutput"];

        if(isInput){
          checkInLat = item["checkInLat"].toString();
          checkInLon = item["checkInLon"].toString();
        }

        if(isOutput){
          checkOutLat = item["checkOutLat"].toString();
          checkOutLon = item["checkOutLon"].toString();
        }
        final logs = item["logs"] ?? [];

        logsByDateList.add({
          "date": dateStr,
          "checkInLat": checkInLat,
          "checkInLon": checkInLon,
          "checkOutLat": checkOutLat,
          "checkOutLon": checkOutLon,
          "logs": logs,
        });
        update();

      }
    } catch (e) {
      LogService.e("Xatolik: $e");
    } finally {
      isPageLoading = false;
      update();
    }
  }

  void updateDay(DateTime selected, DateTime focused) {
    selectedDay = selected;
    focusedDay = focused;
    update();
  }

  bool get isKetishEnabled {
    if (kirishVaqti == null) return false;
    return DateTime.now().isAfter(
      kirishVaqti!.add(const Duration(hours: 1)),
    );
  }

  Widget buildDayInfo(DateTime day, BuildContext context, String token, int id) {
    final key =
        "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";

    final data = attendancesMap[key];
    update();


    if (data == null) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.notData,
          style: TextStyle(
            color: AppColors.appActiveBlue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.lato().fontFamily,
          ),
        ),
      );
    }

    LogService.e("IN TIME => ${data["inTime"]}");

    final inTime = _formatTime(data["inTime"]);
    final outTime = _formatTime(data["outTime"]);
    final inDist = data["checkInDistance"] ?? 0;
    final outDist = data["checkOutDistance"] ?? 0;

    final bool isInput = data["isInput"] == true;
    final bool isOutput = data["isOutput"] == true;

    bool isToday = DateTime.now().year == day.year &&
        DateTime.now().month == day.month &&
        DateTime.now().day == day.day;

    return Column(
      children: [
        if (isToday)
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              if (isInput && !isOutput)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      // String udId = await FlutterUdid.udid;
                      // String deviceId = "";
                      // deviceId = udId;
                      //
                      // LogService.e(deviceId);
                      // NoSqlService.updateUserDevice(udId);

                      bool hasPermission = await checkLocationPermission(context);
                      if (!hasPermission) return;

                      String? note = await showNoteDialog(context, isCheckIn: false);
                      if (note == null) return;

                      String finalNote = note.isEmpty ? "Assalomu Aleykum" : note;

                      isPageLoading = true;
                      update();

                      bool allow = true;
                      if (Platform.isAndroid) {
                        allow = !await isMockLocation();
                      }

                      if (allow) {
                        try {
                          Position position = await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high,
                          );

                          lat = position.latitude.toString();
                          lng = position.longitude.toString();

                          var request = await httpService.attendance(
                            token: token,
                            internshipId: id,

                            lat: lat,
                            lng: lng,

                            // lat: "41.282200201287125",
                            // lng: "69.27498458131157",

                            notes: finalNote,
                            buttonType: 'CHECK_OUT',
                          );

                          Map<String, dynamic> jsonResponse =
                          jsonDecode(request.body);

                          if (request.statusCode == 200 || request.statusCode == 201) {
                            ShowDialogHelper.showCustomDialog(
                              context,
                              jsonResponse['message'],
                              AppColors.appActiveGreen,
                            );
                            await loadData(id, token);
                            update();

                          } else {
                            ShowDialogHelper.showCustomDialog(
                              context,
                              jsonResponse['message'],
                              AppColors.red,
                            );
                          }
                        } catch (e) {
                          LogService.e(e.toString());
                        }

                        await loadData(id, token);
                        isPageLoading = false;
                        update();
                      } else {
                        ShowMockLocationDialog.showCustomDialog(
                          context,
                          AppLocalizations.of(context)!.lieLocation,
                        );

                        await loadData(id, token);
                        isPageLoading = false;
                        update();
                      }
                    },
                    style:ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: Text(
                      AppLocalizations.of(context)!.toGoAtt,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),

              if (!isInput)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      bool hasPermission = await checkLocationPermission(context);
                      if (!hasPermission) return;

                      String? note = await showNoteDialog(context, isCheckIn: true);
                      if (note == null) return;

                      String finalNote = note.isEmpty ? "Assalomu Aleykum" : note;

                      isPageLoading = true;
                      update();

                      bool allow = true;
                      if (Platform.isAndroid) {
                        allow = !await isMockLocation();
                      }

                      if (allow) {
                        isPageLoading = true;
                        update();

                        try {
                          Position position = await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high,
                          );

                          lat = position.latitude.toString();
                          lng = position.longitude.toString();

                          var response = await httpService.attendance(
                            token: token,
                            internshipId: id,

                            lat: lat,
                            lng: lng,

                            // lat: "41.282200201287125",
                            // lng: "69.27498458131157",

                            notes: finalNote,
                            buttonType: 'CHECK_IN',
                          );

                          Map<String, dynamic> jsonResponse =
                          jsonDecode(response.body);

                          if (response.statusCode == 200 ||
                              response.statusCode == 201) {
                            await loadData(id, token);
                            update();

                          } else {
                            ShowDialogHelper.showCustomDialog(
                              context,
                              jsonResponse['message'],
                              AppColors.red,
                            );
                          }
                        } catch (e) {
                          showMessage(
                            context,
                            e.toString(),
                            AnimatedSnackBarType.error,
                          );
                        }

                        await loadData(id, token);
                        isPageLoading = false;
                        update();
                      } else {
                        ShowMockLocationDialog.showCustomDialog(
                          context,
                          AppLocalizations.of(context)!.lieLocation,
                        );

                        await loadData(id, token);
                        isPageLoading = false;
                        update();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appActiveBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.login, color: Colors.white),
                    label: Text(
                      AppLocalizations.of(context)!.toComeAtt,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),

        const SizedBox(height: 16),

        if (isInput)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: dayCard(inTime, double.parse('$inDist').round(), Icons.login, Colors.green),
          ),

        if (isOutput)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: dayCard(outTime, double.parse('$outDist').round(), Icons.logout, Colors.red),
          ),
      ],
    );
  }

  String _formatTime(String? iso) {
    if (iso == null) return "—";
    final dt = DateTime.parse(iso).toLocal();
    return "${dt.hour.toString().padLeft(2, "0")}:${dt.minute.toString().padLeft(2, "0")}";
  }

  Widget dayCard(String time, int metr, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          Expanded(
            child: Center(
              child: Text(
                time,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),
          ),
          Text(
            "$metr m",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: metr > 200 ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget chosenInternship(BuildContext context, String interName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.appActiveBlueOch,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            interName,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.lato().fontFamily,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Future<String?> showNoteDialog(BuildContext context, {required bool isCheckIn}) async {
    TextEditingController controller = TextEditingController();

    List<String> suggestions = isCheckIn
        ? [
      "Men amaliyot joyidaman.",
      "Amaliyotni boshladim.",
      "Assalomu Aleykum",
    ]
        : [
      "Men amaliyotni tugatdim.",
      "Bugungi kun amaliyoti tugatildi.",
    ];

    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.55,
          minChildSize: 0.35,
          maxChildSize: 0.9,

          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),


                  Text(
                    isCheckIn ? AppLocalizations.of(context)!.comIn : AppLocalizations.of(context)!.comOut,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: controller,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.optionalMessage,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: suggestions.map((text) {
                      return ActionChip(
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.15),
                        label: Text(
                          text,
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          controller.text = text;
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context, null),
                          child: Text(AppLocalizations.of(context)!.cancelText),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context, controller.text.trim()),
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.appActiveGreen,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.submitText,
                          ),
                        )
                        ,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.submitMainIdeTxt,
                    style: TextStyle(

                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

}
