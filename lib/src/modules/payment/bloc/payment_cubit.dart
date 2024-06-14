import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {

  PaymentCubit() : super(PaymentInitial());
  static PaymentCubit? cubit;
  static PaymentCubit get() {
    cubit ??= PaymentCubit();
    return cubit!;
  }
  void _paymentSuccess() {
    emit(PaymentSuccess());
  }
}
