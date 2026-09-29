import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_nl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('nl'),
  ];

  /// No description provided for @statLvl.
  ///
  /// In nl, this message translates to:
  /// **'LVL: {level}'**
  String statLvl(Object level);

  /// No description provided for @statHp.
  ///
  /// In nl, this message translates to:
  /// **'HP: {current}/{max}'**
  String statHp(Object current, Object max);

  /// No description provided for @statGold.
  ///
  /// In nl, this message translates to:
  /// **'Goud: {amount}'**
  String statGold(Object amount);

  /// No description provided for @statGems.
  ///
  /// In nl, this message translates to:
  /// **'Gems: {amount}'**
  String statGems(Object amount);

  /// No description provided for @statTurns.
  ///
  /// In nl, this message translates to:
  /// **'Beurten: {amount}'**
  String statTurns(Object amount);

  /// No description provided for @statXp.
  ///
  /// In nl, this message translates to:
  /// **'XP: {amount}'**
  String statXp(Object amount);

  /// No description provided for @statDk.
  ///
  /// In nl, this message translates to:
  /// **'DK: {amount}'**
  String statDk(Object amount);

  /// No description provided for @statHonor.
  ///
  /// In nl, this message translates to:
  /// **'Eer: {amount}'**
  String statHonor(Object amount);

  /// No description provided for @statPvpWins.
  ///
  /// In nl, this message translates to:
  /// **'Winst: {wins} | Verlies: {losses}'**
  String statPvpWins(Object losses, Object wins);

  /// No description provided for @btnGoToForest.
  ///
  /// In nl, this message translates to:
  /// **'Betreed het bos'**
  String get btnGoToForest;

  /// No description provided for @btnAttack.
  ///
  /// In nl, this message translates to:
  /// **'Aanval'**
  String get btnAttack;

  /// No description provided for @btnFlee.
  ///
  /// In nl, this message translates to:
  /// **'Vluchten'**
  String get btnFlee;

  /// No description provided for @btnReturnTown.
  ///
  /// In nl, this message translates to:
  /// **'Terug naar stad'**
  String get btnReturnTown;

  /// No description provided for @btnSave.
  ///
  /// In nl, this message translates to:
  /// **'Opslaan'**
  String get btnSave;

  /// No description provided for @btnCancel.
  ///
  /// In nl, this message translates to:
  /// **'Annuleren'**
  String get btnCancel;

  /// No description provided for @btnClose.
  ///
  /// In nl, this message translates to:
  /// **'Sluiten'**
  String get btnClose;

  /// No description provided for @btnLogin.
  ///
  /// In nl, this message translates to:
  /// **'Inloggen'**
  String get btnLogin;

  /// No description provided for @btnRegister.
  ///
  /// In nl, this message translates to:
  /// **'Account aanmaken'**
  String get btnRegister;

  /// No description provided for @btnConfirmRace.
  ///
  /// In nl, this message translates to:
  /// **'Bevestig keuze en start avontuur'**
  String get btnConfirmRace;

  /// No description provided for @btnConfirmSpecialty.
  ///
  /// In nl, this message translates to:
  /// **'Kies klasse en betreed het Dorpsplein'**
  String get btnConfirmSpecialty;

  /// No description provided for @btnUseSkill.
  ///
  /// In nl, this message translates to:
  /// **'Vaardigheid'**
  String get btnUseSkill;

  /// No description provided for @btnBuyUpgrade.
  ///
  /// In nl, this message translates to:
  /// **'Koop Upgrade'**
  String get btnBuyUpgrade;

  /// No description provided for @btnVisitBank.
  ///
  /// In nl, this message translates to:
  /// **'Bank'**
  String get btnVisitBank;

  /// No description provided for @btnVisitSmithy.
  ///
  /// In nl, this message translates to:
  /// **'Winkels'**
  String get btnVisitSmithy;

  /// No description provided for @btnVisitPegasus.
  ///
  /// In nl, this message translates to:
  /// **'Bezoek Pegasus Wapens'**
  String get btnVisitPegasus;

  /// No description provided for @btnVisitMerilon.
  ///
  /// In nl, this message translates to:
  /// **'Bezoek Merilon Harnassen'**
  String get btnVisitMerilon;

  /// No description provided for @btnTalkPegasus.
  ///
  /// In nl, this message translates to:
  /// **'Praat met Pegasus'**
  String get btnTalkPegasus;

  /// No description provided for @btnTalkMerilon.
  ///
  /// In nl, this message translates to:
  /// **'Praat met Merilon'**
  String get btnTalkMerilon;

  /// No description provided for @btnChallengeMaster.
  ///
  /// In nl, this message translates to:
  /// **'Uitdaging Master duel'**
  String get btnChallengeMaster;

  /// No description provided for @btnVisitTraining.
  ///
  /// In nl, this message translates to:
  /// **'Trainingsruimte'**
  String get btnVisitTraining;

  /// No description provided for @btnEventFountainDive.
  ///
  /// In nl, this message translates to:
  /// **'Duik erin'**
  String get btnEventFountainDive;

  /// No description provided for @btnEventFountainLeave.
  ///
  /// In nl, this message translates to:
  /// **'Loop door'**
  String get btnEventFountainLeave;

  /// No description provided for @btnEventGiantSneak.
  ///
  /// In nl, this message translates to:
  /// **'Slip erlangs'**
  String get btnEventGiantSneak;

  /// No description provided for @btnEventGiantSteal.
  ///
  /// In nl, this message translates to:
  /// **'Probeer te stelen'**
  String get btnEventGiantSteal;

  /// No description provided for @btnGraveyardOfferGem.
  ///
  /// In nl, this message translates to:
  /// **'Bied 1 Edelsteen'**
  String get btnGraveyardOfferGem;

  /// No description provided for @btnGraveyardOfferXp.
  ///
  /// In nl, this message translates to:
  /// **'Bied 100 XP'**
  String get btnGraveyardOfferXp;

  /// No description provided for @btnGraveyardAcceptLot.
  ///
  /// In nl, this message translates to:
  /// **'Accepteer je lot (Wacht tot morgen)'**
  String get btnGraveyardAcceptLot;

  /// No description provided for @btnGraveyardRob.
  ///
  /// In nl, this message translates to:
  /// **'GRAAF GRAAF'**
  String get btnGraveyardRob;

  /// No description provided for @btnStartDay.
  ///
  /// In nl, this message translates to:
  /// **'Begin de nieuwe dag'**
  String get btnStartDay;

  /// No description provided for @btnHermitDrink.
  ///
  /// In nl, this message translates to:
  /// **'Drink kruidenthee'**
  String get btnHermitDrink;

  /// No description provided for @btnInnRoll.
  ///
  /// In nl, this message translates to:
  /// **'Gooi dobbelstenen'**
  String get btnInnRoll;

  /// No description provided for @btnVisitInn.
  ///
  /// In nl, this message translates to:
  /// **'Herberg'**
  String get btnVisitInn;

  /// No description provided for @btnVisitStables.
  ///
  /// In nl, this message translates to:
  /// **'Stallen'**
  String get btnVisitStables;

  /// No description provided for @btnChurchPray.
  ///
  /// In nl, this message translates to:
  /// **'Doe een Gebed'**
  String get btnChurchPray;

  /// No description provided for @btnChurchConfess.
  ///
  /// In nl, this message translates to:
  /// **'Biecht Zonden'**
  String get btnChurchConfess;

  /// No description provided for @btnChurchCandle.
  ///
  /// In nl, this message translates to:
  /// **'Steek Kaars op (1 Gem)'**
  String get btnChurchCandle;

  /// No description provided for @btnVisitChurch.
  ///
  /// In nl, this message translates to:
  /// **'Kerk'**
  String get btnVisitChurch;

  /// No description provided for @btnBuyAtkPotion.
  ///
  /// In nl, this message translates to:
  /// **'Koop Drakenbloed (+5 Atk)'**
  String get btnBuyAtkPotion;

  /// No description provided for @btnBuyDefPotion.
  ///
  /// In nl, this message translates to:
  /// **'Koop IJzerhuid (+5 Def)'**
  String get btnBuyDefPotion;

  /// No description provided for @btnVisitAlchemist.
  ///
  /// In nl, this message translates to:
  /// **'Alchemist'**
  String get btnVisitAlchemist;

  /// No description provided for @btnVisitHealer.
  ///
  /// In nl, this message translates to:
  /// **'Kruidendokter 🌿'**
  String get btnVisitHealer;

  /// No description provided for @btnBuyHealing.
  ///
  /// In nl, this message translates to:
  /// **'KOOP GENEZING'**
  String get btnBuyHealing;

  /// No description provided for @btnVisitBarber.
  ///
  /// In nl, this message translates to:
  /// **'KAPPER MET STYLING'**
  String get btnVisitBarber;

  /// No description provided for @btnBuyTitle.
  ///
  /// In nl, this message translates to:
  /// **'KOOP TITEL (1 GEM)'**
  String get btnBuyTitle;

  /// No description provided for @btnVisitAlley.
  ///
  /// In nl, this message translates to:
  /// **'SCHADUWSTEEG 🪓'**
  String get btnVisitAlley;

  /// No description provided for @btnResetReputation.
  ///
  /// In nl, this message translates to:
  /// **'KOOP STRAFBLAD AF (5 GEMS)'**
  String get btnResetReputation;

  /// No description provided for @btnVisitMightyE.
  ///
  /// In nl, this message translates to:
  /// **'DONOR MIGHTYE 💎'**
  String get btnVisitMightyE;

  /// No description provided for @btnDonateGem.
  ///
  /// In nl, this message translates to:
  /// **'DONEER 1 GEM'**
  String get btnDonateGem;

  /// No description provided for @btnVisitWedding.
  ///
  /// In nl, this message translates to:
  /// **'TROUWAPEL 💍'**
  String get btnVisitWedding;

  /// No description provided for @btnMarry.
  ///
  /// In nl, this message translates to:
  /// **'JA IK WIL (500 GOUD)'**
  String get btnMarry;

  /// No description provided for @btnStyxOnboard.
  ///
  /// In nl, this message translates to:
  /// **'GA AAN BOORD (KOST 2 BEURTEN)'**
  String get btnStyxOnboard;

  /// No description provided for @btnStyxStay.
  ///
  /// In nl, this message translates to:
  /// **'BLIJF AAN DE OEVER'**
  String get btnStyxStay;

  /// No description provided for @btnWhispersListen.
  ///
  /// In nl, this message translates to:
  /// **'LUISTER AANDACHTIG'**
  String get btnWhispersListen;

  /// No description provided for @btnWhispersLeave.
  ///
  /// In nl, this message translates to:
  /// **'ZWEEF SNEL VERDER'**
  String get btnWhispersLeave;

  /// No description provided for @btn_attack_dragon.
  ///
  /// In nl, this message translates to:
  /// **'Val de Groene Draak aan!'**
  String get btn_attack_dragon;

  /// No description provided for @btn_sneak_away.
  ///
  /// In nl, this message translates to:
  /// **'Slip stilletjes weg'**
  String get btn_sneak_away;

  /// No description provided for @btn_dragon_continue.
  ///
  /// In nl, this message translates to:
  /// **'Accepteer je lot'**
  String get btn_dragon_continue;

  /// No description provided for @btnDevHeal.
  ///
  /// In nl, this message translates to:
  /// **'Volledig Genezen (Full HP)'**
  String get btnDevHeal;

  /// No description provided for @btnDevGold.
  ///
  /// In nl, this message translates to:
  /// **'Geef +10.000 Goud'**
  String get btnDevGold;

  /// No description provided for @btnDevGems.
  ///
  /// In nl, this message translates to:
  /// **'Geef +5 Gems'**
  String get btnDevGems;

  /// No description provided for @btnDevTurns.
  ///
  /// In nl, this message translates to:
  /// **'Geef +10 Beurten'**
  String get btnDevTurns;

  /// No description provided for @btnDevLevelUp.
  ///
  /// In nl, this message translates to:
  /// **'Direct Level Up (+1 Lvl)'**
  String get btnDevLevelUp;

  /// No description provided for @btnDevAddGold.
  ///
  /// In nl, this message translates to:
  /// **'+10K GOUD'**
  String get btnDevAddGold;

  /// No description provided for @btnDevAddGems.
  ///
  /// In nl, this message translates to:
  /// **'+5 GEMS'**
  String get btnDevAddGems;

  /// No description provided for @btnDevAddTurns.
  ///
  /// In nl, this message translates to:
  /// **'+10 BEURTEN'**
  String get btnDevAddTurns;

  /// No description provided for @btnDevSpawnAction.
  ///
  /// In nl, this message translates to:
  /// **'SPAWN DIRECT 🚀'**
  String get btnDevSpawnAction;

  /// No description provided for @btnBuyCut.
  ///
  /// In nl, this message translates to:
  /// **'Frisse coupe ({cost} Goud)'**
  String btnBuyCut(Object cost);

  /// No description provided for @btnBuyShave.
  ///
  /// In nl, this message translates to:
  /// **'Gladde scheerbeurt ({cost} Goud)'**
  String btnBuyShave(Object cost);

  /// No description provided for @btnBuyDye.
  ///
  /// In nl, this message translates to:
  /// **'Verf haar (1 GEM)'**
  String get btnBuyDye;

  /// No description provided for @btnUpgradeAtk.
  ///
  /// In nl, this message translates to:
  /// **'PERMANENTE AANVAL (+1 ATK)'**
  String get btnUpgradeAtk;

  /// No description provided for @btnUpgradeDef.
  ///
  /// In nl, this message translates to:
  /// **'PERMANENTE VERDEDIGING (+1 DEF)'**
  String get btnUpgradeDef;

  /// No description provided for @btnUpgradeHp.
  ///
  /// In nl, this message translates to:
  /// **'PERMANENTE VITALITEIT (+5 HP)'**
  String get btnUpgradeHp;

  /// No description provided for @btnUpgradeTurns.
  ///
  /// In nl, this message translates to:
  /// **'BOSWANDELAAR ZEGEN (+1 BEURT)'**
  String get btnUpgradeTurns;

  /// No description provided for @btnVisitDragonShrine.
  ///
  /// In nl, this message translates to:
  /// **'Drakenheiligdom'**
  String get btnVisitDragonShrine;

  /// No description provided for @profileSaveName.
  ///
  /// In nl, this message translates to:
  /// **'Naam Opslaan'**
  String get profileSaveName;

  /// No description provided for @profileSaveEmail.
  ///
  /// In nl, this message translates to:
  /// **'E-mail Opslaan'**
  String get profileSaveEmail;

  /// No description provided for @profileChangePassword.
  ///
  /// In nl, this message translates to:
  /// **'Wachtwoord Wijzigen'**
  String get profileChangePassword;

  /// No description provided for @profileNewPasswordLabel.
  ///
  /// In nl, this message translates to:
  /// **'Nieuw Wachtwoord'**
  String get profileNewPasswordLabel;

  /// No description provided for @profileSavePassword.
  ///
  /// In nl, this message translates to:
  /// **'Wachtwoord Opslaan'**
  String get profileSavePassword;

  /// No description provided for @settingsBtnShare.
  ///
  /// In nl, this message translates to:
  /// **'Deel nu'**
  String get settingsBtnShare;

  /// No description provided for @settingsBtnRate.
  ///
  /// In nl, this message translates to:
  /// **'Beoordeel nu'**
  String get settingsBtnRate;

  /// No description provided for @settingsBtnSend.
  ///
  /// In nl, this message translates to:
  /// **'Verzenden'**
  String get settingsBtnSend;

  /// No description provided for @tutorialBtnPrevious.
  ///
  /// In nl, this message translates to:
  /// **'Vorige'**
  String get tutorialBtnPrevious;

  /// No description provided for @tutorialBtnNext.
  ///
  /// In nl, this message translates to:
  /// **'Volgende'**
  String get tutorialBtnNext;

  /// No description provided for @tutorialBtnSkip.
  ///
  /// In nl, this message translates to:
  /// **'Overslaan'**
  String get tutorialBtnSkip;

  /// No description provided for @tutorialBtnFinish.
  ///
  /// In nl, this message translates to:
  /// **'Begrepen / Start Spel'**
  String get tutorialBtnFinish;

  /// No description provided for @btnSend.
  ///
  /// In nl, this message translates to:
  /// **'Verzenden'**
  String get btnSend;

  /// No description provided for @btnDm.
  ///
  /// In nl, this message translates to:
  /// **'Privébericht'**
  String get btnDm;

  /// No description provided for @btnChallenge.
  ///
  /// In nl, this message translates to:
  /// **'Uitdagen'**
  String get btnChallenge;

  /// No description provided for @arenaAccept.
  ///
  /// In nl, this message translates to:
  /// **'Accepteren'**
  String get arenaAccept;

  /// No description provided for @arenaDecline.
  ///
  /// In nl, this message translates to:
  /// **'Afwijzen'**
  String get arenaDecline;

  /// No description provided for @townChatButton.
  ///
  /// In nl, this message translates to:
  /// **'Wereldchat'**
  String get townChatButton;

  /// No description provided for @townArenaButton.
  ///
  /// In nl, this message translates to:
  /// **'PvP Arena'**
  String get townArenaButton;

  /// No description provided for @btnOk.
  ///
  /// In nl, this message translates to:
  /// **'OK'**
  String get btnOk;

  /// No description provided for @btnTalkTownfolk.
  ///
  /// In nl, this message translates to:
  /// **'PRAAT MET DORPSBEWONERS 🗣️'**
  String get btnTalkTownfolk;

  /// No description provided for @btnForestLeprechaunPlay.
  ///
  /// In nl, this message translates to:
  /// **'Speel spel (100 G)'**
  String get btnForestLeprechaunPlay;

  /// No description provided for @btnForestWalkAway.
  ///
  /// In nl, this message translates to:
  /// **'LOOP WEG'**
  String get btnForestWalkAway;

  /// No description provided for @btnForestWizardDrink.
  ///
  /// In nl, this message translates to:
  /// **'Drink uit ketel'**
  String get btnForestWizardDrink;

  /// No description provided for @btnForestWagonSearch.
  ///
  /// In nl, this message translates to:
  /// **'Grondig doorzoeken'**
  String get btnForestWagonSearch;

  /// No description provided for @btnForestWagonSmash.
  ///
  /// In nl, this message translates to:
  /// **'Sla kisten kapot'**
  String get btnForestWagonSmash;

  /// No description provided for @btnForestHartBow.
  ///
  /// In nl, this message translates to:
  /// **'Buig respectvol'**
  String get btnForestHartBow;

  /// No description provided for @btnForestHartHunt.
  ///
  /// In nl, this message translates to:
  /// **'Probeer te jagen'**
  String get btnForestHartHunt;

  /// No description provided for @btnForestCardHigher.
  ///
  /// In nl, this message translates to:
  /// **'Hoger'**
  String get btnForestCardHigher;

  /// No description provided for @btnForestCardLower.
  ///
  /// In nl, this message translates to:
  /// **'Lager'**
  String get btnForestCardLower;

  /// No description provided for @btnForestTreeGold.
  ///
  /// In nl, this message translates to:
  /// **'Geef goud'**
  String get btnForestTreeGold;

  /// No description provided for @btnForestTreeChop.
  ///
  /// In nl, this message translates to:
  /// **'Hak schors'**
  String get btnForestTreeChop;

  /// No description provided for @btnForestTempleRead.
  ///
  /// In nl, this message translates to:
  /// **'Lees boek'**
  String get btnForestTempleRead;

  /// No description provided for @btnForestTempleSearch.
  ///
  /// In nl, this message translates to:
  /// **'Doorzoek altaar'**
  String get btnForestTempleSearch;

  /// No description provided for @btnForestHerbalistRed.
  ///
  /// In nl, this message translates to:
  /// **'Rood elixir'**
  String get btnForestHerbalistRed;

  /// No description provided for @btnForestHerbalistBlue.
  ///
  /// In nl, this message translates to:
  /// **'Blauw elixir'**
  String get btnForestHerbalistBlue;

  /// No description provided for @btnForestBadgerAnswer.
  ///
  /// In nl, this message translates to:
  /// **'Beantwoord vraag'**
  String get btnForestBadgerAnswer;

  /// No description provided for @btnForestBadgerHunt.
  ///
  /// In nl, this message translates to:
  /// **'Jagen weg'**
  String get btnForestBadgerHunt;

  /// No description provided for @btnForestSkeletonPlunder.
  ///
  /// In nl, this message translates to:
  /// **'Plunder harnas'**
  String get btnForestSkeletonPlunder;

  /// No description provided for @btnForestSkeletonBow.
  ///
  /// In nl, this message translates to:
  /// **'Toon respect'**
  String get btnForestSkeletonBow;

  /// No description provided for @btnForestCarnivalSpin.
  ///
  /// In nl, this message translates to:
  /// **'Draai aan rad'**
  String get btnForestCarnivalSpin;

  /// No description provided for @btnForestCampEat.
  ///
  /// In nl, this message translates to:
  /// **'Eet soep'**
  String get btnForestCampEat;

  /// No description provided for @btnForestCampSearch.
  ///
  /// In nl, this message translates to:
  /// **'Doorzoek tenten'**
  String get btnForestCampSearch;

  /// No description provided for @btnForestWellOffer.
  ///
  /// In nl, this message translates to:
  /// **'Bied edelsteen'**
  String get btnForestWellOffer;

  /// No description provided for @btnForestWellFish.
  ///
  /// In nl, this message translates to:
  /// **'Vis naar goud'**
  String get btnForestWellFish;

  /// No description provided for @btnForestHoneyClimb.
  ///
  /// In nl, this message translates to:
  /// **'Pak honing'**
  String get btnForestHoneyClimb;

  /// No description provided for @btnForestHoneySmoke.
  ///
  /// In nl, this message translates to:
  /// **'Rook bijen uit'**
  String get btnForestHoneySmoke;

  /// No description provided for @btnForestMushroomStep.
  ///
  /// In nl, this message translates to:
  /// **'Stap in kring'**
  String get btnForestMushroomStep;

  /// No description provided for @btnForestMushroomDestroy.
  ///
  /// In nl, this message translates to:
  /// **'Vernietig kring'**
  String get btnForestMushroomDestroy;

  /// No description provided for @btnForestHunterPlay.
  ///
  /// In nl, this message translates to:
  /// **'Schietwedstrijd'**
  String get btnForestHunterPlay;

  /// No description provided for @btnForestHunterDemand.
  ///
  /// In nl, this message translates to:
  /// **'Eis goud'**
  String get btnForestHunterDemand;

  /// No description provided for @btnForestStatueOffer.
  ///
  /// In nl, this message translates to:
  /// **'Bied goud'**
  String get btnForestStatueOffer;

  /// No description provided for @btnForestStatueClean.
  ///
  /// In nl, this message translates to:
  /// **'Maak standbeeld schoon'**
  String get btnForestStatueClean;

  /// No description provided for @btnForestSnareCut.
  ///
  /// In nl, this message translates to:
  /// **'Snijd los'**
  String get btnForestSnareCut;

  /// No description provided for @btnForestSnareForce.
  ///
  /// In nl, this message translates to:
  /// **'Gebruik kracht'**
  String get btnForestSnareForce;

  /// No description provided for @btnForestSnareWait.
  ///
  /// In nl, this message translates to:
  /// **'Wacht'**
  String get btnForestSnareWait;

  /// No description provided for @wep0.
  ///
  /// In nl, this message translates to:
  /// **'Blote Vuisten'**
  String get wep0;

  /// No description provided for @wep1.
  ///
  /// In nl, this message translates to:
  /// **'Houten Stok'**
  String get wep1;

  /// No description provided for @wep2.
  ///
  /// In nl, this message translates to:
  /// **'Roestige Dolk'**
  String get wep2;

  /// No description provided for @wep3.
  ///
  /// In nl, this message translates to:
  /// **'Handbijl'**
  String get wep3;

  /// No description provided for @wep4.
  ///
  /// In nl, this message translates to:
  /// **'IJzeren Kortzwaard'**
  String get wep4;

  /// No description provided for @wep5.
  ///
  /// In nl, this message translates to:
  /// **'Stalen Brede Zwaard'**
  String get wep5;

  /// No description provided for @wep6.
  ///
  /// In nl, this message translates to:
  /// **'Grote Strijdhamer'**
  String get wep6;

  /// No description provided for @wep7.
  ///
  /// In nl, this message translates to:
  /// **'Gekruiste Hellebaard'**
  String get wep7;

  /// No description provided for @wep8.
  ///
  /// In nl, this message translates to:
  /// **'Elfen Kruisboog'**
  String get wep8;

  /// No description provided for @wep9.
  ///
  /// In nl, this message translates to:
  /// **'Runenzwaard'**
  String get wep9;

  /// No description provided for @wep10.
  ///
  /// In nl, this message translates to:
  /// **'Mace van Duif'**
  String get wep10;

  /// No description provided for @wep11.
  ///
  /// In nl, this message translates to:
  /// **'Glimmende Knots'**
  String get wep11;

  /// No description provided for @wep12.
  ///
  /// In nl, this message translates to:
  /// **'Obsidiaan Kling'**
  String get wep12;

  /// No description provided for @wep13.
  ///
  /// In nl, this message translates to:
  /// **'Drakenbot Speer'**
  String get wep13;

  /// No description provided for @wep14.
  ///
  /// In nl, this message translates to:
  /// **'Hemels Zwaard'**
  String get wep14;

  /// No description provided for @wep15.
  ///
  /// In nl, this message translates to:
  /// **'Excalibur van Oaktaven'**
  String get wep15;

  /// No description provided for @arm0.
  ///
  /// In nl, this message translates to:
  /// **'Alledaagse Kleding'**
  String get arm0;

  /// No description provided for @arm1.
  ///
  /// In nl, this message translates to:
  /// **'Leren Vest'**
  String get arm1;

  /// No description provided for @arm2.
  ///
  /// In nl, this message translates to:
  /// **'Dik Gekookt Leer'**
  String get arm2;

  /// No description provided for @arm3.
  ///
  /// In nl, this message translates to:
  /// **'Met Klinknagels Beslagen Leren Harnas'**
  String get arm3;

  /// No description provided for @arm4.
  ///
  /// In nl, this message translates to:
  /// **'Ringpantser'**
  String get arm4;

  /// No description provided for @arm5.
  ///
  /// In nl, this message translates to:
  /// **'Lichte Maliënkolder'**
  String get arm5;

  /// No description provided for @arm6.
  ///
  /// In nl, this message translates to:
  /// **'Zware Stalen Maliënkolder'**
  String get arm6;

  /// No description provided for @arm7.
  ///
  /// In nl, this message translates to:
  /// **'Platenpantser'**
  String get arm7;

  /// No description provided for @arm8.
  ///
  /// In nl, this message translates to:
  /// **'Elfen Borstplaat'**
  String get arm8;

  /// No description provided for @arm9.
  ///
  /// In nl, this message translates to:
  /// **'Behouwen Bronzen Harnas'**
  String get arm9;

  /// No description provided for @arm10.
  ///
  /// In nl, this message translates to:
  /// **'Ridderlijk Platenharnas'**
  String get arm10;

  /// No description provided for @arm11.
  ///
  /// In nl, this message translates to:
  /// **'Runen Bescherming'**
  String get arm11;

  /// No description provided for @arm12.
  ///
  /// In nl, this message translates to:
  /// **'Obsidiaan Schild & Harnas'**
  String get arm12;

  /// No description provided for @arm13.
  ///
  /// In nl, this message translates to:
  /// **'Drakenhuid Schild'**
  String get arm13;

  /// No description provided for @arm14.
  ///
  /// In nl, this message translates to:
  /// **'Paladijn Cuirass'**
  String get arm14;

  /// No description provided for @arm15.
  ///
  /// In nl, this message translates to:
  /// **'Het Godenpantser'**
  String get arm15;

  /// No description provided for @mount0.
  ///
  /// In nl, this message translates to:
  /// **'Geen'**
  String get mount0;

  /// No description provided for @mount1.
  ///
  /// In nl, this message translates to:
  /// **'Pony'**
  String get mount1;

  /// No description provided for @mount2.
  ///
  /// In nl, this message translates to:
  /// **'Oorlogspaard'**
  String get mount2;

  /// No description provided for @mount3.
  ///
  /// In nl, this message translates to:
  /// **'Schaduwwolf'**
  String get mount3;

  /// No description provided for @mount4.
  ///
  /// In nl, this message translates to:
  /// **'Gouden Draak'**
  String get mount4;

  /// No description provided for @smithyMaxLevel.
  ///
  /// In nl, this message translates to:
  /// **'`gJe bezit al de absolute beste uitrusting in het rijk!`w'**
  String get smithyMaxLevel;

  /// No description provided for @stablesMaxLevel.
  ///
  /// In nl, this message translates to:
  /// **'`gJe bezit al de legendarische Gouden Draak! De stalmeester kijkt met totale ontzag naar je rijdier.`w'**
  String get stablesMaxLevel;

  /// No description provided for @devSuccessMessage.
  ///
  /// In nl, this message translates to:
  /// **'`p[DEV] Stat succesvol aangepast in de cloud!`w'**
  String get devSuccessMessage;

  /// No description provided for @lblDevSelectEvent.
  ///
  /// In nl, this message translates to:
  /// **'Selecteer Event om te Spawnen:'**
  String get lblDevSelectEvent;

  /// No description provided for @lblDevSelectMonster.
  ///
  /// In nl, this message translates to:
  /// **'Selecteer Monster om te Spawnen:'**
  String get lblDevSelectMonster;

  /// No description provided for @smithyErrorUnknown.
  ///
  /// In nl, this message translates to:
  /// **'`4Er is een onbekende fout opgetreden.`w'**
  String get smithyErrorUnknown;

  /// No description provided for @smithyErrorNoGold.
  ///
  /// In nl, this message translates to:
  /// **'`4De smid lacht je uit: \"Je hebt niet genoeg goudstukken bij je!\"`w'**
  String get smithyErrorNoGold;

  /// No description provided for @alchemistLimitReached.
  ///
  /// In nl, this message translates to:
  /// **'Wacht eens even! Je hebt vandaag al 2 elixers gekocht. Je lichaam kan er niet meer verdragen tot de volgende zonsopgang!'**
  String get alchemistLimitReached;

  /// No description provided for @alchemistErrorAlreadyActive.
  ///
  /// In nl, this message translates to:
  /// **'`4Je hebt al een actieve boost van dit elixir! Meer drinken is pure gif voor je lichaam.`w'**
  String get alchemistErrorAlreadyActive;

  /// No description provided for @dialogRumorTitle.
  ///
  /// In nl, this message translates to:
  /// **'DORPSGERUCHTEN'**
  String get dialogRumorTitle;

  /// No description provided for @dialogWoundedTitle.
  ///
  /// In nl, this message translates to:
  /// **'TE ZWAAR GEWOND'**
  String get dialogWoundedTitle;

  /// No description provided for @dialogWoundedMessage.
  ///
  /// In nl, this message translates to:
  /// **'`4Je bent te zwaar gewond om te vechten. Bezoek de Kruidendokter of de herberg om te herstellen!`w'**
  String get dialogWoundedMessage;

  /// No description provided for @townSquareRumorFallback.
  ///
  /// In nl, this message translates to:
  /// **'De dorpsbewoners zijn stil vandaag...'**
  String get townSquareRumorFallback;

  /// No description provided for @healerFallbackHealthy.
  ///
  /// In nl, this message translates to:
  /// **'Je bent al volkomen gezond!'**
  String get healerFallbackHealthy;

  /// No description provided for @healerSuccessFallback.
  ///
  /// In nl, this message translates to:
  /// **'Je bent genezen!'**
  String get healerSuccessFallback;

  /// No description provided for @townCrierPrefix.
  ///
  /// In nl, this message translates to:
  /// **'`4HOOR ZEGT HET VOORT! `w'**
  String get townCrierPrefix;

  /// No description provided for @defaultUsername.
  ///
  /// In nl, this message translates to:
  /// **'Reiziger'**
  String get defaultUsername;

  /// No description provided for @newsUnknownPlayer.
  ///
  /// In nl, this message translates to:
  /// **'Onbekende Reiziger'**
  String get newsUnknownPlayer;

  /// No description provided for @newsUnknownPartner.
  ///
  /// In nl, this message translates to:
  /// **'iemand'**
  String get newsUnknownPartner;

  /// No description provided for @innRoomRentedMessage.
  ///
  /// In nl, this message translates to:
  /// **'Je hebt een veilige kamer gehuurd in de herberg! Je bent nu beschermd tegen offline PK-aanvallen.'**
  String get innRoomRentedMessage;

  /// No description provided for @innRoomErrorNoGold.
  ///
  /// In nl, this message translates to:
  /// **'Je hebt niet genoeg goud (50 goud vereist) om een kamer te huren!'**
  String get innRoomErrorNoGold;

  /// No description provided for @resetNewDayTitle.
  ///
  /// In nl, this message translates to:
  /// **'Een nieuwe dag daagt!'**
  String get resetNewDayTitle;

  /// No description provided for @resetNightResults.
  ///
  /// In nl, this message translates to:
  /// **'Resultaten van de nacht:'**
  String get resetNightResults;

  /// No description provided for @resetInterestLog.
  ///
  /// In nl, this message translates to:
  /// **'• De bank heeft `y{amount} goud`w aan rente bijgeschreven (2%).'**
  String resetInterestLog(Object amount);

  /// No description provided for @resetTurnsLog.
  ///
  /// In nl, this message translates to:
  /// **'• Je beurten zijn aangevuld tot `c{amount}`w.'**
  String resetTurnsLog(Object amount);

  /// No description provided for @resetReadyLog.
  ///
  /// In nl, this message translates to:
  /// **'• Je voelt je uitgerust en klaar voor de strijd!'**
  String get resetReadyLog;

  /// No description provided for @arenaVictory.
  ///
  /// In nl, this message translates to:
  /// **'`2Je hebt het PvP duel gewonnen en {gold} goud en {honor} eer verdiend!`w'**
  String arenaVictory(Object gold, Object honor);

  /// No description provided for @arenaDefeat.
  ///
  /// In nl, this message translates to:
  /// **'`4Je bent in het PvP duel verslagen door {opponent}!`w'**
  String arenaDefeat(Object opponent);

  /// No description provided for @trainingDuelTitle.
  ///
  /// In nl, this message translates to:
  /// **'=== DUEL MET {name} ==='**
  String trainingDuelTitle(Object name);

  /// No description provided for @btnForestFountainDive.
  ///
  /// In nl, this message translates to:
  /// **'Duik in fontein'**
  String get btnForestFountainDive;

  /// No description provided for @btnForestGiantSteal.
  ///
  /// In nl, this message translates to:
  /// **'Roofdier'**
  String get btnForestGiantSteal;

  /// No description provided for @btnForestGiantSneak.
  ///
  /// In nl, this message translates to:
  /// **'Slip erlangs'**
  String get btnForestGiantSneak;

  /// No description provided for @newsEmpty.
  ///
  /// In nl, this message translates to:
  /// **'`wHet mededelingenbord is momenteel leeg. Het is een rustige dag in het rijk...`w'**
  String get newsEmpty;

  /// No description provided for @authTitle.
  ///
  /// In nl, this message translates to:
  /// **'Toegang tot het Rijk'**
  String get authTitle;

  /// No description provided for @authEmail.
  ///
  /// In nl, this message translates to:
  /// **'E-mailadres'**
  String get authEmail;

  /// No description provided for @authPassword.
  ///
  /// In nl, this message translates to:
  /// **'Wachtwoord'**
  String get authPassword;

  /// No description provided for @authUsername.
  ///
  /// In nl, this message translates to:
  /// **'Karakternaam (alleen registratie)'**
  String get authUsername;

  /// No description provided for @authSwitchToRegister.
  ///
  /// In nl, this message translates to:
  /// **'Nieuw hier? Maak een karakter aan'**
  String get authSwitchToRegister;

  /// No description provided for @authSwitchToLogin.
  ///
  /// In nl, this message translates to:
  /// **'Al een karakter? Log hier in'**
  String get authSwitchToLogin;

  /// No description provided for @authGuestLogin.
  ///
  /// In nl, this message translates to:
  /// **'Speel als gast'**
  String get authGuestLogin;

  /// No description provided for @profileTitle.
  ///
  /// In nl, this message translates to:
  /// **'Karakter Instellingen'**
  String get profileTitle;

  /// No description provided for @profileChangeName.
  ///
  /// In nl, this message translates to:
  /// **'Wijzig Karakter Naam'**
  String get profileChangeName;

  /// No description provided for @profileDeleteAccount.
  ///
  /// In nl, this message translates to:
  /// **'Permanent Karakter Verwijderen'**
  String get profileDeleteAccount;

  /// No description provided for @profileDeleteWarning.
  ///
  /// In nl, this message translates to:
  /// **'Weet je het zeker? Dit verwijdert al je goud, levels en XP permanent!'**
  String get profileDeleteWarning;

  /// No description provided for @profileLogout.
  ///
  /// In nl, this message translates to:
  /// **'Verlaat het Rijk (Uitloggen)'**
  String get profileLogout;

  /// No description provided for @profileBiometricToggle.
  ///
  /// In nl, this message translates to:
  /// **'Biometrisch inloggen (Vingerafdruk/FaceID)'**
  String get profileBiometricToggle;

  /// No description provided for @profileChangeEmail.
  ///
  /// In nl, this message translates to:
  /// **'Wijzig E-mailadres'**
  String get profileChangeEmail;

  /// No description provided for @bankTitle.
  ///
  /// In nl, this message translates to:
  /// **'De Centrale Bank van het Rijk'**
  String get bankTitle;

  /// No description provided for @bankInBank.
  ///
  /// In nl, this message translates to:
  /// **'Goud op bank: `y{amount} goudstukken`w'**
  String bankInBank(Object amount);

  /// No description provided for @bankOnHand.
  ///
  /// In nl, this message translates to:
  /// **'Goud op zak: `y{amount} goudstukken`w'**
  String bankOnHand(Object amount);

  /// No description provided for @btnDepositAll.
  ///
  /// In nl, this message translates to:
  /// **'Stort alles'**
  String get btnDepositAll;

  /// No description provided for @btnWithdrawAll.
  ///
  /// In nl, this message translates to:
  /// **'Opnemen alles'**
  String get btnWithdrawAll;

  /// No description provided for @btnDepositCustom.
  ///
  /// In nl, this message translates to:
  /// **'Stort bedrag'**
  String get btnDepositCustom;

  /// No description provided for @btnWithdrawCustom.
  ///
  /// In nl, this message translates to:
  /// **'Bedrag opnemen'**
  String get btnWithdrawCustom;

  /// No description provided for @bankVaultBalance.
  ///
  /// In nl, this message translates to:
  /// **'Kluissaldo: `y{amount} goud`w'**
  String bankVaultBalance(Object amount);

  /// No description provided for @bankOnHandLabel.
  ///
  /// In nl, this message translates to:
  /// **'Op zak: `y{amount} goud`w'**
  String bankOnHandLabel(Object amount);

  /// No description provided for @bankDepositLimitLabel.
  ///
  /// In nl, this message translates to:
  /// **'Stortlimiet over: `c{amount} goud`w'**
  String bankDepositLimitLabel(Object amount);

  /// No description provided for @btnTalkBanker.
  ///
  /// In nl, this message translates to:
  /// **'Praat met de bankier'**
  String get btnTalkBanker;

  /// No description provided for @raceTitle.
  ///
  /// In nl, this message translates to:
  /// **'Kies je Ras'**
  String get raceTitle;

  /// No description provided for @raceHuman.
  ///
  /// In nl, this message translates to:
  /// **'Mens'**
  String get raceHuman;

  /// No description provided for @raceHumanDesc.
  ///
  /// In nl, this message translates to:
  /// **'Gebalanceerd en gedreven. Start met `y+5 extra beurten`w voor vandaag.'**
  String get raceHumanDesc;

  /// No description provided for @raceElf.
  ///
  /// In nl, this message translates to:
  /// **'Elf'**
  String get raceElf;

  /// No description provided for @raceElfDesc.
  ///
  /// In nl, this message translates to:
  /// **'Elegant en mystiek. Start met `c+1 glimmende edelsteen`w op zak.'**
  String get raceElfDesc;

  /// No description provided for @raceDwarf.
  ///
  /// In nl, this message translates to:
  /// **'Dwerg'**
  String get raceDwarf;

  /// No description provided for @raceDwarfDesc.
  ///
  /// In nl, this message translates to:
  /// **'Robuust en gek op goud. Start met `y+100 extra startgoud`w.'**
  String get raceDwarfDesc;

  /// No description provided for @raceOrc.
  ///
  /// In nl, this message translates to:
  /// **'Ork'**
  String get raceOrc;

  /// No description provided for @raceOrcDesc.
  ///
  /// In nl, this message translates to:
  /// **'Brutaal en sterk. Start met `r+5 maximale HP`w.'**
  String get raceOrcDesc;

  /// No description provided for @specialtyTitle.
  ///
  /// In nl, this message translates to:
  /// **'Kies je Specialiteit'**
  String get specialtyTitle;

  /// No description provided for @specMagic.
  ///
  /// In nl, this message translates to:
  /// **'Mystieke Krachten (Magie)'**
  String get specMagic;

  /// No description provided for @specMagicDesc.
  ///
  /// In nl, this message translates to:
  /// **'Meester in elementen. Start met de spreuk `cRegeneratie`w om jezelf te helen in gevecht.'**
  String get specMagicDesc;

  /// No description provided for @specThieving.
  ///
  /// In nl, this message translates to:
  /// **'Diefstal (Zakkenrollen)'**
  String get specThieving;

  /// No description provided for @specThievingDesc.
  ///
  /// In nl, this message translates to:
  /// **'Snel en doortrapt. Start met de vaardigheid `yZakkenrollen`w om extra goud te slaan uit monsters.'**
  String get specThievingDesc;

  /// No description provided for @specWarrior.
  ///
  /// In nl, this message translates to:
  /// **'Krijger'**
  String get specWarrior;

  /// No description provided for @specWarriorDesc.
  ///
  /// In nl, this message translates to:
  /// **'Brute kracht en staal. Start met de vaardigheid `rSchildbeuk`w voor extra zware klappen.'**
  String get specWarriorDesc;

  /// No description provided for @smithyTitle.
  ///
  /// In nl, this message translates to:
  /// **'Smederij \'Het Hete Ijzer\''**
  String get smithyTitle;

  /// No description provided for @smithyCurrentEquip.
  ///
  /// In nl, this message translates to:
  /// **'Huidige uitrusting:'**
  String get smithyCurrentEquip;

  /// No description provided for @smithyWeaponLabel.
  ///
  /// In nl, this message translates to:
  /// **'Wapen: `c{name}`w (Lvl {lvl})'**
  String smithyWeaponLabel(Object lvl, Object name);

  /// No description provided for @smithyArmorLabel.
  ///
  /// In nl, this message translates to:
  /// **'Pantser: `c{name}`w (Lvl {lvl})'**
  String smithyArmorLabel(Object lvl, Object name);

  /// No description provided for @smithyUpgradeAvailable.
  ///
  /// In nl, this message translates to:
  /// **'Volgende upgrade beschikbaar:'**
  String get smithyUpgradeAvailable;

  /// No description provided for @smithyCostLabel.
  ///
  /// In nl, this message translates to:
  /// **'Kosten: `y{cost} goudstukken`w (inruilwaarde verrekend)'**
  String smithyCostLabel(Object cost);

  /// No description provided for @smithyAmountLabel.
  ///
  /// In nl, this message translates to:
  /// **'Aantal goudstukken'**
  String get smithyAmountLabel;

  /// No description provided for @smithyTabWeapons.
  ///
  /// In nl, this message translates to:
  /// **'Wapens'**
  String get smithyTabWeapons;

  /// No description provided for @smithyTabArmor.
  ///
  /// In nl, this message translates to:
  /// **'Harnassen'**
  String get smithyTabArmor;

  /// No description provided for @trainingTitle.
  ///
  /// In nl, this message translates to:
  /// **'De Trainingsruimte van de Masters'**
  String get trainingTitle;

  /// No description provided for @trainingStatusTitle.
  ///
  /// In nl, this message translates to:
  /// **'=== STATUS ==='**
  String get trainingStatusTitle;

  /// No description provided for @trainingCurrentLevel.
  ///
  /// In nl, this message translates to:
  /// **'Huidig Level: `yLevel {level}`w'**
  String trainingCurrentLevel(Object level);

  /// No description provided for @trainingMasterHp.
  ///
  /// In nl, this message translates to:
  /// **'MASTER HP: `4{current} / {max}`w'**
  String trainingMasterHp(Object current, Object max);

  /// No description provided for @trainingXpLabel.
  ///
  /// In nl, this message translates to:
  /// **'Ervaring (XP): `c{current} / {needed}`w'**
  String trainingXpLabel(Object current, Object needed);

  /// No description provided for @forestTitle.
  ///
  /// In nl, this message translates to:
  /// **'Het Duistere Woud'**
  String get forestTitle;

  /// No description provided for @graveyardTitle.
  ///
  /// In nl, this message translates to:
  /// **'Het Schaduwrijke Kerkhof'**
  String get graveyardTitle;

  /// No description provided for @newsTitle.
  ///
  /// In nl, this message translates to:
  /// **'Het Dagelijks Nieuws van het Rijk'**
  String get newsTitle;

  /// No description provided for @rankingsTitle.
  ///
  /// In nl, this message translates to:
  /// **'De Eeregalerij'**
  String get rankingsTitle;

  /// No description provided for @rankingsWelcome.
  ///
  /// In nl, this message translates to:
  /// **'De machtigste krijgers van het rijk:'**
  String get rankingsWelcome;

  /// No description provided for @rankingsEmpty.
  ///
  /// In nl, this message translates to:
  /// **'Er zijn nog geen legendarische helden opgestaan...'**
  String get rankingsEmpty;

  /// No description provided for @townCrierTitle.
  ///
  /// In nl, this message translates to:
  /// **'De Stadomroeper'**
  String get townCrierTitle;

  /// No description provided for @btnVisitNews.
  ///
  /// In nl, this message translates to:
  /// **'Dagelijks Nieuws'**
  String get btnVisitNews;

  /// No description provided for @devTitle.
  ///
  /// In nl, this message translates to:
  /// **'=== GOD MODE: DEV MENU ==='**
  String get devTitle;

  /// No description provided for @devScreenTitle.
  ///
  /// In nl, this message translates to:
  /// **'MASTER DEV CONSOLE'**
  String get devScreenTitle;

  /// No description provided for @devSpawnMonsterTitle.
  ///
  /// In nl, this message translates to:
  /// **'=== SPAWN MONSTER TEST ==='**
  String get devSpawnMonsterTitle;

  /// No description provided for @devSpawnMonsterDesc.
  ///
  /// In nl, this message translates to:
  /// **'Klik op een monster hieronder om direct een gevecht in het bos te forceren en de balans te checken:'**
  String get devSpawnMonsterDesc;

  /// No description provided for @innTitle.
  ///
  /// In nl, this message translates to:
  /// **'Herberg \'De Dronken Draak\''**
  String get innTitle;

  /// No description provided for @innDiceTitle.
  ///
  /// In nl, this message translates to:
  /// **'=== DE GOKTAFEL ==='**
  String get innDiceTitle;

  /// No description provided for @innDiceDesc.
  ///
  /// In nl, this message translates to:
  /// **'Gok goud om te dobbelen tegen de herbergiers. Hoogste gooi wint!'**
  String get innDiceDesc;

  /// No description provided for @stablesTitle.
  ///
  /// In nl, this message translates to:
  /// **'De Koninklijke Stallen'**
  String get stablesTitle;

  /// No description provided for @stablesCurrentMount.
  ///
  /// In nl, this message translates to:
  /// **'Je huidige rijdier: `c{mount}`w'**
  String stablesCurrentMount(Object mount);

  /// No description provided for @stablesNoMount.
  ///
  /// In nl, this message translates to:
  /// **'Geen (Je reist te voet)'**
  String get stablesNoMount;

  /// No description provided for @stablesUpgradeAvailable.
  ///
  /// In nl, this message translates to:
  /// **'=== BESCHIKBAAR RIJDIER ==='**
  String get stablesUpgradeAvailable;

  /// No description provided for @stablesCostLabel.
  ///
  /// In nl, this message translates to:
  /// **'Prijs: `y{gold} goud`w'**
  String stablesCostLabel(Object gold);

  /// No description provided for @stablesCostGemsLabel.
  ///
  /// In nl, this message translates to:
  /// **'Prijs: `y{gold} goud`w & `c{gems} Gems`w'**
  String stablesCostGemsLabel(Object gems, Object gold);

  /// No description provided for @stablesBonusLabel.
  ///
  /// In nl, this message translates to:
  /// **'Bonus: `2+{def} Def`w | `p+{turns} Beurten per dag`w'**
  String stablesBonusLabel(Object def, Object turns);

  /// No description provided for @churchTitle.
  ///
  /// In nl, this message translates to:
  /// **'Het Serene Klooster'**
  String get churchTitle;

  /// No description provided for @alchemistTitle.
  ///
  /// In nl, this message translates to:
  /// **'De Alchemist'**
  String get alchemistTitle;

  /// No description provided for @alchemistCurrentBoosts.
  ///
  /// In nl, this message translates to:
  /// **'Actieve elixers: `2{atk} Atk`w | `c{def} Def`w'**
  String alchemistCurrentBoosts(Object atk, Object def);

  /// No description provided for @alchemistTodayCounter.
  ///
  /// In nl, this message translates to:
  /// **'Elixers vandaag gekocht: {count}/2'**
  String alchemistTodayCounter(Object count);

  /// No description provided for @innMenuGamble.
  ///
  /// In nl, this message translates to:
  /// **'Goktafel'**
  String get innMenuGamble;

  /// No description provided for @innMenuBartender.
  ///
  /// In nl, this message translates to:
  /// **'Barman Cedrik'**
  String get innMenuBartender;

  /// No description provided for @innMenuFlirt.
  ///
  /// In nl, this message translates to:
  /// **'Barmeisje Violet'**
  String get innMenuFlirt;

  /// No description provided for @innFlirtAttempt.
  ///
  /// In nl, this message translates to:
  /// **'Flirt met Violet (-1 Gem)'**
  String get innFlirtAttempt;

  /// No description provided for @innFlirtNoGems.
  ///
  /// In nl, this message translates to:
  /// **'Je hebt geen edelstenen om haar te schenken!'**
  String get innFlirtNoGems;

  /// No description provided for @innTalkCedrik.
  ///
  /// In nl, this message translates to:
  /// **'Praat met Cedrik'**
  String get innTalkCedrik;

  /// No description provided for @innMenuMain.
  ///
  /// In nl, this message translates to:
  /// **'De Huiskamer'**
  String get innMenuMain;

  /// No description provided for @innMenuSpy.
  ///
  /// In nl, this message translates to:
  /// **'Spioneer op Mensen'**
  String get innMenuSpy;

  /// No description provided for @innMenuNews.
  ///
  /// In nl, this message translates to:
  /// **'Lees Krant & Geruchten'**
  String get innMenuNews;

  /// No description provided for @innMenuBlackjack.
  ///
  /// In nl, this message translates to:
  /// **'Kaarttafel: Blackjack'**
  String get innMenuBlackjack;

  /// No description provided for @innSpySelect.
  ///
  /// In nl, this message translates to:
  /// **'Kies een doelwit om op te spioneren:'**
  String get innSpySelect;

  /// No description provided for @innSpyNoTargets.
  ///
  /// In nl, this message translates to:
  /// **'Er zijn momenteel geen andere reizigers in de herberg aanwezig.'**
  String get innSpyNoTargets;

  /// No description provided for @innNewsTitle.
  ///
  /// In nl, this message translates to:
  /// **'Herberg Geruchten & Laatste Nieuws'**
  String get innNewsTitle;

  /// No description provided for @innBlackjackTitle.
  ///
  /// In nl, this message translates to:
  /// **'Blackjack (Inzet: 50 Goud)'**
  String get innBlackjackTitle;

  /// No description provided for @innBlackjackHit.
  ///
  /// In nl, this message translates to:
  /// **'Kaart (Hit)'**
  String get innBlackjackHit;

  /// No description provided for @innBlackjackStand.
  ///
  /// In nl, this message translates to:
  /// **'Passen (Stand)'**
  String get innBlackjackStand;

  /// No description provided for @btnReturnCommon.
  ///
  /// In nl, this message translates to:
  /// **'Terug naar de Huiskamer'**
  String get btnReturnCommon;

  /// No description provided for @innBlackjackStart.
  ///
  /// In nl, this message translates to:
  /// **'START RONDE (50 GOUD)'**
  String get innBlackjackStart;

  /// No description provided for @innBlackjackHitBtn.
  ///
  /// In nl, this message translates to:
  /// **'KAART (HIT)'**
  String get innBlackjackHitBtn;

  /// No description provided for @innBlackjackStandBtn.
  ///
  /// In nl, this message translates to:
  /// **'PASSEN (STAND)'**
  String get innBlackjackStandBtn;

  /// No description provided for @innBlackjackCommonReturn.
  ///
  /// In nl, this message translates to:
  /// **'TERUG NAAR DE HUISKAMER'**
  String get innBlackjackCommonReturn;

  /// No description provided for @profileBiometricReason.
  ///
  /// In nl, this message translates to:
  /// **'Bevestig je identiteit om snel in te loggen bij LOGD'**
  String get profileBiometricReason;

  /// No description provided for @innBtnDrinkAle.
  ///
  /// In nl, this message translates to:
  /// **'Oaktaven Ale'**
  String get innBtnDrinkAle;

  /// No description provided for @innBtnDrinkDragon.
  ///
  /// In nl, this message translates to:
  /// **'Drakenbloed'**
  String get innBtnDrinkDragon;

  /// No description provided for @innBtnBardGold.
  ///
  /// In nl, this message translates to:
  /// **'Trakteer Goud'**
  String get innBtnBardGold;

  /// No description provided for @innBtnBardGem.
  ///
  /// In nl, this message translates to:
  /// **'Geef Gem'**
  String get innBtnBardGem;

  /// No description provided for @innBtnFlirt.
  ///
  /// In nl, this message translates to:
  /// **'Flirt (1 Beurt)'**
  String get innBtnFlirt;

  /// No description provided for @innBtnGift.
  ///
  /// In nl, this message translates to:
  /// **'Geschenk (1 Gem)'**
  String get innBtnGift;

  /// No description provided for @innBtnPropose.
  ///
  /// In nl, this message translates to:
  /// **'Vraag ten Huwelijk!'**
  String get innBtnPropose;

  /// No description provided for @innBtnGambleDice.
  ///
  /// In nl, this message translates to:
  /// **'Dobbelen'**
  String get innBtnGambleDice;

  /// No description provided for @innBtnGambleShell.
  ///
  /// In nl, this message translates to:
  /// **'Cupgame'**
  String get innBtnGambleShell;

  /// No description provided for @innBtnGambleBlackjack.
  ///
  /// In nl, this message translates to:
  /// **'Blackjack'**
  String get innBtnGambleBlackjack;

  /// No description provided for @innBtnBribe.
  ///
  /// In nl, this message translates to:
  /// **'Omkopen (1 Gem)'**
  String get innBtnBribe;

  /// No description provided for @innBtnBountyAction.
  ///
  /// In nl, this message translates to:
  /// **'BOUNTY'**
  String get innBtnBountyAction;

  /// No description provided for @innRomanceLabel.
  ///
  /// In nl, this message translates to:
  /// **'Toewijding: `p{points} / 100`w'**
  String innRomanceLabel(Object points);

  /// No description provided for @innBtnRichest.
  ///
  /// In nl, this message translates to:
  /// **'Vraag wie het rijkst is (50 G)'**
  String get innBtnRichest;

  /// No description provided for @innGambleShark.
  ///
  /// In nl, this message translates to:
  /// **'Kaarthaai:'**
  String get innGambleShark;

  /// No description provided for @innBtnHigher.
  ///
  /// In nl, this message translates to:
  /// **'Hoger'**
  String get innBtnHigher;

  /// No description provided for @innBtnLower.
  ///
  /// In nl, this message translates to:
  /// **'Lager'**
  String get innBtnLower;

  /// No description provided for @innMenuBard.
  ///
  /// In nl, this message translates to:
  /// **'De Bard'**
  String get innMenuBard;

  /// No description provided for @innMenuVeteran.
  ///
  /// In nl, this message translates to:
  /// **'Veteraan'**
  String get innMenuVeteran;

  /// No description provided for @innMenuBounty.
  ///
  /// In nl, this message translates to:
  /// **'Premiejager'**
  String get innMenuBounty;

  /// No description provided for @innMenuBuyDrink.
  ///
  /// In nl, this message translates to:
  /// **'KOOP DRANKJE (20 GOUD)'**
  String get innMenuBuyDrink;

  /// No description provided for @innDrinkSelectTitle.
  ///
  /// In nl, this message translates to:
  /// **'=== CEDRIKS ASSORTIMENT ==='**
  String get innDrinkSelectTitle;

  /// No description provided for @innDrinkSelectDesc.
  ///
  /// In nl, this message translates to:
  /// **'Cedrik poetst een glas en kijkt je aan: \"Wat kan ik inschenken, reiziger?\"'**
  String get innDrinkSelectDesc;

  /// No description provided for @innDrink1Name.
  ///
  /// In nl, this message translates to:
  /// **'DWERGEN STOUT'**
  String get innDrink1Name;

  /// No description provided for @innDrink1Desc.
  ///
  /// In nl, this message translates to:
  /// **'Een zwaar, donker bier. Geeft extra kracht maar maakt je slaperig. (+15 HP, -1 Beurt)'**
  String get innDrink1Desc;

  /// No description provided for @innDrink2Name.
  ///
  /// In nl, this message translates to:
  /// **'ELFENDRAM'**
  String get innDrink2Name;

  /// No description provided for @innDrink2Desc.
  ///
  /// In nl, this message translates to:
  /// **'Een zoete, mousserende honingwijn. Geeft je vernieuwde energie! (+2 Beurten)'**
  String get innDrink2Desc;

  /// No description provided for @labelHealCost.
  ///
  /// In nl, this message translates to:
  /// **'Kosten voor volledige genezing: `y{cost} goudstukken`w'**
  String labelHealCost(Object cost);

  /// No description provided for @graveyard_title.
  ///
  /// In nl, this message translates to:
  /// **'Het Kerkhof van Oaktaven (Onderwereld)'**
  String get graveyard_title;

  /// No description provided for @graveyard_status_dead.
  ///
  /// In nl, this message translates to:
  /// **'STATUS: DOOD (Geest)'**
  String get graveyard_status_dead;

  /// No description provided for @graveyard_favor_points.
  ///
  /// In nl, this message translates to:
  /// **'Gunst bij Ramius: {points} punten'**
  String graveyard_favor_points(Object points);

  /// No description provided for @graveyard_btn_fight.
  ///
  /// In nl, this message translates to:
  /// **'Vecht tegen Gekweld Sterrenbeeld (1 Beurt)'**
  String get graveyard_btn_fight;

  /// No description provided for @graveyard_btn_resurrect.
  ///
  /// In nl, this message translates to:
  /// **'Smeek Ramius om Genade'**
  String get graveyard_btn_resurrect;

  /// No description provided for @graveyard_btn_haunt.
  ///
  /// In nl, this message translates to:
  /// **'Plaag de Herberg (1 Beurt)'**
  String get graveyard_btn_haunt;

  /// No description provided for @graveyard_btn_talk.
  ///
  /// In nl, this message translates to:
  /// **'Praat met Ramius'**
  String get graveyard_btn_talk;

  /// No description provided for @ghost_combat_title.
  ///
  /// In nl, this message translates to:
  /// **'ONDERWERELD GEVECHT'**
  String get ghost_combat_title;

  /// No description provided for @ghost_combat_monster_label.
  ///
  /// In nl, this message translates to:
  /// **'Monster: {name} (LVL {level})'**
  String ghost_combat_monster_label(Object level, Object name);

  /// No description provided for @ghost_combat_hp_label.
  ///
  /// In nl, this message translates to:
  /// **'Monster HP: {current} / {max}'**
  String ghost_combat_hp_label(Object current, Object max);

  /// No description provided for @ghost_combat_btn_attack.
  ///
  /// In nl, this message translates to:
  /// **'AANVAL'**
  String get ghost_combat_btn_attack;

  /// No description provided for @ghost_combat_btn_return.
  ///
  /// In nl, this message translates to:
  /// **'TERUG NAAR KERKHOF'**
  String get ghost_combat_btn_return;

  /// No description provided for @inn_btn_leave.
  ///
  /// In nl, this message translates to:
  /// **'Verlaat de Herberg'**
  String get inn_btn_leave;

  /// No description provided for @inn_btn_talk_veteran.
  ///
  /// In nl, this message translates to:
  /// **'LUISTER NAAR VERHAAL'**
  String get inn_btn_talk_veteran;

  /// No description provided for @inn_section_title.
  ///
  /// In nl, this message translates to:
  /// **'=== {section} ==='**
  String inn_section_title(Object section);

  /// No description provided for @inn_section_barman.
  ///
  /// In nl, this message translates to:
  /// **'=== De Herberg Bar ==='**
  String get inn_section_barman;

  /// No description provided for @inn_section_gamble.
  ///
  /// In nl, this message translates to:
  /// **'=== De Goktafel ==='**
  String get inn_section_gamble;

  /// No description provided for @inn_section_veteran.
  ///
  /// In nl, this message translates to:
  /// **'=== De Oude Krijger ==='**
  String get inn_section_veteran;

  /// No description provided for @inn_section_bounty.
  ///
  /// In nl, this message translates to:
  /// **'=== De Premiejager ==='**
  String get inn_section_bounty;

  /// No description provided for @inn_section_spy.
  ///
  /// In nl, this message translates to:
  /// **'=== Schimmige Figuren ==='**
  String get inn_section_spy;

  /// No description provided for @inn_section_news.
  ///
  /// In nl, this message translates to:
  /// **'=== Het Stadsnieuws ==='**
  String get inn_section_news;

  /// No description provided for @town_btn_forest.
  ///
  /// In nl, this message translates to:
  /// **'Betreed het Bos'**
  String get town_btn_forest;

  /// No description provided for @town_btn_news.
  ///
  /// In nl, this message translates to:
  /// **'Dagelijks Nieuws'**
  String get town_btn_news;

  /// No description provided for @town_btn_shops.
  ///
  /// In nl, this message translates to:
  /// **'Winkelstraat'**
  String get town_btn_shops;

  /// No description provided for @town_btn_mystery.
  ///
  /// In nl, this message translates to:
  /// **'Geheime Plekken'**
  String get town_btn_mystery;

  /// No description provided for @town_btn_training.
  ///
  /// In nl, this message translates to:
  /// **'Binnenplaats & Training'**
  String get town_btn_training;

  /// No description provided for @town_btn_heart.
  ///
  /// In nl, this message translates to:
  /// **'Het Dorpshart'**
  String get town_btn_heart;

  /// No description provided for @town_sub_shops.
  ///
  /// In nl, this message translates to:
  /// **'Smederij'**
  String get town_sub_shops;

  /// No description provided for @town_sub_bank.
  ///
  /// In nl, this message translates to:
  /// **'De Bank'**
  String get town_sub_bank;

  /// No description provided for @town_sub_barber.
  ///
  /// In nl, this message translates to:
  /// **'Kapper'**
  String get town_sub_barber;

  /// No description provided for @town_sub_alchemist.
  ///
  /// In nl, this message translates to:
  /// **'Alchemist'**
  String get town_sub_alchemist;

  /// No description provided for @town_sub_healer.
  ///
  /// In nl, this message translates to:
  /// **'Kruidendokter'**
  String get town_sub_healer;

  /// No description provided for @town_sub_alley.
  ///
  /// In nl, this message translates to:
  /// **'Schaduwsteeg'**
  String get town_sub_alley;

  /// No description provided for @town_sub_classroom.
  ///
  /// In nl, this message translates to:
  /// **'Trainingsruimte'**
  String get town_sub_classroom;

  /// No description provided for @town_sub_stables.
  ///
  /// In nl, this message translates to:
  /// **'De Stables'**
  String get town_sub_stables;

  /// No description provided for @town_sub_inn.
  ///
  /// In nl, this message translates to:
  /// **'De Herberg'**
  String get town_sub_inn;

  /// No description provided for @town_sub_church.
  ///
  /// In nl, this message translates to:
  /// **'De Kerk'**
  String get town_sub_church;

  /// No description provided for @town_sub_wedding.
  ///
  /// In nl, this message translates to:
  /// **'Trouwkapel'**
  String get town_sub_wedding;

  /// No description provided for @town_sub_townfolk.
  ///
  /// In nl, this message translates to:
  /// **'Dorpsbewoners'**
  String get town_sub_townfolk;

  /// No description provided for @town_sub_mightye.
  ///
  /// In nl, this message translates to:
  /// **'Donor MightyE'**
  String get town_sub_mightye;

  /// No description provided for @inn_news_empty.
  ///
  /// In nl, this message translates to:
  /// **'Er is vandaag niets voorgevallen in het rijk...'**
  String get inn_news_empty;

  /// No description provided for @inn_spy_empty.
  ///
  /// In nl, this message translates to:
  /// **'Er zijn momenteel geen andere reizigers in de herberg...'**
  String get inn_spy_empty;

  /// No description provided for @inn_btn_spy_action.
  ///
  /// In nl, this message translates to:
  /// **'SPIONEER (10 GOUD)'**
  String get inn_btn_spy_action;

  /// No description provided for @inn_title.
  ///
  /// In nl, this message translates to:
  /// **'Herberg \'De Dronken Draak\''**
  String get inn_title;

  /// No description provided for @dragon_lair_title.
  ///
  /// In nl, this message translates to:
  /// **'Het Hol van de Groene Draak'**
  String get dragon_lair_title;

  /// No description provided for @dragonShrineTitle.
  ///
  /// In nl, this message translates to:
  /// **'Het Drakenheiligdom'**
  String get dragonShrineTitle;

  /// No description provided for @dragonShrinePoints.
  ///
  /// In nl, this message translates to:
  /// **'Draken Punten (DP): `y{amount}`w'**
  String dragonShrinePoints(Object amount);

  /// No description provided for @guestPlayerName.
  ///
  /// In nl, this message translates to:
  /// **'Gast Reiziger'**
  String get guestPlayerName;

  /// No description provided for @alleyBribeDefaultName.
  ///
  /// In nl, this message translates to:
  /// **'Een schimmige reiziger'**
  String get alleyBribeDefaultName;

  /// No description provided for @mightyEDefaultTitle.
  ///
  /// In nl, this message translates to:
  /// **'Donor'**
  String get mightyEDefaultTitle;

  /// No description provided for @defaultTravelerName.
  ///
  /// In nl, this message translates to:
  /// **'Reiziger'**
  String get defaultTravelerName;

  /// No description provided for @settingsSectionAccount.
  ///
  /// In nl, this message translates to:
  /// **'Karakter & Account'**
  String get settingsSectionAccount;

  /// No description provided for @settingsSectionLanguage.
  ///
  /// In nl, this message translates to:
  /// **'Taal & Voorkeuren'**
  String get settingsSectionLanguage;

  /// No description provided for @settingsSectionCommunity.
  ///
  /// In nl, this message translates to:
  /// **'Over LOGD & Community'**
  String get settingsSectionCommunity;

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In nl, this message translates to:
  /// **'Taalkeuze'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsLangDutch.
  ///
  /// In nl, this message translates to:
  /// **'Nederlands 🇳🇱'**
  String get settingsLangDutch;

  /// No description provided for @settingsLangEnglish.
  ///
  /// In nl, this message translates to:
  /// **'Engels 🇬🇧'**
  String get settingsLangEnglish;

  /// No description provided for @settingsAboutTitle.
  ///
  /// In nl, this message translates to:
  /// **'Over LOGD'**
  String get settingsAboutTitle;

  /// No description provided for @settingsAboutSubtitle.
  ///
  /// In nl, this message translates to:
  /// **'Lees het verhaal achter Legend of the Golden Dragon.'**
  String get settingsAboutSubtitle;

  /// No description provided for @settingsShareTitle.
  ///
  /// In nl, this message translates to:
  /// **'Deel App'**
  String get settingsShareTitle;

  /// No description provided for @settingsShareSubtitle.
  ///
  /// In nl, this message translates to:
  /// **'Nodig vrienden uit om lid te worden van het rijk.'**
  String get settingsShareSubtitle;

  /// No description provided for @settingsShareDialogTitle.
  ///
  /// In nl, this message translates to:
  /// **'Deel het Rijk'**
  String get settingsShareDialogTitle;

  /// No description provided for @settingsRateTitle.
  ///
  /// In nl, this message translates to:
  /// **'Beoordeel App'**
  String get settingsRateTitle;

  /// No description provided for @settingsRateSubtitle.
  ///
  /// In nl, this message translates to:
  /// **'Geef een 5-sterren beoordeling in de Play Store.'**
  String get settingsRateSubtitle;

  /// No description provided for @settingsRateDialogTitle.
  ///
  /// In nl, this message translates to:
  /// **'Beoordeel LOGD'**
  String get settingsRateDialogTitle;

  /// No description provided for @settingsFeedbackTitle.
  ///
  /// In nl, this message translates to:
  /// **'Feedback'**
  String get settingsFeedbackTitle;

  /// No description provided for @settingsFeedbackSubtitle.
  ///
  /// In nl, this message translates to:
  /// **'Stuur ideeën of bugrapporten naar de makers.'**
  String get settingsFeedbackSubtitle;

  /// No description provided for @settingsFeedbackDialogTitle.
  ///
  /// In nl, this message translates to:
  /// **'Stuur Feedback'**
  String get settingsFeedbackDialogTitle;

  /// No description provided for @settingsFeedbackHint.
  ///
  /// In nl, this message translates to:
  /// **'Typ hier je feedback...'**
  String get settingsFeedbackHint;

  /// No description provided for @settingsPrivacyTitle.
  ///
  /// In nl, this message translates to:
  /// **'Privacybeleid'**
  String get settingsPrivacyTitle;

  /// No description provided for @settingsPrivacySubtitle.
  ///
  /// In nl, this message translates to:
  /// **'Bekijk hoe we omgaan met je spelersdata.'**
  String get settingsPrivacySubtitle;

  /// No description provided for @settingsPrivacyDialogTitle.
  ///
  /// In nl, this message translates to:
  /// **'Privacybeleid'**
  String get settingsPrivacyDialogTitle;

  /// No description provided for @tutorialTitle.
  ///
  /// In nl, this message translates to:
  /// **'Hoe te Spelen'**
  String get tutorialTitle;

  /// No description provided for @tutorialStepProgress.
  ///
  /// In nl, this message translates to:
  /// **'Stap {current} van {total}'**
  String tutorialStepProgress(Object current, Object total);

  /// No description provided for @tutorialStep1Title.
  ///
  /// In nl, this message translates to:
  /// **'1. Dorpsplein & Gebouwen'**
  String get tutorialStep1Title;

  /// No description provided for @tutorialStep2Title.
  ///
  /// In nl, this message translates to:
  /// **'2. Het Bos & Gevechten'**
  String get tutorialStep2Title;

  /// No description provided for @tutorialStep3Title.
  ///
  /// In nl, this message translates to:
  /// **'3. Smederij & Uitrusting'**
  String get tutorialStep3Title;

  /// No description provided for @tutorialStep4Title.
  ///
  /// In nl, this message translates to:
  /// **'4. Trainingsruimte & Level-Ups'**
  String get tutorialStep4Title;

  /// No description provided for @tutorialStep5Title.
  ///
  /// In nl, this message translates to:
  /// **'5. Nieuwe Dag & De Draak'**
  String get tutorialStep5Title;

  /// No description provided for @settingsTutorialTitle.
  ///
  /// In nl, this message translates to:
  /// **'Hoe te Spelen (Handleiding)'**
  String get settingsTutorialTitle;

  /// No description provided for @settingsTutorialSubtitle.
  ///
  /// In nl, this message translates to:
  /// **'Bekijk de interactieve spelgids'**
  String get settingsTutorialSubtitle;

  /// No description provided for @globalChatTitle.
  ///
  /// In nl, this message translates to:
  /// **'Wereldchat'**
  String get globalChatTitle;

  /// No description provided for @directMessagesTitle.
  ///
  /// In nl, this message translates to:
  /// **'Privéberichten'**
  String get directMessagesTitle;

  /// No description provided for @arenaTitle.
  ///
  /// In nl, this message translates to:
  /// **'PvP Arena & Duels'**
  String get arenaTitle;

  /// No description provided for @innRentRoom.
  ///
  /// In nl, this message translates to:
  /// **'Huur Kamer (50 goud)'**
  String get innRentRoom;

  /// No description provided for @chatSendHint.
  ///
  /// In nl, this message translates to:
  /// **'Typ een bericht... (Scheldwoordenfilter actief)'**
  String get chatSendHint;

  /// No description provided for @arenaWagerPrompt.
  ///
  /// In nl, this message translates to:
  /// **'Inzet (Goud):'**
  String get arenaWagerPrompt;

  /// No description provided for @dmSelectRecipient.
  ///
  /// In nl, this message translates to:
  /// **'Selecteer Ontvanger'**
  String get dmSelectRecipient;

  /// No description provided for @dmNoConversations.
  ///
  /// In nl, this message translates to:
  /// **'Geen privéberichten gevonden. Tik op een speler in de Arena of Chat om een DM te starten.'**
  String get dmNoConversations;

  /// No description provided for @arenaNoOpponents.
  ///
  /// In nl, this message translates to:
  /// **'Geen andere reizigers gevonden in het rijk.'**
  String get arenaNoOpponents;

  /// No description provided for @arenaChallengeSent.
  ///
  /// In nl, this message translates to:
  /// **'Uitdaging verzonden!'**
  String get arenaChallengeSent;

  /// No description provided for @dialogGuardHaltTitle.
  ///
  /// In nl, this message translates to:
  /// **'HALT!'**
  String get dialogGuardHaltTitle;

  /// No description provided for @authErrorEmpty.
  ///
  /// In nl, this message translates to:
  /// **'Vul alle velden in!'**
  String get authErrorEmpty;

  /// No description provided for @authSuccessRegister.
  ///
  /// In nl, this message translates to:
  /// **'Karakter succesvol aangemaakt! Je kunt nu inloggen.'**
  String get authSuccessRegister;

  /// No description provided for @profileSuccessUpdate.
  ///
  /// In nl, this message translates to:
  /// **'`2Naam succesvol gewijzigd!`w'**
  String get profileSuccessUpdate;

  /// No description provided for @profileEmailSuccessUpdate.
  ///
  /// In nl, this message translates to:
  /// **'`2E-mail succesvol bijgewerkt!`w'**
  String get profileEmailSuccessUpdate;

  /// No description provided for @profileEmailError.
  ///
  /// In nl, this message translates to:
  /// **'`4Kan e-mailadres niet bijwerken.`w'**
  String get profileEmailError;

  /// No description provided for @bankSuccessDeposit.
  ///
  /// In nl, this message translates to:
  /// **'`2Je hebt {amount} goudstukken op je rekening gestort.`w'**
  String bankSuccessDeposit(Object amount);

  /// No description provided for @bankSuccessWithdraw.
  ///
  /// In nl, this message translates to:
  /// **'`2Je hebt {amount} goudstukken van je rekening opgenomen.`w'**
  String bankSuccessWithdraw(Object amount);

  /// No description provided for @bankErrorNoGoldOnHand.
  ///
  /// In nl, this message translates to:
  /// **'`4Je hebt niet zoveel goud bij je!`w'**
  String get bankErrorNoGoldOnHand;

  /// No description provided for @bankErrorNoGoldInBank.
  ///
  /// In nl, this message translates to:
  /// **'`4Zoveel goud staat er niet op je bankrekening!`w'**
  String get bankErrorNoGoldInBank;

  /// No description provided for @bankErrorInvalid.
  ///
  /// In nl, this message translates to:
  /// **'`4Voer een geldig bedrag in!`w'**
  String get bankErrorInvalid;

  /// No description provided for @smithySuccessBuy.
  ///
  /// In nl, this message translates to:
  /// **'`2Je hebt met succes geüpgraded naar: {name}!`w'**
  String smithySuccessBuy(Object name);

  /// No description provided for @alchemistSuccessBuy.
  ///
  /// In nl, this message translates to:
  /// **'`2Je drinkt het elixir op. Een intense energie stroomt direct door je lichaam! Je hebt {boost} ontvangen.`w'**
  String alchemistSuccessBuy(Object boost);

  /// No description provided for @stablesSuccessBuy.
  ///
  /// In nl, this message translates to:
  /// **'`2Je hebt succesvol een {mount} gekocht! De stalmeester brengt je nieuwe metgezel naar buiten.`w'**
  String stablesSuccessBuy(Object mount);

  /// No description provided for @profilePasswordSuccessUpdate.
  ///
  /// In nl, this message translates to:
  /// **'`2Wachtwoord succesvol gewijzigd!`w'**
  String get profilePasswordSuccessUpdate;

  /// No description provided for @profilePasswordErrorEmpty.
  ///
  /// In nl, this message translates to:
  /// **'`4Voer een nieuw wachtwoord in!`w'**
  String get profilePasswordErrorEmpty;

  /// No description provided for @profilePasswordError.
  ///
  /// In nl, this message translates to:
  /// **'`4Kan wachtwoord niet wijzigen.`w'**
  String get profilePasswordError;

  /// No description provided for @settingsFeedbackSent.
  ///
  /// In nl, this message translates to:
  /// **'`2Bedankt! Je feedback is in goede orde ontvangen.`w'**
  String get settingsFeedbackSent;

  /// No description provided for @profileBiometricDeviceError.
  ///
  /// In nl, this message translates to:
  /// **'Dit apparaat ondersteunt geen biometrie.'**
  String get profileBiometricDeviceError;

  /// No description provided for @profileBiometricAuthError.
  ///
  /// In nl, this message translates to:
  /// **'Verificatie mislukt.'**
  String get profileBiometricAuthError;

  /// No description provided for @profileDatabaseError.
  ///
  /// In nl, this message translates to:
  /// **'Er is een fout opgetreden.'**
  String get profileDatabaseError;

  /// No description provided for @errorNoGems.
  ///
  /// In nl, this message translates to:
  /// **'Je hebt niet genoeg glimmende edelstenen!'**
  String get errorNoGems;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'nl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'nl':
      return AppLocalizationsNl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
