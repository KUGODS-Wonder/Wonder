import 'package:flutter/material.dart';

class CheckBoxFormField extends FormField<bool> {
  CheckBoxFormField({
    Key? key,
    Widget? trailing,
    EdgeInsets padding = EdgeInsets.zero,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    OutlinedBorder? checkboxShape,
    Color? checkColor,
    Color? activeColor,
    bool initialValue = false,
    AutovalidateMode autoValidate = AutovalidateMode.disabled,
  }) : super(
    key: key,
    onSaved: onSaved,
    validator: validator,
    initialValue: initialValue,
    autovalidateMode: autoValidate,
    builder: (FormFieldState<bool> state) {

      Widget checkBox = Checkbox(
        value: state.value,
        onChanged: state.didChange,
        shape: checkboxShape ?? RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        activeColor: activeColor,
        checkColor: checkColor,
        visualDensity: VisualDensity.compact,
      );

      return Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (trailing != null) Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 25,
                  height: 25,
                  child: checkBox,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: trailing,
                ),
              ],
            ) else checkBox,
            if (state.hasError) Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Builder(
                builder: (BuildContext context) => Text(
                  state.errorText ?? 'Invalid value.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Theme.of(context).colorScheme.error),
                ),
              ),
            ) else const SizedBox.shrink()
          ],
        ),
      );
    }
  );
}
