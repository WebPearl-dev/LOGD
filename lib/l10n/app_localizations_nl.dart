// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String statLvl(Object level) {
    return 'LVL: $level';
  }

  @override
  String statHp(Object current, Object max) {
    return 'HP: $current/$max';
  }

  @override
  String statGold(Object amount) {
    return 'Goud: $amount';
  }

  @override
  String statGems(Object amount) {
    return 'Gems: $amount';
  }

  @override
  String statTurns(Object amount) {
    return 'Beurten: $amount';
  }

  @override
  String statXp(Object amount) {
    return 'XP: $amount';
  }

  @override
  String statDk(Object amount) {
    return 'DK: $amount';
  }

  @override
  String statHonor(Object amount) {
    return 'Eer: $amount';
  }

  @override
  String statPvpWins(Object losses, Object wins) {
    return 'Winst: $wins | Verlies: $losses';
  }

  @override
  String get btnGoToForest => 'Betreed het bos';

  @override
  String get btnAttack => 'Aanval';

  @override
  String get btnFlee => 'Vluchten';

  @override
  String get btnReturnTown => 'Terug naar stad';

  @override
  String get btnSave => 'Opslaan';

  @override
  String get btnCancel => 'Annuleren';

  @override
  String get btnClose => 'Sluiten';

  @override
  String get btnLogin => 'Inloggen';

  @override
  String get btnRegister => 'Account aanmaken';

  @override
  String get btnConfirmRace => 'Bevestig keuze en start avontuur';

  @override
  String get btnConfirmSpecialty => 'Kies klasse en betreed het Dorpsplein';

  @override
  String get btnUseSkill => 'Vaardigheid';

  @override
  String get btnBuyUpgrade => 'Koop Upgrade';

  @override
  String get btnVisitBank => 'Bank';

  @override
  String get btnVisitSmithy => 'Winkels';

  @override
  String get btnVisitPegasus => 'Bezoek Pegasus Wapens';

  @override
  String get btnVisitMerilon => 'Bezoek Merilon Harnassen';

  @override
  String get btnTalkPegasus => 'Praat met Pegasus';

  @override
  String get btnTalkMerilon => 'Praat met Merilon';

  @override
  String get btnChallengeMaster => 'Uitdaging Master duel';

  @override
  String get btnVisitTraining => 'Trainingsruimte';

  @override
  String get btnEventFountainDive => 'Duik erin';

  @override
  String get btnEventFountainLeave => 'Loop door';

  @override
  String get btnEventGiantSneak => 'Slip erlangs';

  @override
  String get btnEventGiantSteal => 'Probeer te stelen';

  @override
  String get btnGraveyardOfferGem => 'Bied 1 Edelsteen';

  @override
  String get btnGraveyardOfferXp => 'Bied 100 XP';

  @override
  String get btnGraveyardAcceptLot => 'Accepteer je lot (Wacht tot morgen)';

  @override
  String get btnGraveyardRob => 'GRAAF GRAAF';

  @override
  String get btnStartDay => 'Begin de nieuwe dag';

  @override
  String get btnHermitDrink => 'Drink kruidenthee';

  @override
  String get btnInnRoll => 'Gooi dobbelstenen';

  @override
  String get btnVisitInn => 'Herberg';

  @override
  String get btnVisitStables => 'Stallen';

  @override
  String get btnChurchPray => 'Doe een Gebed';

  @override
  String get btnChurchConfess => 'Biecht Zonden';

  @override
  String get btnChurchCandle => 'Steek Kaars op (1 Gem)';

  @override
  String get btnVisitChurch => 'Kerk';

  @override
  String get btnBuyAtkPotion => 'Koop Drakenbloed (+5 Atk)';

  @override
  String get btnBuyDefPotion => 'Koop IJzerhuid (+5 Def)';

  @override
  String get btnVisitAlchemist => 'Alchemist';

  @override
  String get btnVisitHealer => 'Kruidendokter 🌿';

  @override
  String get btnBuyHealing => 'KOOP GENEZING';

  @override
  String get btnVisitBarber => 'KAPPER MET STYLING';

  @override
  String get btnBuyTitle => 'KOOP TITEL (1 GEM)';

  @override
  String get btnVisitAlley => 'SCHADUWSTEEG 🪓';

  @override
  String get btnResetReputation => 'KOOP STRAFBLAD AF (5 GEMS)';

  @override
  String get btnVisitMightyE => 'DONOR MIGHTYE 💎';

  @override
  String get btnDonateGem => 'DONEER 1 GEM';

  @override
  String get btnVisitWedding => 'TROUWAPEL 💍';

  @override
  String get btnMarry => 'JA IK WIL (500 GOUD)';

  @override
  String get btnStyxOnboard => 'GA AAN BOORD (KOST 2 BEURTEN)';

  @override
  String get btnStyxStay => 'BLIJF AAN DE OEVER';

  @override
  String get btnWhispersListen => 'LUISTER AANDACHTIG';

  @override
  String get btnWhispersLeave => 'ZWEEF SNEL VERDER';

  @override
  String get btn_attack_dragon => 'Val de Groene Draak aan!';

  @override
  String get btn_sneak_away => 'Slip stilletjes weg';

  @override
  String get btn_dragon_continue => 'Accepteer je lot';

  @override
  String get btnDevHeal => 'Volledig Genezen (Full HP)';

  @override
  String get btnDevGold => 'Geef +10.000 Goud';

  @override
  String get btnDevGems => 'Geef +5 Gems';

  @override
  String get btnDevTurns => 'Geef +10 Beurten';

  @override
  String get btnDevLevelUp => 'Direct Level Up (+1 Lvl)';

  @override
  String get btnDevAddGold => '+10K GOUD';

  @override
  String get btnDevAddGems => '+5 GEMS';

  @override
  String get btnDevAddTurns => '+10 BEURTEN';

  @override
  String get btnDevSpawnAction => 'SPAWN DIRECT 🚀';

  @override
  String btnBuyCut(Object cost) {
    return 'Frisse coupe ($cost Goud)';
  }

  @override
  String btnBuyShave(Object cost) {
    return 'Gladde scheerbeurt ($cost Goud)';
  }

  @override
  String get btnBuyDye => 'Verf haar (1 GEM)';

  @override
  String get btnUpgradeAtk => 'PERMANENTE AANVAL (+1 ATK)';

  @override
  String get btnUpgradeDef => 'PERMANENTE VERDEDIGING (+1 DEF)';

  @override
  String get btnUpgradeHp => 'PERMANENTE VITALITEIT (+5 HP)';

  @override
  String get btnUpgradeTurns => 'BOSWANDELAAR ZEGEN (+1 BEURT)';

  @override
  String get btnVisitDragonShrine => 'Drakenheiligdom';

  @override
  String get profileSaveName => 'Naam Opslaan';

  @override
  String get profileSaveEmail => 'E-mail Opslaan';

  @override
  String get profileChangePassword => 'Wachtwoord Wijzigen';

  @override
  String get profileNewPasswordLabel => 'Nieuw Wachtwoord';

  @override
  String get profileSavePassword => 'Wachtwoord Opslaan';

  @override
  String get settingsBtnShare => 'Deel nu';

  @override
  String get settingsBtnRate => 'Beoordeel nu';

  @override
  String get settingsBtnSend => 'Verzenden';

  @override
  String get tutorialBtnPrevious => 'Vorige';

  @override
  String get tutorialBtnNext => 'Volgende';

  @override
  String get tutorialBtnSkip => 'Overslaan';

  @override
  String get tutorialBtnFinish => 'Begrepen / Start Spel';

  @override
  String get btnSend => 'Verzenden';

  @override
  String get reportUser => 'Rapporteer gebruiker';

  @override
  String get blockUser => 'Blokkeer gebruiker';

  @override
  String get reportReasonPrompt => 'Geef reden op voor rapportage:';

  @override
  String get reportSuccess => 'Gebruiker succesvol gerapporteerd.';

  @override
  String get blockSuccess => 'Gebruiker succesvol geblokkeerd.';

  @override
  String get options => 'Opties';

  @override
  String get btnDm => 'Privébericht';

  @override
  String get btnChallenge => 'Uitdagen';

  @override
  String get arenaAccept => 'Accepteren';

  @override
  String get arenaDecline => 'Afwijzen';

  @override
  String get townChatButton => 'Wereldchat';

  @override
  String get townArenaButton => 'PvP Arena';

  @override
  String get btnOk => 'OK';

  @override
  String get btnTalkTownfolk => 'PRAAT MET DORPSBEWONERS 🗣️';

  @override
  String get btnForestLeprechaunPlay => 'Speel spel (100 G)';

  @override
  String get btnForestWalkAway => 'LOOP WEG';

  @override
  String get btnForestWizardDrink => 'Drink uit ketel';

  @override
  String get btnForestWagonSearch => 'Grondig doorzoeken';

  @override
  String get btnForestWagonSmash => 'Sla kisten kapot';

  @override
  String get btnForestHartBow => 'Buig respectvol';

  @override
  String get btnForestHartHunt => 'Probeer te jagen';

  @override
  String get btnForestCardHigher => 'Hoger';

  @override
  String get btnForestCardLower => 'Lager';

  @override
  String get btnForestTreeGold => 'Geef goud';

  @override
  String get btnForestTreeChop => 'Hak schors';

  @override
  String get btnForestTempleRead => 'Lees boek';

  @override
  String get btnForestTempleSearch => 'Doorzoek altaar';

  @override
  String get btnForestHerbalistRed => 'Rood elixir';

  @override
  String get btnForestHerbalistBlue => 'Blauw elixir';

  @override
  String get btnForestBadgerAnswer => 'Beantwoord vraag';

  @override
  String get btnForestBadgerHunt => 'Jagen weg';

  @override
  String get btnForestSkeletonPlunder => 'Plunder harnas';

  @override
  String get btnForestSkeletonBow => 'Toon respect';

  @override
  String get btnForestCarnivalSpin => 'Draai aan rad';

  @override
  String get btnForestCampEat => 'Eet soep';

  @override
  String get btnForestCampSearch => 'Doorzoek tenten';

  @override
  String get btnForestWellOffer => 'Bied edelsteen';

  @override
  String get btnForestWellFish => 'Vis naar goud';

  @override
  String get btnForestHoneyClimb => 'Pak honing';

  @override
  String get btnForestHoneySmoke => 'Rook bijen uit';

  @override
  String get btnForestMushroomStep => 'Stap in kring';

  @override
  String get btnForestMushroomDestroy => 'Vernietig kring';

  @override
  String get btnForestHunterPlay => 'Schietwedstrijd';

  @override
  String get btnForestHunterDemand => 'Eis goud';

  @override
  String get btnForestStatueOffer => 'Bied goud';

  @override
  String get btnForestStatueClean => 'Maak standbeeld schoon';

  @override
  String get btnForestSnareCut => 'Snijd los';

  @override
  String get btnForestSnareForce => 'Gebruik kracht';

  @override
  String get btnForestSnareWait => 'Wacht';

  @override
  String get wep0 => 'Blote Vuisten';

  @override
  String get wep1 => 'Houten Stok';

  @override
  String get wep2 => 'Roestige Dolk';

  @override
  String get wep3 => 'Handbijl';

  @override
  String get wep4 => 'IJzeren Kortzwaard';

  @override
  String get wep5 => 'Stalen Brede Zwaard';

  @override
  String get wep6 => 'Grote Strijdhamer';

  @override
  String get wep7 => 'Gekruiste Hellebaard';

  @override
  String get wep8 => 'Elfen Kruisboog';

  @override
  String get wep9 => 'Runenzwaard';

  @override
  String get wep10 => 'Mace van Duif';

  @override
  String get wep11 => 'Glimmende Knots';

  @override
  String get wep12 => 'Obsidiaan Kling';

  @override
  String get wep13 => 'Drakenbot Speer';

  @override
  String get wep14 => 'Hemels Zwaard';

  @override
  String get wep15 => 'Excalibur van Oaktaven';

  @override
  String get arm0 => 'Alledaagse Kleding';

  @override
  String get arm1 => 'Leren Vest';

  @override
  String get arm2 => 'Dik Gekookt Leer';

  @override
  String get arm3 => 'Met Klinknagels Beslagen Leren Harnas';

  @override
  String get arm4 => 'Ringpantser';

  @override
  String get arm5 => 'Lichte Maliënkolder';

  @override
  String get arm6 => 'Zware Stalen Maliënkolder';

  @override
  String get arm7 => 'Platenpantser';

  @override
  String get arm8 => 'Elfen Borstplaat';

  @override
  String get arm9 => 'Behouwen Bronzen Harnas';

  @override
  String get arm10 => 'Ridderlijk Platenharnas';

  @override
  String get arm11 => 'Runen Bescherming';

  @override
  String get arm12 => 'Obsidiaan Schild & Harnas';

  @override
  String get arm13 => 'Drakenhuid Schild';

  @override
  String get arm14 => 'Paladijn Cuirass';

  @override
  String get arm15 => 'Het Godenpantser';

  @override
  String get mount0 => 'Geen';

  @override
  String get mount1 => 'Pony';

  @override
  String get mount2 => 'Oorlogspaard';

  @override
  String get mount3 => 'Schaduwwolf';

  @override
  String get mount4 => 'Gouden Draak';

  @override
  String get devSuccessMessage =>
      '`p[DEV] Stat succesvol aangepast in de cloud!`w';

  @override
  String get lblDevSelectEvent => 'Selecteer Event om te Spawnen:';

  @override
  String get lblDevSelectMonster => 'Selecteer Monster om te Spawnen:';

  @override
  String get smithyErrorUnknown => '`4Er is een onbekende fout opgetreden.`w';

  @override
  String get dialogRumorTitle => 'DORPSGERUCHTEN';

  @override
  String get dialogWoundedTitle => 'TE ZWAAR GEWOND';

  @override
  String get townCrierPrefix => '`4HOOR ZEGT HET VOORT! `w';

  @override
  String get defaultUsername => 'Reiziger';

  @override
  String get newsUnknownPlayer => 'Onbekende Reiziger';

  @override
  String get newsUnknownPartner => 'iemand';

  @override
  String get innRoomRentedMessage =>
      'Je hebt een veilige kamer gehuurd in de herberg! Je bent nu beschermd tegen offline PK-aanvallen.';

  @override
  String get innRoomErrorNoGold =>
      'Je hebt niet genoeg goud (50 goud vereist) om een kamer te huren!';

  @override
  String get resetNewDayTitle => 'Een nieuwe dag daagt!';

  @override
  String get resetNightResults => 'Resultaten van de nacht:';

  @override
  String resetInterestLog(Object amount) {
    return '• De bank heeft `y$amount goud`w aan rente bijgeschreven (2%).';
  }

  @override
  String resetTurnsLog(Object amount) {
    return '• Je beurten zijn aangevuld tot `c$amount`w.';
  }

  @override
  String get resetReadyLog =>
      '• Je voelt je uitgerust en klaar voor de strijd!';

  @override
  String trainingDuelTitle(Object name) {
    return '=== DUEL MET $name ===';
  }

  @override
  String get btnForestFountainDive => 'Duik in fontein';

  @override
  String get btnForestGiantSteal => 'Roofdier';

  @override
  String get btnForestGiantSneak => 'Slip erlangs';

  @override
  String get newsEmpty =>
      '`wHet mededelingenbord is momenteel leeg. Het is een rustige dag in het rijk...`w';

  @override
  String get authTitle => 'Toegang tot het Rijk';

  @override
  String get authEmail => 'E-mailadres';

  @override
  String get authPassword => 'Wachtwoord';

  @override
  String get authUsername => 'Karakternaam (alleen registratie)';

  @override
  String get authSwitchToRegister => 'Nieuw hier? Maak een karakter aan';

  @override
  String get authSwitchToLogin => 'Al een karakter? Log hier in';

  @override
  String get authGuestLogin => 'Speel als gast';

  @override
  String get profileTitle => 'Karakter Instellingen';

  @override
  String get profileChangeName => 'Wijzig Karakter Naam';

  @override
  String get profileDeleteAccount => 'Permanent Karakter Verwijderen';

  @override
  String get profileDeleteWarning =>
      'Weet je het zeker? Dit verwijdert al je goud, levels en XP permanent!';

  @override
  String get profileLogout => 'Verlaat het Rijk (Uitloggen)';

  @override
  String get profileBiometricToggle =>
      'Biometrisch inloggen (Vingerafdruk/FaceID)';

  @override
  String get profileChangeEmail => 'Wijzig E-mailadres';

  @override
  String get bankTitle => 'De Centrale Bank van het Rijk';

  @override
  String bankInBank(Object amount) {
    return 'Goud op bank: `y$amount goudstukken`w';
  }

  @override
  String bankOnHand(Object amount) {
    return 'Goud op zak: `y$amount goudstukken`w';
  }

  @override
  String get btnDepositAll => 'Stort alles';

  @override
  String get btnWithdrawAll => 'Opnemen alles';

  @override
  String get btnDepositCustom => 'Stort bedrag';

  @override
  String get btnWithdrawCustom => 'Bedrag opnemen';

  @override
  String bankVaultBalance(Object amount) {
    return 'Kluissaldo: `y$amount goud`w';
  }

  @override
  String bankOnHandLabel(Object amount) {
    return 'Op zak: `y$amount goud`w';
  }

  @override
  String bankDepositLimitLabel(Object amount) {
    return 'Stortlimiet over: `c$amount goud`w';
  }

  @override
  String get btnTalkBanker => 'Praat met de bankier';

  @override
  String get raceTitle => 'Kies je Ras';

  @override
  String get raceHuman => 'Mens';

  @override
  String get raceHumanDesc =>
      'Gebalanceerd en gedreven. Start met `y+5 extra beurten`w voor vandaag.';

  @override
  String get raceElf => 'Elf';

  @override
  String get raceElfDesc =>
      'Elegant en mystiek. Start met `c+1 glimmende edelsteen`w op zak.';

  @override
  String get raceDwarf => 'Dwerg';

  @override
  String get raceDwarfDesc =>
      'Robuust en gek op goud. Start met `y+100 extra startgoud`w.';

  @override
  String get raceOrc => 'Ork';

  @override
  String get raceOrcDesc => 'Brutaal en sterk. Start met `r+5 maximale HP`w.';

  @override
  String get specialtyTitle => 'Kies je Specialiteit';

  @override
  String get specMagic => 'Mystieke Krachten (Magie)';

  @override
  String get specMagicDesc =>
      'Meester in elementen. Start met de spreuk `cRegeneratie`w om jezelf te helen in gevecht.';

  @override
  String get specThieving => 'Diefstal (Zakkenrollen)';

  @override
  String get specThievingDesc =>
      'Snel en doortrapt. Start met de vaardigheid `yZakkenrollen`w om extra goud te slaan uit monsters.';

  @override
  String get specWarrior => 'Krijger';

  @override
  String get specWarriorDesc =>
      'Brute kracht en staal. Start met de vaardigheid `rSchildbeuk`w voor extra zware klappen.';

  @override
  String get smithyTitle => 'Smederij \'Het Hete Ijzer\'';

  @override
  String get smithyCurrentEquip => 'Huidige uitrusting:';

  @override
  String smithyWeaponLabel(Object lvl, Object name) {
    return 'Wapen: `c$name`w (Lvl $lvl)';
  }

  @override
  String smithyArmorLabel(Object lvl, Object name) {
    return 'Pantser: `c$name`w (Lvl $lvl)';
  }

  @override
  String get smithyUpgradeAvailable => 'Volgende upgrade beschikbaar:';

  @override
  String smithyCostLabel(Object cost) {
    return 'Kosten: `y$cost goudstukken`w (inruilwaarde verrekend)';
  }

  @override
  String get smithyAmountLabel => 'Aantal goudstukken';

  @override
  String get smithyTabWeapons => 'Wapens';

  @override
  String get smithyTabArmor => 'Harnassen';

  @override
  String get trainingTitle => 'De Trainingsruimte van de Masters';

  @override
  String get trainingStatusTitle => '=== STATUS ===';

  @override
  String trainingCurrentLevel(Object level) {
    return 'Huidig Level: `yLevel $level`w';
  }

  @override
  String trainingMasterHp(Object current, Object max) {
    return 'MASTER HP: `4$current / $max`w';
  }

  @override
  String trainingXpLabel(Object current, Object needed) {
    return 'Ervaring (XP): `c$current / $needed`w';
  }

  @override
  String get forestTitle => 'Het Duistere Woud';

  @override
  String get graveyardTitle => 'Het Schaduwrijke Kerkhof';

  @override
  String get newsTitle => 'Het Dagelijks Nieuws van het Rijk';

  @override
  String get rankingsTitle => 'De Eeregalerij';

  @override
  String get rankingsWelcome => 'De machtigste krijgers van het rijk:';

  @override
  String get rankingsEmpty =>
      'Er zijn nog geen legendarische helden opgestaan...';

  @override
  String get townCrierTitle => 'De Stadomroeper';

  @override
  String get btnVisitNews => 'Dagelijks Nieuws';

  @override
  String get devTitle => '=== GOD MODE: DEV MENU ===';

  @override
  String get devScreenTitle => 'MASTER DEV CONSOLE';

  @override
  String get devSpawnMonsterTitle => '=== SPAWN MONSTER TEST ===';

  @override
  String get devSpawnMonsterDesc =>
      'Klik op een monster hieronder om direct een gevecht in het bos te forceren en de balans te checken:';

  @override
  String get innTitle => 'Herberg \'De Dronken Draak\'';

  @override
  String get innDiceTitle => '=== DE GOKTAFEL ===';

  @override
  String get innDiceDesc =>
      'Gok goud om te dobbelen tegen de herbergiers. Hoogste gooi wint!';

  @override
  String get stablesTitle => 'De Koninklijke Stallen';

  @override
  String stablesCurrentMount(Object mount) {
    return 'Je huidige rijdier: `c$mount`w';
  }

  @override
  String get stablesNoMount => 'Geen (Je reist te voet)';

  @override
  String get stablesUpgradeAvailable => '=== BESCHIKBAAR RIJDIER ===';

  @override
  String stablesCostLabel(Object gold) {
    return 'Prijs: `y$gold goud`w';
  }

  @override
  String stablesCostGemsLabel(Object gems, Object gold) {
    return 'Prijs: `y$gold goud`w & `c$gems Gems`w';
  }

  @override
  String stablesBonusLabel(Object def, Object turns) {
    return 'Bonus: `2+$def Def`w | `p+$turns Beurten per dag`w';
  }

  @override
  String get churchTitle => 'Het Serene Klooster';

  @override
  String get alchemistTitle => 'De Alchemist';

  @override
  String alchemistCurrentBoosts(Object atk, Object def) {
    return 'Actieve elixers: `2$atk Atk`w | `c$def Def`w';
  }

  @override
  String alchemistTodayCounter(Object count) {
    return 'Elixers vandaag gekocht: $count/2';
  }

  @override
  String get innMenuGamble => 'Goktafel';

  @override
  String get innMenuBartender => 'Barman Cedrik';

  @override
  String get innMenuFlirt => 'Barmeisje Violet';

  @override
  String get innFlirtAttempt => 'Flirt met Violet (-1 Gem)';

  @override
  String get innFlirtNoGems => 'Je hebt geen edelstenen om haar te schenken!';

  @override
  String get innTalkCedrik => 'Praat met Cedrik';

  @override
  String get innMenuMain => 'De Huiskamer';

  @override
  String get innMenuSpy => 'Spioneer op Mensen';

  @override
  String get innMenuNews => 'Lees Krant & Geruchten';

  @override
  String get innMenuBlackjack => 'Kaarttafel: Blackjack';

  @override
  String get innSpySelect => 'Kies een doelwit om op te spioneren:';

  @override
  String get innSpyNoTargets =>
      'Er zijn momenteel geen andere reizigers in de herberg aanwezig.';

  @override
  String get innNewsTitle => 'Herberg Geruchten & Laatste Nieuws';

  @override
  String get innBlackjackTitle => 'Blackjack (Inzet: 50 Goud)';

  @override
  String get innBlackjackHit => 'Kaart (Hit)';

  @override
  String get innBlackjackStand => 'Passen (Stand)';

  @override
  String get btnReturnCommon => 'Terug naar de Huiskamer';

  @override
  String get innBlackjackStart => 'START RONDE (50 GOUD)';

  @override
  String get innBlackjackHitBtn => 'KAART (HIT)';

  @override
  String get innBlackjackStandBtn => 'PASSEN (STAND)';

  @override
  String get innBlackjackCommonReturn => 'TERUG NAAR DE HUISKAMER';

  @override
  String get profileBiometricReason =>
      'Bevestig je identiteit om snel in te loggen bij LOGD';

  @override
  String get innBtnDrinkAle => 'Oaktaven Ale';

  @override
  String get innBtnDrinkDragon => 'Drakenbloed';

  @override
  String get innBtnBardGold => 'Trakteer Goud';

  @override
  String get innBtnBardGem => 'Geef Gem';

  @override
  String get innBtnFlirt => 'Flirt (1 Beurt)';

  @override
  String get innBtnGift => 'Geschenk (1 Gem)';

  @override
  String get innBtnPropose => 'Vraag ten Huwelijk!';

  @override
  String get innBtnGambleDice => 'Dobbelen';

  @override
  String get innBtnGambleShell => 'Cupgame';

  @override
  String get innBtnGambleBlackjack => 'Blackjack';

  @override
  String get innBtnBribe => 'Omkopen (1 Gem)';

  @override
  String get innBtnBountyAction => 'BOUNTY';

  @override
  String innRomanceLabel(Object points) {
    return 'Toewijding: `p$points / 100`w';
  }

  @override
  String get innBtnRichest => 'Vraag wie het rijkst is (50 G)';

  @override
  String get innGambleShark => 'Kaarthaai:';

  @override
  String get innBtnHigher => 'Hoger';

  @override
  String get innBtnLower => 'Lager';

  @override
  String get innMenuBard => 'De Bard';

  @override
  String get innMenuVeteran => 'Veteraan';

  @override
  String get innMenuBounty => 'Premiejager';

  @override
  String get innMenuBuyDrink => 'KOOP DRANKJE (20 GOUD)';

  @override
  String get innDrinkSelectTitle => '=== CEDRIKS ASSORTIMENT ===';

  @override
  String get innDrinkSelectDesc =>
      'Cedrik poetst een glas en kijkt je aan: \"Wat kan ik inschenken, reiziger?\"';

  @override
  String get innDrink1Name => 'DWERGEN STOUT';

  @override
  String get innDrink1Desc =>
      'Een zwaar, donker bier. Geeft extra kracht maar maakt je slaperig. (+15 HP, -1 Beurt)';

  @override
  String get innDrink2Name => 'ELFENDRAM';

  @override
  String get innDrink2Desc =>
      'Een zoete, mousserende honingwijn. Geeft je vernieuwde energie! (+2 Beurten)';

  @override
  String labelHealCost(Object cost) {
    return 'Kosten voor volledige genezing: `y$cost goudstukken`w';
  }

  @override
  String get graveyard_title => 'Het Kerkhof van Oaktaven (Onderwereld)';

  @override
  String get graveyard_status_dead => 'STATUS: DOOD (Geest)';

  @override
  String graveyard_favor_points(Object points) {
    return 'Gunst bij Ramius: $points punten';
  }

  @override
  String get graveyard_btn_fight =>
      'Vecht tegen Gekweld Sterrenbeeld (1 Beurt)';

  @override
  String get graveyard_btn_resurrect => 'Smeek Ramius om Genade';

  @override
  String get graveyard_btn_haunt => 'Plaag de Herberg (1 Beurt)';

  @override
  String get graveyard_btn_talk => 'Praat met Ramius';

  @override
  String get ghost_combat_title => 'ONDERWERELD GEVECHT';

  @override
  String ghost_combat_monster_label(Object level, Object name) {
    return 'Monster: $name (LVL $level)';
  }

  @override
  String ghost_combat_hp_label(Object current, Object max) {
    return 'Monster HP: $current / $max';
  }

  @override
  String get ghost_combat_btn_attack => 'AANVAL';

  @override
  String get ghost_combat_btn_return => 'TERUG NAAR KERKHOF';

  @override
  String get inn_btn_leave => 'Verlaat de Herberg';

  @override
  String get inn_btn_talk_veteran => 'LUISTER NAAR VERHAAL';

  @override
  String inn_section_title(Object section) {
    return '=== $section ===';
  }

  @override
  String get inn_section_barman => '=== De Herberg Bar ===';

  @override
  String get inn_section_gamble => '=== De Goktafel ===';

  @override
  String get inn_section_veteran => '=== De Oude Krijger ===';

  @override
  String get inn_section_bounty => '=== De Premiejager ===';

  @override
  String get inn_section_spy => '=== Schimmige Figuren ===';

  @override
  String get inn_section_news => '=== Het Stadsnieuws ===';

  @override
  String get town_btn_forest => 'Betreed het Bos';

  @override
  String get town_btn_news => 'Dagelijks Nieuws';

  @override
  String get town_btn_shops => 'Winkelstraat';

  @override
  String get town_btn_mystery => 'Geheime Plekken';

  @override
  String get town_btn_training => 'Binnenplaats & Training';

  @override
  String get town_btn_heart => 'Het Dorpshart';

  @override
  String get town_sub_shops => 'Smederij';

  @override
  String get town_sub_bank => 'De Bank';

  @override
  String get town_sub_barber => 'Kapper';

  @override
  String get town_sub_alchemist => 'Alchemist';

  @override
  String get town_sub_healer => 'Kruidendokter';

  @override
  String get town_sub_alley => 'Schaduwsteeg';

  @override
  String get town_sub_classroom => 'Trainingsruimte';

  @override
  String get town_sub_stables => 'De Stables';

  @override
  String get town_sub_inn => 'De Herberg';

  @override
  String get town_sub_church => 'De Kerk';

  @override
  String get town_sub_wedding => 'Trouwkapel';

  @override
  String get town_sub_townfolk => 'Dorpsbewoners';

  @override
  String get town_sub_mightye => 'Donor MightyE';

  @override
  String get inn_news_empty =>
      'Er is vandaag niets voorgevallen in het rijk...';

  @override
  String get inn_spy_empty =>
      'Er zijn momenteel geen andere reizigers in de herberg...';

  @override
  String get inn_btn_spy_action => 'SPIONEER (10 GOUD)';

  @override
  String get inn_title => 'Herberg \'De Dronken Draak\'';

  @override
  String get dragon_lair_title => 'Het Hol van de Groene Draak';

  @override
  String get dragonShrineTitle => 'Het Drakenheiligdom';

  @override
  String dragonShrinePoints(Object amount) {
    return 'Draken Punten (DP): `y$amount`w';
  }

  @override
  String get guestPlayerName => 'Gast Reiziger';

  @override
  String get alleyBribeDefaultName => 'Een schimmige reiziger';

  @override
  String get mightyEDefaultTitle => 'Donor';

  @override
  String get defaultTravelerName => 'Reiziger';

  @override
  String get settingsSectionAccount => 'Karakter & Account';

  @override
  String get settingsSectionLanguage => 'Taal & Voorkeuren';

  @override
  String get settingsSectionCommunity => 'Over LOGD & Community';

  @override
  String get settingsLanguageTitle => 'Taalkeuze';

  @override
  String get settingsLangDutch => 'Nederlands 🇳🇱';

  @override
  String get settingsLangEnglish => 'Engels 🇬🇧';

  @override
  String get settingsAboutTitle => 'Over LOGD';

  @override
  String get settingsAboutSubtitle =>
      'Lees het verhaal achter Legend of the Golden Dragon.';

  @override
  String get settingsShareTitle => 'Deel App';

  @override
  String get settingsShareSubtitle =>
      'Nodig vrienden uit om lid te worden van het rijk.';

  @override
  String get settingsShareDialogTitle => 'Deel het Rijk';

  @override
  String get settingsRateTitle => 'Beoordeel App';

  @override
  String get settingsRateSubtitle =>
      'Geef een 5-sterren beoordeling in de Play Store.';

  @override
  String get settingsRateDialogTitle => 'Beoordeel LOGD';

  @override
  String get settingsFeedbackTitle => 'Feedback';

  @override
  String get settingsFeedbackSubtitle =>
      'Stuur ideeën of bugrapporten naar de makers.';

  @override
  String get settingsFeedbackDialogTitle => 'Stuur Feedback';

  @override
  String get settingsFeedbackHint => 'Typ hier je feedback...';

  @override
  String get settingsPrivacyTitle => 'Privacybeleid';

  @override
  String get settingsPrivacySubtitle =>
      'Bekijk hoe we omgaan met je spelersdata.';

  @override
  String get settingsPrivacyDialogTitle => 'Privacybeleid';

  @override
  String get tutorialTitle => 'Hoe te Spelen';

  @override
  String tutorialStepProgress(Object current, Object total) {
    return 'Stap $current van $total';
  }

  @override
  String get tutorialStep1Title => '1. Dorpsplein & Gebouwen';

  @override
  String get tutorialStep2Title => '2. Het Bos & Gevechten';

  @override
  String get tutorialStep3Title => '3. Smederij & Uitrusting';

  @override
  String get tutorialStep4Title => '4. Trainingsruimte & Level-Ups';

  @override
  String get tutorialStep5Title => '5. Nieuwe Dag & De Draak';

  @override
  String get settingsTutorialTitle => 'Hoe te Spelen (Handleiding)';

  @override
  String get settingsTutorialSubtitle => 'Bekijk de interactieve spelgids';

  @override
  String get globalChatTitle => 'Wereldchat';

  @override
  String get directMessagesTitle => 'Privéberichten';

  @override
  String get arenaTitle => 'PvP Arena & Duels';

  @override
  String get innRentRoom => 'Huur Kamer (50 goud)';

  @override
  String get chatSendHint => 'Typ een bericht... (Scheldwoordenfilter actief)';

  @override
  String get arenaWagerPrompt => 'Inzet (Goud):';

  @override
  String get dmSelectRecipient => 'Selecteer Ontvanger';

  @override
  String get dmNoConversations =>
      'Geen privéberichten gevonden. Tik op een speler in de Arena of Chat om een DM te starten.';

  @override
  String get arenaNoOpponents => 'Geen andere reizigers gevonden in het rijk.';

  @override
  String get arenaChallengeSent => 'Uitdaging verzonden!';

  @override
  String get dialogGuardHaltTitle => 'HALT!';

  @override
  String get authErrorEmpty => 'Vul alle velden in!';

  @override
  String get authSuccessRegister =>
      'Karakter succesvol aangemaakt! Je kunt nu inloggen.';

  @override
  String get profileSuccessUpdate => '`2Naam succesvol gewijzigd!`w';

  @override
  String get profileEmailSuccessUpdate => '`2E-mail succesvol bijgewerkt!`w';

  @override
  String get profileEmailError => '`4Kan e-mailadres niet bijwerken.`w';

  @override
  String bankSuccessDeposit(Object amount) {
    return '`2Je hebt $amount goudstukken op je rekening gestort.`w';
  }

  @override
  String bankSuccessWithdraw(Object amount) {
    return '`2Je hebt $amount goudstukken van je rekening opgenomen.`w';
  }

  @override
  String get bankErrorNoGoldOnHand => '`4Je hebt niet zoveel goud bij je!`w';

  @override
  String get bankErrorNoGoldInBank =>
      '`4Zoveel goud staat er niet op je bankrekening!`w';

  @override
  String get bankErrorInvalid => '`4Voer een geldig bedrag in!`w';

  @override
  String smithySuccessBuy(Object name) {
    return '`2Je hebt met succes geüpgraded naar: $name!`w';
  }

  @override
  String alchemistSuccessBuy(Object boost) {
    return '`2Je drinkt het elixir op. Een intense energie stroomt direct door je lichaam! Je hebt $boost ontvangen.`w';
  }

  @override
  String stablesSuccessBuy(Object mount) {
    return '`2Je hebt succesvol een $mount gekocht! De stalmeester brengt je nieuwe metgezel naar buiten.`w';
  }

  @override
  String get profilePasswordSuccessUpdate =>
      '`2Wachtwoord succesvol gewijzigd!`w';

  @override
  String get profilePasswordErrorEmpty => '`4Voer een nieuw wachtwoord in!`w';

  @override
  String get profilePasswordError => '`4Kan wachtwoord niet wijzigen.`w';

  @override
  String get settingsFeedbackSent =>
      '`2Bedankt! Je feedback is in goede orde ontvangen.`w';

  @override
  String get profileBiometricDeviceError =>
      'Dit apparaat ondersteunt geen biometrie.';

  @override
  String get profileBiometricAuthError => 'Verificatie mislukt.';

  @override
  String get profileDatabaseError => 'Er is een fout opgetreden.';

  @override
  String get errorNoGems => 'Je hebt niet genoeg glimmende edelstenen!';
}
