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

  /// No description provided for @enemyDefeated.
  ///
  /// In nl, this message translates to:
  /// **'`2Je hebt de {enemy} verslagen! `w\nJe verdient `y{gold} goud `wen `c{xp} ervaring`w!'**
  String enemyDefeated(Object enemy, Object gold, Object xp);

  /// No description provided for @playerDied.
  ///
  /// In nl, this message translates to:
  /// **'`4Je bent bezweken aan je verwondingen door de {enemy}... Je bent DOOD! `w\nJe verliest al het goud op zak.'**
  String playerDied(Object enemy);

  /// No description provided for @roundContinue.
  ///
  /// In nl, this message translates to:
  /// **'`2Je valt aan en doet {damageDealt} schade bij de {enemy}.`w(\nDe {enemy} {attackText}) en doet `4{damageReceived} schade`w terug!'**
  String roundContinue(
    Object attackText,
    Object damageDealt,
    Object damageReceived,
    Object enemy,
  );

  /// No description provided for @fleeSuccess.
  ///
  /// In nl, this message translates to:
  /// **'`gJe rent hard weg en ontsnapt veilig aan de {enemy}!`w'**
  String fleeSuccess(Object enemy);

  /// No description provided for @fleeFailed.
  ///
  /// In nl, this message translates to:
  /// **'`4Vluchten mislukt! De {enemy} blokkeert je weg en doet {damage} schade tijdens je vluchtpoging!`w'**
  String fleeFailed(Object damage, Object enemy);

  /// No description provided for @townSquareWelcome.
  ///
  /// In nl, this message translates to:
  /// **'`gWelkom op het Dorpsplein van `yLord of the Golden Dragon`w!\n\nDe zon schijnt over het rijk. Reizigers praten in de schazuw, en in de verte hoor je het gebrul uit het bos... Wat ga je vandaag doen?`w'**
  String get townSquareWelcome;

  /// No description provided for @btnGoToForest.
  ///
  /// In nl, this message translates to:
  /// **'Ga het bos in'**
  String get btnGoToForest;

  /// No description provided for @forestSearching.
  ///
  /// In nl, this message translates to:
  /// **'`gJe sluipt voorzichtig door het dichte struikgewas op zoek naar gevaar...`w'**
  String get forestSearching;

  /// No description provided for @btnAttack.
  ///
  /// In nl, this message translates to:
  /// **'Aanvallen'**
  String get btnAttack;

  /// No description provided for @btnFlee.
  ///
  /// In nl, this message translates to:
  /// **'Vluchten'**
  String get btnFlee;

  /// No description provided for @btnReturnTown.
  ///
  /// In nl, this message translates to:
  /// **'Terug naar het dorp'**
  String get btnReturnTown;

  /// No description provided for @enemyHpLabel.
  ///
  /// In nl, this message translates to:
  /// **'{enemy} HP: {current}/{max}'**
  String enemyHpLabel(Object current, Object enemy, Object max);

  /// No description provided for @combatEncounterStart.
  ///
  /// In nl, this message translates to:
  /// **'`wJe komt oog in oog te staan met een {enemy}!\n\n`w'**
  String combatEncounterStart(Object enemy);

  /// No description provided for @forestNoTurns.
  ///
  /// In nl, this message translates to:
  /// **'`4Je hebt geen beurten meer over voor vandaag!`w'**
  String get forestNoTurns;

  /// No description provided for @fleeFailedDeathSuffix.
  ///
  /// In nl, this message translates to:
  /// **'\n`4Je bent bezweken aan je verwondingen... Je bent DOOD!`w'**
  String get fleeFailedDeathSuffix;

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
  /// **'Karakternaam (Alleen bij registratie)'**
  String get authUsername;

  /// No description provided for @btnLogin.
  ///
  /// In nl, this message translates to:
  /// **'Inloggen'**
  String get btnLogin;

  /// No description provided for @btnRegister.
  ///
  /// In nl, this message translates to:
  /// **'Karakter aanmaken'**
  String get btnRegister;

  /// No description provided for @authSwitchToRegister.
  ///
  /// In nl, this message translates to:
  /// **'Nieuw hier? Maak een karakter aan'**
  String get authSwitchToRegister;

  /// No description provided for @authSwitchToLogin.
  ///
  /// In nl, this message translates to:
  /// **'Heb je al een karakter? Log hier in'**
  String get authSwitchToLogin;

  /// No description provided for @authGuestLogin.
  ///
  /// In nl, this message translates to:
  /// **'Inloggen als gast'**
  String get authGuestLogin;

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

  /// No description provided for @statXp.
  ///
  /// In nl, this message translates to:
  /// **'XP: {amount}'**
  String statXp(Object amount);

  /// No description provided for @profileTitle.
  ///
  /// In nl, this message translates to:
  /// **'Karakter Instellingen'**
  String get profileTitle;

  /// No description provided for @profileChangeName.
  ///
  /// In nl, this message translates to:
  /// **'Karakternaam wijzigen'**
  String get profileChangeName;

  /// No description provided for @profileDeleteAccount.
  ///
  /// In nl, this message translates to:
  /// **'Karakter definitief wissen'**
  String get profileDeleteAccount;

  /// No description provided for @profileDeleteWarning.
  ///
  /// In nl, this message translates to:
  /// **'Weet je het zeker? Dit wist al je goud, levels en XP permanent!'**
  String get profileDeleteWarning;

  /// No description provided for @profileLogout.
  ///
  /// In nl, this message translates to:
  /// **'Verlaat het rijk (Uitloggen)'**
  String get profileLogout;

  /// No description provided for @profileBiometricToggle.
  ///
  /// In nl, this message translates to:
  /// **'Biometrisch inloggen (Vingerafdruk/FaceID)'**
  String get profileBiometricToggle;

  /// No description provided for @profileSuccessUpdate.
  ///
  /// In nl, this message translates to:
  /// **'`2Naam succesvol gewijzigd!`w'**
  String get profileSuccessUpdate;

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

  /// No description provided for @bankTitle.
  ///
  /// In nl, this message translates to:
  /// **'De Centrale Bank van het Rijk'**
  String get bankTitle;

  /// No description provided for @bankWelcome.
  ///
  /// In nl, this message translates to:
  /// **'`gJe loopt het statige gebouw van de bank binnen. Een dwerg achter de balie kijkt je streng aan door zijn bril.`w\n\n\"Welkom reiziger. Hier kun je je goud veilig stallen voor het geval je de monsters in het bos onderschat. Wat wil je doen?\"'**
  String get bankWelcome;

  /// No description provided for @bankInBank.
  ///
  /// In nl, this message translates to:
  /// **'Goud op de bank: `y{amount} goudstukken`w'**
  String bankInBank(Object amount);

  /// No description provided for @bankOnHand.
  ///
  /// In nl, this message translates to:
  /// **'Goud op zak: `y{amount} goudstukken`w'**
  String bankOnHand(Object amount);

  /// No description provided for @btnDepositAll.
  ///
  /// In nl, this message translates to:
  /// **'Alles storten'**
  String get btnDepositAll;

  /// No description provided for @btnWithdrawAll.
  ///
  /// In nl, this message translates to:
  /// **'Alles opnemen'**
  String get btnWithdrawAll;

  /// No description provided for @btnDepositCustom.
  ///
  /// In nl, this message translates to:
  /// **'Bedrag storten'**
  String get btnDepositCustom;

  /// No description provided for @btnWithdrawCustom.
  ///
  /// In nl, this message translates to:
  /// **'Bedrag opnemen'**
  String get btnWithdrawCustom;

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
  /// **'`4Je hebt niet zoveel goud op zak!`w'**
  String get bankErrorNoGoldOnHand;

  /// No description provided for @bankErrorNoGoldInBank.
  ///
  /// In nl, this message translates to:
  /// **'`4Zoveel goud staat er niet op je bankrekening!`w'**
  String get bankErrorNoGoldInBank;

  /// No description provided for @bankErrorInvalid.
  ///
  /// In nl, this message translates to:
  /// **'`4Vul een geldig aantal in!`w'**
  String get bankErrorInvalid;

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
  /// **'Daglimiet over: `c{amount} goud`w'**
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

  /// No description provided for @raceWelcome.
  ///
  /// In nl, this message translates to:
  /// **'`gVoordat je het rijk betreedt, moet je bepalen uit welk hout je gesneden bent. Kies zorgvuldig, reiziger...`w'**
  String get raceWelcome;

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
  /// **'Robuust en dol op goud. Start met `y+100 extra startgoud`w.'**
  String get raceDwarfDesc;

  /// No description provided for @raceOrc.
  ///
  /// In nl, this message translates to:
  /// **'Orc'**
  String get raceOrc;

  /// No description provided for @raceOrcDesc.
  ///
  /// In nl, this message translates to:
  /// **'Brutaal en ijzersterk. Start met `r+5 maximale HP`w.'**
  String get raceOrcDesc;

  /// No description provided for @btnConfirmRace.
  ///
  /// In nl, this message translates to:
  /// **'Bevestig keuze en start avontuur'**
  String get btnConfirmRace;

  /// No description provided for @specialtyTitle.
  ///
  /// In nl, this message translates to:
  /// **'Kies je Specialisatie'**
  String get specialtyTitle;

  /// No description provided for @specialtyWelcome.
  ///
  /// In nl, this message translates to:
  /// **'`gElke reiziger in het rijk blinkt ergens anders in uit. Kies het pad dat bij jouw vechtstijl past...`w'**
  String get specialtyWelcome;

  /// No description provided for @specMagic.
  ///
  /// In nl, this message translates to:
  /// **'Mystieke Krachten (Magic)'**
  String get specMagic;

  /// No description provided for @specMagicDesc.
  ///
  /// In nl, this message translates to:
  /// **'Meester van de elementen. Start met de spreuk `cRegeneratie`w om jezelf te genezen in gevechten.'**
  String get specMagicDesc;

  /// No description provided for @specThieving.
  ///
  /// In nl, this message translates to:
  /// **'Diefstal (Thieving)'**
  String get specThieving;

  /// No description provided for @specThievingDesc.
  ///
  /// In nl, this message translates to:
  /// **'Snel en sluw. Start met de vaardigheid `yZakkenrollen`w om extra goud uit monsters te kloppen.'**
  String get specThievingDesc;

  /// No description provided for @specWarrior.
  ///
  /// In nl, this message translates to:
  /// **'Krijger (Warrior)'**
  String get specWarrior;

  /// No description provided for @specWarriorDesc.
  ///
  /// In nl, this message translates to:
  /// **'Brute kracht en staal. Start met de vaardigheid `rSchildbeuk`w voor extra zware klappen.'**
  String get specWarriorDesc;

  /// No description provided for @btnConfirmSpecialty.
  ///
  /// In nl, this message translates to:
  /// **'Kies klasse en betreed het Dorpsplein'**
  String get btnConfirmSpecialty;

  /// No description provided for @trainingDuelTitle.
  ///
  /// In nl, this message translates to:
  /// **'=== DUEL MET {name} ==='**
  String trainingDuelTitle(Object name);

  /// No description provided for @trainingMasterHp.
  ///
  /// In nl, this message translates to:
  /// **'MEESTER HP: `4{current} / {max}`w'**
  String trainingMasterHp(Object current, Object max);

  /// No description provided for @trainingMasterAttack.
  ///
  /// In nl, this message translates to:
  /// **'haalt uit met een houten oefenzwaard'**
  String get trainingMasterAttack;

  /// No description provided for @trainingPlayerAttackLog.
  ///
  /// In nl, this message translates to:
  /// **'`2Je raakt de Meester voor {damage} schade.`w'**
  String trainingPlayerAttackLog(Object damage);

  /// No description provided for @trainingMasterAttackLog.
  ///
  /// In nl, this message translates to:
  /// **'\n{name} {attack} en doet `4{damage} schade`w terug!'**
  String trainingMasterAttackLog(Object attack, Object damage, Object name);

  /// No description provided for @trainingXpLabel.
  ///
  /// In nl, this message translates to:
  /// **'Ervaring (XP): `c{current} / {needed}`w'**
  String trainingXpLabel(Object current, Object needed);

  /// No description provided for @btnUseSkill.
  ///
  /// In nl, this message translates to:
  /// **'Vaardigheid'**
  String get btnUseSkill;

  /// No description provided for @skillAlreadyUsed.
  ///
  /// In nl, this message translates to:
  /// **'`4Je hebt je speciale vaardigheid al gebruikt in dit gevecht!`w'**
  String get skillAlreadyUsed;

  /// No description provided for @skillMagicSuccess.
  ///
  /// In nl, this message translates to:
  /// **'`cJe spreekt de spreuk Regeneratie uit! Een mystiek licht omringt je en geneest {amount} HP.`w'**
  String skillMagicSuccess(Object amount);

  /// No description provided for @skillThievingSuccess.
  ///
  /// In nl, this message translates to:
  /// **'`yJe gebruikt je Zakkenrollen vaardigheid tijdens de aanval en slaat {amount} extra goudstukken uit de {enemy}!`w'**
  String skillThievingSuccess(Object amount, Object enemy);

  /// No description provided for @skillWarriorSuccess.
  ///
  /// In nl, this message translates to:
  /// **'`rJe voert een brute Schildbeuk uit! Je beukt vol in op de {enemy} en doet {amount} GEGARANDEERDE schade!`w(\nDe {enemy}) is wankel!'**
  String skillWarriorSuccess(Object amount, Object enemy);

  /// No description provided for @smithyTitle.
  ///
  /// In nl, this message translates to:
  /// **'De Markt van Oaktaven'**
  String get smithyTitle;

  /// No description provided for @smithyWelcome.
  ///
  /// In nl, this message translates to:
  /// **'`gJe loopt de levendige markt op. Aan de linkerkant zie je de rokende smidse van Pegasus, aan de rechterkant de elegante boetiek van Merilon.`w'**
  String get smithyWelcome;

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
  /// **'Kosten: `y{cost} goudstukken`w (inruilwaarde verwerkt)'**
  String smithyCostLabel(Object cost);

  /// No description provided for @btnBuyUpgrade.
  ///
  /// In nl, this message translates to:
  /// **'Koop Upgrade'**
  String get btnBuyUpgrade;

  /// No description provided for @smithyMaxLevel.
  ///
  /// In nl, this message translates to:
  /// **'`gJe hebt de allerbeste uitrusting van het rijk al in bezit!`w'**
  String get smithyMaxLevel;

  /// No description provided for @smithySuccessBuy.
  ///
  /// In nl, this message translates to:
  /// **'`2Je hebt succesvol geüpgrade naar: {name}!`w'**
  String smithySuccessBuy(Object name);

  /// No description provided for @smithyErrorNoGold.
  ///
  /// In nl, this message translates to:
  /// **'`4De smid lacht je uit: \"Je hebt niet genoeg goudstukken op zak!\"`w'**
  String get smithyErrorNoGold;

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

  /// No description provided for @smithyAmountLabel.
  ///
  /// In nl, this message translates to:
  /// **'Aantal goudstukken'**
  String get smithyAmountLabel;

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
  /// **'IJzeren Korte Zwaard'**
  String get wep4;

  /// No description provided for @wep5.
  ///
  /// In nl, this message translates to:
  /// **'Stalen Slagzwaard'**
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
  /// **'Duivenseis (Mace)'**
  String get wep10;

  /// No description provided for @wep11.
  ///
  /// In nl, this message translates to:
  /// **'Glanzende Klabat'**
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
  /// **'Geklonken Leren Harnas'**
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
  /// **'Bandenpantser'**
  String get arm7;

  /// No description provided for @arm8.
  ///
  /// In nl, this message translates to:
  /// **'Elfen Borstplaat'**
  String get arm8;

  /// No description provided for @arm9.
  ///
  /// In nl, this message translates to:
  /// **'Geciseleerd Brons Pantser'**
  String get arm9;

  /// No description provided for @arm10.
  ///
  /// In nl, this message translates to:
  /// **'Ridderlijk Platenpantser'**
  String get arm10;

  /// No description provided for @arm11.
  ///
  /// In nl, this message translates to:
  /// **'Runenbescherming'**
  String get arm11;

  /// No description provided for @arm12.
  ///
  /// In nl, this message translates to:
  /// **'Obsidiaan Schild & Pantser'**
  String get arm12;

  /// No description provided for @arm13.
  ///
  /// In nl, this message translates to:
  /// **'Schilden van Drakenhuid'**
  String get arm13;

  /// No description provided for @arm14.
  ///
  /// In nl, this message translates to:
  /// **'Paladijn Kuras'**
  String get arm14;

  /// No description provided for @arm15.
  ///
  /// In nl, this message translates to:
  /// **'Het Godenpantser'**
  String get arm15;

  /// No description provided for @trainingTitle.
  ///
  /// In nl, this message translates to:
  /// **'De Trainingsruimte van de Meesters'**
  String get trainingTitle;

  /// No description provided for @trainingWelcome.
  ///
  /// In nl, this message translates to:
  /// **'`gJe stapt de serene, naar wierook ruikende trainingsruimte binnen. Je Meester staat met gekruiste armen in het midden van de mat.`w\n\n\"Welkom, reiziger. Ik zie dat je hebt gevochten in het bos. Maar ben je echt klaar voor de volgende stap?\"'**
  String get trainingWelcome;

  /// No description provided for @trainingStatusReq.
  ///
  /// In nl, this message translates to:
  /// **'Vereiste XP voor Level {nextLvl}: `c{reqXp} XP`w (Huidig: `c{currentXp} XP`w)'**
  String trainingStatusReq(Object currentXp, Object nextLvl, Object reqXp);

  /// No description provided for @trainingReady.
  ///
  /// In nl, this message translates to:
  /// **'`2Je bent klaar om te vechten voor je volgende level!`w'**
  String get trainingReady;

  /// No description provided for @trainingNotReady.
  ///
  /// In nl, this message translates to:
  /// **'`4Je hebt nog niet genoeg ervaring verdient om mij uit te dagen. Train harder in het bos!`w'**
  String get trainingNotReady;

  /// No description provided for @btnChallengeMaster.
  ///
  /// In nl, this message translates to:
  /// **'Daag de Meester uit'**
  String get btnChallengeMaster;

  /// No description provided for @trainingVictory.
  ///
  /// In nl, this message translates to:
  /// **'`2Gefeliciteerd! Je hebt je Meester verslagen en stijgt naar Level {lvl}! Je maximale HP is permanent verhoogd naar {maxHp}.`w'**
  String trainingVictory(Object lvl, Object maxHp);

  /// No description provided for @trainingDefeat.
  ///
  /// In nl, this message translates to:
  /// **'`4Je Meester slaat je met een houten trainingszwaard verrot op de mat: \"Je bent er nog niet klaar voor, leerling!\" Je overleeft het net, maar je HP staat op 1.`w'**
  String get trainingDefeat;

  /// No description provided for @master0.
  ///
  /// In nl, this message translates to:
  /// **'Meester Jon'**
  String get master0;

  /// No description provided for @master1.
  ///
  /// In nl, this message translates to:
  /// **'Meester Gibson'**
  String get master1;

  /// No description provided for @master2.
  ///
  /// In nl, this message translates to:
  /// **'Meesteres Olivia'**
  String get master2;

  /// No description provided for @master3.
  ///
  /// In nl, this message translates to:
  /// **'Meester Drake'**
  String get master3;

  /// No description provided for @btnVisitTraining.
  ///
  /// In nl, this message translates to:
  /// **'Trainingsruimte'**
  String get btnVisitTraining;

  /// No description provided for @eventFountainTitle.
  ///
  /// In nl, this message translates to:
  /// **'De Oude Waterbron'**
  String get eventFountainTitle;

  /// No description provided for @eventFountainDesc.
  ///
  /// In nl, this message translates to:
  /// **'`gJe struikelt over een overgroeide, vervallen waterbron bedekt met mos. In het kristalheldere water op de bodem zie je iets glinsteren...`w\n\nWat doe je?'**
  String get eventFountainDesc;

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

  /// No description provided for @eventFountainSuccess.
  ///
  /// In nl, this message translates to:
  /// **'`2Je springt in het koude water en graait op de bodem. Je komt boven met een handvol van {amount} oude goudstukken!`w'**
  String eventFountainSuccess(Object amount);

  /// No description provided for @eventFountainFail.
  ///
  /// In nl, this message translates to:
  /// **'`4Plons! Je springt mis, stoot je knie keihard tegen een scherpe rots en verliest {amount} HP. Het glinsterende object bleek een waardeloos stuk glas te zijn...`w'**
  String eventFountainFail(Object amount);

  /// No description provided for @eventFountainLeaveLog.
  ///
  /// In nl, this message translates to:
  /// **'`wJe vertrouwt het niet en loopt voorzichtig verder door het struikgewas.`w'**
  String get eventFountainLeaveLog;

  /// No description provided for @eventGiantTitle.
  ///
  /// In nl, this message translates to:
  /// **'De Slapende Reus'**
  String get eventGiantTitle;

  /// No description provided for @eventGiantDesc.
  ///
  /// In nl, this message translates to:
  /// **'`gVoor je op het pad ligt een gigantische bosreus luidruchtig te ronken. De grond trilt bij elke snurk. Om zijn nek hangt een leren buidel...`w\n\nWat doe je?'**
  String get eventGiantDesc;

  /// No description provided for @btnEventGiantSneak.
  ///
  /// In nl, this message translates to:
  /// **'Sluip erlangs'**
  String get btnEventGiantSneak;

  /// No description provided for @btnEventGiantSteal.
  ///
  /// In nl, this message translates to:
  /// **'Probeer te bestelen'**
  String get btnEventGiantSteal;

  /// No description provided for @eventGiantSneakSuccess.
  ///
  /// In nl, this message translates to:
  /// **'`2Je houdt je adem in en sluipt op je tenen langs de reus. Deze behoedzame actie levert je {amount} ervaring (XP) op!`w'**
  String eventGiantSneakSuccess(Object amount);

  /// No description provided for @eventGiantStealSuccess.
  ///
  /// In nl, this message translates to:
  /// **'`yMet fluwelen vingers snijd je de buidel los. Je steelt {amount} goudstukken en 1 edelsteen (Gem) zonder dat hij wakker wordt!`w'**
  String eventGiantStealSuccess(Object amount);

  /// No description provided for @eventGiantStealFail.
  ///
  /// In nl, this message translates to:
  /// **'`4Kraak! Je trapt op een takje. De reus opent een bloeddoorlopen oog, brult woedend en geeft je een harde klap! Je verliest {amount} HP voordat je doodsbang wegrent!`w'**
  String eventGiantStealFail(Object amount);

  /// No description provided for @skillThievingName.
  ///
  /// In nl, this message translates to:
  /// **'Zakkenrollen'**
  String get skillThievingName;

  /// No description provided for @skillWarriorName.
  ///
  /// In nl, this message translates to:
  /// **'Schildbeuk'**
  String get skillWarriorName;

  /// No description provided for @skillMagicName.
  ///
  /// In nl, this message translates to:
  /// **'Regeneratie'**
  String get skillMagicName;

  /// No description provided for @forestTitle.
  ///
  /// In nl, this message translates to:
  /// **'Het Donkere Bos'**
  String get forestTitle;

  /// No description provided for @smithyTabWeapons.
  ///
  /// In nl, this message translates to:
  /// **'Wapens'**
  String get smithyTabWeapons;

  /// No description provided for @smithyTabArmor.
  ///
  /// In nl, this message translates to:
  /// **'Pantsers'**
  String get smithyTabArmor;

  /// No description provided for @smithyErrorUnknown.
  ///
  /// In nl, this message translates to:
  /// **'`4Er is een onbekende fout opgetreden.`w'**
  String get smithyErrorUnknown;

  /// No description provided for @graveyardTitle.
  ///
  /// In nl, this message translates to:
  /// **'De Schimmige Begraafplaats'**
  String get graveyardTitle;

  /// No description provided for @graveyardWelcome.
  ///
  /// In nl, this message translates to:
  /// **'`4Je bent gestorven!`w\n\n`gDe ijzige mist trekt op en je staat oog in oog met Magere Hein. Zijn holle ogen staren diep in je ziel. Een zware stem galmt door de stilte:`w\n\n\"Je tijd is gekomen, sterveling. Maar ik ben in een gulle bui... Als je mij een kostbare Edelsteen schenkt of een deel van je Ervaring opoffert, geef ik je je sterfelijke lichaam direct terug. Wat kies je?\"'**
  String get graveyardWelcome;

  /// No description provided for @btnGraveyardOfferGem.
  ///
  /// In nl, this message translates to:
  /// **'Offer 1 Edelsteen (Gem)'**
  String get btnGraveyardOfferGem;

  /// No description provided for @btnGraveyardOfferXp.
  ///
  /// In nl, this message translates to:
  /// **'Offer 100 XP'**
  String get btnGraveyardOfferXp;

  /// No description provided for @btnGraveyardAcceptLot.
  ///
  /// In nl, this message translates to:
  /// **'Accepteer je lot (Wacht tot morgen)'**
  String get btnGraveyardAcceptLot;

  /// No description provided for @graveyardSuccessResurrect.
  ///
  /// In nl, this message translates to:
  /// **'`2Magere Hein lacht angstaanjagend. Een warm licht stroomt door je aderen... Je bent herrezen en mag het Dorpsplein weer betreden!`w'**
  String get graveyardSuccessResurrect;

  /// No description provided for @graveyardErrorNoGem.
  ///
  /// In nl, this message translates to:
  /// **'`4Je hebt geen glimmende edelstenen op zak! Hein rammelt ongeduldig met zijn zeis.`w'**
  String get graveyardErrorNoGem;

  /// No description provided for @graveyardErrorNoXp.
  ///
  /// In nl, this message translates to:
  /// **'`4Je hebt niet eens genoeg ervaring om op te offeren! Hein schudt zijn hoofd.`w'**
  String get graveyardErrorNoXp;

  /// No description provided for @graveyardWaitMessage.
  ///
  /// In nl, this message translates to:
  /// **'`gJe dwaalt rustig rond tussen de grafstenen en wacht op de nieuwe dag...`w'**
  String get graveyardWaitMessage;

  /// No description provided for @newsTitle.
  ///
  /// In nl, this message translates to:
  /// **'Het Dagelijks Nieuws van het Rijk'**
  String get newsTitle;

  /// No description provided for @newsWelcome.
  ///
  /// In nl, this message translates to:
  /// **'`gJe loopt naar het houten mededelingenbord in het midden van het plein. Er hangen een paar vers perkamenten vellen die door de wind zachtjes klapperen.`w\n\n\"Hoor en zegt het voort! Dit is wat er vandaag in ons rijk is voorgevallen:\"'**
  String get newsWelcome;

  /// No description provided for @newsEmpty.
  ///
  /// In nl, this message translates to:
  /// **'`wHet mededelingenbord is momenteel leeg. Het is een rustige dag in het rijk...`w'**
  String get newsEmpty;

  /// No description provided for @newsLogDefeated.
  ///
  /// In nl, this message translates to:
  /// **'{user} is in het bos op brute wijze afgeslacht door een {enemy}!'**
  String newsLogDefeated(Object enemy, Object user);

  /// No description provided for @newsLogDefeatedBrutal.
  ///
  /// In nl, this message translates to:
  /// **'{user} dacht een held te zijn, maar werd door een {enemy} als ontbijt genuttigd!'**
  String newsLogDefeatedBrutal(Object enemy, Object user);

  /// No description provided for @newsLogLevelUp.
  ///
  /// In nl, this message translates to:
  /// **'{user} is gestegen naar Level {level} na een legendarisch duel in de trainingsruimte!'**
  String newsLogLevelUp(Object level, Object user);

  /// No description provided for @newsLogMarriage.
  ///
  /// In nl, this message translates to:
  /// **'Groot feest! {user} is vandaag in het huwelijksbootje gestapt met {partner}!'**
  String newsLogMarriage(Object partner, Object user);

  /// No description provided for @rankingsTitle.
  ///
  /// In nl, this message translates to:
  /// **'De Hall of Fame'**
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
  /// **'De Dorpsomroeper'**
  String get townCrierTitle;

  /// No description provided for @townCrierPrefix.
  ///
  /// In nl, this message translates to:
  /// **'`4HOREN, ZIEN EN ZEGT HET VOORT! `w'**
  String get townCrierPrefix;

  /// No description provided for @statDk.
  ///
  /// In nl, this message translates to:
  /// **'DK: {amount}'**
  String statDk(Object amount);

  /// No description provided for @btnVisitNews.
  ///
  /// In nl, this message translates to:
  /// **'Dagelijks Nieuws'**
  String get btnVisitNews;

  /// No description provided for @newsUnknownPlayer.
  ///
  /// In nl, this message translates to:
  /// **'Onbekende Reiziger'**
  String get newsUnknownPlayer;

  /// No description provided for @newsUnknownEnemy.
  ///
  /// In nl, this message translates to:
  /// **'een monster'**
  String get newsUnknownEnemy;

  /// No description provided for @newsUnknownPartner.
  ///
  /// In nl, this message translates to:
  /// **'iemand'**
  String get newsUnknownPartner;

  /// No description provided for @defaultUsername.
  ///
  /// In nl, this message translates to:
  /// **'Reiziger'**
  String get defaultUsername;

  /// No description provided for @devTitle.
  ///
  /// In nl, this message translates to:
  /// **'=== GOD MODUS: DEV MENU ==='**
  String get devTitle;

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
  /// **'Geef +5 Edelstenen'**
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

  /// No description provided for @devSuccessMessage.
  ///
  /// In nl, this message translates to:
  /// **'`p[DEV] Stat succesvol aangepast in de cloud!`w'**
  String get devSuccessMessage;

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
  /// **'Klik op een monster hieronder om direct een gevecht in het bos te forceren en de balans te controleren:'**
  String get devSpawnMonsterDesc;

  /// No description provided for @innTitle.
  ///
  /// In nl, this message translates to:
  /// **'Herberg \'De Dronken Draak\''**
  String get innTitle;

  /// No description provided for @innWelcome.
  ///
  /// In nl, this message translates to:
  /// **'`gJe stapt de rumoerige herberg binnen. De geur van gebraden vlees en stevig bier komt je tegemoet. In de hoek zingt een bard een vals retro-lied, terwijl reizigers luidruchtig met dobbelstenen gooien.`w\n\n\"Welkom, vreemdeling!\" roept de herbergier terwijl hij een grote pul schoonmaakt. \"Schuif gezellig aansluiten bij de goktafel, of drink een slok!\"'**
  String get innWelcome;

  /// No description provided for @innDiceTitle.
  ///
  /// In nl, this message translates to:
  /// **'=== DE GOKTAFEL ==='**
  String get innDiceTitle;

  /// No description provided for @innDiceDesc.
  ///
  /// In nl, this message translates to:
  /// **'Zet goud in om te dobbelen tegen de kroegbazen. Hoogste worp wint!'**
  String get innDiceDesc;

  /// No description provided for @btnInnRoll.
  ///
  /// In nl, this message translates to:
  /// **'Gooi dobbelstenen'**
  String get btnInnRoll;

  /// No description provided for @innErrorNoGold.
  ///
  /// In nl, this message translates to:
  /// **'`4De herbergier schudt zijn hoofd: \"Geen goud, geen dobbelstenen, vriend!\"`w'**
  String get innErrorNoGold;

  /// No description provided for @innDiceVictory.
  ///
  /// In nl, this message translates to:
  /// **'`2Je gooit {pRoll} en de kroegbaas gooit {eRoll}. Je wint {gold} goudstukken!`w'**
  String innDiceVictory(Object eRoll, Object gold, Object pRoll);

  /// No description provided for @innDiceDefeat.
  ///
  /// In nl, this message translates to:
  /// **'`4Je gooit {pRoll} en de kroegbaas gooit {eRoll}. Je verliest {gold} goudstukken...`w'**
  String innDiceDefeat(Object eRoll, Object gold, Object pRoll);

  /// No description provided for @innDiceTie.
  ///
  /// In nl, this message translates to:
  /// **'`wGelijkspel! Jullie gooien allebei {pRoll}. Je krijgt je inzet terug.`w'**
  String innDiceTie(Object pRoll);

  /// No description provided for @btnVisitInn.
  ///
  /// In nl, this message translates to:
  /// **'Herberg'**
  String get btnVisitInn;

  /// No description provided for @newsLogInnWin.
  ///
  /// In nl, this message translates to:
  /// **'{user} heeft zojuist {gold} goudstukken gewonnen met dobbelen in de Herberg!'**
  String newsLogInnWin(Object gold, Object user);

  /// No description provided for @newsLogInnLoss.
  ///
  /// In nl, this message translates to:
  /// **'{user} is zojuist volledig blut gespeeld door de kroegbaas en verloor {gold} goudstukken...'**
  String newsLogInnLoss(Object gold, Object user);

  /// No description provided for @stablesTitle.
  ///
  /// In nl, this message translates to:
  /// **'De Koninklijke Stallen'**
  String get stablesTitle;

  /// No description provided for @stablesWelcome.
  ///
  /// In nl, this message translates to:
  /// **'`gJe loopt de stallen binnen. De geur van vers hooi en leder vult de ruimte. De stalmeester loopt op je af en tikt tegen zijn hoed:`w\n\n\"Welkom reiziger! Zoek je een trouwe metgezel voor je reizen? Een goed rijdier beschermt je in de strijd en zorgt dat je elke dag sneller kunt reizen!\"'**
  String get stablesWelcome;

  /// No description provided for @stablesCurrentMount.
  ///
  /// In nl, this message translates to:
  /// **'Je huidige rijdier: `c{mount}`w'**
  String stablesCurrentMount(Object mount);

  /// No description provided for @stablesNoMount.
  ///
  /// In nl, this message translates to:
  /// **'Geen (Je loopt te voet)'**
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

  /// No description provided for @stablesSuccessBuy.
  ///
  /// In nl, this message translates to:
  /// **'`2Je hebt succesvol een {mount} gekocht! De stalmeester brengt je nieuwe metgezel naar buiten.`w'**
  String stablesSuccessBuy(Object mount);

  /// No description provided for @stablesMaxLevel.
  ///
  /// In nl, this message translates to:
  /// **'`gJe bezit al de legendarische Gouden Draak! De stalmeester kijkt vol ontzag naar je rijdier.`w'**
  String get stablesMaxLevel;

  /// No description provided for @btnVisitStables.
  ///
  /// In nl, this message translates to:
  /// **'Stallen'**
  String get btnVisitStables;

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

  /// No description provided for @churchTitle.
  ///
  /// In nl, this message translates to:
  /// **'Het Serene Klooster'**
  String get churchTitle;

  /// No description provided for @churchWelcome.
  ///
  /// In nl, this message translates to:
  /// **'`gJe stapt de imposante, stille kerk binnen. Het weinige licht valt door de glas-in-loodramen op het altaar. Er hangt een geur van wierook en oude perkamenten.`w\n\n\"Kniel neer, reiziger,\" fluistert een monnik in een lange pij. \"Doe een gebed tot de Goden van het Rijk. Maar wees gewaarschuwd... de Goden zijn wispelturig!\"'**
  String get churchWelcome;

  /// No description provided for @btnChurchPray.
  ///
  /// In nl, this message translates to:
  /// **'Doe een Gebed'**
  String get btnChurchPray;

  /// No description provided for @btnChurchConfess.
  ///
  /// In nl, this message translates to:
  /// **'Biechten'**
  String get btnChurchConfess;

  /// No description provided for @btnChurchCandle.
  ///
  /// In nl, this message translates to:
  /// **'Kaarsje aansteken (1 Gem)'**
  String get btnChurchCandle;

  /// No description provided for @churchAlreadyPrayed.
  ///
  /// In nl, this message translates to:
  /// **'`4Je hebt zojuist al gebeden! De Goden horen je niet als je blijft zeuren.`w'**
  String get churchAlreadyPrayed;

  /// No description provided for @churchAlreadyConfessed.
  ///
  /// In nl, this message translates to:
  /// **'`4Je hebt je geweten voor vandaag al gezuiverd.`w'**
  String get churchAlreadyConfessed;

  /// No description provided for @churchAlreadyLitCandle.
  ///
  /// In nl, this message translates to:
  /// **'`4Het altaar staat al vol met jouw kaarsen.`w'**
  String get churchAlreadyLitCandle;

  /// No description provided for @churchBlessGold.
  ///
  /// In nl, this message translates to:
  /// **'`2De hemel opent zich en een warme lichtstraal raakt je aan! Je vindt {gold} goudstukken op het altaar!`w'**
  String churchBlessGold(Object gold);

  /// No description provided for @churchBlessGems.
  ///
  /// In nl, this message translates to:
  /// **'`2Een engel daalt neer en schenkt je een glimmende Edelsteen ({gems} Gem)!`w'**
  String churchBlessGems(Object gems);

  /// No description provided for @churchBlessHeal.
  ///
  /// In nl, this message translates to:
  /// **'`2Een goddelijke kracht stroomt door je aderen. Al je wonden zijn in één klap genezen!`w'**
  String get churchBlessHeal;

  /// No description provided for @churchNeutral.
  ///
  /// In nl, this message translates to:
  /// **'`gJe bidt vurig tot de Goden... maar er gebeurt niets. De stilte in de kerk blijft onverstoord.`w'**
  String get churchNeutral;

  /// No description provided for @churchCurseHp.
  ///
  /// In nl, this message translates to:
  /// **'`4De hemel betrekt en een felle bliksemstraal slaat vlak voor je voeten in! Je verliest {hp} HP door de schok!`w'**
  String churchCurseHp(Object hp);

  /// No description provided for @churchCurseGold.
  ///
  /// In nl, this message translates to:
  /// **'`4Een plotseline windvlaag raast door de kerk en blaast stiekem {gold} goudstukken uit je buidel!`w'**
  String churchCurseGold(Object gold);

  /// No description provided for @churchConfessResult.
  ///
  /// In nl, this message translates to:
  /// **'`2Je knielt neer en biecht je zonden. De monnik knikt langzaam. Je voelt je geest lichter worden. (+{xp} XP)`w'**
  String churchConfessResult(Object xp);

  /// No description provided for @churchCandleResult.
  ///
  /// In nl, this message translates to:
  /// **'`cJe steekt een kaarsje aan bij het beeld van de Oude Goden. Een vlaag van vrede trekt door de kerk. Ramius zal dit onthouden. (+{favor} Gunst)`w'**
  String churchCandleResult(Object favor);

  /// No description provided for @btnVisitChurch.
  ///
  /// In nl, this message translates to:
  /// **'Kerk'**
  String get btnVisitChurch;

  /// No description provided for @alchemistTitle.
  ///
  /// In nl, this message translates to:
  /// **'De Alchemist'**
  String get alchemistTitle;

  /// No description provided for @alchemistWelcome.
  ///
  /// In nl, this message translates to:
  /// **'`gJe stapt een donker, mystiek laboratorium binnen. Overal pruttelen glazen kolven met vreemde, dampende vloeistoffen. Een oude alchemist met een dikke bril kijkt op:`w\n\n\"Ah, een avonturier! Zoek je extra kracht voor in het bos? Mijn elixers geven je tijdelijk ongekende macht in je eerstvolgende gevechten. Kies verstandig!\"'**
  String get alchemistWelcome;

  /// No description provided for @alchemistCurrentBoosts.
  ///
  /// In nl, this message translates to:
  /// **'Actieve elixers: `2{atk} Atk`w | `c{def} Def`w'**
  String alchemistCurrentBoosts(Object atk, Object def);

  /// No description provided for @btnBuyAtkPotion.
  ///
  /// In nl, this message translates to:
  /// **'Koop Drakebloed (+5 Atk)'**
  String get btnBuyAtkPotion;

  /// No description provided for @btnBuyDefPotion.
  ///
  /// In nl, this message translates to:
  /// **'Koop IJzerhuid (+5 Def)'**
  String get btnBuyDefPotion;

  /// No description provided for @alchemistSuccessBuy.
  ///
  /// In nl, this message translates to:
  /// **'`2Je drinkt het elixer op. Een intense energie stroomt direct door je lichaam! Je hebt {boost} ontvangen.`w'**
  String alchemistSuccessBuy(Object boost);

  /// No description provided for @alchemistErrorAlreadyActive.
  ///
  /// In nl, this message translates to:
  /// **'`4Je hebt al een actieve boost van dit elixer! Meer drinken is puur gif voor je lichaam.`w'**
  String get alchemistErrorAlreadyActive;

  /// No description provided for @btnVisitAlchemist.
  ///
  /// In nl, this message translates to:
  /// **'Alchemist'**
  String get btnVisitAlchemist;

  /// No description provided for @trainingErrorNoXp.
  ///
  /// In nl, this message translates to:
  /// **'`4Je bent nog niet klaar! Je hebt niet genoeg ervaring (XP) om de Meester uit te dagen.`w'**
  String get trainingErrorNoXp;

  /// No description provided for @trainingSuccessLevelUp.
  ///
  /// In nl, this message translates to:
  /// **'`2Gefeliciteerd! Je hebt de Meester verslagen in een episch gevecht en bent gestegen naar Level {level}!`w'**
  String trainingSuccessLevelUp(Object level);

  /// No description provided for @resetNewDayTitle.
  ///
  /// In nl, this message translates to:
  /// **'Een Nieuwe Dag Breekt Aan!'**
  String get resetNewDayTitle;

  /// No description provided for @resetNewDayMessage.
  ///
  /// In nl, this message translates to:
  /// **'`2De zon komt op over het rijk en de vogels beginnen te fluiten. Je voelt je uitgerust en vol energie voor nieuwe avonturen!`w\n\nJe beurten zijn aangevuld en de poorten naar het Dorpsplein staan weer wijd open!'**
  String get resetNewDayMessage;

  /// No description provided for @btnStartDay.
  ///
  /// In nl, this message translates to:
  /// **'Begin de nieuwe dag'**
  String get btnStartDay;

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
  /// **'• Je beurten zijn aangevuld naar `c{amount}`w.'**
  String resetTurnsLog(Object amount);

  /// No description provided for @resetReadyLog.
  ///
  /// In nl, this message translates to:
  /// **'• Je voelt je uitgerust en klaar voor de strijd!'**
  String get resetReadyLog;

  /// No description provided for @eventHermitTitle.
  ///
  /// In nl, this message translates to:
  /// **'De Oude Kluizenaar'**
  String get eventHermitTitle;

  /// No description provided for @eventHermitDesc.
  ///
  /// In nl, this message translates to:
  /// **'`gTussen de dichte begroeiing zie je een kleine, gecamoufleerde hut. Een stokoude kluizenaar met een lange baard zit voor de deur op een boomstam.`w\n\n\"Ah, jonge reiziger,\" spreekt hij met een krakerige stem. \"Je bent ver van het Dorpsplein. Drink een beker kruidenthee met mij. Het zal je vermoeide benen direct verkwikken!\"'**
  String get eventHermitDesc;

  /// No description provided for @eventHermitSuccess.
  ///
  /// In nl, this message translates to:
  /// **'`2Je drinkt die bittere kruidenthee op. Een golf van intense energie schiet door je benen! Je krijgt +3 extra beurten (turns) voor vandaag.`w'**
  String get eventHermitSuccess;

  /// No description provided for @btnHermitDrink.
  ///
  /// In nl, this message translates to:
  /// **'Drink kruidenthee'**
  String get btnHermitDrink;

  /// No description provided for @btnSkillFallback.
  ///
  /// In nl, this message translates to:
  /// **'VAARDIGHEID'**
  String get btnSkillFallback;

  /// No description provided for @alchemistLimitReached.
  ///
  /// In nl, this message translates to:
  /// **'Ho eens even! Je hebt vandaag al 2 elixers gekocht. Meer kan je lichaam niet verdragen tot de volgende zonsopgang!'**
  String get alchemistLimitReached;

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
  /// **'Barmeid Violet'**
  String get innMenuFlirt;

  /// No description provided for @innFlirtAttempt.
  ///
  /// In nl, this message translates to:
  /// **'Flirt met Violet (-1 Edelsteen)'**
  String get innFlirtAttempt;

  /// No description provided for @innFlirtNoGems.
  ///
  /// In nl, this message translates to:
  /// **'Je hebt geen edelstenen om haar cadeau te doen!'**
  String get innFlirtNoGems;

  /// No description provided for @innFlirtSuccess.
  ///
  /// In nl, this message translates to:
  /// **'Violet bloost van je compliment en schenkt je een herstellend drankje! (+15 HP, +1 Max HP)'**
  String get innFlirtSuccess;

  /// No description provided for @innFlirtFail.
  ///
  /// In nl, this message translates to:
  /// **'Violet lacht je vierkant uit. Pijnlijk... Je verliest 2 HP van schaamte.'**
  String get innFlirtFail;

  /// No description provided for @innTalkCedrik.
  ///
  /// In nl, this message translates to:
  /// **'Praat met Cedrik'**
  String get innTalkCedrik;

  /// No description provided for @innCedrikRumor1.
  ///
  /// In nl, this message translates to:
  /// **'Cedrik poetst een glas en fluistert: \'Pas op in het bos, SamHaoir. Er zwerft een oude kluizenaar rond met magische kruidenthee...\''**
  String get innCedrikRumor1;

  /// No description provided for @innCedrikRumor2.
  ///
  /// In nl, this message translates to:
  /// **'Cedrik bromt: \'De reus in het bos slaapt diep, maar als je hem besteelt, kun je bakken met goud verdienen!\''**
  String get innCedrikRumor2;

  /// No description provided for @innMenuMain.
  ///
  /// In nl, this message translates to:
  /// **'De Gelagkamer'**
  String get innMenuMain;

  /// No description provided for @innMenuSpy.
  ///
  /// In nl, this message translates to:
  /// **'Mensen Bespioneren'**
  String get innMenuSpy;

  /// No description provided for @innMenuNews.
  ///
  /// In nl, this message translates to:
  /// **'Krant & Geruchten Lezen'**
  String get innMenuNews;

  /// No description provided for @innMenuBlackjack.
  ///
  /// In nl, this message translates to:
  /// **'Kaarttafel: Blackjack'**
  String get innMenuBlackjack;

  /// No description provided for @innSpySelect.
  ///
  /// In nl, this message translates to:
  /// **'Kies een doelwit om te bespioneren:'**
  String get innSpySelect;

  /// No description provided for @innSpyNoTargets.
  ///
  /// In nl, this message translates to:
  /// **'Er liggen momenteel geen andere reizigers te slapen in de herberg.'**
  String get innSpyNoTargets;

  /// No description provided for @innSpyResult.
  ///
  /// In nl, this message translates to:
  /// **'Je sluipt naar boven en bekijkt de spullen van {target}. Level: {lvl}, Goud op zak: {gold}.'**
  String innSpyResult(Object gold, Object lvl, Object target);

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
  /// **'Kaart Vragen'**
  String get innBlackjackHit;

  /// No description provided for @innBlackjackStand.
  ///
  /// In nl, this message translates to:
  /// **'Pas'**
  String get innBlackjackStand;

  /// No description provided for @innBlackjackWin.
  ///
  /// In nl, this message translates to:
  /// **'Gewonnen! Je hebt {player} tegen {house} van de bank. (+50 Goud)'**
  String innBlackjackWin(Object house, Object player);

  /// No description provided for @innBlackjackLose.
  ///
  /// In nl, this message translates to:
  /// **'Verloren! De bank heeft {house} en jij hebt {player}. (-50 Goud)'**
  String innBlackjackLose(Object house, Object player);

  /// No description provided for @innBlackjackBust.
  ///
  /// In nl, this message translates to:
  /// **'Te veel! Je bent kapot gegaan met {player} punten. (-50 Goud)'**
  String innBlackjackBust(Object player);

  /// No description provided for @innBlackjackTie.
  ///
  /// In nl, this message translates to:
  /// **'Gelijkspel! Beiden {points} punten. Je behoudt je inzet.'**
  String innBlackjackTie(Object points);

  /// No description provided for @btnReturnCommon.
  ///
  /// In nl, this message translates to:
  /// **'Terug naar de Gelagkamer'**
  String get btnReturnCommon;

  /// No description provided for @innBlackjackStart.
  ///
  /// In nl, this message translates to:
  /// **'START POTJE (50 GOUD)'**
  String get innBlackjackStart;

  /// No description provided for @innBlackjackHitBtn.
  ///
  /// In nl, this message translates to:
  /// **'HIT (KAART)'**
  String get innBlackjackHitBtn;

  /// No description provided for @innBlackjackStandBtn.
  ///
  /// In nl, this message translates to:
  /// **'STAND (PAS)'**
  String get innBlackjackStandBtn;

  /// No description provided for @innBlackjackCommonReturn.
  ///
  /// In nl, this message translates to:
  /// **'TERUG NAAR DE GELAGKAMER'**
  String get innBlackjackCommonReturn;

  /// No description provided for @innBlackjackScoreLog.
  ///
  /// In nl, this message translates to:
  /// **'Jouw hand: {playerHand} ({playerScore})\nBank kaarten: {houseHand}'**
  String innBlackjackScoreLog(
    Object houseHand,
    Object playerHand,
    Object playerScore,
  );

  /// No description provided for @innSpyResultLog.
  ///
  /// In nl, this message translates to:
  /// **'Je sluipt naar boven en bekijkt de spullen van {username}. Level: {level}, Goud op zak: {gold}.'**
  String innSpyResultLog(Object gold, Object level, Object username);

  /// No description provided for @innBlackjackBustLog.
  ///
  /// In nl, this message translates to:
  /// **'Bust! Je bent kapot gegaan met {score} punten. (-50 Goud)'**
  String innBlackjackBustLog(Object score);

  /// No description provided for @innBlackjackWinLog.
  ///
  /// In nl, this message translates to:
  /// **'Gewonnen! Je hebt {player} tegen {house} van de bank! (+50 Goud)'**
  String innBlackjackWinLog(Object house, Object player);

  /// No description provided for @innBlackjackLoseLog.
  ///
  /// In nl, this message translates to:
  /// **'Verloren! De bank wint met {house} tegen jouw {player}. (-50 Goud)'**
  String innBlackjackLoseLog(Object house, Object player);

  /// No description provided for @innBlackjackTieLog.
  ///
  /// In nl, this message translates to:
  /// **'Gelijkspel! Beiden {score} punten. Je behoudt je inzet.'**
  String innBlackjackTieLog(Object score);

  /// No description provided for @profileBiometricReason.
  ///
  /// In nl, this message translates to:
  /// **'Bevestig je identiteit om snel in te loggen bij LOGD'**
  String get profileBiometricReason;

  /// No description provided for @profileBiometricDeviceError.
  ///
  /// In nl, this message translates to:
  /// **'Dit toestel ondersteunt geen biometrie.'**
  String get profileBiometricDeviceError;

  /// No description provided for @profileDatabaseError.
  ///
  /// In nl, this message translates to:
  /// **'Er is een fout opgetreden.'**
  String get profileDatabaseError;

  /// No description provided for @trainingStatusTitle.
  ///
  /// In nl, this message translates to:
  /// **'=== STATUS ==='**
  String get trainingStatusTitle;

  /// No description provided for @trainingCurrentLevel.
  ///
  /// In nl, this message translates to:
  /// **'Huidig Niveau: `yLevel {level}`w'**
  String trainingCurrentLevel(Object level);

  /// No description provided for @btnForestWalkAway.
  ///
  /// In nl, this message translates to:
  /// **'LOOP DOOR'**
  String get btnForestWalkAway;

  /// No description provided for @btnForestFountainDive.
  ///
  /// In nl, this message translates to:
  /// **'DUIK IN BRON'**
  String get btnForestFountainDive;

  /// No description provided for @btnForestGiantSneak.
  ///
  /// In nl, this message translates to:
  /// **'SLUIP ER LANGS'**
  String get btnForestGiantSneak;

  /// No description provided for @btnForestGiantSteal.
  ///
  /// In nl, this message translates to:
  /// **'BESTEEL REUS'**
  String get btnForestGiantSteal;

  /// No description provided for @btnForestAttack.
  ///
  /// In nl, this message translates to:
  /// **'AANVALLEN'**
  String get btnForestAttack;

  /// No description provided for @btnForestFlee.
  ///
  /// In nl, this message translates to:
  /// **'VLUCHTEN'**
  String get btnForestFlee;

  /// No description provided for @btnForestLeprechaunPlay.
  ///
  /// In nl, this message translates to:
  /// **'Speel spel (100 G)'**
  String get btnForestLeprechaunPlay;

  /// No description provided for @btnForestWizardDrink.
  ///
  /// In nl, this message translates to:
  /// **'Drink uit ketel'**
  String get btnForestWizardDrink;

  /// No description provided for @btnForestWagonSearch.
  ///
  /// In nl, this message translates to:
  /// **'Doorzoek grondig'**
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
  /// **'Rode elixir'**
  String get btnForestHerbalistRed;

  /// No description provided for @btnForestHerbalistBlue.
  ///
  /// In nl, this message translates to:
  /// **'Blauwe elixir'**
  String get btnForestHerbalistBlue;

  /// No description provided for @btnForestBadgerAnswer.
  ///
  /// In nl, this message translates to:
  /// **'Beantwoord vraag'**
  String get btnForestBadgerAnswer;

  /// No description provided for @btnForestBadgerHunt.
  ///
  /// In nl, this message translates to:
  /// **'Jaag das weg'**
  String get btnForestBadgerHunt;

  /// No description provided for @btnForestSkeletonPlunder.
  ///
  /// In nl, this message translates to:
  /// **'Plunder harnas'**
  String get btnForestSkeletonPlunder;

  /// No description provided for @btnForestSkeletonBow.
  ///
  /// In nl, this message translates to:
  /// **'Breng eerbetoon'**
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
  /// **'Offer edelsteen'**
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
  /// **'Stap in cirkel'**
  String get btnForestMushroomStep;

  /// No description provided for @btnForestMushroomDestroy.
  ///
  /// In nl, this message translates to:
  /// **'Vernietig cirkel'**
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
  /// **'Offer goud'**
  String get btnForestStatueOffer;

  /// No description provided for @btnForestStatueClean.
  ///
  /// In nl, this message translates to:
  /// **'Maak schoon'**
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
  /// **'Wacht af'**
  String get btnForestSnareWait;

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
  /// **'Geef Edelsteen'**
  String get innBtnBardGem;

  /// No description provided for @innBtnFlirt.
  ///
  /// In nl, this message translates to:
  /// **'Flirten (1 beurt)'**
  String get innBtnFlirt;

  /// No description provided for @innBtnGift.
  ///
  /// In nl, this message translates to:
  /// **'Cadeau (1 gem)'**
  String get innBtnGift;

  /// No description provided for @innBtnPropose.
  ///
  /// In nl, this message translates to:
  /// **'Doe een aanzoek!'**
  String get innBtnPropose;

  /// No description provided for @innBtnGambleDice.
  ///
  /// In nl, this message translates to:
  /// **'Dobbelen'**
  String get innBtnGambleDice;

  /// No description provided for @innBtnGambleShell.
  ///
  /// In nl, this message translates to:
  /// **'Bekerspel'**
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
  /// **'PREMIE'**
  String get innBtnBountyAction;

  /// No description provided for @innRomanceLabel.
  ///
  /// In nl, this message translates to:
  /// **'Affectie: `p{points} / 100`w'**
  String innRomanceLabel(Object points);

  /// No description provided for @innBtnRichest.
  ///
  /// In nl, this message translates to:
  /// **'Vraag wie de rijkste is (50 G)'**
  String get innBtnRichest;

  /// No description provided for @innGambleShark.
  ///
  /// In nl, this message translates to:
  /// **'Kaarten-haai:'**
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

  /// No description provided for @innBlackjackReturn.
  ///
  /// In nl, this message translates to:
  /// **'TERUG NAAR DE GELAGKAMER'**
  String get innBlackjackReturn;

  /// No description provided for @innNewsWinLog.
  ///
  /// In nl, this message translates to:
  /// **'- {user} won {val} goudstukken aan de goktafel!'**
  String innNewsWinLog(Object user, Object val);

  /// No description provided for @innNewsLossLog.
  ///
  /// In nl, this message translates to:
  /// **'- {user} verloor {val} goudstukken aan de bank.'**
  String innNewsLossLog(Object user, Object val);

  /// No description provided for @innNewsEnterLog.
  ///
  /// In nl, this message translates to:
  /// **'- {user} betreedt de herberg.'**
  String innNewsEnterLog(Object user);

  /// No description provided for @innNewsUnknownPlayer.
  ///
  /// In nl, this message translates to:
  /// **'Een avonturier'**
  String get innNewsUnknownPlayer;

  /// No description provided for @combatSkillMagicSuccess.
  ///
  /// In nl, this message translates to:
  /// **'`2Je spreekt een genezingsspreuk uit en herstelt `w{hp} `2HP!`w'**
  String combatSkillMagicSuccess(Object hp);

  /// No description provided for @combatSkillThievingSuccess.
  ///
  /// In nl, this message translates to:
  /// **'`cJe sluipt achterom en rooft `y{gold} goudstukken `cvantussen de spullen van de {enemy}!`w'**
  String combatSkillThievingSuccess(Object enemy, Object gold);

  /// No description provided for @combatSkillWarriorSuccess.
  ///
  /// In nl, this message translates to:
  /// **'`4Je heft je wapen en brengt de {enemy} een verwoestende klap toe van `w{damage} `4schade!`w'**
  String combatSkillWarriorSuccess(Object damage, Object enemy);

  /// No description provided for @combatSkillWarriorVictory.
  ///
  /// In nl, this message translates to:
  /// **'`4Je brengt de {enemy} een genadeslag toe van `w{damage} `4schade!`w'**
  String combatSkillWarriorVictory(Object damage, Object enemy);

  /// No description provided for @combatFleeSuccess.
  ///
  /// In nl, this message translates to:
  /// **'\n\n`yJe gooit je wapen neer en rent in paniek het struikgewas in! Je bent succesvol ontsnapt aan de {enemy}.`w\n\n'**
  String combatFleeSuccess(Object enemy);

  /// No description provided for @combatFleeFailed.
  ///
  /// In nl, this message translates to:
  /// **'\n\n`4Je probeert te vluchten, maar de {enemy} haalt fel uit en raakt je in je rug voor `w{damage} `4schade!`w\n\n'**
  String combatFleeFailed(Object damage, Object enemy);

  /// No description provided for @combatFleeDeath.
  ///
  /// In nl, this message translates to:
  /// **'\n\n`4Je probeert te vluchten, maar de {enemy} brengt je een fatale klap toe! Je bent gestorven in het bos.`w\n\n'**
  String combatFleeDeath(Object enemy);

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
  /// **'Cedrik poetst een glas op en kijkt je aan: \"Wat kan ik voor je inschenken, reiziger?\"'**
  String get innDrinkSelectDesc;

  /// No description provided for @innDrink1Name.
  ///
  /// In nl, this message translates to:
  /// **'DWERGEN STOUT'**
  String get innDrink1Name;

  /// No description provided for @innDrink1Desc.
  ///
  /// In nl, this message translates to:
  /// **'Een zwaar, donker bier. Geeft extra kracht maar maakt je slaperig. (+15 HP, -1 Turn)'**
  String get innDrink1Desc;

  /// No description provided for @innDrink2Name.
  ///
  /// In nl, this message translates to:
  /// **'ELFEN MEEDE'**
  String get innDrink2Name;

  /// No description provided for @innDrink2Desc.
  ///
  /// In nl, this message translates to:
  /// **'Een zoete, sprankelende honingwijn. Geeft je hernieuwde energie! (+2 Turns)'**
  String get innDrink2Desc;

  /// No description provided for @innDrinkSuccess1.
  ///
  /// In nl, this message translates to:
  /// **'`2Je drinkt het Dwergen Stout in één teug leeg. Je voelt je een stuk sterker! (+15 HP, -1 Turn)`w'**
  String get innDrinkSuccess1;

  /// No description provided for @innDrinkSuccess2.
  ///
  /// In nl, this message translates to:
  /// **'`2De Elfen Meede smaakt heerlijk zoet. Je voelt de energie door je aderen stromen! (+2 Turns)`w'**
  String get innDrinkSuccess2;

  /// No description provided for @btnGraveyardRob.
  ///
  /// In nl, this message translates to:
  /// **'GRAF PLUNDEREN'**
  String get btnGraveyardRob;

  /// No description provided for @graveyardSuccessGold.
  ///
  /// In nl, this message translates to:
  /// **'`2Je pakt een schep en graaft een oud graf open... Onder het rotte hout vind je een verborgen kistje met `y{gold} goudstukken`2!`w'**
  String graveyardSuccessGold(Object gold);

  /// No description provided for @graveyardSuccessGem.
  ///
  /// In nl, this message translates to:
  /// **'`cJe doorzoekt een statige crypte en glimmende stenen trekken je aandacht... Je vindt `w{gems} edelsteen`c!`w'**
  String graveyardSuccessGem(Object gems);

  /// No description provided for @graveyardZombieEncounter.
  ///
  /// In nl, this message translates to:
  /// **'`4Terwijl je graaft, grijpt een rotte, koude hand plotseling je enkel! Een zombie kruipt omhoog uit de aarde en valt je aan! (-{hp} HP)`w'**
  String graveyardZombieEncounter(Object hp);

  /// No description provided for @graveyardEmpty.
  ///
  /// In nl, this message translates to:
  /// **'Je struint urenlang over het mistige kerkhof, maar alle graven lijken al te zijn leeggeroofd door grafrovers.'**
  String get graveyardEmpty;

  /// No description provided for @graveyardErrorResurrection.
  ///
  /// In nl, this message translates to:
  /// **'`4Er is een fout opgetreden bij de opstanding.`w'**
  String get graveyardErrorResurrection;

  /// No description provided for @innFlirtMaxHpBonus.
  ///
  /// In nl, this message translates to:
  /// **'`2Violet valt als een blok voor je charmes! Ze glimlacht verlegen en geeft je een permanente gezondheids-upgrade! (+1 Max HP & Volledig Genezen)`w'**
  String get innFlirtMaxHpBonus;

  /// No description provided for @innFlirtTurnsBonus.
  ///
  /// In nl, this message translates to:
  /// **'`2Je openingszin is een schot in de roos! Violet vindt je gezelschap fantastisch en schenkt je hernieuwde energie. (+2 Turns)`w'**
  String get innFlirtTurnsBonus;

  /// No description provided for @innFlirtSlapDefeat.
  ///
  /// In nl, this message translates to:
  /// **'`4Je openingszin slaat de plank volledig mis! Violet is diep beledigd en geeft je een harde klap in je gezicht! (-5 HP)`w'**
  String get innFlirtSlapDefeat;

  /// No description provided for @btnVisitHealer.
  ///
  /// In nl, this message translates to:
  /// **'KRUIDENHEKS 🌿'**
  String get btnVisitHealer;

  /// No description provided for @dialogWoundedTitle.
  ///
  /// In nl, this message translates to:
  /// **'TE ZWAARGEWOND'**
  String get dialogWoundedTitle;

  /// No description provided for @dialogWoundedMessage.
  ///
  /// In nl, this message translates to:
  /// **'`4Je bent te zwaargewond om te vechten. Bezoek de Kruidenheks of de herberg om te herstellen!`w'**
  String get dialogWoundedMessage;

  /// No description provided for @btnBuyHealing.
  ///
  /// In nl, this message translates to:
  /// **'KOOP GENEZING'**
  String get btnBuyHealing;

  /// No description provided for @labelHealCost.
  ///
  /// In nl, this message translates to:
  /// **'Kosten voor volledige genezing: `y{cost} goudstukken`w'**
  String labelHealCost(Object cost);

  /// No description provided for @btnOk.
  ///
  /// In nl, this message translates to:
  /// **'OK'**
  String get btnOk;

  /// No description provided for @healerFallbackWelcome.
  ///
  /// In nl, this message translates to:
  /// **'De hut van Althea...'**
  String get healerFallbackWelcome;

  /// No description provided for @healerFallbackHealthy.
  ///
  /// In nl, this message translates to:
  /// **'Je bent al kerngezond!'**
  String get healerFallbackHealthy;

  /// No description provided for @btnTalkTownfolk.
  ///
  /// In nl, this message translates to:
  /// **'PRAAT MET DORPELINGEN 🗣️'**
  String get btnTalkTownfolk;

  /// No description provided for @dialogRumorTitle.
  ///
  /// In nl, this message translates to:
  /// **'DORPSGERUCHTEN'**
  String get dialogRumorTitle;

  /// No description provided for @townSquareRumorFallback.
  ///
  /// In nl, this message translates to:
  /// **'De dorpelingen zijn stil vandaag...'**
  String get townSquareRumorFallback;

  /// No description provided for @healerSuccessFallback.
  ///
  /// In nl, this message translates to:
  /// **'Je bent genezen!'**
  String get healerSuccessFallback;

  /// No description provided for @btnVisitBarber.
  ///
  /// In nl, this message translates to:
  /// **'KAPPER MET STYLING 💈'**
  String get btnVisitBarber;

  /// No description provided for @btnBuyTitle.
  ///
  /// In nl, this message translates to:
  /// **'KOOP TITEL (1 EDELSTEEN)'**
  String get btnBuyTitle;

  /// No description provided for @btnVisitAlley.
  ///
  /// In nl, this message translates to:
  /// **'SCHADUWRIJKE STEEG 🪓'**
  String get btnVisitAlley;

  /// No description provided for @btnResetReputation.
  ///
  /// In nl, this message translates to:
  /// **'STRAFBLAD AFKOPEN (5 EDELSTENEN)'**
  String get btnResetReputation;

  /// No description provided for @btnVisitMightyE.
  ///
  /// In nl, this message translates to:
  /// **'DONATEUR MIGHTYE 💎'**
  String get btnVisitMightyE;

  /// No description provided for @btnDonateGem.
  ///
  /// In nl, this message translates to:
  /// **'DONEER 1 EDELSTEEN'**
  String get btnDonateGem;

  /// No description provided for @btnVisitWedding.
  ///
  /// In nl, this message translates to:
  /// **'TROUW KAPEL 💍'**
  String get btnVisitWedding;

  /// No description provided for @btnMarry.
  ///
  /// In nl, this message translates to:
  /// **'JA, IK WIL (500 GOUD)'**
  String get btnMarry;

  /// No description provided for @graveyard_title.
  ///
  /// In nl, this message translates to:
  /// **'De Begraafplaats van Oaktaven (Onderwereld)'**
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
  /// **'Vecht tegen Gekweld Gesternte (1 Beurt)'**
  String get graveyard_btn_fight;

  /// No description provided for @graveyard_btn_resurrect.
  ///
  /// In nl, this message translates to:
  /// **'Smeek Ramius om Genade'**
  String get graveyard_btn_resurrect;

  /// No description provided for @graveyard_btn_haunt.
  ///
  /// In nl, this message translates to:
  /// **'Spook in de Herberg (1 Beurt)'**
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
  /// **'VAL AAN'**
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
  /// **'=== De Bar van de Herberg ==='**
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
  /// **'=== Het Dorpsnieuws ==='**
  String get inn_section_news;

  /// No description provided for @town_btn_forest.
  ///
  /// In nl, this message translates to:
  /// **'Ga het Bos in'**
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
  /// **'Mysterieuze Plekken'**
  String get town_btn_mystery;

  /// No description provided for @town_btn_training.
  ///
  /// In nl, this message translates to:
  /// **'Krijgshof & Training'**
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
  /// **'Kruidenheks'**
  String get town_sub_healer;

  /// No description provided for @town_sub_alley.
  ///
  /// In nl, this message translates to:
  /// **'Schaduwrijke Steeg'**
  String get town_sub_alley;

  /// No description provided for @town_sub_classroom.
  ///
  /// In nl, this message translates to:
  /// **'Training zaal'**
  String get town_sub_classroom;

  /// No description provided for @town_sub_stables.
  ///
  /// In nl, this message translates to:
  /// **'De Stallen'**
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
  /// **'Dorpelingen'**
  String get town_sub_townfolk;

  /// No description provided for @town_sub_mightye.
  ///
  /// In nl, this message translates to:
  /// **'Donateur Mightye'**
  String get town_sub_mightye;

  /// No description provided for @inn_news_empty.
  ///
  /// In nl, this message translates to:
  /// **'Er is vandaag nog niets voorgevallen in het rijk...'**
  String get inn_news_empty;

  /// No description provided for @inn_spy_empty.
  ///
  /// In nl, this message translates to:
  /// **'Er dwalen momenteel geen andere reizigers in de herberg...'**
  String get inn_spy_empty;

  /// No description provided for @inn_btn_spy_action.
  ///
  /// In nl, this message translates to:
  /// **'SPIONEER (10 GOUD)'**
  String get inn_btn_spy_action;

  /// No description provided for @inn_title.
  ///
  /// In nl, this message translates to:
  /// **'De Herberg \'De Dronken Draak\''**
  String get inn_title;

  /// No description provided for @profileBiometricAuthError.
  ///
  /// In nl, this message translates to:
  /// **'Verificatie mislukt.'**
  String get profileBiometricAuthError;

  /// No description provided for @btnStyxOnboard.
  ///
  /// In nl, this message translates to:
  /// **'STAP OP HET VLOT (KOST 2 TURNS)'**
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

  /// No description provided for @dragon_lair_title.
  ///
  /// In nl, this message translates to:
  /// **'Het Hol van de Groene Draak'**
  String get dragon_lair_title;

  /// No description provided for @btn_attack_dragon.
  ///
  /// In nl, this message translates to:
  /// **'Val de Groene Draak aan!'**
  String get btn_attack_dragon;

  /// No description provided for @btn_sneak_away.
  ///
  /// In nl, this message translates to:
  /// **'Sluip stilletjes weg'**
  String get btn_sneak_away;

  /// No description provided for @btn_dragon_continue.
  ///
  /// In nl, this message translates to:
  /// **'Accepteer je lot'**
  String get btn_dragon_continue;

  /// No description provided for @news_dragon_kill.
  ///
  /// In nl, this message translates to:
  /// **'{user} heeft de Groene Draak verslagen en redt het rijk! Dit is hun {kills}e overwinning!'**
  String news_dragon_kill(Object kills, Object user);

  /// No description provided for @newsLogDragonAttack.
  ///
  /// In nl, this message translates to:
  /// **'`4HOREN, ZIEN EN ZEGT HET VOORT!`w {user} betreedt het hol van de Groene Draak! Het gebrul trilt door de bergen...'**
  String newsLogDragonAttack(Object user);

  /// No description provided for @newsLogDragonDefeat.
  ///
  /// In nl, this message translates to:
  /// **'`4HOREN, ZIEN EN ZEGT HET VOORT!`w {user} is op brute wijze geroosterd door de Groene Draak! Oaktaven rouwt...'**
  String newsLogDragonDefeat(Object user);

  /// No description provided for @btnDevAddGold.
  ///
  /// In nl, this message translates to:
  /// **'+10K GOUD'**
  String get btnDevAddGold;

  /// No description provided for @btnDevAddGems.
  ///
  /// In nl, this message translates to:
  /// **'+5 EDELSTENEN'**
  String get btnDevAddGems;

  /// No description provided for @btnDevAddTurns.
  ///
  /// In nl, this message translates to:
  /// **'+10 BEURTEN'**
  String get btnDevAddTurns;

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

  /// No description provided for @btnDevSpawnAction.
  ///
  /// In nl, this message translates to:
  /// **'SPAWN RECHTSTREEKS 🚀'**
  String get btnDevSpawnAction;

  /// No description provided for @errorNoGems.
  ///
  /// In nl, this message translates to:
  /// **'Je hebt niet genoeg glimmende edelstenen!'**
  String get errorNoGems;

  /// No description provided for @btnBuyCut.
  ///
  /// In nl, this message translates to:
  /// **'Frisse Coupe ({cost} Goud)'**
  String btnBuyCut(Object cost);

  /// No description provided for @btnBuyShave.
  ///
  /// In nl, this message translates to:
  /// **'Gladde Scheerbeurt ({cost} Goud)'**
  String btnBuyShave(Object cost);

  /// No description provided for @btnBuyDye.
  ///
  /// In nl, this message translates to:
  /// **'Haar Verven (1 GEM)'**
  String get btnBuyDye;

  /// No description provided for @dragonShrineTitle.
  ///
  /// In nl, this message translates to:
  /// **'Het Drakenheiligdom'**
  String get dragonShrineTitle;

  /// No description provided for @dragonShrineWelcome.
  ///
  /// In nl, this message translates to:
  /// **'`gJe stapt een verborgen, met klimop begroeide ruïne net buiten het dorpsplein binnen. In het midden zweeft een mystiek, zacht gloeiend kristal dat pulseert met pure energie. Zodra je dichterbij komt, vormt de energie zich tot het gezicht van een oude woudgod.`w'**
  String get dragonShrineWelcome;

  /// No description provided for @dragonShrinePoints.
  ///
  /// In nl, this message translates to:
  /// **'Drakenpunten (DP): `y{amount}`w'**
  String dragonShrinePoints(Object amount);

  /// No description provided for @dragonShrineNoPoints.
  ///
  /// In nl, this message translates to:
  /// **'`4De energie in het kristal blijft flets en dof. De stem van de woudgod klinkt koud: \"Je draagt de markering van een drakendoder niet bij je, sterveling. Je hebt hier niets te zoeken.\"`w'**
  String get dragonShrineNoPoints;

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
  /// **'PERMANENTE LEVENSKRACHT (+5 HP)'**
  String get btnUpgradeHp;

  /// No description provided for @btnUpgradeTurns.
  ///
  /// In nl, this message translates to:
  /// **'WOUDLOPER ZEGENING (+1 BEURT)'**
  String get btnUpgradeTurns;

  /// No description provided for @dragonShrineSuccess.
  ///
  /// In nl, this message translates to:
  /// **'`2De woudgod raakt je aan met een straal van licht. \"De transactie is voltooid. Ga heen en gebruik je nieuwe krachten wijs!\"`w'**
  String get dragonShrineSuccess;

  /// No description provided for @btnVisitDragonShrine.
  ///
  /// In nl, this message translates to:
  /// **'Draken Heiligdom'**
  String get btnVisitDragonShrine;
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
