part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class GetAccountBalanceSuccess extends PaymentState {
  final double balance;

  GetAccountBalanceSuccess(this.balance);
}

final class GetAccountBalanceError extends PaymentState {
  final String error;

  GetAccountBalanceError(this.error);
}

final class TransferBalanceSuccess extends PaymentState {
  final bool isSuccess;

  TransferBalanceSuccess(this.isSuccess);
}

final class TransferBalanceError extends PaymentState {
  final String error;

  TransferBalanceError(this.error);
}
