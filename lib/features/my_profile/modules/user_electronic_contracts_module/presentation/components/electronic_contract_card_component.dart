import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/features/my_profile/modules/user_electronic_contracts_module/domain/entity/user_electronic_contract_entity.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/foundation.dart';
import 'package:enmaa/core/components/custom_snack_bar.dart';
import 'dart:io';
import '../../../../../../core/services/get_file_permission.dart';

class ElectronicContractCardComponent extends StatefulWidget {
  final UserElectronicContractEntity contract;
  final double width;
  final double height;

  const ElectronicContractCardComponent({
    super.key,
    required this.contract,
    required this.width,
    required this.height,
  });

  @override
  State<ElectronicContractCardComponent> createState() => _ElectronicContractCardComponentState();
}

class _ElectronicContractCardComponentState extends State<ElectronicContractCardComponent> {
  bool _isDownloading = false;
  double _downloadProgress = 0.0;

  Future<void> _handleContractAction() async {
    String url = widget.contract.contractUrl;
    await _downloadAndStoreFile(url);
  }

  Future<void> _downloadAndStoreFile(String url) async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

     bool hasPermission = await FilePermissionService.checkFilePermission(context);
    if (!hasPermission) {
      setState(() => _isDownloading = false);
      return;
    }

    try {
      final dio = Dio();
      final directory = await getApplicationDocumentsDirectory();

      Response response = await dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _downloadProgress = received / total;
            });
          }
        },
      );

      String contentType = response.headers.value('content-type') ?? 'application/octet-stream';
      String fileExtension = _getFileExtension(contentType);
      String fileName = 'contract_${widget.contract.id}_${DateTime.now().millisecondsSinceEpoch}$fileExtension';
      final filePath = '${directory.path}/$fileName';

      File file = File(filePath);
      await file.writeAsBytes(response.data);

      setState(() => _isDownloading = false);
      _showSnackBar('تم تنزيل الملف بنجاح: $fileName');
      await _openDownloadedFile(filePath);
    } catch (e) {
      setState(() => _isDownloading = false);
      _showSnackBar('حدث خطأ أثناء تنزيل الملف: ${e.toString()}');
    }
  }

  String _getFileExtension(String contentType) {
    switch (contentType.toLowerCase()) {
      case 'application/pdf':
        return '.pdf';
      case 'image/jpeg':
        return '.jpg';
      case 'image/png':
        return '.png';
      case 'image/gif':
        return '.gif';
      default:
        return '.pdf';
    }
  }

  Future<void> _openDownloadedFile(String filePath) async {
    try {
      final result = await OpenFile.open(filePath);
      if (result.type != ResultType.done) {
        _showSnackBar('لا يمكن فتح الملف: ${result.message}');
      } else {
        _showSnackBar('تم فتح الملف بنجاح');
      }
    } catch (e) {
      _showSnackBar('حدث خطأ أثناء فتح الملف: ${e.toString()}');
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;

    CustomSnackBar.show(
      context: context,
      message: message,
      type: message.contains('خطأ') ? SnackBarType.error : SnackBarType.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: context.scale(32),
              height: context.scale(32),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorManager.yellowColor,
                shape: BoxShape.circle,
              ),
              child: SvgImageComponent(iconPath: AppAssets.clipIcon),
            ),
            SizedBox(width: context.scale(8)),
            Text(
              'عقد رقم: ${widget.contract.id}',
              style: getBoldStyle(
                color: ColorManager.blackColor,
                fontSize: FontSize.s16,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: _isDownloading ? null : _handleContractAction,
              icon: _isDownloading
                  ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  value: _downloadProgress > 0 ? _downloadProgress : null,
                  strokeWidth: 2,
                  color: ColorManager.primaryColor,
                ),
              )
                  : SvgImageComponent(
                color: Colors.black,
                iconPath: AppAssets.downloadIcon,
              ),
              tooltip: 'تنزيل العقد',
            ),
          ],
        ),
      ),
    );
  }
}