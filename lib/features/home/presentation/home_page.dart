import 'package:alafein/core/api/constants/api_caller_config.dart';
import 'package:alafein/core/local_data/session_management.dart';
// import 'package:alafein/core/presentation/routes/app_router.gr.dart';
import 'package:alafein/core/utility/assets_data.dart';
import 'package:alafein/core/utility/colors_data.dart';
import 'package:alafein/core/utility/theme.dart';
import 'package:alafein/features/home/cubit/home_cubit.dart';
import 'package:alafein/features/home/presentation/widgets/home_event_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:svg_flutter/svg.dart';

@RoutePage()
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'EVENTS SPOTLIGHT',
                                  style: homeLabelStyle,
                                ),
                                SizedBox(
                                  height: 180,
                                  child: ListView.builder(
                                      itemCount: state
                                              .homeResponse.spotlight?.length ??
                                          0,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) => InkWell(
                                            onTap: (SessionManagement
                                                        .getUserRole() !=
                                                    "")
                                                ? () {
                                                    routeToEventDetails(
                                                      context,
                                                      state
                                                              .homeResponse
                                                              .spotlight?[index]
                                                              .id ??
                                                          -1,
                                                    );
                                                  }
                                                : () async {
                                                    routeToEventDetails(
                                                      context,
                                                      state
                                                              .homeResponse
                                                              .spotlight?[index]
                                                              .id ??
                                                          -1,
                                                    );
                                                    await Future.delayed(
                                                        const Duration(
                                                            seconds: 2));
                                                  /*  AutoRouter.of(context)
                                                        .popAndPush(
                                                            const LoginRoute());*/
                                                  },
                                            child: HomeEventItem(
                                              name: state.homeResponse
                                                      .spotlight?[index].name ??
                                                  "",
                                              image: state
                                                          .homeResponse
                                                          .spotlight?[index]
                                                          .poster !=
                                                      null
                                                  ? "${APICallerConfiguration.baseImageUrl}${state.homeResponse.spotlight?[index].poster}"
                                                  : "",
                                              catImage: state
                                                          .homeResponse
                                                          .spotlight?[index]
                                                          .catPoster !=
                                                      null
                                                  ? "${APICallerConfiguration.baseImageUrl}${state.homeResponse.spotlight?[index].catPoster}"
                                                  : "",
                                              date: state.homeResponse
                                                      .spotlight?[index].date ??
                                                  "",
                                            ),
                                          )),
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
                                GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: 0.75,
                                    crossAxisSpacing: 3.sw,
                                    mainAxisSpacing: 3.sw,
                                  ),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      state.homeResponse.category?.length ?? 0,
                                  itemBuilder: (context, index) => InkWell(
                                    borderRadius: BorderRadius.circular(17),
                                    child: SizedBox(
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(17),
                                            child: CachedNetworkImage(
                                              width: double.infinity,
                                              imageUrl:
                                                  "${APICallerConfiguration.baseImageUrl}${state.homeResponse.category?[index].image}",
                                              fit: BoxFit.fitWidth,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                AssetsData.music,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          const Gap(4),
                                          Text(
                                              state.homeResponse
                                                      .category?[index].name ??
                                                  "Event",
                                              textAlign: TextAlign.center,
                                              style: homeLabel3Style)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (state.homeResponse.today != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Gap(16),
                                const Text(
                                  'Happening today',
                                  style: homeLabelStyle,
                                ),
                                SizedBox(
                                  height: 180,
                                  child: ListView.builder(
                                      itemCount:
                                          state.homeResponse.today?.length ?? 0,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) => InkWell(
                                            onTap: (SessionManagement
                                                        .getUserRole() !=
                                                    "")
                                                ? () {
                                                    routeToEventDetails(
                                                        context,
                                                        state
                                                                .homeResponse
                                                                .today?[index]
                                                                .id ??
                                                            -1);
                                                  }
                                                : () async {
                                                    routeToEventDetails(
                                                        context,
                                                        state
                                                                .homeResponse
                                                                .today?[index]
                                                                .id ??
                                                            -1);
                                                    await Future.delayed(
                                                        const Duration(
                                                            seconds: 2));
                                                    /*AutoRouter.of(context)
                                                        .popAndPush(
                                                            const LoginRoute());*/
                                                  },
                                            child: HomeEventItem(
                                              name: state.homeResponse
                                                      .today?[index].name ??
                                                  "",
                                              image: state
                                                          .homeResponse
                                                          .today?[index]
                                                          .poster !=
                                                      null
                                                  ? "${APICallerConfiguration.baseImageUrl}${state.homeResponse.today?[index].poster}"
                                                  : "",
                                              catImage: state
                                                          .homeResponse
                                                          .today?[index]
                                                          .catPoster !=
                                                      null
                                                  ? "${APICallerConfiguration.baseImageUrl}${state.homeResponse.today?[index].catPoster}"
                                                  : "",
                                              date: state.homeResponse
                                                      .today?[index].date ??
                                                  "",
                                            ),
                                          )),
                                ),
                              ],
                            ),
                          const Gap(16),
                          Image.asset(
                            AssetsData.bottomBanner,
                          ),
                          const Gap(16),
                          // SizedBox(height: MediaQuery.of(context).size.height*0.1,)
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
