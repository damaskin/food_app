import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_icons/line_icons.dart';
import 'package:momentum/momentum.dart';
import 'package:restaurant_app/components/index.dart';
import 'package:restaurant_app/widgets/index.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RouterPage(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double _w = constraints.maxWidth;
          final double _h = constraints.maxHeight;
          final double _chipRadius = 40;

          return MomentumBuilder(
            controllers: [
              CartController,
              UserProfileController,
            ],
            builder: (context, snapshot) {
              final _cartModel = snapshot<CartModel>();
              final _userModel = snapshot<UserProfileModel>();

              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(_chipRadius),
                      bottomRight: Radius.circular(_chipRadius),
                    ),
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      width: _w,
                      height: _h,
                      padding: const EdgeInsets.all(15),
                      child: SingleChildScrollView(
                        child: _userModel.user.favorites.isEmpty
                            ? emptyWidget(
                                height: _h,
                                width: _w,
                                message: 'Your favorites is empty',
                                icon: LineIcons.heart_o,
                              )
                            : StaggeredGridView.countBuilder(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 30,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _userModel.user.favorites.length,
                                itemBuilder: (context, index) {
                                  final favProduct =
                                      _userModel.user.favorites[index];

                                  return productContainer(
                                    context: context,
                                    product: favProduct,
                                    cartController: _cartModel.controller,
                                    showCartButton: false,
                                  );
                                },
                                staggeredTileBuilder: (index) {
                                  return StaggeredTile.count(
                                    1,
                                    index.isEven ? 1.2 : 1.4,
                                  );
                                },
                              ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
