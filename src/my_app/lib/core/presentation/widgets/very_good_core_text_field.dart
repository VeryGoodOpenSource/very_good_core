import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:very_good_core/app/themes/spacing.dart';
import 'package:very_good_core/app/themes/text_styles.dart';

class VeryGoodCoreTextField extends StatelessWidget {
  const VeryGoodCoreTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.textInputAction,
    this.textInputType,
    this.onChanged,
    this.padding,
    this.isPassword = false,
    this.maxLength,
    this.autofocus = false,
    this.onSubmitted,
    this.focusNode,
    this.suffix,
    this.textAlign = TextAlign.left,
    this.contentPadding,
    this.style,
    this.hintTextStyle,
    this.decoration,
  });

  final TextEditingController controller;
  final String? hintText;
  final bool isPassword;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final EdgeInsets? padding;
  final Function(String)? onChanged;
  final int? maxLength;
  final bool autofocus;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final Widget? suffix;
  final TextAlign textAlign;
  final EdgeInsets? contentPadding;
  final TextStyle? style;
  final TextStyle? hintTextStyle;
  final InputDecoration? decoration;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      key: Key(labelText),
      textField: true,
      label: labelText,
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: Insets.med),
        child: textInputType == TextInputType.visiblePassword || isPassword
            ? _PasswordTextField(
                controller: controller,
                onChanged: onChanged,
                autofocus: autofocus,
                onSubmitted: onSubmitted,
                textInputAction: textInputAction,
                focusNode: focusNode,
                hintText: hintText,
                labelText: labelText,
              )
            : TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: decoration ??
                    InputDecoration(
                      labelText: labelText,
                      hintText: hintText,
                      hintStyle: hintTextStyle,
                      contentPadding: contentPadding,
                      suffix: suffix,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorScheme.primary),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorScheme.secondary),
                      ),
                    ),
                keyboardType: textInputType,
                textInputAction: textInputAction,
                style: style ??
                    AppTextStyle.bodyLarge
                        .copyWith(color: colorScheme.onSurface),
                textAlign: textAlign,
                autofocus: autofocus,
                maxLength: maxLength,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                buildCounter: (
                  _, {
                  int? currentLength,
                  int? maxLength,
                  bool? isFocused,
                }) =>
                    null,
              ),
      ),
    );
  }
}

class _PasswordTextField extends HookWidget {
  const _PasswordTextField({
    this.controller,
    this.onChanged,
    this.autofocus = false,
    this.onSubmitted,
    this.textInputAction,
    this.focusNode,
    required this.hintText,
    required this.labelText,
  });

  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final ValueChanged<String>? onSubmitted;
  final String? hintText;
  final String labelText;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isPasswordHidden = useState<bool>(true);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: <Widget>[
        Expanded(
          child: Semantics(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                suffixIcon: GestureDetector(
                  key: const Key('password_icon'),
                  onTap: () => isPasswordHidden.value = !isPasswordHidden.value,
                  child: Icon(
                    isPasswordHidden.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.secondary),
                ),
              ),
              textInputAction: textInputAction,
              style:
                  AppTextStyle.bodyLarge.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.left,
              autofocus: autofocus,
              obscureText: isPasswordHidden.value,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            ),
          ),
        ),
      ],
    );
  }
}
