import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tap/languages/app_localizations.dart';

import '../../../constands/appcolors.dart';

class LogsAndMap extends StatefulWidget {
  final List<Map<String, dynamic>> logsByDateList;

  const LogsAndMap({
    super.key,
    required this.logsByDateList,
  });

  @override
  State<LogsAndMap> createState() => _LogsAndMapState();
}

class _LogsAndMapState extends State<LogsAndMap> {
  String? selectedDate;
  List<Map<String, dynamic>> selectedLogs = [];
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    if (widget.logsByDateList.isNotEmpty) {
      selectedDate = widget.logsByDateList.first["date"];
      _loadLogsByDate(selectedDate!);
    }
  }

  void _loadLogsByDate(String date) {
    final dayData = widget.logsByDateList.firstWhere(
          (e) => e["date"] == date,
      orElse: () => {"logs": []},
    );

    final logs = List<Map<String, dynamic>>.from(dayData["logs"] ?? []);

    final newMarkers = logs.map((log) {
      return Marker(
        markerId: MarkerId(log["dateTime"].toString()),
        position: LatLng(log["latitude"], log["longitude"]),
        infoWindow: InfoWindow(
          title: log["action"],
          snippet: log["dateTime"],
        ),
      );
    }).toSet();

    setState(() {
      selectedDate = date;
      selectedLogs = logs;
      markers = newMarkers;
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
                target: markers.isNotEmpty
                    ? markers.first.position
                    : const LatLng(41.2995, 69.2401),
                zoom: 14,
              ),
              markers: markers,
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
                  title: Text(log["action"]),
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
