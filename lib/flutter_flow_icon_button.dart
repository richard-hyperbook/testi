import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const kIconDepreciated = Icon(Icons.thumb_down);
const kIconInfoStart = Icon(Icons.help_center_rounded);
const kIconInfoStartWhite = Icon(Icons.help_center_rounded, color: Colors.white);
const kIconNotVisited = Icon(Icons.visibility_off);
const kIconVisited = Icon(Icons.battery_0_bar);
const kIconPariallyRead = Icon(Icons.battery_3_bar);
const kIconFullyRead = Icon(Icons.battery_full);
const kIconHighlighted = Icon(Icons.highlight);
const kIconChooseChapterState = Icon(Icons.palette);
const kIconChooseChapterStateWhite = Icon(Icons.palette, color: Colors.white);
const kIconHyperbookMap = Icon(Icons.share);
const kIconHyperbookMapWhite = Icon(Icons.share, color: Colors.white);
const kIconEditChapter = Icon(Icons.edit_note);
const kIconEditChapterWhite = Icon(Icons.edit_note, color: Colors.white);
const kIconPostComment = Icon(Icons.comment);
const kIconPostCommentWhite = Icon(Icons.comment, color: Colors.white);
const kIconReadChapter = Icon(Icons.visibility);
const kIconArrowForward = Icon(Icons.arrow_forward_ios);
const kIconSettings = Icon(Icons.settings);
final kIconSettingsWhite = Icon(Icons.settings, color: Colors.white);
const kIconBackArrow = Icon(Icons.arrow_back);
const kIconDelete = Icon(Icons.delete);
const kIconTelephone = Icon(Icons.call_rounded);
const kIconVisible = Icon(Icons.visibility_outlined);
const kIconNotVisible = Icon(Icons.visibility_off_outlined);
const kIconList = Icon(Icons.list_alt);
const kIconListWhite = Icon(Icons.list_alt,  color: Colors.white);
const kIconRequestsOutstanding = Icon(Icons.star);
const kIconRequestsOutstandingRed = Icon(Icons.star, color: Colors.red);
const kIconRequest = Icon(Icons.local_library);
const kIconTutorial = Icon(Icons.school);
const kIconTutorialWhite = Icon(Icons.school, color: Colors.white);
final Widget kIconTutorialReverse = Container(child: Icon(Icons.school), color: Colors.white);
const kIconLogin = Icon(Icons.login);
const kIconLoginWhite = Icon(Icons.login, color: Colors.white);
final Widget kIconLoginReverse = Container(child: Icon(Icons.login), color: Colors.white);
const kIconProfile = Icon(Icons.person);
const kIconProfileWhite = Icon(Icons.person, color: Colors.white);
final Widget kIconProfileReverse = Container(child: Icon(Icons.person), color: Colors.white);
const kIconHyperbooks = Icon(Icons.folder_copy);
const kIconHyperbooksWhite = Icon(Icons.folder_copy, color: Colors.white);
final Widget kIconHyperbooksReverse = Container(child: Icon(Icons.folder_copy), color: Colors.white);
const kIconSave = Icon(Icons.save);



class FlutterFlowIconButton extends StatefulWidget {
  const FlutterFlowIconButton({
    super.key,
    required this.icon,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.buttonSize,
    this.fillColor,
    this.disabledColor,
    this.disabledIconColor,
    this.hoverColor,
    this.hoverIconColor,
    this.onPressed,
    this.showLoadingIndicator = false,
    this.tooltipMessage,
    this.enabled = true,
  });

  final Widget icon;
  final double? borderRadius;
  final double? buttonSize;
  final Color? fillColor;
  final Color? disabledColor;
  final Color? disabledIconColor;
  final Color? hoverColor;
  final Color? hoverIconColor;
  final Color? borderColor;
  final double? borderWidth;
  final bool showLoadingIndicator;
  final Function()? onPressed;
  final String? tooltipMessage;
  final bool enabled;

  @override
  State<FlutterFlowIconButton> createState() => _FlutterFlowIconButtonState();
}

class _FlutterFlowIconButtonState extends State<FlutterFlowIconButton> {
  bool loading = false;
  late double? iconSize;
  late Color? iconColor;
  late Widget effectiveIcon;

  @override
  void initState() {
    super.initState();
    _updateIcon();
  }

  @override
  void didUpdateWidget(FlutterFlowIconButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateIcon();
  }

  void _updateIcon() {
    final bool isFontAwesome = widget.icon is FaIcon;
    if (isFontAwesome) {
      final FaIcon icon = widget.icon as FaIcon;
      effectiveIcon = FaIcon(
        icon.icon,
        size: icon.size,
      );
      iconSize = icon.size;
      iconColor = icon.color;
    } else {
      final Icon icon = widget.icon as Icon;
      effectiveIcon = Icon(
        icon.icon,
        size: icon.size,
      );
      iconSize = icon.size;
      iconColor = icon.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('(NN1)${widget.tooltipMessage}');
    final ButtonStyle style = ButtonStyle(
      shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
            (Set<WidgetState> states) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
            side: BorderSide(
              color: widget.borderColor ?? Colors.transparent,
              width: widget.borderWidth ?? 0,
            ),
          );
        },
      ),
      iconColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled) &&
              widget.disabledIconColor != null) {
            return widget.disabledIconColor;
          }
          if (states.contains(WidgetState.hovered) &&
              widget.hoverIconColor != null) {
            return widget.hoverIconColor;
          }
          return iconColor;
        },
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled) &&
              widget.disabledColor != null) {
            return widget.disabledColor;
          }
          if (states.contains(WidgetState.hovered) &&
              widget.hoverColor != null) {
            return widget.hoverColor;
          }

          return widget.fillColor;
        },
      ),
    );

    return Tooltip(message: widget.tooltipMessage ?? '???',
      child: SizedBox(
        width: widget.buttonSize,
        height: widget.buttonSize,
        child: Theme(
          data: Theme.of(context).copyWith(),
          child: IgnorePointer(
            ignoring: widget.showLoadingIndicator && loading,
            child: IconButton(
              //disabledColor: Colors.red,
              icon: (widget.showLoadingIndicator && loading)
                  ? SizedBox(
                width: iconSize,
                height: iconSize,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    iconColor ?? Colors.white,
                  ),
                ),
              )
                  : effectiveIcon,
              onPressed: widget.enabled ? widget.onPressed == null
                  ? null
                  : () async {
                print('(NN10)${loading}++++${widget.tooltipMessage}');
                if (loading) {
                  return;
                }
                setState(() => loading = true);
                try {
                  await widget.onPressed!();
                } finally {
                  if (mounted) {
                    setState(() => loading = false);
                  }
                }
              } : null,
              splashRadius: widget.buttonSize,
              style: style,
            ),
          ),
        ),
      ),
    );
  }
}
