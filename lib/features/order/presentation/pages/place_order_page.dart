import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_for_you_app/common/app_colors.dart';
import 'package:trade_for_you_app/common/app_strings.dart';
import 'package:trade_for_you_app/common/app_ui_const.dart';
import 'package:trade_for_you_app/common/enums.dart';
import 'package:trade_for_you_app/common/extension.dart';
import 'package:trade_for_you_app/common/widgets/basic_app_bar.dart';
import 'package:trade_for_you_app/features/order/presentation/blocs/pair_cubit/pair_cubit.dart';
import 'package:trade_for_you_app/features/order/presentation/blocs/place_order_cubit/place_order_cubit.dart';

class PlaceOrderPage extends StatefulWidget {
  const PlaceOrderPage({super.key});

  @override
  State<PlaceOrderPage> createState() => _PlaceOrderPageState();
}

class _PlaceOrderPageState extends State<PlaceOrderPage> {
  late PairCubit _pairCubit;
  late PlaceOrderCubit _placeOrderCubit;

  @override
  void initState() {
    _placeOrderCubit = context.read<PlaceOrderCubit>();
    _pairCubit = context.read<PairCubit>();
    _pairCubit.getPairs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                AppStrings.placeOrder,
                style: AppUiConst.font20BoldTS.copyWith(
                  color: AppColors.accent,
                ),
              ),
              SizedBox(height: AppUiConst.mp16),
              BlocBuilder<PlaceOrderCubit, PlaceOrderState>(
                builder: (context, state) {
                  return BlocBuilder<PairCubit, PairState>(
                    builder: (context, pairState) {
                      if (pairState.pairs.isEmpty) return SizedBox();
                      return _buildLabelFormField(
                        label: "Trading pair",
                        formField: _buildDropDown<int>(
                          value: state.placeOrderRequestEntity.pairId,
                          items:
                              pairState.pairs.map((item) {
                                return DropdownMenuItem(
                                  value: item.id,
                                  child: Text(item.symbol),
                                );
                              }).toList(),
                          onChanged: _placeOrderCubit.selectPairId,
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: AppUiConst.mp12),
              BlocBuilder<PlaceOrderCubit, PlaceOrderState>(
                builder: (context, state) {
                  return _buildLabelFormField(
                    label: "Unit type",
                    formField: _buildDropDown(
                      value: state.placeOrderRequestEntity.unitType,
                      items:
                          UnitType.values.map((item) {
                            return DropdownMenuItem(
                              value: item.ddValue,
                              child: Text(item.ddValue),
                            );
                          }).toList(),
                      onChanged: _placeOrderCubit.selectUnitType,
                    ),
                  );
                },
              ),
              SizedBox(height: AppUiConst.mp12),
              BlocBuilder<PlaceOrderCubit, PlaceOrderState>(
                builder: (context, state) {
                  return _buildLabelFormField(
                    label: "Side",
                    formField: _buildDropDown(
                      value: state.placeOrderRequestEntity.side,
                      items:
                          OrderSide.values.map((item) {
                            return DropdownMenuItem(
                              value: item.ddValue,
                              child: Text(item.name),
                            );
                          }).toList(),
                      onChanged: _placeOrderCubit.selectSide,
                    ),
                  );
                },
              ),
              SizedBox(height: AppUiConst.mp12),
              _buildLabelFormField(
                label: "Leverage",
                formField: BlocBuilder<PlaceOrderCubit, PlaceOrderState>(
                  builder: (context, state) {
                    return _buildTextFormField(
                      hintText: "1",
                      initialValue:
                          state.placeOrderRequestEntity.leverage.toString(),
                      onChanged: _placeOrderCubit.setLeverage,
                    );
                  },
                ),
              ),
              SizedBox(height: AppUiConst.mp12),
              _buildLabelFormField(
                label: "Percent",
                formField: BlocBuilder<PlaceOrderCubit, PlaceOrderState>(
                  builder: (context, state) {
                    return _buildTextFormField(
                      hintText: "50",
                      onChanged: _placeOrderCubit.selectPercent,
                      initialValue:
                          state.placeOrderRequestEntity.percent.toString(),
                    );
                  },
                ),
              ),
              SizedBox(height: AppUiConst.mp12),
              _buildLabelFormField(
                label: "Stop loss",
                formField: BlocBuilder<PlaceOrderCubit, PlaceOrderState>(
                  builder: (context, state) {
                    return _buildTextFormField(
                      hintText: "0",
                      onChanged: _placeOrderCubit.setStopLoss,
                      initialValue:
                          state.placeOrderRequestEntity.stopLoss?.toString(),
                    );
                  },
                ),
              ),
              SizedBox(height: AppUiConst.mp12),
              _buildLabelFormField(
                label: "Take profit",
                formField: BlocBuilder<PlaceOrderCubit, PlaceOrderState>(
                  builder: (context, state) {
                    return _buildTextFormField(
                      hintText: "0",
                      onChanged: _placeOrderCubit.setTakeProfit,
                      initialValue:
                          state.placeOrderRequestEntity.takeProfit?.toString(),
                    );
                  },
                ),
              ),

              SizedBox(height: AppUiConst.mp12),
              _buildLabelFormField(
                label: "Username",
                formField: BlocBuilder<PlaceOrderCubit, PlaceOrderState>(
                  builder: (context, state) {
                    return _buildTextFormField(
                      hintText: "5212345678",
                      onChanged: _placeOrderCubit.setUsername,
                      initialValue:
                          state.placeOrderRequestEntity.username?.toString(),
                    );
                  },
                ),
              ),
              SizedBox(height: AppUiConst.mp12),
              _buildPlaceOrderButton(onTap: _placeOrderCubit.placeOrder),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField<T>({
    String? hintText,
    TextEditingController? controller,
    Function(String)? onChanged,
    String? initialValue,
  }) {
    TextStyle style = AppUiConst.font12RegularTS.copyWith(
      color: AppColors.textPrimary,
    );
    return _buildInputContainer(
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        style: style,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: style.copyWith(color: style.color?.withValues(alpha: 0.2)),
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

  _buildPlaceOrderButton({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppUiConst.mp12),
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppUiConst.borderRadius10),
        ),
        child: Center(
          child: Text(
            AppStrings.placeOrder,
            style: AppUiConst.font12RegularTS.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
