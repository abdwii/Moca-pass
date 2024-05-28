import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:svg_flutter/svg.dart';
import '../../../core/utility/assets_data.dart';
import '../../../core/utility/colors_data.dart';
import '../../../core/utility/theme.dart';
import '../cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final PageController _scrollController = PageController();

  Future<void> _refresh() async {
    EasyLoading.show(status: 'Loading...');
    setState(() {});
    await Future.delayed(const Duration(seconds: 1), () {
      EasyLoading.dismiss();
    });
    return Future.delayed(
      const Duration(microseconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getData(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          leadingWidth: 120,
          leading: Container(
            padding: const EdgeInsets.all(4.0),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: SvgPicture.asset(
              AssetsData.logo,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: LiquidPullToRefresh(
                  color: Colors.transparent,
                  onRefresh: _refresh,
                  showChildOpacityTransition: false,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state.homeResponse.spotlight != null)
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'EVENTS SPOTLIGHT',
                                  style: homeLabelStyle,
                                ),
                                SizedBox(
                                  height: 180,
                                  child: Placeholder(),
                                ),
                              ],
                            ),
                          if (state.homeResponse.category != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    'categories'.toUpperCase(),
                                    style: homeLabelStyle,
                                  ),
                                ),
                              ],
                            ),
                          if (state.homeResponse.today != null)
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Gap(16),
                                Text(
                                  'Happening today',
                                  style: homeLabelStyle,
                                ),
                              ],
                            ),
                          const Gap(16),
                        ]),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  void routeToEventDetails(BuildContext context, int index) {
    // AutoRouter.of(context).popAndPush(EventDeatilsPage(index: index));
  }
}
