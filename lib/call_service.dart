import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

class MeetingUtils {
  static Future<void> joinMeeting({
    required String roomName,
    String? serverUrl,
    String? subject,
    String? token,
    bool isAudioMuted = false,
    bool isAudioOnly = false,
    bool isVideoMuted = false,
    required String userDisplayName,
    required String userEmail,
    String? userAvatarUrl,
  }) async {
    Map<String, Object> featureFlags = {
      "invite.enabled": false,
      "kickOutEnabled": false,
      "callIntegrationEnabled": false,
      "toolboxAlwaysVisible": false,
      "alwaysModeratorEnabled": false,
      "meetingPasswordEnabled": true,
    };

    // Define meetings options here
    var options = JitsiMeetingOptions(
      roomNameOrUrl: roomName,
      serverUrl: serverUrl,
      subject: subject,
      token: token,
      isAudioMuted: isAudioMuted,
      isAudioOnly: isAudioOnly,
      isVideoMuted: isVideoMuted,
      userDisplayName: userDisplayName,
      userEmail: userEmail,
      featureFlags: featureFlags,
    );

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onOpened: () => debugPrint("onOpened"),
        onConferenceWillJoin: (url) {
          debugPrint("onConferenceWillJoin: url: $url");
        },
        onConferenceJoined: (url) {
          debugPrint("onConferenceJoined: url: $url");
        },
        onConferenceTerminated: (url, error) {
          debugPrint("onConferenceTerminated: url: $url, error: $error");
        },
        onAudioMutedChanged: (isMuted) {
          debugPrint("onAudioMutedChanged: isMuted: $isMuted");
        },
        onVideoMutedChanged: (isMuted) {
          debugPrint("onVideoMutedChanged: isMuted: $isMuted");
        },
        onScreenShareToggled: (participantId, isSharing) {
          debugPrint(
            "onScreenShareToggled: participantId: $participantId, "
            "isSharing: $isSharing",
          );
        },
        onParticipantJoined: (email, name, role, participantId) {
          debugPrint(
            "onParticipantJoined: email: $email, name: $name, role: $role, "
            "participantId: $participantId",
          );
        },
        onParticipantLeft: (participantId) {
          debugPrint("onParticipantLeft: participantId: $participantId");
        },
        onParticipantsInfoRetrieved: (participantsInfo, requestId) {
          debugPrint(
            "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
            "requestId: $requestId",
          );
        },
        onChatMessageReceived: (senderId, message, isPrivate) {
          debugPrint(
            "onChatMessageReceived: senderId: $senderId, message: $message, "
            "isPrivate: $isPrivate",
          );
        },
        onChatToggled: (isOpen) => debugPrint("onChatToggled: isOpen: $isOpen"),
        onClosed: () => debugPrint("onClosed"),
      ),
    );
  }
}
