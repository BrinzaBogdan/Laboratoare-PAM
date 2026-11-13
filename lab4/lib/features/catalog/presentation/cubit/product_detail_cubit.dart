import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usecases/get_product_detail.dart';
import 'product_detail_state.dart';

/// Încarcă detaliile unui produs direct de la serviciul Web.
class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit(this._getProductDetail)
      : super(const ProductDetailState());

  final GetProductDetail _getProductDetail;

  Future<void> load(int id) async {
    emit(const ProductDetailState(status: ProductDetailStatus.loading));

    try {
      final product = await _getProductDetail(id);
      if (isClosed) return;
      emit(
        ProductDetailState(
          status: ProductDetailStatus.success,
          product: product,
        ),
      );
    } on Failure catch (failure) {
      if (isClosed) return;
      emit(
        ProductDetailState(
          status: ProductDetailStatus.failure,
          errorMessage: failure.message,
        ),
      );
    }
  }
}
