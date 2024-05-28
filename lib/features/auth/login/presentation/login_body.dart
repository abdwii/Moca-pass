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
import '../../../../core/utility/theme.dart';
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
    print(deviceType);
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
          padding: deviceType == DeviceScreenType.tablet
              ? EdgeInsets.symmetric(horizontal: 35.sw)
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
                      Gap(deviceType == DeviceScreenType.tablet
                          ? 10.sw
                          : 35.sw),
                      SvgPicture.asset(
                        AssetsData.welcomeTo,
                        width: deviceType == DeviceScreenType.tablet
                            ? 20.sw
                            : 35.sw,
                      ),
                      Gap(1.sw),
                      Image.asset(
                        AssetsData.logo,
                        width: deviceType == DeviceScreenType.tablet
                            ? 35.sw
                            : 50.sw,
                      ),
                      Gap(deviceType == DeviceScreenType.tablet
                          ? 10.sw
                          : 24.sw),
                      Text(StringConst.login,
                          style: popbodyMediumsemi_bold.copyWith(
                              color: Colors.white,
                              fontSize: deviceType == DeviceScreenType.tablet
                                  ? 64
                                  : 32)),
                      Gap(deviceType == DeviceScreenType.tablet ? 4.sw : 6.sw),
                      EmailField(onChange: () {
                        cubit.formKey.currentState!.save();
                      }),
                      Gap(deviceType == DeviceScreenType.tablet ? 2.sw : 4.sw),
                      const PasswordField(),
                      Gap(deviceType == DeviceScreenType.tablet ? 4.sw : 6.sw),
                      MainCustomButton(
                        buttonName: StringConst.Continue,
                        onPressed: () async {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.formKey.currentState!.save();
                            cubit.signIn();
                          }
                        },
                      ),
                      Gap(deviceType == DeviceScreenType.tablet ? 4.sw : 6.sw),
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
