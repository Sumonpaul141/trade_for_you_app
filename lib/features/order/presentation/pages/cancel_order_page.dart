import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_for_you_app/common/app_colors.dart';
import 'package:trade_for_you_app/common/app_strings.dart';
import 'package:trade_for_you_app/common/app_toaster.dart';
import 'package:trade_for_you_app/common/app_ui_const.dart';
import 'package:trade_for_you_app/common/enums.dart';
import 'package:trade_for_you_app/common/widgets/basic_app_bar.dart';
import 'package:trade_for_you_app/features/order/presentation/blocs/cancel_order_cubit/cancel_order_cubit.dart';
import 'package:trade_for_you_app/features/order/presentation/blocs/pair_cubit/pair_cubit.dart';

class CancelOrderPage extends StatefulWidget {
  const CancelOrderPage({super.key});

  @override
  State<CancelOrderPage> createState() => _CancelOrderPageState();
}

class _CancelOrderPageState extends State<CancelOrderPage> {
  late CancelOrderCubit _cancelOrderCubit;
  late PairCubit _pairCubit;

  @override
  void initState() {
    _pairCubit = context.read<PairCubit>();
    _cancelOrderCubit = context.read<CancelOrderCubit>();
    _pairCubit.getPairs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CancelOrderCubit, CancelOrderState>(
      listener: (context, state) {
        if (state.cancelOrderEventCallResult == EventCallResult.error) {
          AppToaster.showInfo(context, state.errorText);
        }
      },
      child: Scaffold(
        appBar: BasicAppBar(),
        body: Container(
          margin: EdgeInsets.all(AppUiConst.mp16),
          padding: EdgeInsets.all(AppUiConst.mp12),
          decoration: BoxDecoration(color: AppColors.cardBackground),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppStrings.cancelOrder,
                  style: AppUiConst.font20BoldTS.copyWith(
                    color: AppColors.accent,
                  ),
                ),
                SizedBox(height: AppUiConst.mp16),
                BlocBuilder<PairCubit, PairState>(
                  builder: (context, pairState) {
                    if (pairState.pairs.isEmpty) return SizedBox();
                    return _buildLabelFormField(
                      label: "Trading pair",
                      formField:
                          BlocBuilder<CancelOrderCubit, CancelOrderState>(
                            builder: (context, state) {
                              return _buildDropDown<int>(
                                value: state.selectedPairId,
                                items:
                                    pairState.pairs.map((item) {
                                      return DropdownMenuItem(
                                        value: item.id,
                                        child: Text(item.symbol),
                                      );
                                    }).toList(),
                                onChanged: _cancelOrderCubit.selectPairId,
                              );
                            },
                          ),
                    );
                  },
                ),
                SizedBox(height: AppUiConst.mp12),
                _buildCancelOrderButton(onTap: _cancelOrderCubit.cancelOrder),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildCancelOrderButton({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppUiConst.mp12),
        decoration: BoxDecoration(
          color: AppColors.red.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppUiConst.borderRadius10),
        ),
        child: Center(
          child: Text(
            AppStrings.cancelOrder,
            style: AppUiConst.font12RegularTS.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputContainer({Widget? child}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppUiConst.mp12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppUiConst.borderRadius5),
        color: AppColors.textPrimary.withValues(alpha: 0.05),
      ),
      child: child,
    );
  }

  Widget _buildDropDown<T>({
    required List<DropdownMenuItem> items,
    T? value,
    Function(T)? onChanged,
  }) {
    return _buildInputContainer(
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          value: value,
          dropdownColor: AppColors.cardBackground,
          items: items,
          style: AppUiConst.font12RegularTS.copyWith(
            color: AppColors.textPrimary,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (val) {
            if (onChanged != null) {
              onChanged(val);
            }
          },
        ),
      ),
    );
  }

  Widget _buildLabelFormField({
    required String label,
    required Widget formField,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppUiConst.font12RegularTS.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppUiConst.mp8),
        formField,
      ],
    );
  }
}
