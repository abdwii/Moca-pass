import 'package:alafein/core/utility/assets_data.dart';
import 'package:alafein/core/utility/colors_data.dart';
import 'package:alafein/core/utility/strings.dart';
import 'package:alafein/core/utility/theme.dart';
import 'package:alafein/features/auth/login/application/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
        style: GoogleFonts.abhayaLibre(
          color: kSemiBlack,
          fontWeight: FontWeight.w700,
          fontSize: 4.sw,
        ),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        onSaved: (value) {
          context.read<LoginCubit>().password = value!;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Can't be empty";
          } else if (value.length < 8) {
            return "password must be at least 8 characters";
          } else if (!value.contains(RegExp(r'[A-Z]'))) {
            return "Password contains at least one uppercase letter";
          } else if (!value.contains(RegExp(r'[a-z]'))) {
            return "Password contains at least one lowercase letter";
          }

          if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
            return "Password contains at least one special character";
          }
          return null;
        },
        cursorColor: Colors.white,
        key: const ValueKey('Password'),
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
            suffixIconColor: Colors.white,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.sw, horizontal: 4.sw),
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
                isObscured ? AssetsData.visable : AssetsData.invisable,
                color: Colors.white,
              ),
            ),
            constraints: const BoxConstraints(
                maxWidth: double.infinity, minWidth: double.infinity),
            contentPadding: EdgeInsets.all(
              6.sw,
            ),
            border: textFormFieldBorderStyle,
            enabledBorder: textFormFieldBorderStyle,
            errorBorder: textFormFieldBorderStyle,
            focusedBorder: textFormFieldBorderStyle,
            disabledBorder: textFormFieldBorderStyle,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: const Text(
              'Password',
            ),
            labelStyle: const TextStyle(
                color: Colors.white,
                fontFamily: StringConst.formulaFont,
                fontWeight: FontWeight.w300),
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
