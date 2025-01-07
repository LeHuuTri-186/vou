import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
import 'package:shake/shake.dart';
import 'package:vou/shared/styles/border_radius.dart';

import '../../../../theme/color/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _score = 0;
  int _shakeChance = 3;
  late ShakeDetector shakeDetector;
  String stateShake = 'phone_shaking';

  bool isProcessingShake = false;

  @override
  void initState() {
    super.initState();

    shakeDetector = ShakeDetector.waitForStart(
      onPhoneShake: () {
        if (!mounted) return; // Ensure the widget is still in the tree
        setState(() {
          _score++;
          if (_score == 5) {
            stateShake = 'phone_puzzle_pop';
          }
        });

        if (_score == 5) {
          // Delay for 1 second before resetting the state
          Future.delayed(const Duration(seconds: 1), () {
            if (!mounted) return; // Prevent calling setState if the widget is no longer active
            setState(() {
              _score = 0;
              stateShake = 'phone_shaking';
              _shakeChance--;
            });
          });
        }
      },
    );
  }

  @override
  void dispose() {
    shakeDetector.stopListening(); // Stop the shake detector to prevent memory leaks
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    shakeDetector.startListening();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(),
      body: Container(
        color: TColor.poppySurprise,
        child: SafeArea(
          child: Center(
            child: Stack(
              children: [
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.01,
                  top: MediaQuery.of(context).size.width * 0.01,
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  child: Opacity(
                    opacity: 0.8, // Set the opacity to 0.8
                    child: Image.asset("images/coin.png",
                        fit: BoxFit.contain),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: MediaQuery.of(context).size.width * 0.4,
                  width: MediaQuery.of(context).size.width * 0.13,
                  height: MediaQuery.of(context).size.width * 0.13,
                  child: Opacity(
                    opacity: 0.8,
                    child: Image.asset("images/like-bubble.png",
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
                    child: Image.asset("images/heart.png",
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
                    child: Image.asset("images/haha-emoji.png",
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
                    child: Image.asset("images/love-counter.png",
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
                    child: Image.asset("images/star-bubble.png",
                        fit: BoxFit.contain),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(300),
                      child: Container(
                        color: Colors.white.withOpacity(0.9),
                        width: 300,
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: rive.RiveAnimation.asset(
                            useArtboardSize: false,
                            stateMachines: [stateShake],
                            'lib/core/assets/rive/phone_shake_animation.riv',
                            fit: BoxFit.cover, // Adjust fit as needed
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
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: TColor.petRock.withOpacity(0.3),
                          ),
                          borderRadius: TBorderRadius.sm,
                          color: TColor.doctorWhite.withOpacity(0.5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Your shake chances: $_shakeChance",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: TColor.doctorWhite,
                                    fontSize: 18,
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
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      clipBehavior: Clip.none,
      elevation: 0,
      backgroundColor: Colors.transparent,
      forceMaterialTransparency: true,
      leading: const Material(
        color: Colors.transparent,
        child: InkWell(
          child: Icon(Icons.arrow_back_rounded),
        ),
      ),
      iconTheme: IconThemeData(
        color: TColor.doctorWhite,
      ),
      title: const Text(""),
      actions: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              child: Icon(Icons.people_outlined),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              child: Icon(Icons.question_mark_rounded),
            ),
          ),
        ),
      ],
    );
  }
}
