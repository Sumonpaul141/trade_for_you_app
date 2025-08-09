import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trade_for_you_app/common/app_colors.dart';
import 'package:trade_for_you_app/common/app_toaster.dart';
import 'package:trade_for_you_app/common/app_ui_const.dart';
import 'package:trade_for_you_app/features/order/data/models/order_response_model.dart';

class PlaceOrderResponseView extends StatelessWidget {
  final List<OrderResponseModel> results;

  const PlaceOrderResponseView({super.key, required this.results});

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
          "Order statuses",
          style: AppUiConst.font14RegularTS.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final result = results[index];
          return GestureDetector(
            onLongPress: () {
              _copyUsernameAndShowText(context, result.username.toString());
            },
            child: Card(
              color: AppColors.cardBackground,
              margin: const EdgeInsets.symmetric(
                horizontal: AppUiConst.mp12,
                vertical: AppUiConst.mp8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppUiConst.mp12),
              ),
              child: ListTile(
                leading: Icon(
                  result.success ? Icons.check_circle : Icons.error,
                  color: result.success ? Colors.green : Colors.red,
                  size: 30,
                ),
                title: Text(
                  "User: ${result.username}",
                  style: AppUiConst.font14RegularTS.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                subtitle: Text(
                  result.success
                      ? result.message
                          .split("-")
                          .map((x) => x.trim())
                          .join("\n")
                      : result.message,
                  style: AppUiConst.font12RegularTS.copyWith(
                    color:
                        result.success
                            ? Colors.green.shade700
                            : Colors.red.shade700,
                  ),
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Order ID",
                      style: AppUiConst.font12RegularTS.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      "${result.orderId}",
                      style: AppUiConst.font12RegularTS.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
