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
    return '`2You defeated the $enemy! `w\nYou earned `y$gold gold `wand `c$xp experience`w!';
  }

  @override
  String playerDied(Object enemy) {
    return '`4You succumbed to your wounds caused by the $enemy... You are DEAD! `w\nYou lose all gold on hand.';
  }

  @override
  String roundContinue(
    Object attackText,
    Object damageDealt,
    Object damageReceived,
    Object enemy,
  ) {
    return '`2You attack and deal $damageDealt damage to the $enemy.`w\nThe $enemy $attackText and deals `4$damageReceived damage`w back!';
  }

  @override
  String fleeSuccess(Object enemy) {
    return '`gYou run away and safely escape from the $enemy!`w';
  }

  @override
  String fleeFailed(Object damage, Object enemy) {
    return '`4Flee failed! The $enemy blocks your way and deals $damage damage during your escape attempt!`w';
  }

  @override
  String get townSquareWelcome =>
      '`gWelcome to the Town Square of `yLord of the Golden Dragon`w!\n\nThe sun shines over the realm. Travelers gossip in the shadows, and in the distance, you hear roaring from the forest... What will you do today?`w';

  @override
  String get btnGoToForest => 'Enter the forest';

  @override
  String get forestSearching =>
      '`gYou carefully stalk through the dense undergrowth looking for danger...`w';

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
  String get authTitle => 'Enter the Realm';

  @override
  String get authEmail => 'Email Address';

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
  String get authErrorEmpty => 'Please fill in all fields!';

  @override
  String get authSuccessRegister =>
      'Character created successfully! You can now log in.';

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
      'Are you sure? This deletes all your gold, levels, and XP permanently!';

  @override
  String get profileLogout => 'Leave the Realm (Logout)';

  @override
  String get profileBiometricToggle => 'Biometric Login (Fingerprint/FaceID)';

  @override
  String get profileSuccessUpdate => '`2Name changed successfully!`w';

  @override
  String get btnSave => 'Save';

  @override
  String get btnCancel => 'Cancel';

  @override
  String get bankTitle => 'The Central Bank of the Realm';

  @override
  String get bankWelcome =>
      '`gYou walk into the stately building of the bank. A dwarf behind the counter stares at you strictly through his spectacles.`w\n\n\"Welcome traveler. Here you can store your gold safely in case you underestimate the monsters in the forest. What will you do?\"';

  @override
  String bankInBank(Object amount) {
    return 'Gold in bank: `y$amount gold pieces`w';
  }

  @override
  String bankOnHand(Object amount) {
    return 'Gold on hand: `y$amount gold pieces`w';
  }

  @override
  String get btnDepositAll => 'Deposit All';

  @override
  String get btnWithdrawAll => 'Withdraw All';

  @override
  String get btnDepositCustom => 'Deposit Custom';

  @override
  String get btnWithdrawCustom => 'Withdraw Custom';

  @override
  String bankSuccessDeposit(Object amount) {
    return '`2You deposited $amount gold pieces into your account.`w';
  }

  @override
  String bankSuccessWithdraw(Object amount) {
    return '`2You withdrew $amount gold pieces from your account.`w';
  }

  @override
  String get bankErrorNoGoldOnHand =>
      '`4You don\'t have that much gold on hand!`w';

  @override
  String get bankErrorNoGoldInBank =>
      '`4You don\'t have that much gold in your bank account!`w';

  @override
  String get bankErrorInvalid => '`4Please enter a valid amount!`w';

  @override
  String get raceTitle => 'Choose your Race';

  @override
  String get raceWelcome =>
      '`gBefore entering the realm, you must determine what you are made of. Choose wisely, traveler...`w';

  @override
  String get raceHuman => 'Human';

  @override
  String get raceHumanDesc =>
      'Balanced and driven. Starts with `y+5 extra turns`w for today.';

  @override
  String get raceElf => 'Elf';

  @override
  String get raceElfDesc =>
      'Elegant and mystical. Starts with `c+1 shiny gem`w on hand.';

  @override
  String get raceDwarf => 'Dwarf';

  @override
  String get raceDwarfDesc =>
      'Robust and loves gold. Starts with `y+100 extra starting gold`w.';

  @override
  String get raceOrc => 'Orc';

  @override
  String get raceOrcDesc =>
      'Brutal and powerful. Starts with `r+5 maximum HP`w.';

  @override
  String get btnConfirmRace => 'Confirm choice and start adventure';

  @override
  String get specialtyTitle => 'Choose your Specialty';

  @override
  String get specialtyWelcome =>
      '`gEvery traveler in the realm excels in different arts. Choose the path that suits your combat style...`w';

  @override
  String get specMagic => 'Mystical Arts (Magic)';

  @override
  String get specMagicDesc =>
      'Master of elements. Starts with the `cRegeneration`w spell to heal yourself during combat.';

  @override
  String get specThieving => 'Thieving Skills';

  @override
  String get specThievingDesc =>
      'Quick and cunning. Starts with the `yPickpocket`w skill to extract extra gold from monsters.';

  @override
  String get specWarrior => 'Warrior Skills';

  @override
  String get specWarriorDesc =>
      'Brute strength and steel. Starts with the `rShield Bash`w skill for extra heavy hits.';

  @override
  String get btnConfirmSpecialty => 'Choose class and enter the Town Square';

  @override
  String get btnUseSkill => 'Use Skill';

  @override
  String get skillAlreadyUsed =>
      '`4You have already used your special skill in this fight!`w';

  @override
  String skillMagicSuccess(Object amount) {
    return '`cYou cast Regeneration! A mystical light surrounds you and heals $amount HP.`w';
  }

  @override
  String skillThievingSuccess(Object amount, Object enemy) {
    return '`yYou use your Pickpocket skill during the attack and knock an extra $amount gold pieces out of the $enemy!`w';
  }

  @override
  String skillWarriorSuccess(Object amount, Object enemy) {
    return '`rYou perform a brute Shield Bash! You slam heavily into the $enemy and deal $amount GUARANTEED damage!`w\nThe $enemy is dazed!';
  }

  @override
  String get smithyTitle => 'The Blazing Anvil Smithy';

  @override
  String get smithyWelcome =>
      '`gYou step into the blistering hot smithy. A muscular dwarf slams a massive hammer onto a glowing blade. Hot iron hisses in a bucket of water.`w\n\n\"Welcome to my forge, traveler! Tired of that wooden stick and tattered shirt? Have a look around, but remember: looking is free, buying costs gold!\"';

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
    return 'Cost: `y$cost gold pieces`w (trade-in value included)';
  }

  @override
  String get btnBuyUpgrade => 'Buy Upgrade';

  @override
  String get smithyMaxLevel =>
      '`gYou already possess the finest equipment in the realm!`w';

  @override
  String smithySuccessBuy(Object name) {
    return '`2You successfully upgraded to: $name!`w';
  }

  @override
  String get smithyErrorNoGold =>
      '`4The smith laughs at you: \"You don\'t have enough gold on hand!\"`w';

  @override
  String get btnVisitBank => 'Bank';

  @override
  String get btnVisitSmithy => 'Smithy';

  @override
  String get smithyAmountLabel => 'Amount of gold pieces';

  @override
  String get wep0 => 'Wooden Stick';

  @override
  String get wep1 => 'Rusty Dagger';

  @override
  String get wep2 => 'Large Cleaver';

  @override
  String get wep3 => 'Iron Sword';

  @override
  String get wep4 => 'Gleaming Broadsword';

  @override
  String get wep5 => 'Heavy Battlehammer';

  @override
  String get wep6 => 'Trident Spear';

  @override
  String get wep7 => 'Crystal Sabre';

  @override
  String get wep8 => '龍 (Dragon) Sword';

  @override
  String get arm0 => 'Tattered Shirt';

  @override
  String get arm1 => 'Leather Vest';

  @override
  String get arm2 => 'Reinforced Leather Armor';

  @override
  String get arm3 => 'Iron Chainmail';

  @override
  String get arm4 => 'Bronze Breastplate';

  @override
  String get arm5 => 'Steel Plate Mail';

  @override
  String get arm6 => 'Mithril Chainmail';

  @override
  String get arm7 => 'Enchanted Shield';

  @override
  String get arm8 => 'Dragon Scale Armor';

  @override
  String get trainingTitle => 'The Masters Training Hall';

  @override
  String get trainingWelcome =>
      '`gYou step into the serene, incense-scented training hall. Your Master stands with crossed arms in the center of the mat.`w\n\n\"Welcome, traveler. I see you have fought in the forest. But are you truly ready for the next level?\"';

  @override
  String trainingStatusReq(Object currentXp, Object nextLvl, Object reqXp) {
    return 'Required XP for Level $nextLvl: `c$reqXp XP`w (Current: `c$currentXp XP`w)';
  }

  @override
  String get trainingReady => '`2You are ready to fight for your next level!`w';

  @override
  String get trainingNotReady =>
      '`4You haven\'t earned enough experience to challenge me yet. Train harder in the forest!`w';

  @override
  String get btnChallengeMaster => 'Challenge the Master';

  @override
  String trainingVictory(Object lvl, Object maxHp) {
    return '`2Congratulations! You defeated your Master and rise to Level $lvl! Your maximum HP is permanently increased to $maxHp.`w';
  }

  @override
  String get trainingDefeat =>
      '`4Your Master beats you senseless with a wooden training sword: \"You are not ready yet, apprentice!\" You barely survive, your HP is reduced to 1.`w';

  @override
  String get master0 => 'Master Jon';

  @override
  String get master1 => 'Master Gibson';

  @override
  String get master2 => 'Master Olivia';

  @override
  String get master3 => 'Master Drake';

  @override
  String get btnVisitTraining => 'Training Hall';

  @override
  String get eventFountainTitle => 'The Old Water Fountain';

  @override
  String get eventFountainDesc =>
      '`gYou stumble upon an overgrown, ruined water fountain covered in moss. In the crystal-clear water at the bottom, you see something glittering...`w\n\nWhat do you do?';

  @override
  String get btnEventFountainDive => 'Dive in';

  @override
  String get btnEventFountainLeave => 'Walk away';

  @override
  String eventFountainSuccess(Object amount) {
    return '`2You splash into the cold water and scoop the bottom. You surface with a handful of $amount old gold pieces!`w';
  }

  @override
  String eventFountainFail(Object amount) {
    return '`4Splash! You miss, smash your knee hard against a sharp rock, and lose $amount HP. The glittering object was just a worthless piece of glass...`w';
  }

  @override
  String get eventFountainLeaveLog =>
      '`wYou don\'t trust it and carefully continue through the brush.`w';

  @override
  String get eventGiantTitle => 'The Sleeping Giant';

  @override
  String get eventGiantDesc =>
      '`gBlocking the path ahead, a gigantic forest giant is snoring loudly. The ground shakes with every snore. Around his neck hangs a leather pouch...`w\n\nWhat do you do?';

  @override
  String get btnEventGiantSneak => 'Sneak past';

  @override
  String get btnEventGiantSteal => 'Try to pickpocket';

  @override
  String eventGiantSneakSuccess(Object amount) {
    return '`2You hold your breath and tiptoe past the giant. This cautious maneuver earns you $amount experience (XP)!`w';
  }

  @override
  String eventGiantStealSuccess(Object amount) {
    return '`yWith velvet fingers, you slice the pouch open. You steal $amount gold pieces and 1 Gem without him waking up!`w';
  }

  @override
  String eventGiantStealFail(Object amount) {
    return '`4Crack! You step on a twig. The giant opens a bloodshot eye, roars furiously, and slaps you hard! You lose $amount HP before running away terrified!`w';
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
      '`4You have died!`w\n\n`gThe icy mist clears, and you stand face to face with Death. His hollow eyes stare deep into your soul. A heavy voice echoes through the silence:`w\n\n\"Your time has come, mortal. But I am in a generous mood... If you grant me a precious Gem or sacrifice a part of your Experience, I will return your mortal body at once. What do you choose?\"';

  @override
  String get btnGraveyardOfferGem => 'Sacrifice 1 Gem';

  @override
  String get btnGraveyardOfferXp => 'Sacrifice 100 XP';

  @override
  String get btnGraveyardAcceptLot => 'Accept your fate (Wait till tomorrow)';

  @override
  String get graveyardSuccessResurrect =>
      '`2Death laughs terrifyingly. A warm light flows through your veins... You are resurrected and may enter the Town Square once more!`w';

  @override
  String get graveyardErrorNoGem =>
      '`You don\'t have any shiny gems on hand! Death rattles his scythe impatiently.`w';

  @override
  String get graveyardErrorNoXp =>
      '`4You don\'t even have enough experience to sacrifice! Death shakes his head.`w';

  @override
  String get graveyardWaitMessage =>
      '`gYou wander quietly among the tombstones, waiting for the dawn of a new day...`w';

  @override
  String get newsTitle => 'The Daily News of the Realm';

  @override
  String get newsWelcome =>
      '`gYou walk up to the wooden notice board in the center of the square. Fresh sheets of parchment rustle gently in the wind.`w\n\n\"Hear ye, hear ye! This is what transpired in our realm today:\"';

  @override
  String get newsEmpty =>
      '`wThe notice board is currently empty. It is a peaceful day in the realm...`w';

  @override
  String newsLogDefeated(Object enemy, Object username) {
    return '`4$username`w was brutally slaughtered in the forest by a `r$enemy`w!';
  }

  @override
  String newsLogLevelUp(Object level, Object username) {
    return '`2$username`w has risen to `yLevel $level`w after a legendary duel in the training hall!';
  }

  @override
  String get btnVisitNews => 'Daily News';

  @override
  String get newsUnknownPlayer => 'Unknown Traveler';

  @override
  String get defaultUsername => 'Traveler';

  @override
  String get devTitle => '=== GOD MODE: DEV MENU ===';

  @override
  String get btnDevHeal => 'Fully Heal (Full HP)';

  @override
  String get btnDevGold => 'Give +10,000 Gold';

  @override
  String get btnDevGems => 'Give +5 Gems';

  @override
  String get btnDevTurns => 'Give +10 Turns';

  @override
  String get btnDevLevelUp => 'Instant Level Up (+1 Lvl)';

  @override
  String get devSuccessMessage =>
      '`p[DEV] Stat successfully updated in the cloud!`w';

  @override
  String get devScreenTitle => 'MASTER DEV CONSOLE';

  @override
  String get devSpawnMonsterTitle => '=== SPAWN MONSTER TEST ===';

  @override
  String get devSpawnMonsterDesc =>
      'Click on any monster below to instantly force a fight in the forest and test balances:';

  @override
  String get innTitle => 'The Drunken Dragon Inn';

  @override
  String get innWelcome =>
      '`gYou step into the rowdy inn. The smell of roasted meat and heavy ale greets you. In the corner, a bard sings a terrible retro tune while travelers loudly roll dice.`w\n\n\"Welcome, stranger!\" the innkeeper shouts while wiping a large mug. \"Pull up a chair at the dice table or have a drink!\"';

  @override
  String get innDiceTitle => '=== THE DICE TABLE ===';

  @override
  String get innDiceDesc =>
      'Wager gold to roll dice against the locals. Highest roll wins!';

  @override
  String get btnInnRoll => 'Roll Dice';

  @override
  String get innErrorNoGold =>
      '`4The innkeeper shakes his head: \"No gold, no dice, friend!\"`w';

  @override
  String innDiceVictory(Object eRoll, Object gold, Object pRoll) {
    return '`2You roll $pRoll and the house rolls $eRoll. You win $gold gold pieces!`w';
  }

  @override
  String innDiceDefeat(Object eRoll, Object gold, Object pRoll) {
    return '`4You roll $pRoll and the house rolls $eRoll. You lose $gold gold pieces...`w';
  }

  @override
  String innDiceTie(Object pRoll) {
    return '`wIt\'s a tie! You both rolled $pRoll. Your wager is returned.`w';
  }

  @override
  String get btnVisitInn => 'The Inn';

  @override
  String newsLogInnWin(Object gold, Object username) {
    return '`2$username`w just won `y$gold gold pieces`w rolling dice at the Inn!';
  }

  @override
  String newsLogInnLoss(Object gold, Object username) {
    return '`o$username`w just got cleaned out by the innkeeper and lost `y$gold gold pieces`w...';
  }

  @override
  String get stablesTitle => 'The Royal Stables';

  @override
  String get stablesWelcome =>
      '`gYou walk into the stables. The scent of fresh hay and leather fills the air. The stablemaster approaches you and tips his hat:`w\n\n\"Welcome traveler! Looking for a loyal companion? A good mount protects you in battle and allows you to travel faster every day!\"';

  @override
  String stablesCurrentMount(Object mount) {
    return 'Your current mount: `c$mount`w';
  }

  @override
  String get stablesNoMount => 'None (You are traveling on foot)';

  @override
  String get stablesUpgradeAvailable => '=== AVAILABLE MOUNT ===';

  @override
  String stablesCostLabel(Object gold) {
    return 'Price: `y$gold gold`w';
  }

  @override
  String stablesCostGemsLabel(Object gems, Object gold) {
    return 'Price: `y$gold gold`w & `c$gems Gems`w';
  }

  @override
  String stablesBonusLabel(Object def, Object turns) {
    return 'Bonus: `2+$def Def`w | `p+$turns Turns per day`w';
  }

  @override
  String stablesSuccessBuy(Object mount) {
    return '`2You successfully purchased a $mount! The stablemaster brings out your new companion.`w';
  }

  @override
  String get stablesMaxLevel =>
      '`gYou already own the legendary Golden Dragon! The stablemaster looks at your mount in awe.`w';

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
      '`gYou step into the imposing, silent church. Dim light filters through stained glass windows onto the altar. The scent of incense and ancient parchment fills the air.`w\n\n\"Kneel, traveler,\" whispers a monk in a long robe. \"Offer a prayer to the Gods of the Realm. But beware... the Gods are fickle!\"';

  @override
  String get btnChurchPray => 'Offer a Prayer';

  @override
  String get churchAlreadyPrayed =>
      '`4You have already prayed just now! The Gods will not hear you if you keep pestering them.`w';

  @override
  String churchBlessGold(Object gold) {
    return '`2The heavens open and a warm beam of light touches you! You find $gold gold pieces on the altar!`w';
  }

  @override
  String churchBlessGems(Object gems) {
    return '`2An angel descends and gifts you a shiny Gem ($gems Gem)!`w';
  }

  @override
  String get churchBlessHeal =>
      '`2A divine power flows through your veins. All your wounds are healed instantly!`w';

  @override
  String get churchNeutral =>
      '`gYou pray fervently to the Gods... but nothing happens. The silence in the church remains undisturbed.`w';

  @override
  String churchCurseHp(Object hp) {
    return '`4The sky darkens and a sharp bolt of lightning strikes right at your feet! You lose $hp HP from the shock!`w';
  }

  @override
  String churchCurseGold(Object gold) {
    return '`4A sudden gust of wind sweeps through the church, stealthily blowing away $gold gold pieces from your pouch!`w';
  }

  @override
  String get btnVisitChurch => 'Church';

  @override
  String get alchemistTitle => 'The Alchemist';

  @override
  String get alchemistWelcome =>
      '`gYou step into a dark, mystical laboratory. Glass flasks bubble everywhere with strange, steaming liquids. An old alchemist with thick glasses looks up:`w\n\n\"Ah, an adventurer! Seeking extra power for the forest? My elixirs grant you temporary, unprecedented power in your next battles. Choose wisely!\"';

  @override
  String alchemistCurrentBoosts(Object atk, Object def) {
    return 'Active elixirs: `2$atk Atk`w | `c$def Def`w';
  }

  @override
  String get btnBuyAtkPotion => 'Buy Dragonblood (+5 Atk)';

  @override
  String get btnBuyDefPotion => 'Buy Ironskin (+5 Def)';

  @override
  String alchemistSuccessBuy(Object boost) {
    return '`2You drink the elixir. An intense energy flows through your body instantly! You received $boost.`w';
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
      '`2The sun rises over the realm and the birds begin to sing. You feel rested and full of energy for new adventures!`w\n\nYour turns have been replenished and the gates to the Town Square are wide open once more!';

  @override
  String get btnStartDay => 'Start the new day';

  @override
  String get eventHermitTitle => 'The Old Hermit';

  @override
  String get eventHermitDesc =>
      '`gBetween the dense foliage, you spot a small, camouflaged hut. A bone-old hermit with a long beard sits on a log in front of the door.`w\n\n\"Ah, young traveler,\" he speaks in a raspy voice. \"You are far from the Town Square. Share a cup of herbal tea with me. It will refresh your weary legs instantly!\"';

  @override
  String get eventHermitSuccess =>
      '`2You drink the bitter herbal tea. A wave of intense energy shoots through your legs! You receive +3 extra turns for today.`w';

  @override
  String get btnHermitDrink => 'Drink herbal tea';

  @override
  String get btnSkillFallback => 'SKILL';

  @override
  String get alchemistLimitReached =>
      'Hold on! You have already bought 2 elixers today. Your body cannot take any more until the next sunrise!';

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
  String get innFlirtNoGems => 'You don\'t have any gems to gift her!';

  @override
  String get innFlirtSuccess =>
      'Violet blushes at your compliment and pours you a restorative drink! (+15 HP, +1 Max HP)';

  @override
  String get innFlirtFail =>
      'Violet laughs right in your face. Painful... You lose 2 HP from embarrassment.';

  @override
  String get innTalkCedrik => 'Talk to Cedrik';

  @override
  String get innCedrikRumor1 =>
      'Cedrik polishes a glass and whispers: \'Watch out in the forest, SamHaoir. There is an old hermit wandering around with magical tea...\'';

  @override
  String get innCedrikRumor2 =>
      'Cedrik grunts: \'The giant in the forest sleeps deeply, but if you steal from him, you can make a fortune!\'';
}
