import 'package:freezed_annotation/freezed_annotation.dart';
import 'models/wp_session.dart';

part 'session_state.freezed.dart';

enum SessionStatus { unknown, authenticated, unauthenticated }

@freezed
sealed class SessionState with _$SessionState {
  const factory SessionState({
    required SessionStatus status,
    WpSession? session,
    String? errorMessage,
  }) = _SessionState;

  const SessionState._();

  factory SessionState.unknown() =>
      const SessionState(status: SessionStatus.unknown);

  factory SessionState.authed(WpSession s) =>
      SessionState(status: SessionStatus.authenticated, session: s);

  factory SessionState.unauthed([String? msg]) =>
      SessionState(status: SessionStatus.unauthenticated, errorMessage: msg);
}
