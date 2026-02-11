import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constands/appcolors.dart';
import '../../models/login_users_model/internship_model.dart';
import '../../pages/student_pages/login/login_page.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';
import '../../services/nosql_service.dart';
import '../../widgets/dialogs/generic_dialog.dart';
import '../../widgets/show_message/show_message.dart';

class QuotaPageController extends GetxController{

  final httpService = HttpService();
  late Box<InternshipModel> internshipBox;

  List<dynamic> quotaList = [];
  Map<String,dynamic> quotaMap = {};
  bool isLoading = true;

  String interName = "";
  int interId = -1;

  void loadData(String token, int id) async {
    isLoading = true;
    update();

    try {
      var response = await httpService.getQuotas(token, id, 0);
      final data = jsonDecode(response.body);

      LogService.i(response.body);


      if (response.statusCode == 200) {

        quotaList = data['data']['content'];
        update();

        quotaMap = {};
        update();

      } else if (response.statusCode == 202) {
        quotaMap = data['data']['quotaResponse'];
        update();
        quotaList = [];
      }
      else {
        quotaList = [];
        quotaMap = {};
      }
    } catch (e) {
      quotaList = [];
      quotaMap = {};
    }

    isLoading = false;
    update();
  }

  Widget quotaListBuilder(List<dynamic> quotaList1,String token, int interId){
    return ListView.builder(
      itemCount: quotaList1.length,
      itemBuilder: (context, index) {
        final item = quotaList1[index];
        final company = item['company'];
        final quotaId = item['id'];
        final companyName = company['name'];
        final phone = company['phone'] ?? "—";
        final subject = item['subject']['name'] ?? "—";
        final used = item['usedQuota'];
        final total = item['totalQuota'];
        final address = company['location']['address'];
        final yandexMapUrl = company['location']['yandexMapUrl'];
        final googleMapUrl = company['location']['googleMapUrl'];
        final language = item['educationlanguage'] ?? "—";

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.appActiveBlueOch,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.school, color: AppColors.appActiveBlue, size: 30),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          companyName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: GoogleFonts.lato().fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "$used / $total",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.lato().fontFamily,
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Icon(Icons.book, size: 20, color: AppColors.appActiveBlue),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "Fan: $subject",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Icon(Icons.language, size: 20, color: AppColors.appActiveBlue),
                      const SizedBox(width: 6),
                      Text(
                        "Til: $language",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Icon(Icons.location_pin, size: 20, color: Colors.redAccent),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Icon(Icons.phone, size: 20, color: Colors.green),
                      const SizedBox(width: 6),
                      Text(
                        phone,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _mapButton("Yandex Map", yandexMapUrl, Colors.red),
                      _mapButton("Google Map", googleMapUrl, Colors.blue),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appActiveBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        onPressed: () {
                          choseInterDialog(
                            context,
                            companyName,
                            "Amaliyot joyini tanlaysizmi?", token, interId, quotaId
                          );
                        },
                        child: Text(
                          "Tanlash",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget chosenInternship(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: MediaQuery.of(context).size.width, // eni
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

  Future<void> showQuotaResponseDialog(BuildContext context, String token, int internshipId, int quotaId) async {
    try {
      final response = await httpService.choseQuota(token, internshipId, quotaId);
      final body = response.body;
      final json = jsonDecode(body);

      String message = json["message"]?.toString() ?? "";
      int status = json["status"] ?? 0;
      dynamic data = json["data"];

      List<dynamic>? quotaResponses = data["quotaResponses"];

      await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Kvota tanlash natijasi"),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Message: $message"),
                  const SizedBox(height: 8),
                  Text("Status: $status"),
                  const SizedBox(height: 12),
                  if (quotaResponses != null && quotaResponses.isNotEmpty)
                    ...quotaResponses.map((qr) {
                      final company = qr["company"];
                      final subject = qr["subject"];
                      final internship = qr["internship"];
                      final loc = company["location"];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("-------"),
                          Text("Quota ID: ${qr["id"]}"),
                          Text("Company: ${company["name"]}"),
                          Text("Subject: ${subject["name"]}"),
                          Text("Internship: ${internship["name"]}"),
                          Text("Total Quota: ${qr["totalQuota"]}"),
                          Text("Used Quota: ${qr["usedQuota"]}"),
                          Text("Available Quota: ${qr["availableQuota"]}"),
                          Text("Location City: ${loc["city"]}"),
                          Text("Map URL: ${loc["googleMapUrl"]}"),
                          const SizedBox(height: 8),
                        ],
                      );
                    }).toList()
                  else
                    Text("quotaResponses yo‘q"),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Yopish"),
              ),
            ],
          );
        },
      );
    } catch (e) {
      Get.snackbar("Xato", "Server bilan ulanib bo‘lmadi: $e");
    }
  }

  choseInterDialog(BuildContext context,String title,String content,String token, int interId, int quotaId) async {
    bool result = await showGenericDialog(
      context: context,
      title: title,
      content: content,
      optionsBuilder: () => {
        "Yo'q": false,
        "Ha": true,
      },
    );
    if (result) {
      isLoading = true;
      update();

      try {
        final response = await httpService.choseQuota(token, interId, quotaId);

        isLoading = false;
        update();

        if (response.statusCode == 200) {
          ShowMessage.showMessage(context,"Amaliyot joyi tanlandi!", AnimatedSnackBarType.success);

          loadData(token, interId);
          update();
        }

        else if (response.statusCode == 202) {
          ShowMessage.showMessage(context,"Siz allaqachon kvota tanlagansiz", AnimatedSnackBarType.info);
          Get.snackbar("Ma'lumot", "");
        }

        else if (response.statusCode == 401 ||response.statusCode == 403 || response.statusCode == 500 ) {
          ShowMessage.showMessage(context,"Foydalanuvchi ma'lumotlari eskirgan. Iltimos ilovaga qaytadan kiring!", AnimatedSnackBarType.info);

          await NoSqlService.clearAllData();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false,
          );
        }

      } catch (e) {
        isLoading = false;
        update();
        Get.snackbar("Xatolik", "Internet yoki server xatosi: $e");
      }

    }
  }

  Widget quotaItem(Map<String, dynamic> item, BuildContext context) {
    final company = item['company'];
    final subject = item['subject'];
    final internship = item['internship'];
    final location = company['location'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.school, size: 30, color: Colors.blueAccent),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      company['name'] ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /// 📍 Address
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, color: Colors.redAccent, size: 22),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      location['address'] ?? "",
                      style: const TextStyle(fontSize: 15),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /// ☎ Phone
              Row(
                children: [
                  const Icon(Icons.phone, color: Colors.green, size: 22),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      company['phone'] ?? "",
                      style: const TextStyle(fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// 🎓 Chips (responsive)
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  _chip("${item['course'] == 0 ? "3-4" : item['course']}-kurs"),
                  _chip("Til: ${item['educationlanguage']}"),
                ],
              ),

              const SizedBox(height: 12),

              /// 📚 Subject
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.book, color: Colors.orange, size: 22),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "Fan: ${subject['name'] ?? ""}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// ⏳ Internship
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.timelapse, color: Colors.lightBlue, size: 22),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      internship['name'] ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              /// 📊 Quota bar
              _quotaBar(
                used: item['usedQuota'],
                total: item['totalQuota'],
              ),

              const SizedBox(height: 15),

              /// 🗺 Map buttons (responsive)
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    child: _mapButton(
                      "Yandex Map",
                      location['yandexMapUrl'],
                      Colors.red,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    child: _mapButton(
                      "Google Map",
                      location['googleMapUrl'],
                      Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _quotaBar({required int used, required int total}) {
    final percent = used / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kvota: $used / $total",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: LinearProgressIndicator(
            minHeight: 12,
            value: percent,
            backgroundColor: Colors.grey.shade300,
            color: Colors.blueAccent,
          ),
        ),
      ],
    );
  }

  Widget _mapButton(String text, String url, Color color) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url),
              mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(Icons.map, size: 20, color: color),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}