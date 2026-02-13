import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tap/languages/app_localizations.dart';

import '../../../constands/appcolors.dart';
import '../../../widgets/dialogs/map_information.dart';
import '../../../widgets/dialogs/show_notice_dialog.dart';

class LogsAndMap extends StatefulWidget {
  final List<Map<String, dynamic>> logsByDateList;
  final double expectedLat;
  final double expectedLon;


  const LogsAndMap({
    super.key,
    required this.expectedLat,
    required this.expectedLon,
    required this.logsByDateList,
  });

  @override
  State<LogsAndMap> createState() => _LogsAndMapState();
}

class _LogsAndMapState extends State<LogsAndMap> {
  String? selectedDate;
  List<Map<String, dynamic>> selectedLogs = [];
  Set<Marker> markers = {};
  Set<Circle> circles = {};
  BitmapDescriptor? buildingIcon;

  @override
  void initState() {
    super.initState();

    // if (widget.logsByDateList.isNotEmpty) {
    //   selectedDate = widget.logsByDateList.first["date"];
    // }

    final today = DateTime.now();
    final todayStr = "${today.year.toString().padLeft(4,'0')}-"
        "${today.month.toString().padLeft(2,'0')}-"
        "${today.day.toString().padLeft(2,'0')}";

    if (widget.logsByDateList.isNotEmpty) {
      final todayExists = widget.logsByDateList.any((e) => e["date"] == todayStr);
      selectedDate = todayExists ? todayStr : widget.logsByDateList.first["date"];
    }

    loadMarker();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (selectedDate != null) {
      _loadLogsByDate(selectedDate!);
    }

  }

  Future<void> loadMarker() async {
    buildingIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/icons/school.png',
    );
    setState(() {});
  }

  void _loadLogsByDate(String date) {
    final local = AppLocalizations.of(context)!;

    final dayData = widget.logsByDateList.firstWhere(
          (e) => e["date"] == date,
      orElse: () => {"logs": []},
    );

    final logs = List<Map<String, dynamic>>.from(dayData["logs"] ?? []);

    final logMarkers = logs.map((log) {
      return Marker(
        markerId: MarkerId(log["dateTime"].toString()),
        position: LatLng(
          (log["latitude"] as num).toDouble(),
          (log["longitude"] as num).toDouble(),
        ),
        infoWindow: InfoWindow(
          title: log["action"]?.toString() == "CHECK_IN"
              ? local.toComeText
              : local.toGoText,
          snippet:
          "${((log["distance"] ?? 0) as num).toDouble().toStringAsFixed(1)} m",
        ),
      );
    }).toSet();

    final buildingMarker = Marker(
      markerId: const MarkerId("expected_location"),
      position: LatLng(widget.expectedLat, widget.expectedLon),
      icon:BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow:  InfoWindow(
        title: AppLocalizations.of(context)!.buildingMarkerTitle ,
      ),
    );

    final buildingCircle = Circle(
      circleId: const CircleId("expected_location_radius"),
      center: LatLng(widget.expectedLat, widget.expectedLon),
      radius: 150, // metr
      strokeColor: AppColors.appActiveBlue,
      strokeWidth: 2,
    );

    // final checkInMarker = Marker(
    //   markerId: const MarkerId("expected_location"),
    //   position: LatLng(double.parse(dayData["checkInLat"]),double.parse(dayData["checkInLon"])),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(
    //     BitmapDescriptor.hueGreen,
    //   ),
    //   infoWindow: const InfoWindow(
    //     title: "Amaliyot binosi",
    //   ),
    // );
    //
    // final checkOutMarker = Marker(
    //   markerId: const MarkerId("expected_location"),
    //   position: LatLng(double.parse(dayData["checkOutLat"]),double.parse(dayData["checkOutLon"])),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(
    //     BitmapDescriptor.hueGreen,
    //   ),
    //   infoWindow: const InfoWindow(
    //     title: "Amaliyot binosi",
    //   ),
    // );

    setState(() {
      selectedDate = date;
      selectedLogs = logs;
      // markers = {...logMarkers, buildingMarker,checkInMarker,checkOutMarker};
      markers = {...logMarkers, buildingMarker};
      circles = {buildingCircle};
    });
  }



  @override
  Widget build(BuildContext context) {
    final txt = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.appActiveBlue,
        title: Text(
          txt.logsAndMap,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.lato().fontFamily,
          ),
        ),

        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_outlined, color: AppColors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            color: AppColors.white,
            iconSize: 30,
            onPressed: (){
              showMapInformation(context);
            },
          ),
          SizedBox(width: 5,),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.logsByDateList.length,
              itemBuilder: (context, index) {
                final date = widget.logsByDateList[index]["date"];

                final isSelected = date == selectedDate;

                return GestureDetector(
                  onTap: () => _loadLogsByDate(date),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.appActiveBlue
                          : AppColors.appActiveBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        date,
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.appActiveBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            flex: 2,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.expectedLat, widget.expectedLon),
                zoom: 14,
              ),
              markers: markers,
              circles: circles,
            ),
          ),

          Expanded(
            flex: 2,
            child: selectedLogs.isEmpty
                ? Center(child: Text(AppLocalizations.of(context)!.logsEmpty))
                : ListView.builder(
              itemCount: selectedLogs.length,
              itemBuilder: (context, index) {
                final log = selectedLogs[index];

                return ListTile(
                  leading: Icon(Icons.location_on, color: AppColors.red),
                  title: Text(log["action"]?.toString() == "CHECK_IN" ? AppLocalizations.of(context)!.toComeText : AppLocalizations.of(context)!.toGoText),
                  subtitle: Row(
                    children: [
                      Text(log["dateTime"].split("T")[0] ?? ""),
                      SizedBox(width: 10,),
                      Text(log["dateTime"].split("T")[1].substring(0, 5) ?? ""),
                    ],
                  ),
                  trailing: Text(
                    "${(log["distance"] ?? 0).toStringAsFixed(1)} m",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
