import 'package:fast8_test/modules/home/bloc/home_bloc.dart';
import 'package:fast8_test/modules/home/bloc/home_event.dart';
import 'package:fast8_test/modules/home/bloc/home_state.dart';
import 'package:fast8_test/modules/home/widget/category_item.dart';
import 'package:fast8_test/modules/home/widget/explore_wellness.dart';
import 'package:fast8_test/modules/home/widget/appbar.dart';
import 'package:fast8_test/modules/home/widget/product_item.dart';
import 'package:fast8_test/modules/home/widget/tabbar.dart';
import 'package:fast8_test/utils/color.dart';
import 'package:fast8_test/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        color: primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppbarWidget(),
            buildVerticalSpacer(10),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: BlocProvider(
                  create: (context) => HomeBloc(),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 12, bottom: 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildVerticalSpacer(12),
                          BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                              return PayuungTab(
                                state: state,
                                onToggle: () {
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(TogglePayungEvent());
                                },
                              );
                            },
                          ),
                          buildVerticalSpacer(20),
                          const Text(
                            "Produk Keuangan",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              buildProductItem("Urun", 'urun', isNew: true),
                              buildProductItem(
                                  "Pembiayaan Porsi Haji", 'porsi_haji'),
                              buildProductItem(
                                  "Financial Check Up", 'financial'),
                              buildProductItem("Asuransi Mobil", 'car'),
                              buildProductItem("Asuransi Properti", 'home'),
                            ],
                          ),

                          buildVerticalSpacer(20),
                          const Text(
                            "Kategori Pilihan",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              buildCategoryItem("Hobi", 'hobi'),
                              buildCategoryItem("Merchandise", 'merchandise'),
                              buildCategoryItem(
                                  "Gaya Hidup Sehat", 'heart_rate'),
                              buildCategoryItem(
                                  "Konseling & Rohani", 'konseling'),
                              buildCategoryItem("Self Development", 'brain'),
                              buildCategoryItem("Perencanaan Keuangan", 'card'),
                              buildCategoryItem(
                                  "Konsultasi Medis", 'face_mask'),
                              buildCategoryItem("Lihat semua", 'view_all'),
                            ],
                          ),
                          buildVerticalSpacer(20),
                          const Text(
                            "Explore Wellness",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          buildVerticalSpacer(20),
                          GridView.count(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 10),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 22,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              buildWellnessItem(
                                  'Voucher Digital Indomaret Rp 25.000',
                                  'indomaret',
                                  '25.000'),
                              buildWellnessItem(
                                  'Voucher Digital H&M Rp 100.000',
                                  'h&m',
                                  '25.000',
                                  percentDiscount: '3%',
                                  isDiscount: true,
                                  priceDiscount: '97.000'),
                              buildWellnessItem(
                                  'Voucher Digital Grab Rp 20.000',
                                  'grab',
                                  '20.000'),
                              buildWellnessItem(
                                  'Voucher Digital Keds Rp 50.000',
                                  'keds',
                                  '50.000',
                                  percentDiscount: '2%',
                                  isDiscount: true,
                                  priceDiscount: '49.000'),
                              buildWellnessItem(
                                  'Voucher Digital Ace Hardware Rp 50.000',
                                  'ace',
                                  '50.000'),
                              buildWellnessItem(
                                'Voucher Digital Alfamart Rp 25.000',
                                'alfamart',
                                '25.000',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
