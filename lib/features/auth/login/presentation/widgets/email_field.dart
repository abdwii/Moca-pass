import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../../../../../core/utility/assets_data.dart';
import '../../../../../core/utility/theme.dart';
import '../../application/cubit/login_cubit.dart';

class EmailField extends StatelessWidget {
  VoidCallback onChange;

  EmailField({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        maxLines: 1,
        style: textInputsLabelStyle(),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        validator: (value) {
          final RegExp emailRegex = RegExp(
            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
          );

          if (value != null &&
              value.isNotEmpty &&
              !emailRegex.hasMatch(value)) {
            return '*Invalid email';
          }
          return null;
        },
        onChanged: (value) {
          context.read<LoginCubit>().email = value;
          onChange();
        },
        cursorColor: Colors.white,
        onSaved: (newValue) {
          if (newValue != null && newValue.isNotEmpty) {}
          context.read<LoginCubit>().email = newValue!;
        },
        key: const ValueKey('SignInEmail'),
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(vertical: 3.sw, horizontal: 3.sw),
            child: SvgPicture.asset(
              AssetsData.email,
              color: Colors.white,
              width: 24,
            ),
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: isValidEmail(context)
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 3.sw, horizontal: 3.sw),
                  child: SvgPicture.asset(
                    AssetsData.checkMark,
                    width: 24,
                  ),
                )
              : null,
          suffixIconColor:
              Colors.white.withOpacity(isValidEmail(context) ? 1 : 0.3),
          constraints: const BoxConstraints(
              maxWidth: double.infinity, minWidth: double.infinity),
          contentPadding: EdgeInsets.all(
            2.sw,
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
          labelStyle: textInputsLabelStyle(),
          filled: false,
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        autocorrect: false,
      ),
    );
  }

  bool isValidEmail(BuildContext context) {
    try {
      var value = BlocProvider.of<LoginCubit>(context).email;
      final RegExp emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );
      return emailRegex.hasMatch(value);
    } catch (e) {
      return false;
    }
  }
}
