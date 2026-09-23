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
  String enemyDefeated(Object enemy, Object gold, Object xp) {
    return '`2You have defeated the $enemy! `w\nYou earn `y$gold gold `wand `c$xp experience`w!';
  }

  @override
  String playerDied(Object enemy) {
    return '`4You have succumbed to your wounds from the $enemy... You are DEAD! `w\nYou lose all gold on hand.';
  }

  @override
  String roundContinue(
    Object attackText,
    Object damageDealt,
    Object damageReceived,
    Object enemy,
  ) {
    return '`2You attack and deal $damageDealt damage to the $enemy.`w(\nThe $enemy $attackText) and deals `4$damageReceived damage`w back!';
  }

  @override
  String fleeSuccess(Object enemy) {
    return '`gYou run away fast and safely escape from the $enemy!`w';
  }

  @override
  String fleeFailed(Object damage, Object enemy) {
    return '`4Fleeing failed! The $enemy blocks your path and deals $damage damage during your escape attempt!`w';
  }

  @override
  String get townSquareWelcome =>
      '`gWelcome to the Town Square of `yLord of the Golden Dragon`w!\n\nThe sun shines over the realm. Travelers talk in the shade, and in the distance you hear the roaring from the forest... What are you going to do today?`w';

  @override
  String get btnGoToForest => 'Enter the forest';

  @override
  String get forestSearching =>
      '`gYou carefully sneak through the dense undergrowth in search of danger...`w';

  @override
  String get btnAttack => 'Attack';

  @override
  String get btnFlee => 'Flee';

  @override
  String get btnReturnTown => 'Return to town';

  @override
  String enemyHpLabel(Object current, Object enemy, Object max) {
    return '$enemy HP: $current/$max';
  }

  @override
  String combatEncounterStart(Object enemy) {
    return '`wYou come face to face with a $enemy!\n\n`w';
  }

  @override
  String get forestNoTurns => '`4You have no turns left for today!`w';

  @override
  String get fleeFailedDeathSuffix =>
      '\n`4You succumbed to your wounds... You are DEAD!`w';

  @override
  String get authTitle => 'Access to the Realm';

  @override
  String get authEmail => 'Email address';

  @override
  String get authPassword => 'Password';

  @override
  String get authUsername => 'Character Name (Registration only)';

  @override
  String get btnLogin => 'Login';

  @override
  String get btnRegister => 'Create Character';

  @override
  String get authSwitchToRegister => 'New here? Create a character';

  @override
  String get authSwitchToLogin => 'Already have a character? Log in here';

  @override
  String get authGuestLogin => 'Play as guest';

  @override
  String get authErrorEmpty => 'Please fill in all fields!';

  @override
  String get authSuccessRegister =>
      'Character successfully created! You can now log in.';

  @override
  String statXp(Object amount) {
    return 'XP: $amount';
  }

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
  String get profileSuccessUpdate => '`2Name successfully changed!`w';

  @override
  String get profileChangeEmail => 'Change Email Address';

  @override
  String get profileEmailSuccessUpdate => '`2Email successfully updated!`w';

  @override
  String get profileEmailError => '`4Failed to update email address.`w';

  @override
  String get btnSave => 'Save';

  @override
  String get btnCancel => 'Cancel';

  @override
  String get bankTitle => 'The Central Bank of the Realm';

  @override
  String get bankWelcome =>
      '`gYou walk into the stately building of the bank. A dwarf behind the counter stares at you strictly through his glasses.`w\n\n\"Welcome traveler. Here you can safely store your gold in case you underestimate the monsters in the forest. What do you want to do?\"';

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
  String get raceWelcome =>
      '`gBefore you enter the realm, you must determine what you are made of. Choose carefully, traveler...`w';

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
  String get btnConfirmRace => 'Confirm choice and start adventure';

  @override
  String get specialtyTitle => 'Choose your Specialty';

  @override
  String get specialtyWelcome =>
      '`gEvery traveler in the realm excels in something else. Choose the path that matches your fighting style...`w';

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
  String get btnConfirmSpecialty => 'Choose class and enter the Town Square';

  @override
  String trainingDuelTitle(Object name) {
    return '=== DUEL WITH $name ===';
  }

  @override
  String trainingMasterHp(Object current, Object max) {
    return 'MASTER HP: `4$current / $max`w';
  }

  @override
  String get trainingMasterAttack => 'strikes with a wooden practice sword';

  @override
  String trainingPlayerAttackLog(Object damage) {
    return '`2You hit the Master for $damage damage.`w';
  }

  @override
  String trainingMasterAttackLog(Object attack, Object damage, Object name) {
    return '\n$name $attack and deals `4$damage damage`w back!';
  }

  @override
  String trainingXpLabel(Object current, Object needed) {
    return 'Experience (XP): `c$current / $needed`w';
  }

  @override
  String get btnUseSkill => 'Skill';

  @override
  String get skillAlreadyUsed =>
      '`4You have already used your special skill in this fight!`w';

  @override
  String skillMagicSuccess(Object amount) {
    return '`cYou cast the spell Regeneration! A mystic light surrounds you and heals $amount HP.`w';
  }

  @override
  String skillThievingSuccess(Object amount, Object enemy) {
    return '`yYou use your Pickpocket skill during the attack and rob $amount extra gold pieces from the $enemy!`w';
  }

  @override
  String skillWarriorSuccess(Object amount, Object enemy) {
    return '`rYou execute a brute Shield Bash! You slam directly into the $enemy and deal $amount GUARANTEED damage!`w(\nThe $enemy) is dazed!';
  }

  @override
  String get smithyTitle => 'The Market of Oaktaven';

  @override
  String get smithyWelcome =>
      '`gYou walk onto the lively market. To the left you see the smoking forge of Pegasus, to the right the elegant boutique of Merilon.`w';

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
  String get btnBuyUpgrade => 'Buy Upgrade';

  @override
  String get smithyMaxLevel =>
      '`gYou already possess the absolute best equipment in the realm!`w';

  @override
  String smithySuccessBuy(Object name) {
    return '`2You have successfully upgraded to: $name!`w';
  }

  @override
  String get smithyErrorNoGold =>
      '`4The smith laughs at you: \"You do not have enough gold pieces on hand!\"`w';

  @override
  String get btnVisitBank => 'Bank';

  @override
  String get btnVisitSmithy => 'Shops';

  @override
  String get smithyAmountLabel => 'Amount of gold pieces';

  @override
  String get btnVisitPegasus => 'Visit Pegasus Weapons';

  @override
  String get btnVisitMerilon => 'Visit Merilon Armour';

  @override
  String get btnTalkPegasus => 'Talk to Pegasus';

  @override
  String get btnTalkMerilon => 'Talk to Merilon';

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
  String get trainingTitle => 'The Training Room of the Masters';

  @override
  String get trainingWelcome =>
      '`gYou step into the serene, incense-scented training room. Your Master stands with crossed arms in the middle of the mat.`w\n\n\"Welcome, traveler. I see you have fought in the forest. But are you truly ready for the next step?\"';

  @override
  String trainingStatusReq(Object currentXp, Object nextLvl, Object reqXp) {
    return 'Required XP for Level $nextLvl: `c$reqXp XP`w (Current: `c$currentXp XP`w)';
  }

  @override
  String get trainingReady => '`2You are ready to fight for your next level!`w';

  @override
  String get trainingNotReady =>
      '`4You have not earned enough experience to challenge me yet. Train harder in the forest!`w';

  @override
  String get btnChallengeMaster => 'Challenge the Master';

  @override
  String trainingVictory(Object lvl, Object maxHp) {
    return '`2Congratulations! You have defeated your Master and rise to Level $lvl! Your maximum HP is permanently increased to $maxHp.`w';
  }

  @override
  String get trainingDefeat =>
      '`4Your Master beats you senseless on the mat with a wooden training sword: \"You are not ready yet, apprentice!\" You barely survive, but your HP is at 1.`w';

  @override
  String get master0 => 'Master Jon';

  @override
  String get master1 => 'Master Gibson';

  @override
  String get master2 => 'Master Olivia';

  @override
  String get master3 => 'Master Drake';

  @override
  String get btnVisitTraining => 'Training Room';

  @override
  String get eventFountainTitle => 'The Old Water Fountain';

  @override
  String get eventFountainDesc =>
      '`gYou stumble upon an overgrown, dilapidated water fountain covered in moss. In the crystal-clear water at the bottom, you see something gleaming...`w\n\nWhat do you do?';

  @override
  String get btnEventFountainDive => 'Dive in';

  @override
  String get btnEventFountainLeave => 'Walk away';

  @override
  String eventFountainSuccess(Object amount) {
    return '`2You jump into the cold water and grab around the bottom. You come up with a handful of $amount old gold pieces!`w';
  }

  @override
  String eventFountainFail(Object amount) {
    return '`4Splash! You miss your jump, smash your knee hard against a sharp rock, and lose $amount HP. The gleaming object turned out to be a worthless piece of glass...`w';
  }

  @override
  String get eventFountainLeaveLog =>
      '`wYou do not trust it and carefully walk further through the undergrowth.`w';

  @override
  String get eventGiantTitle => 'The Sleeping Giant';

  @override
  String get eventGiantDesc =>
      '`gAhead on the path, a gigantic forest giant lies snoring loudly. The ground shakes with every snore. Around his neck hangs a leather pouch...`w\n\nWhat do you do?';

  @override
  String get btnEventGiantSneak => 'Sneak past';

  @override
  String get btnEventGiantSteal => 'Try to steal';

  @override
  String eventGiantSneakSuccess(Object amount) {
    return '`2You hold your breath and sneak on your tiptoes past the giant. This cautious action rewards you with $amount experience (XP)!`w';
  }

  @override
  String eventGiantStealSuccess(Object amount) {
    return '`yWith velvety fingers, you cut the pouch loose. You steal $amount gold pieces and 1 gem without waking him up!`w';
  }

  @override
  String eventGiantStealFail(Object amount) {
    return '`4Crack! You step on a twig. The giant opens a bloodshot eye, roars furiously, and gives you a hard blow! You lose $amount HP before running away terrified!`w';
  }

  @override
  String get skillThievingName => 'Pickpocket';

  @override
  String get skillWarriorName => 'Shield Bash';

  @override
  String get skillMagicName => 'Regeneration';

  @override
  String get forestTitle => 'The Dark Forest';

  @override
  String get smithyTabWeapons => 'Weapons';

  @override
  String get smithyTabArmor => 'Armor';

  @override
  String get smithyErrorUnknown => '`4An unknown error occurred.`w';

  @override
  String get graveyardTitle => 'The Shadowy Graveyard';

  @override
  String get graveyardWelcome =>
      '`4You have died!`w\n\n`gThe icy mist clears and you stand face to face with the Grim Reaper. His hollow eyes stare deep into your soul. A heavy voice echoes through the silence:`w\n\n\"Your time has come, mortal. But I am in a generous mood... If you grant me a precious Gem or sacrifice a part of your Experience, I will give you your mortal body back immediately. What do you choose?\"';

  @override
  String get btnGraveyardOfferGem => 'Offer 1 Gem';

  @override
  String get btnGraveyardOfferXp => 'Offer 100 XP';

  @override
  String get btnGraveyardAcceptLot => 'Accept your fate (Wait until tomorrow)';

  @override
  String get graveyardSuccessResurrect =>
      '`2The Grim Reaper laughs terrifyingly. A warm light flows through your veins... You have resurrected and may enter the Town Square again!`w';

  @override
  String get graveyardErrorNoGem =>
      '`4You do not have any shiny gems on hand! The Reaper rattles his scythe impatiently.`w';

  @override
  String get graveyardErrorNoXp =>
      '`4You do not even have enough experience to sacrifice! The Reaper shakes his head.`w';

  @override
  String get graveyardWaitMessage =>
      '`gYou wander quietly among the gravestones and wait for the new day...`w';

  @override
  String get newsTitle => 'The Daily News of the Realm';

  @override
  String get newsWelcome =>
      '`gYou walk to the wooden notice board in the middle of the square. A few fresh sheets of parchment are gently flapping in the wind.`w\n\n\"Hear ye, hear ye! This is what has occurred in our realm today:\"';

  @override
  String get newsEmpty =>
      '`wThe notice board is currently empty. It is a quiet day in the realm...`w';

  @override
  String newsLogDefeated(Object enemy, Object user) {
    return '$user was brutally slaughtered in the forest by a $enemy!';
  }

  @override
  String newsLogDefeatedBrutal(Object enemy, Object user) {
    return '$user thought they were a hero, but was eaten for breakfast by a $enemy!';
  }

  @override
  String newsLogLevelUp(Object level, Object user) {
    return '$user has risen to Level $level after a legendary duel in the training room!';
  }

  @override
  String newsLogMarriage(Object partner, Object user) {
    return 'Great celebration! $user has tied the knot today with $partner!';
  }

  @override
  String get rankingsTitle => 'The Hall of Fame';

  @override
  String get rankingsWelcome => 'The mightiest warriors of the realm:';

  @override
  String get rankingsEmpty => 'No legendary heroes have risen yet...';

  @override
  String get townCrierTitle => 'The Town Crier';

  @override
  String get townCrierPrefix => '`4HEAR YE, HEAR YE! `w';

  @override
  String statDk(Object amount) {
    return 'DK: $amount';
  }

  @override
  String get btnVisitNews => 'Daily News';

  @override
  String get newsUnknownPlayer => 'Unknown Traveler';

  @override
  String get newsUnknownEnemy => 'a monster';

  @override
  String get newsUnknownPartner => 'someone';

  @override
  String get defaultUsername => 'Traveler';

  @override
  String get devTitle => '=== GOD MODE: DEV MENU ===';

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
  String get devSuccessMessage =>
      '`p[DEV] Stat successfully adjusted in the cloud!`w';

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
  String get innWelcome =>
      '`gYou step into the rowdy inn. The smell of roasted meat and strong beer welcomes you. In the corner, a bard sings a terrible retro song, while travelers loudly roll dice.`w\n\n\"Welcome, stranger!\" cries the innkeeper while cleaning a large mug. \"Pull up a chair at the gamble table, or have a drink!\"';

  @override
  String get innDiceTitle => '=== THE GAMBLE TABLE ===';

  @override
  String get innDiceDesc =>
      'Bet gold to roll dice against the tavern masters. Highest roll wins!';

  @override
  String get btnInnRoll => 'Roll dice';

  @override
  String get innErrorNoGold =>
      '`4The innkeeper shakes his head: \"No gold, no dice, friend!\"`w';

  @override
  String innDiceVictory(Object eRoll, Object gold, Object pRoll) {
    return '`2You roll $pRoll and the tavern master rolls $eRoll. You win $gold gold pieces!`w';
  }

  @override
  String innDiceDefeat(Object eRoll, Object gold, Object pRoll) {
    return '`4You roll $pRoll and the tavern master rolls $eRoll. You lose $gold gold pieces...`w';
  }

  @override
  String innDiceTie(Object pRoll) {
    return '`wTie! You both roll $pRoll. You get your bet back.`w';
  }

  @override
  String get btnVisitInn => 'Inn';

  @override
  String newsLogInnWin(Object gold, Object user) {
    return 'Just now, $user won $gold gold pieces by rolling dice in the Inn!';
  }

  @override
  String newsLogInnLoss(Object gold, Object user) {
    return 'Just now, $user was played completely broke by the bank and lost $gold gold pieces...';
  }

  @override
  String get stablesTitle => 'The Royal Stables';

  @override
  String get stablesWelcome =>
      '`gYou enter the stables. The scent of fresh hay and leather fills the air. The stable master walks up to you and taps his hat:`w\n\n\"Welcome traveler! Looking for a loyal companion for your travels? A good mount protects you in battle and ensures you can travel faster every day!\"';

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
  String stablesSuccessBuy(Object mount) {
    return '`2You have successfully bought a $mount! The stable master brings your new companion outside.`w';
  }

  @override
  String get stablesMaxLevel =>
      '`gYou already own the legendary Golden Dragon! The stable master looks at your mount with total awe.`w';

  @override
  String get btnVisitStables => 'Stables';

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
  String get churchTitle => 'The Serene Monastery';

  @override
  String get churchWelcome =>
      '`gYou step into the imposing, quiet church. The little light falls through the stained-glass windows onto the altar. There is a scent of incense and old parchments.`w\n\n\"Kneel down, traveler,\" whispers a monk in a long robe. \"Say a prayer to the Gods of the Realm. But be warned... the Gods are fickle!\"';

  @override
  String get btnChurchPray => 'Say a Prayer';

  @override
  String get btnChurchConfess => 'Confess Sins';

  @override
  String get btnChurchCandle => 'Light a Candle (1 Gem)';

  @override
  String get churchAlreadyPrayed =>
      '`4You have already prayed just now! The Gods do not hear you if you keep nagging.`w';

  @override
  String get churchAlreadyConfessed =>
      '`4You have already cleared your conscience for today.`w';

  @override
  String get churchAlreadyLitCandle =>
      '`4The altar is already full of your candles.`w';

  @override
  String churchBlessGold(Object gold) {
    return '`2The heavens open and a warm beam of light touches you! You find $gold gold pieces on the altar!`w';
  }

  @override
  String churchBlessGems(Object gems) {
    return '`2An angel descends and grants you a shiny Gem ($gems Gem)!`w';
  }

  @override
  String get churchBlessHeal =>
      '`2A divine power flows through your veins. All your wounds are healed in one blow!`w';

  @override
  String get churchNeutral =>
      '`gYou pray fervently to the Gods... but nothing happens. The silence in the church remains undisturbed.`w';

  @override
  String churchCurseHp(Object hp) {
    return '`4The sky darkens and a fierce bolt of lightning strikes right before your feet! You lose $hp HP from the shock!`w';
  }

  @override
  String churchCurseGold(Object gold) {
    return '`4A sudden gust of wind rushes through the church and secretly blows $gold gold pieces out of your pouch!`w';
  }

  @override
  String churchConfessResult(Object xp) {
    return '`2You kneel down and confess your sins. The monk nods slowly. You feel your mind becoming lighter. (+$xp XP)`w';
  }

  @override
  String churchCandleResult(Object favor) {
    return '`cYou light a candle at the statue of the Old Gods. A wave of peace pulls through the church. Ramius will remember this. (+$favor Favor)`w';
  }

  @override
  String get btnVisitChurch => 'Church';

  @override
  String get alchemistTitle => 'The Alchemist';

  @override
  String get alchemistWelcome =>
      '`gYou step into a dark, mystic laboratory. Everywhere glass flasks bubble with strange, steaming liquids. An old alchemist with thick glasses looks up:`w\n\n\"Ah, an adventurer! Looking for extra strength for the forest? My elixirs grant you temporary unprecedented power in your next battles. Choose wisely!\"';

  @override
  String alchemistCurrentBoosts(Object atk, Object def) {
    return 'Active elixirs: `2$atk Atk`w | `c$def Def`w';
  }

  @override
  String get btnBuyAtkPotion => 'Buy Dragon Blood (+5 Atk)';

  @override
  String get btnBuyDefPotion => 'Buy Ironskin (+5 Def)';

  @override
  String alchemistSuccessBuy(Object boost) {
    return '`2You drink the elixir. An intense energy immediately flows through your body! You have received $boost.`w';
  }

  @override
  String get alchemistErrorAlreadyActive =>
      '`4You already have an active boost from this elixir! Drinking more is pure poison for your body.`w';

  @override
  String get btnVisitAlchemist => 'Alchemist';

  @override
  String get trainingErrorNoXp =>
      '`4You are not ready yet! You do not have enough experience (XP) to challenge the Master.`w';

  @override
  String trainingSuccessLevelUp(Object level) {
    return '`2Congratulations! You defeated the Master in an epic battle and rose to Level $level!`w';
  }

  @override
  String get resetNewDayTitle => 'A New Day Dawns!';

  @override
  String get resetNewDayMessage =>
      '`2The sun rises over the realm and the birds begin to chirp. You feel rested and full of energy for new adventures!`w\n\nYour turns are replenished and the gates to the Town Square are wide open again!';

  @override
  String get btnStartDay => 'Begin the new day';

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
  String get eventHermitTitle => 'The Old Hermit';

  @override
  String get eventHermitDesc =>
      '`gAmong the dense vegetation you see a small, camouflaged hut. A centuries-old hermit with a long beard sits on a log in front of the door.`w\n\n\"Ah, young traveler,\" he speaks with a crackling voice. \"You are far from the Town Square. Drink a cup of herbal tea with me. It will refresh your tired legs immediately!\"';

  @override
  String get eventHermitSuccess =>
      '`2You drink the bitter herbal tea. A wave of intense energy shoots through your legs! You get +3 extra turns for today.`w';

  @override
  String get btnHermitDrink => 'Drink herbal tea';

  @override
  String get btnSkillFallback => 'SKILL';

  @override
  String get alchemistLimitReached =>
      'Hold on! You have already bought 2 elixers today. Your body cannot take more until the next sunrise!';

  @override
  String alchemistTodayCounter(Object count) {
    return 'Elixirs bought today: $count/2';
  }

  @override
  String get innMenuGamble => 'Gamble';

  @override
  String get innMenuBartender => 'Bartender Cedrik';

  @override
  String get innMenuFlirt => 'Barmaid Violet';

  @override
  String get innFlirtAttempt => 'Flirt with Violet (-1 Gem)';

  @override
  String get innFlirtNoGems => 'You do not have any gems to gift her!';

  @override
  String get innFlirtSuccess =>
      'Violet blushes from your compliment and pours you a restorative drink! (+15 HP, +1 Max HP)';

  @override
  String get innFlirtFail =>
      'Violet laughs straight in your face. Painful... You lose 2 HP from embarrassment.';

  @override
  String get innTalkCedrik => 'Talk to Cedrik';

  @override
  String get innCedrikRumor1 =>
      'Cedrik polishes a glass and whispers: \'Watch out in the forest, SamHaoir. There is an old hermit wandering around with magical herbal tea...\'';

  @override
  String get innCedrikRumor2 =>
      'Cedrik grunts: \'The giant in the forest sleeps deeply, but if you rob him, you can earn bags of gold!\'';

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
  String innSpyResult(Object gold, Object lvl, Object target) {
    return 'You sneak upstairs and check the belongings of $target. Level: $lvl, Gold on hand: $gold.';
  }

  @override
  String get innNewsTitle => 'Inn Rumors & Latest News';

  @override
  String get innBlackjackTitle => 'Blackjack (Bet: 50 Gold)';

  @override
  String get innBlackjackHit => 'Hit (Card)';

  @override
  String get innBlackjackStand => 'Stand';

  @override
  String innBlackjackWin(Object house, Object player) {
    return 'Won! You have $player against $house of the bank. (+50 Gold)';
  }

  @override
  String innBlackjackLose(Object house, Object player) {
    return 'Lost! The bank has $house and you have $player. (-50 Gold)';
  }

  @override
  String innBlackjackBust(Object player) {
    return 'Too much! You went bust with $player points. (-50 Gold)';
  }

  @override
  String innBlackjackTie(Object points) {
    return 'Tie! Both $points points. You keep your bet.';
  }

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
  String innBlackjackScoreLog(
    Object houseHand,
    Object playerHand,
    Object playerScore,
  ) {
    return 'Your hand: $playerHand ($playerScore)\nBank cards: $houseHand';
  }

  @override
  String innSpyResultLog(Object gold, Object level, Object username) {
    return 'You sneak upstairs and check the belongings of $username. Level: $level, Gold on hand: $gold.';
  }

  @override
  String innBlackjackBustLog(Object score) {
    return 'Bust! You went bust with $score points. (-50 Gold)';
  }

  @override
  String innBlackjackWinLog(Object house, Object player) {
    return 'Won! You have $player against $house of the bank! (+50 Gold)';
  }

  @override
  String innBlackjackLoseLog(Object house, Object player) {
    return 'Lost! The bank wins with $house against your $player. (-50 Gold)';
  }

  @override
  String innBlackjackTieLog(Object score) {
    return 'Tie! Both $score points. You keep your bet.';
  }

  @override
  String get profileBiometricReason =>
      'Confirm your identity to log in quickly to LOGD';

  @override
  String get profileBiometricDeviceError =>
      'This device does not support biometrics.';

  @override
  String get profileDatabaseError => 'An error occurred.';

  @override
  String get trainingStatusTitle => '=== STATUS ===';

  @override
  String trainingCurrentLevel(Object level) {
    return 'Current Level: `yLevel $level`w';
  }

  @override
  String get btnForestWalkAway => 'WALK AWAY';

  @override
  String get btnForestFountainDive => 'DIVE IN FOUNTAIN';

  @override
  String get btnForestGiantSneak => 'SNEAK PAST';

  @override
  String get btnForestGiantSteal => 'ROB GIANT';

  @override
  String get btnForestAttack => 'ATTACK';

  @override
  String get btnForestFlee => 'FLEE';

  @override
  String get btnForestLeprechaunPlay => 'Play game (100 G)';

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
  String get innBlackjackReturn => 'RETURN TO THE COMMON ROOM';

  @override
  String innNewsWinLog(Object user, Object val) {
    return '- $user won $val gold pieces at the gamble table!';
  }

  @override
  String innNewsLossLog(Object user, Object val) {
    return '- $user lost $val gold pieces to the bank.';
  }

  @override
  String innNewsEnterLog(Object user) {
    return '- $user enters the inn.';
  }

  @override
  String get innNewsUnknownPlayer => 'An adventurer';

  @override
  String combatSkillMagicSuccess(Object hp) {
    return '`2You cast a healing spell and restore `w$hp `2HP!`w';
  }

  @override
  String combatSkillThievingSuccess(Object enemy, Object gold) {
    return '`cYou sneak behind and rob `y$gold gold pieces `cfrom among the belongings of the $enemy!`w';
  }

  @override
  String combatSkillWarriorSuccess(Object damage, Object enemy) {
    return '`4You raise your weapon and strike the $enemy a devastating blow of `w$damage `4damage!`w';
  }

  @override
  String combatSkillWarriorVictory(Object damage, Object enemy) {
    return '`4You deliver a death blow to the $enemy of `w$damage `4damage!`w';
  }

  @override
  String combatFleeSuccess(Object enemy) {
    return '\n\n`yYou throw down your weapon and run into the undergrowth in panic! You successfully escaped the $enemy.`w\n\n';
  }

  @override
  String combatFleeFailed(Object damage, Object enemy) {
    return '\n\n`4You try to flee, but the $enemy strikes fiercely and hits you in your back for `w$damage `4damage!`w\n\n';
  }

  @override
  String combatFleeDeath(Object enemy) {
    return '\n\n`4You try to flee, but the $enemy delivers a fatal blow! You have died in the forest.`w\n\n';
  }

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
  String get innDrinkSuccess1 =>
      '`2You drink the Dwarven Stout in one gulp. You feel a lot stronger! (+15 HP, -1 Turn)`w';

  @override
  String get innDrinkSuccess2 =>
      '`2The Elven Mead tastes delicious and sweet. You feel the energy flowing through your veins! (+2 Turns)`w';

  @override
  String get btnGraveyardRob => 'ROB GRAVE';

  @override
  String graveyardSuccessGold(Object gold) {
    return '`2You take a shovel and dig up an old grave... Under the rotten wood you find a hidden box with `y$gold gold pieces`2!`w';
  }

  @override
  String graveyardSuccessGem(Object gems) {
    return '`cYou search a stately crypt and shiny stones catch your attention... You find `w$gems gem`c!`w';
  }

  @override
  String graveyardZombieEncounter(Object hp) {
    return '`4While digging, a rotten, cold hand suddenly grabs your ankle! A zombie crawls up from the earth and attacks you! (-$hp HP)`w';
  }

  @override
  String get graveyardEmpty =>
      'You wander for hours across the misty graveyard, but all graves seem to have been emptied by grave robbers already.';

  @override
  String get graveyardErrorResurrection =>
      '`4An error occurred during resurrection.`w';

  @override
  String get innFlirtMaxHpBonus =>
      '`2Violet falls head over heels for your charms! She smiles shyly and gives you a permanent health upgrade! (+1 Max HP & Fully Healed)`w';

  @override
  String get innFlirtTurnsBonus =>
      '`2Your pickup line is a bullseye! Violet loves your company and grants you renewed energy. (+2 Turns)`w';

  @override
  String get innFlirtSlapDefeat =>
      '`4Your pickup line completely misses the mark! Violet is deeply offended and slaps you hard in your face! (-5 HP)`w';

  @override
  String get btnVisitHealer => 'HERBALIST 🌿';

  @override
  String get dialogWoundedTitle => 'TOO SEVERELY WOUNDED';

  @override
  String get dialogWoundedMessage =>
      '`4You are too severely wounded to fight. Visit the Herbalist or the inn to recover!`w';

  @override
  String get btnBuyHealing => 'BUY HEALING';

  @override
  String labelHealCost(Object cost) {
    return 'Cost for full healing: `y$cost gold pieces`w';
  }

  @override
  String get btnOk => 'OK';

  @override
  String get healerFallbackWelcome => 'Althea\'s hut...';

  @override
  String get healerFallbackHealthy => 'You are already perfectly healthy!';

  @override
  String get btnTalkTownfolk => 'TALK TO TOWNSFOLK 🗣️';

  @override
  String get dialogRumorTitle => 'TOWN RUMORS';

  @override
  String get townSquareRumorFallback => 'The townsfolk are quiet today...';

  @override
  String get healerSuccessFallback => 'You are healed!';

  @override
  String get btnVisitBarber => 'BARBER WITH STYLING 💈';

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
  String get profileBiometricAuthError => 'Verification failed.';

  @override
  String get btnStyxOnboard => 'BOARD THE RAFT (COSTS 2 TURNS)';

  @override
  String get btnStyxStay => 'REMAIN ON THE SHORE';

  @override
  String get btnWhispersListen => 'LISTEN ATTENTIVELY';

  @override
  String get btnWhispersLeave => 'FLOAT AWAY QUICKLY';

  @override
  String get dragon_lair_title => 'The Green Dragon\'s Lair';

  @override
  String get btn_attack_dragon => 'Attack the Green Dragon!';

  @override
  String get btn_sneak_away => 'Sneak away quietly';

  @override
  String get btn_dragon_continue => 'Accept your fate';

  @override
  String news_dragon_kill(Object kills, Object user) {
    return '$user has defeated the Green Dragon and saves the realm! This is their $kills victory!';
  }

  @override
  String newsLogDragonAttack(Object user) {
    return '`4HEAR YE, HEAR YE!`w $user enters the Green Dragon\'s lair! The roar echoes through the mountains...';
  }

  @override
  String newsLogDragonDefeat(Object user) {
    return '`4HEAR YE, HEAR YE!`w $user was brutally roasted by the Green Dragon! Oaktaven mourns...';
  }

  @override
  String get btnDevAddGold => '+10K GOLD';

  @override
  String get btnDevAddGems => '+5 GEMS';

  @override
  String get btnDevAddTurns => '+10 TURNS';

  @override
  String get lblDevSelectEvent => 'Select Event to Spawn:';

  @override
  String get lblDevSelectMonster => 'Select Monster to Spawn:';

  @override
  String get btnDevSpawnAction => 'SPAWN DIRECTLY 🚀';

  @override
  String get errorNoGems => 'You do not have enough shiny gems!';

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
  String get dragonShrineTitle => 'The Dragon Shrine';

  @override
  String get dragonShrineWelcome =>
      '`gYou step into a hidden, ivy-covered ruin just outside the town square. In the center floats a mystic, softly glowing crystal pulsing with pure energy. As you approach, the energy forms into the face of an ancient forest god.`w';

  @override
  String dragonShrinePoints(Object amount) {
    return 'Dragon Points (DP): `y$amount`w';
  }

  @override
  String get dragonShrineNoPoints =>
      '`4The energy in the crystal remains dull and dim. The voice of the forest god sounds cold: \"You do not carry the mark of a dragon slayer, mortal. You have no business here.\"`w';

  @override
  String get btnUpgradeAtk => 'PERMANENT ATTACK (+1 ATK)';

  @override
  String get btnUpgradeDef => 'PERMANENT DEFENSE (+1 DEF)';

  @override
  String get btnUpgradeHp => 'PERMANENT VITALITY (+5 HP)';

  @override
  String get btnUpgradeTurns => 'FOREST WALKER BLESSING (+1 TURN)';

  @override
  String get dragonShrineSuccess =>
      '`2The forest god touches you with a beam of light. \"The transaction is complete. Go forth and use your new powers wisely!\"`w';

  @override
  String get btnVisitDragonShrine => 'Dragon Shrine';

  @override
  String get guestPlayerName => 'Guest Traveler';

  @override
  String get guestWelcomeNews =>
      'Welcome to the world of the Golden Dragon as a guest!';

  @override
  String get alleyBribeDefaultName => 'A shady traveler';

  @override
  String alleyBribeNews(String name) {
    return '$name secretly handed over some gems to Sly and suddenly looks a lot better behaved.';
  }

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
  String get profilePasswordSuccessUpdate =>
      '`2Password changed successfully!`w';

  @override
  String get profilePasswordErrorEmpty => '`4Please enter a new password!`w';

  @override
  String get profilePasswordError => '`4Failed to change password.`w';

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
  String get settingsAboutStory =>
      '`gLegend of the Golden Dragon is a homage to the classic BBS text adventures of the \'80s and \'90s.\n\nIn a world full of danger, dark monsters, and ancient legends, travelers fight for glory, gold, and the defeat of the fearsome Golden Dragon.\n\nBuild your character, visit the town square, battle in the forest, and conquer a place in the rankings!`w';

  @override
  String get settingsShareTitle => 'Share App';

  @override
  String get settingsShareSubtitle => 'Invite friends to join the realm.';

  @override
  String get settingsShareDialogTitle => 'Share the Realm';

  @override
  String get settingsShareDialogText =>
      '`gWord of mouth travels faster than a dragon on the wind!\n\nShare LOGD with your friends and battle together in the town square.`w';

  @override
  String get settingsBtnShare => 'Share now';

  @override
  String get settingsRateTitle => 'Rate App';

  @override
  String get settingsRateSubtitle => 'Leave a 5-star review in the Play Store.';

  @override
  String get settingsRateDialogTitle => 'Rate LOGD';

  @override
  String get settingsRateDialogText =>
      '`yEnjoying your adventures in the realm?\n\nLeave a 5-star review to support the creators and attract more travelers to the village!`w';

  @override
  String get settingsBtnRate => 'Rate now';

  @override
  String get settingsFeedbackTitle => 'Feedback';

  @override
  String get settingsFeedbackSubtitle =>
      'Send ideas or bug reports to creators.';

  @override
  String get settingsFeedbackDialogTitle => 'Send Feedback';

  @override
  String get settingsFeedbackDialogText =>
      '`cHave a suggestion for a new feature or found a bug?\n\nLet us know! Your feedback helps improve the realm.`w';

  @override
  String get settingsFeedbackHint => 'Type your feedback here...';

  @override
  String get settingsFeedbackSent =>
      '`2Thank you! Your feedback has been received.`w';

  @override
  String get settingsBtnSend => 'Send';

  @override
  String get settingsPrivacyTitle => 'Privacy Policy';

  @override
  String get settingsPrivacySubtitle => 'View how we handle your player data.';

  @override
  String get settingsPrivacyDialogTitle => 'Privacy Policy';

  @override
  String get settingsPrivacyDialogText =>
      '`wAt LOGD we respect every traveler\'s privacy.\n\n• We only collect your email address and character name for account management.\n• Passwords are stored securely encrypted via Supabase Auth.\n• We never sell or share your data with third parties.\n• You can permanently delete your account and data at any time.`w';

  @override
  String get btnClose => 'Close';
}
