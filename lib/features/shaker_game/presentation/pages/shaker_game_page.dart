import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:shake/shake.dart';
import 'package:rive/rive.dart' as rive;
import 'package:vou/features/event/domain/entities/game_in_event.dart';
import '../../../../shared/styles/border_radius.dart';
import '../../../../theme/color/colors.dart';
import '../../bloc/shaker_cubit.dart';
import 'package:flutter/src/widgets/image.dart' as img;


class ShakerGamePage extends StatefulWidget {
  const ShakerGamePage({super.key, required this.game});
  final GameInEvent game;

  @override
  _ShakerGamePageState createState() => _ShakerGamePageState();
}

class _ShakerGamePageState extends State<ShakerGamePage> {
  late ShakeDetector shakeDetector;
  late ValueNotifier<String> animationStateNotifier;

  @override
  void initState() {
    super.initState();

    // Initialize the ValueNotifier with the default state
    animationStateNotifier = ValueNotifier('phone_shaking');

    // Load the shake chances
    context.read<ShakerCubit>().loadShakeChance(eventId: widget.game.eventId);

    // Initialize ShakeDetector
    shakeDetector = ShakeDetector.waitForStart(
      onPhoneShake: () {
        if (mounted) {
          context.read<ShakerCubit>().onShake(
            id: widget.game.id,
            eventId: widget.game.eventId,
          );
        }
      },
    );
    shakeDetector.startListening();
  }

  @override
  void dispose() {
    shakeDetector.stopListening();
    animationStateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(),
      body: BlocListener<ShakerCubit, ShakerState>(
        listener: (context, state) {
          // Update the animation state when the cubit state changes
          animationStateNotifier.value = state.stateShake;
        },
        child: Container(
          color: TColor.poppySurprise,
          child: SafeArea(
            child: Center(
              child: Stack(
                children: [
                  // Positioned background assets
                  _buildPositionedAssets(context),
                  // Shake animation and state info
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(300),
                          child: Container(
                            color: Colors.white.withOpacity(0.9),
                            width: 300,
                            height: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ValueListenableBuilder<String>(
                                valueListenable: animationStateNotifier,
                                builder: (context, stateMachine, _) {
                                  return rive.RiveAnimation.asset(
                                    'assets/animations/phone_shake_animation.riv',
                                    stateMachines: [stateMachine],
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Shake your device!",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: TColor.doctorWhite,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            if (mounted) {
                              context.read<ShakerCubit>().onShake(
                                id: widget.game.id,
                                eventId: widget.game.eventId,
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: TColor.petRock.withOpacity(0.3),
                              ),
                              borderRadius: TBorderRadius.sm,
                              color: TColor.doctorWhite.withOpacity(0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Your shake chances: ${context.read<ShakerCubit>().state.shakeChance}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                  color: TColor.doctorWhite,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPositionedAssets(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: MediaQuery.of(context).size.width * 0.01,
          top: MediaQuery.of(context).size.width * 0.01,
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.width * 0.2,
          child: Opacity(
            opacity: 0.8,
            child: img.Image.asset("assets/images/coin.png", fit: BoxFit.contain),
          ),
        ),
        Positioned(
          left: 0,
          top: MediaQuery.of(context).size.width * 0.4,
          width: MediaQuery.of(context).size.width * 0.13,
          height: MediaQuery.of(context).size.width * 0.13,
          child: Opacity(
            opacity: 0.8,
            child: img.Image.asset("assets/images/like-bubble.png",
                fit: BoxFit.contain),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * 0.01,
          top: MediaQuery.of(context).size.width * 0.03,
          width: MediaQuery.of(context).size.width * 0.15,
          height: MediaQuery.of(context).size.width * 0.15,
          child: Opacity(
            opacity: 0.8,
            child: img.Image.asset("assets/images/heart.png",
                fit: BoxFit.contain),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * 0.01,
          bottom: MediaQuery.of(context).size.width * 0.03,
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.width * 0.2,
          child: Opacity(
            opacity: 0.8,
            child: img.Image.asset("assets/images/haha-emoji.png",
                fit: BoxFit.contain),
          ),
        ),
        Positioned(
          right: 0,
          bottom: MediaQuery.of(context).size.width * 0.5,
          width: MediaQuery.of(context).size.width * 0.13,
          height: MediaQuery.of(context).size.width * 0.13,
          child: Opacity(
            opacity: 0.8,
            child: img.Image.asset("assets/images/love-counter.png",
                fit: BoxFit.contain),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.02,
          bottom: MediaQuery.of(context).size.width * 0.02,
          width: MediaQuery.of(context).size.width * 0.13,
          height: MediaQuery.of(context).size.width * 0.13,
          child: Opacity(
            opacity: 0.8,
            child: img.Image.asset("assets/images/star-bubble.png",
                fit: BoxFit.contain),
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: TBorderRadius.md,
          onTap: context.pop,
          child: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      title: const Text(""),
      actions: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              context.push("/friend/share", extra: widget.game.eventId);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.people_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
