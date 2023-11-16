part of 'conn_cubit.dart';

final class ConnState {
  final bool isConnected;
  final bool isLoading;
  final String errorMessage;

  ConnState({
    required this.isConnected,
    required this.isLoading,
    required this.errorMessage,
  });
}
