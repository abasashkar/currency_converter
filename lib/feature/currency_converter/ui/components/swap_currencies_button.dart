import 'package:currency_app/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SwapCurrenciesButton extends StatefulWidget {
  const SwapCurrenciesButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  State<SwapCurrenciesButton> createState() => SwapCurrenciesButtonState();
}

class SwapCurrenciesButtonState extends State<SwapCurrenciesButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward(from: 0).then((_) => _controller.reset());
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.cardBorder(context).withValues(alpha: 0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Material(
            elevation: 0,
            color: Colors.transparent,
            child: InkWell(
              onTap: _handleTap,
              customBorder: const CircleBorder(),
              child: Ink(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.swapButtonGradient(context),
                  border: Border.all(
                    color: AppColors.cardSurface(context),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.indigo.withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: RotationTransition(
                  turns: Tween<double>(begin: 0, end: 0.5).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Curves.easeInOutCubic,
                    ),
                  ),
                  child: const Icon(
                    Icons.swap_vert_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
