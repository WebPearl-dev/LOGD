import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/story_service.dart';
import '../theme/logd_codes.dart';
import 'logd_text.dart';

class LogdTutorialDialog extends StatefulWidget {
  const LogdTutorialDialog({super.key});

  @override
  State<LogdTutorialDialog> createState() => _LogdTutorialDialogState();
}

class _LogdTutorialDialogState extends State<LogdTutorialDialog> {
  int _currentStep = 0;
  static const int _totalSteps = 5;
  Map<String, dynamic> _storyContent = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTutorial();
  }

  Future<void> _loadTutorial() async {
    final content = await StoryService.loadLocationContent(context, 'tutorial');
    if (mounted) {
      setState(() {
        _storyContent = content;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (_isLoading) {
      return Dialog(
        backgroundColor: LogdCodes.uiCardBg,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: LogdCodes.uiCyan),
              const SizedBox(width: 16),
              Text(local.tutorialTitle, style: const TextStyle(color: Colors.white, fontFamily: LogdCodes.retroFont)),
            ],
          ),
        ),
      );
    }

    final List<_TutorialStep> steps = [
      _TutorialStep(
        title: local.tutorialStep1Title,
        content: _storyContent['step1_content'] ?? "",
        icon: Icons.location_city,
        color: LogdCodes.uiCyan,
      ),
      _TutorialStep(
        title: local.tutorialStep2Title,
        content: _storyContent['step2_content'] ?? "",
        icon: Icons.forest,
        color: LogdCodes.uiGreen,
      ),
      _TutorialStep(
        title: local.tutorialStep3Title,
        content: _storyContent['step3_content'] ?? "",
        icon: Icons.shield,
        color: LogdCodes.uiYellow,
      ),
      _TutorialStep(
        title: local.tutorialStep4Title,
        content: _storyContent['step4_content'] ?? "",
        icon: Icons.military_tech,
        color: LogdCodes.uiPurple,
      ),
      _TutorialStep(
        title: local.tutorialStep5Title,
        content: _storyContent['step5_content'] ?? "",
        icon: Icons.wb_sunny,
        color: LogdCodes.uiRed,
      ),
    ];

    final currentStepData = steps[_currentStep];

    return Dialog(
      backgroundColor: LogdCodes.uiCardBg,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: currentStepData.color, width: 1.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header met titel en stap-indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(currentStepData.icon, color: currentStepData.color, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        local.tutorialTitle.toUpperCase(),
                        style: TextStyle(
                          fontFamily: LogdCodes.retroFont,
                          fontSize: LogdCodes.fontSizeCardTitle,
                          color: currentStepData.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    local.tutorialStepProgress(_currentStep + 1, _totalSteps),
                    style: const TextStyle(
                      fontFamily: LogdCodes.retroFont,
                      fontSize: LogdCodes.fontSizeDefault - 2,
                      color: LogdCodes.uiGrey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Divider(height: 1, color: currentStepData.color.withValues(alpha: 0.3)),
              const SizedBox(height: 12),

              // Stap Titel
              Text(
                currentStepData.title,
                style: TextStyle(
                  fontFamily: LogdCodes.retroFont,
                  fontSize: LogdCodes.fontSizeCardTitle,
                  color: currentStepData.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // Stap Inhoud
              LogdText(
                text: currentStepData.content,
                fontSize: LogdCodes.fontSizeDefault,
              ),
              const SizedBox(height: 20),

              // Visuele Stap-Indicatoren (stipjes)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_totalSteps, (index) {
                  final bool isActive = index == _currentStep;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: isActive ? 20.0 : 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: isActive ? currentStepData.color : LogdCodes.uiGrey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Actieknoppen: Vorige, Volgende / Begrepen, Overslaan
              Column(
                children: [
                  Row(
                    children: [
                      if (_currentStep > 0) ...[
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: LogdCodes.uiGrey, width: 1.5),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                            ),
                            onPressed: () {
                              setState(() {
                                _currentStep--;
                              });
                            },
                            child: Text(
                              local.tutorialBtnPrevious.toUpperCase(),
                              style: const TextStyle(
                                fontFamily: LogdCodes.retroFont,
                                fontSize: LogdCodes.fontSizeDefault - 1,
                                color: LogdCodes.uiGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      if (_currentStep < _totalSteps - 1) ...[
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: currentStepData.color, width: 1.5),
                              backgroundColor: currentStepData.color.withValues(alpha: 0.1),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                            ),
                            onPressed: () {
                              setState(() {
                                _currentStep++;
                              });
                            },
                            child: Text(
                              local.tutorialBtnNext.toUpperCase(),
                              style: TextStyle(
                                fontFamily: LogdCodes.retroFont,
                                fontSize: LogdCodes.fontSizeDefault - 1,
                                color: currentStepData.color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ] else ...[
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: LogdCodes.uiGreen, width: 1.5),
                              backgroundColor: LogdCodes.uiGreen.withValues(alpha: 0.15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              local.tutorialBtnFinish.toUpperCase(),
                              style: const TextStyle(
                                fontFamily: LogdCodes.retroFont,
                                fontSize: LogdCodes.fontSizeDefault - 1,
                                color: LogdCodes.uiGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (_currentStep < _totalSteps - 1) ...[
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        local.tutorialBtnSkip,
                        style: const TextStyle(
                          fontFamily: LogdCodes.retroFont,
                          fontSize: LogdCodes.fontSizeDefault - 2,
                          color: LogdCodes.uiGrey,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TutorialStep {
  final String title;
  final String content;
  final IconData icon;
  final Color color;

  const _TutorialStep({
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
  });
}
