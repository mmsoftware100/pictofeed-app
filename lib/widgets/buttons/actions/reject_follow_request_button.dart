import 'package:Okuna/models/user.dart';
import 'package:Okuna/provider.dart';
import 'package:Okuna/services/localization.dart';
import 'package:Okuna/services/toast.dart';
import 'package:Okuna/services/user.dart';
import 'package:Okuna/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:intl/intl.dart';

class OBRejectFollowRequestButton extends StatefulWidget {
  final User user;
  final VoidCallback? onFollowRequestRejected;
  final OBButtonSize size;

  const OBRejectFollowRequestButton(this.user,
      {Key? key, this.onFollowRequestRejected, this.size = OBButtonSize.medium})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return OBRejectFollowRequestButtonState();
  }
}

class OBRejectFollowRequestButtonState extends State<OBRejectFollowRequestButton> {
  late ToastService _toastService;
  late LocalizationService _localizationService;
  late UserService _userService;
  late bool _needsBootstrap;

  late bool _isFollowRequestActionInProgress;
  CancelableOperation? _followRequestActionOperation;

  @override
  void initState() {
    super.initState();
    _needsBootstrap = true;
    _isFollowRequestActionInProgress = false;
  }

  @override
  Widget build(BuildContext context) {
    var openbookProvider = OpenbookProvider.of(context);

    if (_needsBootstrap) {
      _localizationService = openbookProvider.localizationService;
      _userService = openbookProvider.userService;
      _toastService = openbookProvider.toastService;
    }

    return OBButton(
      size: OBButtonSize.small,
      isLoading: _isFollowRequestActionInProgress,
      child: Text(toBeginningOfSentenceCase(
          _localizationService.moderation__community_review_reject)!),
      type: OBButtonType.danger,
      onPressed: _onWantsToRejectRequest,
    );
  }

  Future<void> _onWantsToRejectRequest() async {
    _setFollowRequestActionInProgress(true);

    try {
      _followRequestActionOperation = CancelableOperation.fromFuture(
          _userService
              .rejectFollowRequestFromUser(widget.user));
      await _followRequestActionOperation!.value;
      if(widget.onFollowRequestRejected != null) widget.onFollowRequestRejected!();

    } catch (error) {
      _onError(error);
      rethrow;
    } finally {
      _setFollowRequestActionInProgress(false);
      _followRequestActionOperation = null;
    }
  }

  void _onError(error) async {
    if (error is HttpieConnectionRefusedError) {
      _toastService.error(
          message: error.toHumanReadableMessage(), context: context);
    } else if (error is HttpieRequestError) {
      String? errorMessage = await error.toHumanReadableMessage();
      _toastService.error(message: errorMessage ?? _localizationService.error__unknown_error, context: context);
    } else {
      _toastService.error(
          message: _localizationService.error__unknown_error, context: context);
      throw error;
    }
  }

  void _setFollowRequestActionInProgress(bool followRequestActionInProgress) {
    setState(() {
      _isFollowRequestActionInProgress = followRequestActionInProgress;
    });
  }
}
