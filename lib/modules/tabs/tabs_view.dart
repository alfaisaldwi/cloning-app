import 'package:fast8_test/modules/tabs/bloc/navbar_bloc.dart';
import 'package:fast8_test/modules/tabs/bloc/navbar_event.dart';
import 'package:fast8_test/modules/tabs/bloc/navbar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ultimate_bottom_navbar/ultimate_bottom_navbar.dart';
import 'package:flutter/material.dart';

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({Key? key}) : super(key: key);

  @override
  _BottomNavigationViewState createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  final List<IconData> icons = const [
    Icons.home_outlined,
    Icons.search_outlined,
    Icons.shopping_cart_outlined,
  ];

  final List<String> titles = const ["Beranda", "Cari", "Keranjang"];

  final List<Widget> pages = const [
    Center(child: Text("Page 1")),
    Center(child: Text("Page 2")),
    Center(child: Text("Page 3")),
  ];

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height * 0.3;

    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<BottomNavBloc, BottomNavState>(
            builder: (context, state) {
              return pages[state.currentIndex];
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BlocBuilder<BottomNavBloc, BottomNavState>(
              builder: (context, state) {
                bool isExpanded = state.isExpanded;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height:
                      isExpanded ? maxHeight : kBottomNavigationBarHeight + 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    border: Border.all(width: 1),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!isExpanded)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                icons.length,
                                (index) => Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(icons[index]),
                                      color: state.currentIndex == index
                                          ? Colors.orange.shade300
                                          : Colors.black,
                                      onPressed: () {
                                        context
                                            .read<BottomNavBloc>()
                                            .add(ChangeIndexEvent(index));
                                      },
                                    ),
                                    Text(titles[index],
                                        style: TextStyle(
                                          color: state.currentIndex == index
                                              ? Colors.orange.shade300
                                              : Colors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        if (isExpanded)
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                    icons.length,
                                    (index) => Column(
                                      children: [
                                        IconButton(
                                          icon: Icon(icons[index]),
                                          color: state.currentIndex == index
                                              ? Colors.orange.shade300
                                              : Colors.black,
                                          onPressed: () {
                                            context
                                                .read<BottomNavBloc>()
                                                .add(ChangeIndexEvent(index));
                                            context
                                                .read<BottomNavBloc>()
                                                .add(ToggleBottomNavEvent());
                                          },
                                        ),
                                        Text(titles[index],
                                            style: TextStyle(
                                              color: state.currentIndex == index
                                                  ? Colors.orange.shade300
                                                  : Colors.black,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Expanded(
                                  child: GridView.count(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 0,
                                    crossAxisSpacing: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 0),
                                    children: [
                                      _BottomSheetItem(
                                          icon: Icons.list_alt_outlined,
                                          title: "Daftar Transaksi"),
                                      _BottomSheetItem(
                                          icon: Icons.card_giftcard_outlined,
                                          title: "Voucher Saya"),
                                      _BottomSheetItem(
                                          icon: Icons.location_on_outlined,
                                          title: "Alamat Pengiriman"),
                                      _BottomSheetItem(
                                          icon: Icons.people_outline,
                                          title: "Daftar Teman"),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: GridView.count(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 0,
                                    crossAxisSpacing: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 0),
                                    children: [
                                      _BottomSheetItem(
                                          icon: Icons.people_outline,
                                          title: "Daftar Teman"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          BlocBuilder<BottomNavBloc, BottomNavState>(builder: (context, state) {
            return AnimatedPositioned(
                duration:
                    const Duration(milliseconds: 300), 

                bottom:
                    state.isExpanded ? 240 : 70, 
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      side: MaterialStateProperty.all(BorderSide(width: 1)),
                    ),
                    icon: Icon(
                      state.isExpanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                      size: 30,
                    ),
                    onPressed: () {
                      context.read<BottomNavBloc>().add(ToggleBottomNavEvent());
                    },
                  ),
                ));
          }),
        ],
      ),
    );
  }
}

class _BottomSheetItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _BottomSheetItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 30, color: Colors.black),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(color: Colors.black, fontSize: 12)),
      ],
    );
  }
}
