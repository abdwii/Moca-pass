import 'package:flutter/foundation.dart';

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
  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    if (kDebugMode) {
      print(deviceType);
    }
    var isTablet = deviceType == DeviceScreenType.tablet ||
        deviceType == DeviceScreenType.desktop;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.49, 0.87),
          end: Alignment(-0.49, -0.87),
          colors: [
            Color(0xFF9A28CD),
            Color(0xFFFD00E2),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: isTablet
              ? EdgeInsets.symmetric(horizontal: 50.sw)
              : EdgeInsets.symmetric(horizontal: 6.sw),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginStateLoaded) {
                  // AutoRouter.of(context).replace(
                  //   OnboardingRoute(route: MainRoute()),
                  // );
                }
              },
              builder: (context, state) {
                final cubit = context.read<LoginCubit>();
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
                      Gap(isTablet ? 4.sw : 6.sw),
                      EmailField(onChange: () {
                        cubit.formKey.currentState!.save();
                      }),
                      Gap(isTablet ? 2.sw : 4.sw),
                      const PasswordField(),
                      Gap(isTablet ? 4.sw : 6.sw),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MainCustomButton(
                          buttonName: StringConst.Continue,
                          onPressed: () async {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.formKey.currentState!.save();
                              cubit.signIn();
                            }
                          },
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
