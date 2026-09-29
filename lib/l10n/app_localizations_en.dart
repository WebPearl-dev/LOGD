// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

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
    return 'Gold: $amount';
  }

  @override
  String statGems(Object amount) {
    return 'Gems: $amount';
  }

  @override
  String statTurns(Object amount) {
    return 'Turns: $amount';
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
    return 'Honor: $amount';
  }

  @override
  String statPvpWins(Object losses, Object wins) {
    return 'Wins: $wins | Losses: $losses';
  }

  @override
  String get btnGoToForest => 'Enter the forest';

  @override
  String get btnAttack => 'Attack';

  @override
  String get btnFlee => 'Flee';

  @override
  String get btnReturnTown => 'Return to town';

  @override
  String get btnSave => 'Save';

  @override
  String get btnCancel => 'Cancel';

  @override
  String get btnClose => 'Close';

  @override
  String get btnLogin => 'Login';

  @override
  String get btnRegister => 'Create Character';

  @override
  String get btnConfirmRace => 'Confirm choice and start adventure';

  @override
  String get btnConfirmSpecialty => 'Choose class and enter the Town Square';

  @override
  String get btnUseSkill => 'Skill';

  @override
  String get btnBuyUpgrade => 'Buy Upgrade';

  @override
  String get btnVisitBank => 'Bank';

  @override
  String get btnVisitSmithy => 'Shops';

  @override
  String get btnVisitPegasus => 'Visit Pegasus Weapons';

  @override
  String get btnVisitMerilon => 'Visit Merilon Armour';

  @override
  String get btnTalkPegasus => 'Talk to Pegasus';

  @override
  String get btnTalkMerilon => 'Talk to Merilon';

  @override
  String get btnChallengeMaster => 'Challenge Master to duel';

  @override
  String get btnVisitTraining => 'Training Room';

  @override
  String get btnEventFountainDive => 'Dive in';

  @override
  String get btnEventFountainLeave => 'Walk away';

  @override
  String get btnEventGiantSneak => 'Sneak past';

  @override
  String get btnEventGiantSteal => 'Try to steal';

  @override
  String get btnGraveyardOfferGem => 'Offer 1 Gem';

  @override
  String get btnGraveyardOfferXp => 'Offer 100 XP';

  @override
  String get btnGraveyardAcceptLot => 'Accept your fate (Wait until tomorrow)';

  @override
  String get btnGraveyardRob => 'ROB GRAVE';

  @override
  String get btnStartDay => 'Begin the new day';

  @override
  String get btnHermitDrink => 'Drink herbal tea';

  @override
  String get btnInnRoll => 'Roll dice';

  @override
  String get btnVisitInn => 'Inn';

  @override
  String get btnVisitStables => 'Stables';

  @override
  String get btnChurchPray => 'Say a Prayer';

  @override
  String get btnChurchConfess => 'Confess Sins';

  @override
  String get btnChurchCandle => 'Light a Candle (1 Gem)';

  @override
  String get btnVisitChurch => 'Church';

  @override
  String get btnBuyAtkPotion => 'Buy Dragon Blood (+5 Atk)';

  @override
  String get btnBuyDefPotion => 'Buy Ironskin (+5 Def)';

  @override
  String get btnVisitAlchemist => 'Alchemist';

  @override
  String get btnVisitHealer => 'Herbalist 🌿';

  @override
  String get btnBuyHealing => 'BUY HEALING';

  @override
  String get btnVisitBarber => 'BARBER WITH STYLING';

  @override
  String get btnBuyTitle => 'BUY TITLE (1 GEM)';

  @override
  String get btnVisitAlley => 'SHADOWY ALLEY 🪓';

  @override
  String get btnResetReputation => 'BUY OFF CRIMINAL RECORD (5 GEMS)';

  @override
  String get btnVisitMightyE => 'DONOR MIGHTYE 💎';

  @override
  String get btnDonateGem => 'DONATE 1 GEM';

  @override
  String get btnVisitWedding => 'WEDDING CHAPEL 💍';

  @override
  String get btnMarry => 'I DO (500 GOLD)';

  @override
  String get btnStyxOnboard => 'BOARD THE RAFT (COSTS 2 TURNS)';

  @override
  String get btnStyxStay => 'REMAIN ON THE SHORE';

  @override
  String get btnWhispersListen => 'LISTEN ATTENTIVELY';

  @override
  String get btnWhispersLeave => 'FLOAT AWAY QUICKLY';

  @override
  String get btn_attack_dragon => 'Attack the Green Dragon!';

  @override
  String get btn_sneak_away => 'Sneak away quietly';

  @override
  String get btn_dragon_continue => 'Accept your fate';

  @override
  String get btnDevHeal => 'Heal Fully (Full HP)';

  @override
  String get btnDevGold => 'Give +10,000 Gold';

  @override
  String get btnDevGems => 'Give +5 Gems';

  @override
  String get btnDevTurns => 'Give +10 Turns';

  @override
  String get btnDevLevelUp => 'Direct Level Up (+1 Lvl)';

  @override
  String get btnDevAddGold => '+10K GOLD';

  @override
  String get btnDevAddGems => '+5 GEMS';

  @override
  String get btnDevAddTurns => '+10 TURNS';

  @override
  String get btnDevSpawnAction => 'SPAWN DIRECTLY 🚀';

  @override
  String btnBuyCut(Object cost) {
    return 'Fresh Cut ($cost Gold)';
  }

  @override
  String btnBuyShave(Object cost) {
    return 'Smooth Shave ($cost Gold)';
  }

  @override
  String get btnBuyDye => 'Dye Hair (1 GEM)';

  @override
  String get btnUpgradeAtk => 'PERMANENT ATTACK (+1 ATK)';

  @override
  String get btnUpgradeDef => 'PERMANENT DEFENSE (+1 DEF)';

  @override
  String get btnUpgradeHp => 'PERMANENT VITALITY (+5 HP)';

  @override
  String get btnUpgradeTurns => 'FOREST WALKER BLESSING (+1 TURN)';

  @override
  String get btnVisitDragonShrine => 'Dragon Shrine';

  @override
  String get profileSaveName => 'Save Name';

  @override
  String get profileSaveEmail => 'Save Email';

  @override
  String get profileChangePassword => 'Change Password';

  @override
  String get profileNewPasswordLabel => 'New Password';

  @override
  String get profileSavePassword => 'Save Password';

  @override
  String get settingsBtnShare => 'Share now';

  @override
  String get settingsBtnRate => 'Rate now';

  @override
  String get settingsBtnSend => 'Send';

  @override
  String get tutorialBtnPrevious => 'Previous';

  @override
  String get tutorialBtnNext => 'Next';

  @override
  String get tutorialBtnSkip => 'Skip';

  @override
  String get tutorialBtnFinish => 'Got it / Start Game';

  @override
  String get btnSend => 'Send';

  @override
  String get btnDm => 'Direct Message';

  @override
  String get btnChallenge => 'Challenge';

  @override
  String get arenaAccept => 'Accept';

  @override
  String get arenaDecline => 'Decline';

  @override
  String get townChatButton => 'World Chat';

  @override
  String get townArenaButton => 'PvP Arena';

  @override
  String get btnOk => 'OK';

  @override
  String get btnTalkTownfolk => 'TALK TO TOWNSFOLK 🗣️';

  @override
  String get btnForestLeprechaunPlay => 'Play game (100 G)';

  @override
  String get btnForestWalkAway => 'WALK AWAY';

  @override
  String get btnForestWizardDrink => 'Drink from cauldron';

  @override
  String get btnForestWagonSearch => 'Search thoroughly';

  @override
  String get btnForestWagonSmash => 'Smash chests';

  @override
  String get btnForestHartBow => 'Bow respectfully';

  @override
  String get btnForestHartHunt => 'Try to hunt';

  @override
  String get btnForestCardHigher => 'Higher';

  @override
  String get btnForestCardLower => 'Lower';

  @override
  String get btnForestTreeGold => 'Give gold';

  @override
  String get btnForestTreeChop => 'Chop bark';

  @override
  String get btnForestTempleRead => 'Read book';

  @override
  String get btnForestTempleSearch => 'Search altar';

  @override
  String get btnForestHerbalistRed => 'Red elixir';

  @override
  String get btnForestHerbalistBlue => 'Blue elixir';

  @override
  String get btnForestBadgerAnswer => 'Answer question';

  @override
  String get btnForestBadgerHunt => 'Chase away';

  @override
  String get btnForestSkeletonPlunder => 'Plunder armour';

  @override
  String get btnForestSkeletonBow => 'Pay respect';

  @override
  String get btnForestCarnivalSpin => 'Spin wheel';

  @override
  String get btnForestCampEat => 'Eat soup';

  @override
  String get btnForestCampSearch => 'Search tents';

  @override
  String get btnForestWellOffer => 'Offer gem';

  @override
  String get btnForestWellFish => 'Fish for gold';

  @override
  String get btnForestHoneyClimb => 'Grab honey';

  @override
  String get btnForestHoneySmoke => 'Smoke bees';

  @override
  String get btnForestMushroomStep => 'Step into ring';

  @override
  String get btnForestMushroomDestroy => 'Destroy ring';

  @override
  String get btnForestHunterPlay => 'Shooting match';

  @override
  String get btnForestHunterDemand => 'Demand gold';

  @override
  String get btnForestStatueOffer => 'Offer gold';

  @override
  String get btnForestStatueClean => 'Clean statue';

  @override
  String get btnForestSnareCut => 'Cut loose';

  @override
  String get btnForestSnareForce => 'Use force';

  @override
  String get btnForestSnareWait => 'Wait';

  @override
  String get wep0 => 'Bare Fists';

  @override
  String get wep1 => 'Wooden Stick';

  @override
  String get wep2 => 'Rusty Dagger';

  @override
  String get wep3 => 'Hand Axe';

  @override
  String get wep4 => 'Iron Short Sword';

  @override
  String get wep5 => 'Steel Broadsword';

  @override
  String get wep6 => 'Large War Hammer';

  @override
  String get wep7 => 'Crossed Halberd';

  @override
  String get wep8 => 'Elven Crossbow';

  @override
  String get wep9 => 'Rune Sword';

  @override
  String get wep10 => 'Mace of Dove';

  @override
  String get wep11 => 'Shining Club';

  @override
  String get wep12 => 'Obsidian Blade';

  @override
  String get wep13 => 'Dragonbone Spear';

  @override
  String get wep14 => 'Heavenly Sword';

  @override
  String get wep15 => 'Excalibur of Oaktaven';

  @override
  String get arm0 => 'Everyday Clothing';

  @override
  String get arm1 => 'Leather Vest';

  @override
  String get arm2 => 'Thick Boiled Leather';

  @override
  String get arm3 => 'Studded Leather Armor';

  @override
  String get arm4 => 'Ring Mail';

  @override
  String get arm5 => 'Light Chainmail';

  @override
  String get arm6 => 'Heavy Steel Chainmail';

  @override
  String get arm7 => 'Banded Mail';

  @override
  String get arm8 => 'Elven Breastplate';

  @override
  String get arm9 => 'Chiseled Bronze Armor';

  @override
  String get arm10 => 'Knightly Plate Armor';

  @override
  String get arm11 => 'Rune Protection';

  @override
  String get arm12 => 'Obsidian Shield & Armor';

  @override
  String get arm13 => 'Dragonhide Shields';

  @override
  String get arm14 => 'Paladin Cuirass';

  @override
  String get arm15 => 'The God Armor';

  @override
  String get mount0 => 'None';

  @override
  String get mount1 => 'Pony';

  @override
  String get mount2 => 'Warhorse';

  @override
  String get mount3 => 'Shadow Wolf';

  @override
  String get mount4 => 'Golden Dragon';

  @override
  String get smithyMaxLevel =>
      '`gYou already possess the absolute best equipment in the realm!`w';

  @override
  String get stablesMaxLevel =>
      '`gYou already own the legendary Golden Dragon! The stable master looks at your mount with total awe.`w';

  @override
  String get devSuccessMessage =>
      '`p[DEV] Stat successfully adjusted in the cloud!`w';

  @override
  String get lblDevSelectEvent => 'Select Event to Spawn:';

  @override
  String get lblDevSelectMonster => 'Select Monster to Spawn:';

  @override
  String get smithyErrorUnknown => '`4An unknown error occurred.`w';

  @override
  String get smithyErrorNoGold =>
      '`4The smith laughs at you: \"You do not have enough gold pieces on hand!\"`w';

  @override
  String get alchemistLimitReached =>
      'Hold on! You have already bought 2 elixers today. Your body cannot take more until the next sunrise!';

  @override
  String get alchemistErrorAlreadyActive =>
      '`4You already have an active boost from this elixir! Drinking more is pure poison for your body.`w';

  @override
  String get dialogRumorTitle => 'TOWN RUMORS';

  @override
  String get dialogWoundedTitle => 'TOO SEVERELY WOUNDED';

  @override
  String get dialogWoundedMessage =>
      '`4You are too severely wounded to fight. Visit the Herbalist or the inn to recover!`w';

  @override
  String get townSquareRumorFallback => 'The townsfolk are quiet today...';

  @override
  String get healerFallbackHealthy => 'You are already perfectly healthy!';

  @override
  String get healerSuccessFallback => 'You are healed!';

  @override
  String get townCrierPrefix => '`4HEAR YE, HEAR YE! `w';

  @override
  String get defaultUsername => 'Traveler';

  @override
  String get newsUnknownPlayer => 'Unknown Traveler';

  @override
  String get newsUnknownPartner => 'someone';

  @override
  String get innRoomRentedMessage =>
      'You rented a safe room in the inn! You are now protected from offline PK attacks.';

  @override
  String get innRoomErrorNoGold =>
      'You do not have enough gold (50 gold required) to rent a room!';

  @override
  String get resetNewDayTitle => 'A New Day Dawns!';

  @override
  String get resetNightResults => 'Results of the night:';

  @override
  String resetInterestLog(Object amount) {
    return '• The bank has credited `y$amount gold`w in interest (2%).';
  }

  @override
  String resetTurnsLog(Object amount) {
    return '• Your turns are replenished to `c$amount`w.';
  }

  @override
  String get resetReadyLog => '• You feel rested and ready for battle!';

  @override
  String arenaVictory(Object gold, Object honor) {
    return '`2You won the PvP duel and earned $gold gold and $honor honor!`w';
  }

  @override
  String arenaDefeat(Object opponent) {
    return '`4You were defeated in the PvP duel by $opponent!`w';
  }

  @override
  String trainingDuelTitle(Object name) {
    return '=== DUEL WITH $name ===';
  }

  @override
  String get btnForestFountainDive => 'Dive in';

  @override
  String get btnForestGiantSteal => 'Try to steal';

  @override
  String get btnForestGiantSneak => 'Sneak past';

  @override
  String get newsEmpty =>
      '`wThe notice board is currently empty. It is a quiet day in the realm...`w';

  @override
  String get authTitle => 'Access to the Realm';

  @override
  String get authEmail => 'Email address';

  @override
  String get authPassword => 'Password';

  @override
  String get authUsername => 'Character Name (Registration only)';

  @override
  String get authSwitchToRegister => 'New here? Create a character';

  @override
  String get authSwitchToLogin => 'Already have a character? Log in here';

  @override
  String get authGuestLogin => 'Play as guest';

  @override
  String get profileTitle => 'Character Settings';

  @override
  String get profileChangeName => 'Change Character Name';

  @override
  String get profileDeleteAccount => 'Permanently Delete Character';

  @override
  String get profileDeleteWarning =>
      'Are you sure? This will delete all your gold, levels, and XP permanently!';

  @override
  String get profileLogout => 'Leave the Realm (Logout)';

  @override
  String get profileBiometricToggle => 'Biometric login (Fingerprint/FaceID)';

  @override
  String get profileChangeEmail => 'Change Email Address';

  @override
  String get bankTitle => 'The Central Bank of the Realm';

  @override
  String bankInBank(Object amount) {
    return 'Gold in bank: `y$amount gold pieces`w';
  }

  @override
  String bankOnHand(Object amount) {
    return 'Gold on hand: `y$amount gold pieces`w';
  }

  @override
  String get btnDepositAll => 'Deposit all';

  @override
  String get btnWithdrawAll => 'Withdraw all';

  @override
  String get btnDepositCustom => 'Deposit amount';

  @override
  String get btnWithdrawCustom => 'Withdraw amount';

  @override
  String bankVaultBalance(Object amount) {
    return 'Vault Balance: `y$amount gold`w';
  }

  @override
  String bankOnHandLabel(Object amount) {
    return 'On hand: `y$amount gold`w';
  }

  @override
  String bankDepositLimitLabel(Object amount) {
    return 'Deposit limit left: `c$amount gold`w';
  }

  @override
  String get btnTalkBanker => 'Talk to the banker';

  @override
  String get raceTitle => 'Choose your Race';

  @override
  String get raceHuman => 'Human';

  @override
  String get raceHumanDesc =>
      'Balanced and driven. Starts with `y+5 extra turns`w for today.';

  @override
  String get raceElf => 'Elf';

  @override
  String get raceElfDesc =>
      'Elegant and mystic. Starts with `c+1 shiny gem`w on hand.';

  @override
  String get raceDwarf => 'Dwarf';

  @override
  String get raceDwarfDesc =>
      'Robust and loves gold. Starts with `y+100 extra starting gold`w.';

  @override
  String get raceOrc => 'Orc';

  @override
  String get raceOrcDesc => 'Brutal and strong. Starts with `r+5 maximum HP`w.';

  @override
  String get specialtyTitle => 'Choose your Specialty';

  @override
  String get specMagic => 'Mystic Powers (Magic)';

  @override
  String get specMagicDesc =>
      'Master of elements. Starts with the spell `cRegeneration`w to heal yourself in combat.';

  @override
  String get specThieving => 'Theft (Thieving)';

  @override
  String get specThievingDesc =>
      'Fast and sly. Starts with the skill `yPickpocket`w to knock extra gold out of monsters.';

  @override
  String get specWarrior => 'Warrior';

  @override
  String get specWarriorDesc =>
      'Brute strength and steel. Starts with the skill `rShield Bash`w for extra heavy hits.';

  @override
  String get smithyTitle => 'Smithy \'The Hot Iron\'';

  @override
  String get smithyCurrentEquip => 'Current equipment:';

  @override
  String smithyWeaponLabel(Object lvl, Object name) {
    return 'Weapon: `c$name`w (Lvl $lvl)';
  }

  @override
  String smithyArmorLabel(Object lvl, Object name) {
    return 'Armor: `c$name`w (Lvl $lvl)';
  }

  @override
  String get smithyUpgradeAvailable => 'Next upgrade available:';

  @override
  String smithyCostLabel(Object cost) {
    return 'Cost: `y$cost gold pieces`w (trade-in value applied)';
  }

  @override
  String get smithyAmountLabel => 'Amount of gold pieces';

  @override
  String get smithyTabWeapons => 'Weapons';

  @override
  String get smithyTabArmor => 'Armor';

  @override
  String get trainingTitle => 'The Training Room of the Masters';

  @override
  String get trainingStatusTitle => '=== STATUS ===';

  @override
  String trainingCurrentLevel(Object level) {
    return 'Current Level: `yLevel $level`w';
  }

  @override
  String trainingMasterHp(Object current, Object max) {
    return 'MASTER HP: `4$current / $max`w';
  }

  @override
  String trainingXpLabel(Object current, Object needed) {
    return 'Experience (XP): `c$current / $needed`w';
  }

  @override
  String get forestTitle => 'The Dark Forest';

  @override
  String get graveyardTitle => 'The Shadowy Graveyard';

  @override
  String get newsTitle => 'The Daily News of the Realm';

  @override
  String get rankingsTitle => 'The Hall of Fame';

  @override
  String get rankingsWelcome => 'The mightiest warriors of the realm:';

  @override
  String get rankingsEmpty => 'No legendary heroes have risen yet...';

  @override
  String get townCrierTitle => 'The Town Crier';

  @override
  String get btnVisitNews => 'Daily News';

  @override
  String get devTitle => '=== GOD MODE: DEV MENU ===';

  @override
  String get devScreenTitle => 'MASTER DEV CONSOLE';

  @override
  String get devSpawnMonsterTitle => '=== SPAWN MONSTER TEST ===';

  @override
  String get devSpawnMonsterDesc =>
      'Click on a monster below to directly force a fight in the forest and check the balance:';

  @override
  String get innTitle => 'Inn \'The Drunken Dragon\'';

  @override
  String get innDiceTitle => '=== THE GAMBLE TABLE ===';

  @override
  String get innDiceDesc =>
      'Bet gold to roll dice against the tavern masters. Highest roll wins!';

  @override
  String get stablesTitle => 'The Royal Stables';

  @override
  String stablesCurrentMount(Object mount) {
    return 'Your current mount: `c$mount`w';
  }

  @override
  String get stablesNoMount => 'None (You travel on foot)';

  @override
  String get stablesUpgradeAvailable => '=== AVAILABLE MOUNT ===';

  @override
  String stablesCostLabel(Object gold) {
    return 'Price: `y$gold gold`w';
  }

  @override
  String stablesCostGemsLabel(Object gems, Object gold) {
    return 'Price: `y$gold goud`w & `c$gems Gems`w';
  }

  @override
  String stablesBonusLabel(Object def, Object turns) {
    return 'Bonus: `2+$def Def`w | `p+$turns Turns per day`w';
  }

  @override
  String get churchTitle => 'The Serene Monastery';

  @override
  String get alchemistTitle => 'The Alchemist';

  @override
  String alchemistCurrentBoosts(Object atk, Object def) {
    return 'Active elixirs: `2$atk Atk`w | `c$def Def`w';
  }

  @override
  String alchemistTodayCounter(Object count) {
    return 'Elixirs bought today: $count/2';
  }

  @override
  String get innMenuGamble => 'Gamble Table';

  @override
  String get innMenuBartender => 'Bartender Cedrik';

  @override
  String get innMenuFlirt => 'Barmaid Violet';

  @override
  String get innFlirtAttempt => 'Flirt with Violet (-1 Gem)';

  @override
  String get innFlirtNoGems => 'You do not have any gems to gift her!';

  @override
  String get innTalkCedrik => 'Talk to Cedrik';

  @override
  String get innMenuMain => 'The Common Room';

  @override
  String get innMenuSpy => 'Spy on People';

  @override
  String get innMenuNews => 'Read Newspaper & Rumors';

  @override
  String get innMenuBlackjack => 'Card Table: Blackjack';

  @override
  String get innSpySelect => 'Choose a target to spy on:';

  @override
  String get innSpyNoTargets =>
      'There are currently no other travelers sleeping in the inn.';

  @override
  String get innNewsTitle => 'Inn Rumors & Latest News';

  @override
  String get innBlackjackTitle => 'Blackjack (Bet: 50 Gold)';

  @override
  String get innBlackjackHit => 'Hit (Card)';

  @override
  String get innBlackjackStand => 'Stand';

  @override
  String get btnReturnCommon => 'Return to the Common Room';

  @override
  String get innBlackjackStart => 'START ROUND (50 GOLD)';

  @override
  String get innBlackjackHitBtn => 'HIT (CARD)';

  @override
  String get innBlackjackStandBtn => 'STAND (PASS)';

  @override
  String get innBlackjackCommonReturn => 'RETURN TO THE COMMON ROOM';

  @override
  String get profileBiometricReason =>
      'Confirm your identity to log in quickly to LOGD';

  @override
  String get innBtnDrinkAle => 'Oaktaven Ale';

  @override
  String get innBtnDrinkDragon => 'Dragon\'s Breath';

  @override
  String get innBtnBardGold => 'Treat Gold';

  @override
  String get innBtnBardGem => 'Give Gem';

  @override
  String get innBtnFlirt => 'Flirt (1 Turn)';

  @override
  String get innBtnGift => 'Gift (1 Gem)';

  @override
  String get innBtnPropose => 'Propose Marriage!';

  @override
  String get innBtnGambleDice => 'Dice';

  @override
  String get innBtnGambleShell => 'Shell Game';

  @override
  String get innBtnGambleBlackjack => 'Blackjack';

  @override
  String get innBtnBribe => 'Bribe (1 Gem)';

  @override
  String get innBtnBountyAction => 'BOUNTY';

  @override
  String innRomanceLabel(Object points) {
    return 'Affection: `p$points / 100`w';
  }

  @override
  String get innBtnRichest => 'Ask who is richest (50 G)';

  @override
  String get innGambleShark => 'Card Shark:';

  @override
  String get innBtnHigher => 'Higher';

  @override
  String get innBtnLower => 'Lower';

  @override
  String get innMenuBard => 'The Bard';

  @override
  String get innMenuVeteran => 'Veteran';

  @override
  String get innMenuBounty => 'Bounty Hunter';

  @override
  String get innMenuBuyDrink => 'BUY DRINK (20 GOLD)';

  @override
  String get innDrinkSelectTitle => '=== CEDRIKS ASSORTIMENT ===';

  @override
  String get innDrinkSelectDesc =>
      'Cedrik polishes a glass and looks at you: \"What can I pour for you, traveler?\"';

  @override
  String get innDrink1Name => 'DWARVEN STOUT';

  @override
  String get innDrink1Desc =>
      'A heavy, dark beer. Gives extra strength but makes you sleepy. (+15 HP, -1 Turn)';

  @override
  String get innDrink2Name => 'ELVEN MEAD';

  @override
  String get innDrink2Desc =>
      'A sweet, sparkling honey wine. Gives you renewed energy! (+2 Turns)';

  @override
  String labelHealCost(Object cost) {
    return 'Cost for full healing: `y$cost gold pieces`w';
  }

  @override
  String get graveyard_title => 'The Graveyard of Oaktaven (Underworld)';

  @override
  String get graveyard_status_dead => 'STATUS: DEAD (Ghost)';

  @override
  String graveyard_favor_points(Object points) {
    return 'Favor with Ramius: $points points';
  }

  @override
  String get graveyard_btn_fight => 'Fight Tormented Constellation (1 Turn)';

  @override
  String get graveyard_btn_resurrect => 'Beg Ramius for Mercy';

  @override
  String get graveyard_btn_haunt => 'Haunt the Inn (1 Turn)';

  @override
  String get graveyard_btn_talk => 'Talk to Ramius';

  @override
  String get ghost_combat_title => 'UNDERWORLD COMBAT';

  @override
  String ghost_combat_monster_label(Object level, Object name) {
    return 'Monster: $name (LVL $level)';
  }

  @override
  String ghost_combat_hp_label(Object current, Object max) {
    return 'Monster HP: $current / $max';
  }

  @override
  String get ghost_combat_btn_attack => 'ATTACK';

  @override
  String get ghost_combat_btn_return => 'RETURN TO GRAVEYARD';

  @override
  String get inn_btn_leave => 'Leave the Inn';

  @override
  String get inn_btn_talk_veteran => 'LISTEN TO STORY';

  @override
  String inn_section_title(Object section) {
    return '=== $section ===';
  }

  @override
  String get inn_section_barman => '=== The Inn Bar ===';

  @override
  String get inn_section_gamble => '=== The Gamble Table ===';

  @override
  String get inn_section_veteran => '=== The Old Warrior ===';

  @override
  String get inn_section_bounty => '=== The Bounty Hunter ===';

  @override
  String get inn_section_spy => '=== Shadowy Figures ===';

  @override
  String get inn_section_news => '=== The Town News ===';

  @override
  String get town_btn_forest => 'Enter the Forest';

  @override
  String get town_btn_news => 'Daily News';

  @override
  String get town_btn_shops => 'Shopping Street';

  @override
  String get town_btn_mystery => 'Mysterious Places';

  @override
  String get town_btn_training => 'Courtyard & Training';

  @override
  String get town_btn_heart => 'The Town Heart';

  @override
  String get town_sub_shops => 'Smithy';

  @override
  String get town_sub_bank => 'The Bank';

  @override
  String get town_sub_barber => 'Barber';

  @override
  String get town_sub_alchemist => 'Alchemist';

  @override
  String get town_sub_healer => 'Herbalist';

  @override
  String get town_sub_alley => 'Shadowy Alley';

  @override
  String get town_sub_classroom => 'Training Room';

  @override
  String get town_sub_stables => 'The Stables';

  @override
  String get town_sub_inn => 'The Inn';

  @override
  String get town_sub_church => 'The Church';

  @override
  String get town_sub_wedding => 'Wedding Chapel';

  @override
  String get town_sub_townfolk => 'Townsfolk';

  @override
  String get town_sub_mightye => 'Donor Mightye';

  @override
  String get inn_news_empty => 'Nothing has occurred in the realm today...';

  @override
  String get inn_spy_empty =>
      'There are currently no other travelers wandering in the inn...';

  @override
  String get inn_btn_spy_action => 'SPY (10 GOLD)';

  @override
  String get inn_title => 'Inn \'The Drunken Dragon\'';

  @override
  String get dragon_lair_title => 'The Green Dragon\'s Lair';

  @override
  String get dragonShrineTitle => 'The Dragon Shrine';

  @override
  String dragonShrinePoints(Object amount) {
    return 'Dragon Points (DP): `y$amount`w';
  }

  @override
  String get guestPlayerName => 'Guest Traveler';

  @override
  String get alleyBribeDefaultName => 'A shady traveler';

  @override
  String get mightyEDefaultTitle => 'Donor';

  @override
  String get defaultTravelerName => 'Traveler';

  @override
  String get settingsSectionAccount => 'Character & Account';

  @override
  String get settingsSectionLanguage => 'Language & Preferences';

  @override
  String get settingsSectionCommunity => 'About LOGD & Community';

  @override
  String get settingsLanguageTitle => 'Language Selector';

  @override
  String get settingsLangDutch => 'Dutch 🇳🇱';

  @override
  String get settingsLangEnglish => 'English 🇬🇧';

  @override
  String get settingsAboutTitle => 'About LOGD';

  @override
  String get settingsAboutSubtitle =>
      'Read the story behind Legend of the Golden Dragon.';

  @override
  String get settingsShareTitle => 'Share App';

  @override
  String get settingsShareSubtitle => 'Invite friends to join the realm.';

  @override
  String get settingsShareDialogTitle => 'Share the Realm';

  @override
  String get settingsRateTitle => 'Rate App';

  @override
  String get settingsRateSubtitle => 'Leave a 5-star review in the Play Store.';

  @override
  String get settingsRateDialogTitle => 'Rate LOGD';

  @override
  String get settingsFeedbackTitle => 'Feedback';

  @override
  String get settingsFeedbackSubtitle =>
      'Send ideas or bug reports to creators.';

  @override
  String get settingsFeedbackDialogTitle => 'Send Feedback';

  @override
  String get settingsFeedbackHint => 'Type your feedback here...';

  @override
  String get settingsPrivacyTitle => 'Privacy Policy';

  @override
  String get settingsPrivacySubtitle => 'View how we handle your player data.';

  @override
  String get settingsPrivacyDialogTitle => 'Privacy Policy';

  @override
  String get tutorialTitle => 'How to Play';

  @override
  String tutorialStepProgress(Object current, Object total) {
    return 'Step $current of $total';
  }

  @override
  String get tutorialStep1Title => '1. Town Square & Buildings';

  @override
  String get tutorialStep2Title => '2. The Forest & Combat';

  @override
  String get tutorialStep3Title => '3. Smithy & Equipment';

  @override
  String get tutorialStep4Title => '4. Training Grounds & Level-Ups';

  @override
  String get tutorialStep5Title => '5. New Day & The Dragon';

  @override
  String get settingsTutorialTitle => 'How to Play (Tutorial)';

  @override
  String get settingsTutorialSubtitle => 'View the interactive game guide';

  @override
  String get globalChatTitle => 'Global Chat';

  @override
  String get directMessagesTitle => 'Direct Messages';

  @override
  String get arenaTitle => 'PvP Arena & Duels';

  @override
  String get innRentRoom => 'Rent Room (50 gold)';

  @override
  String get chatSendHint => 'Type a message... (Profanity filter active)';

  @override
  String get arenaWagerPrompt => 'Wager (Gold):';

  @override
  String get dmSelectRecipient => 'Select Recipient';

  @override
  String get dmNoConversations =>
      'No direct messages found. Tap a player in the Arena or Chat to start a DM.';

  @override
  String get arenaNoOpponents => 'No other rectors found in the realm.';

  @override
  String get arenaChallengeSent => 'Challenge sent!';

  @override
  String get dialogGuardHaltTitle => 'HALT!';

  @override
  String get authErrorEmpty => 'Please fill in all fields!';

  @override
  String get authSuccessRegister =>
      'Character successfully created! You can now log in.';

  @override
  String get profileSuccessUpdate => '`2Name successfully changed!`w';

  @override
  String get profileEmailSuccessUpdate => '`2Email successfully updated!`w';

  @override
  String get profileEmailError => '`4Failed to update email address.`w';

  @override
  String bankSuccessDeposit(Object amount) {
    return '`2You have deposited $amount gold pieces into your account.`w';
  }

  @override
  String bankSuccessWithdraw(Object amount) {
    return '`2You have withdrawn $amount gold pieces from your account.`w';
  }

  @override
  String get bankErrorNoGoldOnHand =>
      '`4You do not have that much gold on hand!`w';

  @override
  String get bankErrorNoGoldInBank =>
      '`4That much gold is not in your bank account!`w';

  @override
  String get bankErrorInvalid => '`4Please enter a valid amount!`w';

  @override
  String smithySuccessBuy(Object name) {
    return '`2You have successfully upgraded to: $name!`w';
  }

  @override
  String alchemistSuccessBuy(Object boost) {
    return '`2You drink the elixir. An intense energy immediately flows through your body! You have received $boost.`w';
  }

  @override
  String stablesSuccessBuy(Object mount) {
    return '`2You have successfully bought a $mount! The stable master brings your new companion outside.`w';
  }

  @override
  String get profilePasswordSuccessUpdate =>
      '`2Password changed successfully!`w';

  @override
  String get profilePasswordErrorEmpty => '`4Please enter a new password!`w';

  @override
  String get profilePasswordError => '`4Failed to change password.`w';

  @override
  String get settingsFeedbackSent =>
      '`2Thank you! Your feedback has been received.`w';

  @override
  String get profileBiometricDeviceError =>
      'This device does not support biometrics.';

  @override
  String get profileBiometricAuthError => 'Verification failed.';

  @override
  String get profileDatabaseError => 'An error occurred.';

  @override
  String get errorNoGems => 'You do not have enough shiny gems!';
}
