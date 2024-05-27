import 'package:alafein/core/local_data/session_management.dart';
import 'package:alafein/core/utility/assets_data.dart';
import 'package:alafein/core/utility/colors_data.dart';
import 'package:alafein/core/utility/strings.dart';
import 'package:alafein/features/home/presentation/home_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.index = 0});

  final int? index;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomePage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kSecondaryColor,
        unselectedItemColor: kGreyFontColor,
        elevation: 0.0,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          color: kSecondaryColor,
          height: 2,
          fontFamily: StringConst.formulaFont,
        ),
        unselectedLabelStyle: const TextStyle(
          color: kSecondaryColor,
          height: 2,
          fontFamily: StringConst.formulaFont,
        ),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsData.svgIcHomeDisabled,
              width: 24,
              height: 24,
            ),
            label: 'Home',
            activeIcon: SvgPicture.asset(
              AssetsData.svgIcHome,
              width: 24,
              height: 24,
            ),
          ),
          if (SessionManagement.getUserRole() != "")
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AssetsData.svgIcEventsDisabled,
                width: 24,
                height: 24,
              ),
              label: 'Events',
              activeIcon: SvgPicture.asset(
                AssetsData.svgIcEvents,
                width: 24,
                height: 24,
              ),
            ),
          if (SessionManagement.getUserRole() == "Audience")
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AssetsData.svgIcFavoriteDisabled,
                width: 24,
                height: 24,
              ),
              label: 'Favourite',
              activeIcon: SvgPicture.asset(
                AssetsData.svgIcFavorite,
                width: 24,
                height: 24,
              ),
            ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsData.svgIcProfileDisabled,
              width: 24,
              height: 24,
            ),
            label: 'Profile',
            activeIcon: SvgPicture.asset(
              AssetsData.svgIcProfile,
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}
