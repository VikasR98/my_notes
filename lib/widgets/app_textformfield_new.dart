import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';

class AppTextFormFieldNew extends StatelessWidget {
  AppTextFormFieldNew({
    super.key,
    this.label,
    this.inputType,
    this.textEditingController,
    this.inputFormatters,
    this.validator,
    this.onFieldSubmitted,
    this.onChanged,
    this.onEditingComplete,
    this.suffixIcon,
    this.obscureText,
    this.fillColor,
    this.hintText,
    this.hideBorder,
    this.removeContentPadding,
    this.style,
    this.minLines,
    this.maxLines,
    this.contentPadding,
    this.centerTextHorizontal = false,
    this.counterText,
    this.maxLength,
    this.hintStyle,
    this.expands,
    this.focusNode,
    this.enabled = true,
  });

  final EdgeInsets? contentPadding;
  final bool? expands;
  final String? label;
  final TextInputType? inputType;
  final TextEditingController? textEditingController;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final Widget? suffixIcon;
  bool? obscureText = false;
  Color? fillColor;
  String? hintText;
  bool? hideBorder;
  bool? removeContentPadding;
  TextStyle? style;
  TextStyle? hintStyle;
  int? minLines;
  int? maxLines;
  bool centerTextHorizontal;
  int? maxLength;
  String? counterText;
  FocusNode? focusNode;
  bool? enabled;

  @override
  Widget build(BuildContext context) {
    Brightness theme = Theme.of(context).brightness;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Text(
                label ?? '',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              )
            : Container(),
        TextFormField(
          enabled: enabled,
          // minLines: minLines,
          // maxLines: maxLines,
          // expands: false,

          maxLength: maxLength,
          focusNode: focusNode,
          textAlignVertical: TextAlignVertical.center,
          textAlign:
              centerTextHorizontal == true ? TextAlign.center : TextAlign.start,
          cursorColor: theme == Brightness.light
              ? AppColors.appBlackLight
              : AppColors.appWhite,
          obscureText: obscureText ?? false,
          inputFormatters: inputFormatters,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          keyboardType: inputType,
          controller: textEditingController,
          style: style ??
              Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            // suffix: suffixIcon,
            hintText: hintText,
            hintStyle: hintStyle ??
                Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: theme == Brightness.light
                          ? AppColors.hintTextColor
                          : AppColors.appWhite,
                    ),
            errorStyle: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: AppColors.primaryColor),
            suffixIcon: suffixIcon,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                  horizontal: removeContentPadding == true ? 0 : 20,
                  vertical: removeContentPadding == true ? 0 : 10,
                ),
            fillColor: fillColor ?? Theme.of(context).colorScheme.secondary,
            filled: true,
            border: InputBorder.none,
            // label: Text('label'),
            // counterText: 'Counter',
            // helperText: 'Helper',
            // suffixText: 'suffix text',
            // labelText: 'labelText'
            counterText: counterText ?? '',
            focusedBorder: hideBorder == true
                ? InputBorder.none
                : Dimens.textFormFieldBorder(context),
            errorBorder: hideBorder == true
                ? InputBorder.none
                : Dimens.textFormFieldBorder(context),
            enabledBorder: hideBorder == true
                ? InputBorder.none
                : Dimens.textFormFieldBorder(context),
            disabledBorder: hideBorder == true
                ? InputBorder.none
                : Dimens.textFormFieldBorder(context),
          ),
        ),
      ],
    );
  }
}
