import 'package:alafein/core/utility/assets_data.dart';
import 'package:alafein/core/utility/strings.dart';
import 'package:alafein/core/utility/theme.dart';
import 'package:alafein/features/auth/login/application/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:svg_flutter/svg_flutter.dart';

class EmailField extends StatelessWidget {
  EmailField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        maxLines: 1,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 4.sw,
            fontFamily: StringConst.formulaFont),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              !value.contains('@') &
                  !value.contains('.com') &
                  !value.contains('gmail') &
                  !value.contains('yahoo') &
                  !value.contains('outlook') &
                  !value.contains('hotmail') &
                  !value.contains('icloud') &
                  !value.contains('live')) {
            return 'Please enter a valid email';
          }
          return null;
        },
        cursorColor: Colors.white,
        onSaved: (newValue) {
          context.read<LoginCubit>().email = newValue!;
        },
        key: const ValueKey('SignInEmail'),
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.sw, horizontal: 4.sw),
            child: SvgPicture.asset(
              AssetsData.email,
              color: Colors.white,
              width: 24,
            ),
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.sw, horizontal: 4.sw),
            child: SvgPicture.asset(
              AssetsData.checkMark,
              width: 24,
            ),
          ),
          iconColor: Colors.white.withOpacity(0.3),
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
            'Email',
          ),
          labelStyle: const TextStyle(
              color: Colors.white,
              fontFamily: StringConst.formulaFont,
              fontWeight: FontWeight.w300),
          filled: false,
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        autocorrect: false,
      ),
    );
  }
}
