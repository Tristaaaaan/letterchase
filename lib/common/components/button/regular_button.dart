import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letterchase/common/utils/debouncer_delay.dart';

import 'loading_state_notifier.dart';

class RegularButton extends ConsumerStatefulWidget {
  final bool? withIcon;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final String buttonKey;
  final bool? withoutLoading;
  final Future<void> Function()? onTap;
  final bool? suffixIcon;
  final bool? withBorder;
  final double width;

  const RegularButton({
    super.key,
    this.withBorder = false,
    this.withIcon = true,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.buttonKey,
    this.withoutLoading = false,
    this.onTap,
    this.suffixIcon = true,
    required this.width,
  });

  @override
  ConsumerState<RegularButton> createState() => _RegularButtonState();
}

class _RegularButtonState extends ConsumerState<RegularButton> {
  late DeBouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _debouncer = DeBouncer(milliseconds: 500);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(regularButtonLoadingProvider)[widget.buttonKey] ?? false;

    return GestureDetector(
      onTap:
          widget.withoutLoading!
              ? widget.onTap
              : (isLoading || widget.onTap == null)
              ? null
              : () {
                _debouncer.run(() async {
                  await widget.onTap!();
                });
              },
      child: Container(
        height: 55,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border:
              widget.withBorder!
                  ? Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 3,
                  )
                  : null,
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: widget.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
