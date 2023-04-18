import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_grocery/features/home/home.dart';
import 'package:flutter_grocery/features/product_list/product_list.dart';
import 'package:flutter_grocery/theme/theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text(
          'Flutter Grocery',
          style: GoogleFonts.montserratAlternates().copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          const HomeHeader(),
          const SizedBox(height: 24),
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    HomeSectionHeader(
                      title: 'Product List',
                      onTap: () {
                        Navigator.of(context).push(ProductListPage.route());
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<HomeProductsCubit, HomeProductsState>(
                      builder: (context, state) {
                        if (state is HomeProductsLoaded) {
                          return HomeProductList(products: state.products);
                        }

                        if (state is HomeProductsFailed) {
                          return Text(
                            state.failure.message,
                            style: AppTextStyles.subtitle2,
                          );
                        }

                        return const CircularProgressIndicator();
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BannerCarousel extends StatelessWidget {
  const BannerCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 3,
      itemBuilder: (context, index, realIndex) {
        final isLastIndex = index == (3 - 1);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://www.superindo.co.id/images/rollingbanners/banner-JSM18.jpg',
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: (MediaQuery.of(context).size.width * 0.8 - 16) * (434 / 1349),
        autoPlay: true,
        autoPlayInterval: const Duration(milliseconds: 4500),
        padEnds: false,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {},
      ),
    );
  }
}
