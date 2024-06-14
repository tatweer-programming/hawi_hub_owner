import 'package:bloc/bloc.dart';
import 'package:hawi_hub_owner/src/modules/payment/data/services/payment_service.dart';
import 'package:meta/meta.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  static PaymentCubit? cubit;

  static PaymentCubit get() {
    cubit ??= PaymentCubit();
    return cubit!;
  }

  final PaymentService _paymentService = PaymentService();

  void _paymentSuccess() {
    emit(PaymentSuccess());
  }

  Future<void> getAccountBalance(String supplierCode) async {
    final result = await _paymentService.getAccountBalance(supplierCode);
    result.fold(
      (l) {
        emit(GetAccountBalanceError(l));
      },
      (r) {
        emit(GetAccountBalanceSuccess(r));
      },
    );
  }
}
