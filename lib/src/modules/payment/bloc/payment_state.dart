part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentSuccess extends PaymentState {}

final class GetAccountBalanceSuccess extends PaymentState {
  final double balance;

  GetAccountBalanceSuccess(this.balance);
}

final class GetAccountBalanceError extends PaymentState {
  final String error;

  GetAccountBalanceError(this.error);
}
