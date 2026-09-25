import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../services/story_service.dart';
import '../theme/logd_codes.dart';
import '../services/new_day_service.dart';

class NewDayScreen extends StatefulWidget {
  final NewDayResult result;

  const NewDayScreen({super.key, required this.result});

  @override
  State<NewDayScreen> createState() => _NewDayScreenState();
}

class _NewDayScreenState extends State<NewDayScreen> {
  Map<String, dynamic> _storyContent = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStory();
  }

  Future<void> _loadStory() async {
    final content = await StoryService.loadLocationContent(context, 'locatie_dorpsplein');
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
      return const Scaffold(
        backgroundColor: LogdCodes.uiBlueBg,
        body: Center(child: CircularProgressIndicator(color: LogdCodes.uiGreen)),
      );
    }

    return Scaffold(
      backgroundColor: LogdCodes.uiBlueBg,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LogdText(
                text: "`y== ${local.resetNewDayTitle.toUpperCase()} ==`w",
                fontSize: 22,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              
              LogdText(text: _storyContent['reset_new_day_message'] ?? "De zon komt op over het rijk en de vogels beginnen te fluiten.", fontSize: LogdCodes.fontSizeDefault),
              const SizedBox(height: 24),
              
              const Divider(color: Colors.grey),
              const SizedBox(height: 16),
              
              LogdText(text: local.resetNightResults, fontSize: LogdCodes.fontSizeCardTitle),
              const SizedBox(height: 10),
              
              if (widget.result.interestEarned > 0)
                LogdText(text: local.resetInterestLog(widget.result.interestEarned.toString()), fontSize: LogdCodes.fontSizeDefault),
              
              LogdText(text: local.resetTurnsLog(widget.result.newTurns.toString()), fontSize: LogdCodes.fontSizeDefault),
              LogdText(text: local.resetReadyLog, fontSize: LogdCodes.fontSizeDefault),
              
              const SizedBox(height: 40),
              
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: LogdCodes.uiGreen, width: 2),
                  backgroundColor: LogdCodes.uiGreenBg,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                ),
                onPressed: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    local.btnStartDay.toUpperCase(),
                    style: const TextStyle(
                      color: LogdCodes.uiGreen,
                      fontFamily: LogdCodes.retroFont,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
