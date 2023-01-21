import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/spacing.dart';
import 'package:{{project_name.snakeCase()}}/app/themes/text_styles.dart';

class {{#pascalCase}}{{project_name}}{{/pascalCase}}TextField extends StatelessWidget {
  const {{#pascalCase}}{{project_name}}{{/pascalCase}}TextField({
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
      label: labelText,
      textField: true,
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: Insets.med),
        child: textInputType == TextInputType.visiblePassword || isPassword
            ? _PasswordTextField(
                controller: controller,
                textInputAction: textInputAction,
                hintText: hintText,
                onChanged: onChanged,
                autofocus: autofocus,
                focusNode: focusNode,
                onSubmitted: onSubmitted,
                labelText: labelText,
              )
            : TextField(
                controller: controller,
                keyboardType: textInputType,
                textInputAction: textInputAction,
                maxLength: maxLength,
                textAlign: textAlign,
                autofocus: autofocus,
                focusNode: focusNode,
                onSubmitted: onSubmitted,
                buildCounter: (
                  _, {
                  int? currentLength,
                  int? maxLength,
                  bool? isFocused,
                }) =>
                    null,
                decoration: decoration ??
                    InputDecoration(
                      labelText: labelText,
                      hintText: hintText,
                      suffix: suffix,
                      contentPadding: contentPadding,
                      hintStyle: hintTextStyle,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorScheme.secondary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                style: style ??
                    AppTextStyle.bodyText1
                        .copyWith(color: colorScheme.onSurface),
                onChanged: onChanged,
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
              style:
                  AppTextStyle.bodyText1.copyWith(color: colorScheme.onSurface),
              obscureText: isPasswordHidden.value,
              controller: controller,
              onChanged: onChanged,
              autofocus: autofocus,
              textAlign: TextAlign.left,
              textInputAction: textInputAction,
              onSubmitted: onSubmitted,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.secondary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                  ),
                ),
                suffixIcon: GestureDetector(
                  key: const Key('password_icon'),
                  child: Icon(
                    isPasswordHidden.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onTap: () => isPasswordHidden.value = !isPasswordHidden.value,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
