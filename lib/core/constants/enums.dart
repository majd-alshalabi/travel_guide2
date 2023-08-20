enum AppState { foreground, background }

enum AttachmentState { enqueue, completed, failed }

enum ToWhereShouldINavigateFromSplash { home, signInPage, onBoarding }

enum RequestState {
  loading,
  loaded,
  error,
}

enum MessageType {
  text,
  attachment;

  static MessageType fromInt(int type) {
    if (type == 1) return MessageType.text;
    return MessageType.attachment;
  }
}
