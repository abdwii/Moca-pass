import 'package:MocaPass/core/utility/colors_data.dart';

import '../../../../../core/utility/assets_data.dart';
import '../../../../../core/utility/strings.dart';
import '../../../../../core/utility/theme.dart';
import '../../application/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:svg_flutter/svg.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isObscured = true;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(() {});
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 1.sw),
      child: TextFormField(
        focusNode: _focusNode,
        style: textInputsLabelStyle(),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        onSaved: (value) {
          context.read<LoginCubit>().password = value!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "*Incorrect Password ";
          } else if (value.length < 8) {
            return "password must be at least 8 characters";
          }
          return null;
        },
        cursorColor: Colors.white,
        key: const ValueKey('Password'),
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        onChanged: (v){context.read<LoginCubit>().formKey.currentState!.validate();},
        decoration: InputDecoration(
          errorStyle: const TextStyle(color: kErrorColor),
            suffixIconColor: Colors.white,
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.sw),
              child: SvgPicture.asset(
                AssetsData.password,
                width: 24,
              ),
            ),
            suffixIconConstraints:
                const BoxConstraints(maxHeight: double.infinity),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isObscured = !isObscured;
                });
              },
              icon: SvgPicture.asset(
                isObscured ? AssetsData.visable : AssetsData.visable,
                color: Colors.white,
              ),
            ),
            constraints: const BoxConstraints(
                maxWidth: double.infinity, minWidth: double.infinity),
            contentPadding: EdgeInsets.all(
              2.sw,
            ),
            border: textFormFieldBorderStyle,
            enabledBorder: textFormFieldBorderStyle,
            errorBorder: textFormFieldErrorBorderStyle,
            focusedBorder: textFormFieldBorderStyle,
            disabledBorder: textFormFieldBorderStyle,
            focusedErrorBorder: textFormFieldErrorBorderStyle,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: const Text(
              StringConst.password,
            ),
            labelStyle: textInputsLabelStyle(),
            filled: true,
            fillColor: Colors.transparent),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.visiblePassword,
        textCapitalization: TextCapitalization.none,
        autocorrect: false,
        obscureText: isObscured,
      ),
    );
  }
}
