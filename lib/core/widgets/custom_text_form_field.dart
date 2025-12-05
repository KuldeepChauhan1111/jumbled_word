import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final String? inputFormatterRegex;
  final String suffixIconUrl;
  final String prefixIconUrl;
  final Color? fillColor;
  final Color textColor;
  final Color borderColor;
  final Color cursorColor;
  final Color hintColor;
  final Color? prefixIconColor;
  final int maxLines;
  final int maxLength;
  final bool isPassword;
  final bool isShowBorder;
  final bool isIcon;
  final bool isShowSuffixIcon;
  final bool isShowPrefixIcon;
  final bool isSearch;
  final bool enable;
  final bool isReadOnly;
  final bool isCapital;
  final bool isDense;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final Function()? onTapCallBack;

  const CustomTextFormField({
    super.key,
    this.hintText = '',
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.inputFormatterRegex = '',
    this.maxLines = 1,
    this.maxLength = 256,
    this.fillColor,
    this.textColor = Colors.black87,
    this.borderColor = Colors.purple,
    this.cursorColor =  Colors.purple,
    this.hintColor = Colors.grey,
    this.prefixIconColor,
    this.isShowBorder = true,
    this.isShowSuffixIcon = false,
    this.isShowPrefixIcon = false,
    this.onTapCallBack,
    this.isIcon = false,
    this.isPassword = false,
    this.suffixIconUrl = '',
    this.prefixIconUrl = '',
    this.isSearch = false,
    this.enable = true,
    this.isReadOnly = false,
    this.isCapital = true,
    this.isDense = true,
    this.autofocus = false,
    this.onChanged,
    this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(8),
      //     border: Border.all(
      //         color: widget.isShowBorder
      //             ? widget.borderColor
      //             : Colors.transparent)),
      // child: TextField(
      child: TextFormField(
        maxLines: widget.maxLines,
        controller: widget.controller,
        enabled: widget.enable,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        readOnly: widget.isReadOnly,
        onChanged: widget.onChanged,
        textInputAction: widget.inputAction,
        keyboardType: widget.inputType,
        cursorColor: widget.cursorColor,
        textCapitalization: widget.isCapital
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        obscureText: widget.isPassword ? _obscureText : false,
        inputFormatters: widget.inputFormatterRegex.toString().isEmpty
            ? [LengthLimitingTextInputFormatter(widget.maxLength)]
            : [
                LengthLimitingTextInputFormatter(widget.maxLength),
                FilteringTextInputFormatter.allow(
                    RegExp(widget.inputFormatterRegex ?? ''))
              ],
        validator: widget.validator,
        style: TextStyle(
          fontSize: 16,
          color: widget.textColor,
          fontWeight: FontWeight.normal,
          // fontFamily: fontFamilyRegular,
        ),
        decoration: InputDecoration(
          // labelText: '',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: widget.borderColor, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: widget.borderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: widget.borderColor, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          isDense: widget.isDense,
          hintText: widget.hintText,
          fillColor: widget.fillColor ?? Colors.transparent,
          hintStyle: TextStyle(
            fontSize: 16,
            color: widget.hintColor,
            fontWeight: FontWeight.normal,
            // fontFamily: fontFamilyRegular,
          ),
          errorStyle: const TextStyle(
            fontSize: 14,
            color: Colors.red,
            height: 1.2,
            fontWeight: FontWeight.normal,
            // fontFamily: fontFamilyRegular,
          ),
          filled: true,
          prefixIcon: widget.isShowPrefixIcon
              ? Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Image.asset(
                    widget.prefixIconUrl,
                    color: widget.prefixIconColor ?? Colors.grey,
                    colorBlendMode: BlendMode.modulate,
                    height: 18,
                    width: 18,
                  ),
                )
              : const SizedBox.shrink(),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 16, maxHeight: 20),
          suffixIconConstraints:
              const BoxConstraints(minWidth: 30, maxHeight: 30),
          suffixIcon: widget.isShowSuffixIcon
              ? widget.isPassword
                  ? IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 24,
                      icon: Icon(
                          _obscureText
                              ? Icons.visibility_rounded
                              : Icons.visibility_off,
                          color: Colors.white),
                      onPressed: _toggle)
                  : Container(
                      margin: const EdgeInsets.only(left: 12, right: 12),
                      child: Image.asset(
                        widget.suffixIconUrl,
                        width: 18,
                        height: 18,
                      ),
                    )
              : null,
        ),
        onTap: widget.onTapCallBack,
        // onSubmitted: (text) => widget.nextFocus != null
        //     ? FocusScope.of(context).requestFocus(widget.nextFocus)
        //     : null,
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
