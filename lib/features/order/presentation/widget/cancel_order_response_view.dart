import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trade_for_you_app/common/app_colors.dart';
import 'package:trade_for_you_app/common/app_strings.dart';
import 'package:trade_for_you_app/common/app_toaster.dart';
import 'package:trade_for_you_app/common/app_ui_const.dart';
import 'package:trade_for_you_app/features/order/data/models/cancel_response_model.dart';

class CancelOrderResponseView extends StatelessWidget {
  final List<CancelResponseModel> results;

  const CancelOrderResponseView({super.key, required this.results});

  _copyUsernameAndShowText(BuildContext context, String username) {
    Clipboard.setData(ClipboardData(text: username));
    AppToaster.showInfo(
      context,
      "Username copied : $username",
      duration: Duration(milliseconds: 1000),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        title: Text(
          "Cancel statuses",
          style: AppUiConst.font14RegularTS.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final item = results[index];
          final isCancelled =
              (item.openOrderCancelStatus && item.positionCancelStatus);
          return GestureDetector(
            onLongPress: () {
              _copyUsernameAndShowText(context, item.username);
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: AppColors.cardBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              isCancelled ? Icons.check_circle : Icons.error,
                              color: isCancelled ? Colors.green : Colors.red,
                              size: 30,
                            ),
                            const SizedBox(width: AppUiConst.mp8),
                            Text(
                              "${AppStrings.userID}: ${item.username}",
                              style: AppUiConst.font14RegularTS.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        _buildStatusRow(
                          AppStrings.slTP,
                          item.openOrderCancelStatus,
                        ),
                        SizedBox(width: AppUiConst.mp8),
                        _buildStatusRow(
                          AppStrings.position,
                          item.positionCancelStatus,
                        ),
                      ],
                    ),
                    if (item.errors.isNotEmpty) ...[
                      const SizedBox(height: AppUiConst.mp8),
                      const Text(
                        AppStrings.errors,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      for (var err in item.errors)
                        Text(
                          "- $err",
                          style: const TextStyle(color: Colors.red),
                        ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusRow(String title, bool status) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          status ? Icons.check_circle_outline : Icons.cancel_outlined,
          color: status ? Colors.green : Colors.red,
          size: 20,
        ),
        const SizedBox(width: AppUiConst.mp4),
        Text(
          title,
          style: TextStyle(
            color: status ? Colors.green : Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
