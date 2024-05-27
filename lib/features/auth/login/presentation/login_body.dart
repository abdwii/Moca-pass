import 'package:alafein/core/presentation/widgets/main_custom_button.dart';
import 'package:alafein/core/utility/assets_data.dart';
import 'package:alafein/features/auth/login/application/cubit/login_cubit.dart';
import 'package:alafein/features/auth/login/presentation/widgets/email_field.dart';
import 'package:alafein/features/auth/login/presentation/widgets/password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:svg_flutter/svg.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Size> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _heightAnimation = Tween<Size>(
            begin: const Size(double.infinity, 0),
            end: Size(double.infinity, 14.sw))
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    _heightAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.sw),
        child: SingleChildScrollView(
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
                    Gap(35.sw),
                    SvgPicture.asset(
                      AssetsData.welcomeTo,
                      width: 35.sw,
                    ),
                    Gap(1.sw),
                    Image.asset(
                      AssetsData.logo,
                      width: 50.sw,
                    ),
                    Gap(6.sw),
                    EmailField(),
                    Gap(6.sw),
                    const PasswordField(),
                    Gap(6.sw),
                    MainCustomButton(
                      buttonName: 'CONTINUE',
                      onPressed: () async {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.formKey.currentState!.save();
                          cubit.signIn();
                        }
                      },
                    ),
                    Gap(6.sw),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
