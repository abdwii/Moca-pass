import 'package:MocaPass/core/presentation/routes/routes_manager.dart';
import 'package:MocaPass/core/utility/colors_data.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/presentation/widgets/app_background.dart';
import '../../../../core/utility/theme.dart';
import '../../../../features/auth/login/presentation/widgets/email_field.dart';
import '../../../../features/auth/login/presentation/widgets/password_field.dart';
import '../../../../core/presentation/widgets/main_custom_button.dart';
import '../../../../core/utility/assets_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:svg_flutter/svg.dart';
import '../../../../core/utility/strings.dart';
import '../application/cubit/login_cubit.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    var deviceOrientation = (MediaQuery.of(context).orientation);
    if (kDebugMode) {
      print(deviceType);
    }
    var isTablet = deviceType == DeviceScreenType.tablet ||
        deviceType == DeviceScreenType.desktop;
    return AppBackground(
      child: SafeArea(
        child: Padding(
          padding: getLoginHPadding(isTablet, deviceOrientation),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginStateLoaded) {
                  Navigator.of(context).pushReplacementNamed(Routes.mainScreen);
                }
              },
              builder: (context, state) {
                final cubit = BlocProvider.of<LoginCubit>(context);
                print(cubit.isValidForm(cubit.email, cubit.password));
                return Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      SizedBox(height: isTablet ? 8.sh : 35.sw),
                      SvgPicture.asset(
                        AssetsData.welcomeTo,
                        width: isTablet ? 20.sw : 35.sw,
                      ),
                      Gap(1.sh),
                      Image.asset(
                        AssetsData.logo,
                        width: isTablet ? 35.sw : 50.sw,
                      ),
                      Gap(isTablet ? 10.sw : 24.sw),
                      Text(StringConst.login,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: Colors.white,
                                  fontSize: isTablet ? 64 : 32)),
                      /*                      Gap(isTablet ? 4.sw : 6.sw),

                      AppTextFormField(
                        hintText: 'Email',
                        validator: (value) {},
                        contentPadding:  EdgeInsets.symmetric(
                          horizontal: isTablet ? 2.sw : 2.sw,
                          vertical: isTablet ? 1.5.sh : 2.sh,
                        ),
                      ),
    */
                      Gap(isTablet ? 4.sw : 6.sw),
                      EmailField(onChange: () {
                        cubit.formKey.currentState!.validate();
                        cubit.formKey.currentState!.save();
                      }),
                      Gap(isTablet ? 1.sw : 2.sw),
                      const PasswordField(),
                      // AppTextFormField(
                      //   hintText: 'Password',
                      //   isObscureText: isObscureText,
                      //   suffixIcon: GestureDetector(
                      //     onTap: () {
                      //       setState(() {
                      //         isObscureText = !isObscureText ;
                      //       });
                      //     },
                      //
                      //     child: Icon(
                      //       isObscureText ? Icons.visibility_off : Icons.visibility,
                      //       size:isTablet?3.sw: 5.sw,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      //   prefixIcon:  cubit.isValidEmail(null)
                      //       ? Padding(
                      //     padding:
                      //     EdgeInsets.symmetric(vertical: 3.sw, horizontal: 3.sw),
                      //     child: SvgPicture.asset(
                      //       AssetsData.checkMark,
                      //       width: 24,
                      //     ),
                      //   )
                      //       : null,
                      //   contentPadding:  EdgeInsets.symmetric(
                      //     horizontal: isTablet ? 2.sw : 2.sw,
                      //     vertical: isTablet ? 1.5.sh : 2.sh,
                      //   ),
                      //   validator: (value) {
                      //     cubit.isValidPassword(value!);
                      //   },
                      // ),
                      Gap(isTablet ? 4.sw : 6.sw),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: MainCustomButton(
                          buttonName: StringConst.Continue,
                          padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 9.sw : 15.sw,
                            vertical: isTablet ? 2.sw : 4.5.sw,
                          ),
                          onPressed: () async {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.formKey.currentState!.save();
                              cubit.signIn();
                            }
                          },
                          isEnabled: true,
                        ),
                      ),
                      Gap(isTablet ? 8.sw : 6.sw),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
