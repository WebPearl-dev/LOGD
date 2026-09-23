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
  String enemyDefeated(Object enemy, Object gold, Object xp) {
    return '`2Je hebt de $enemy verslagen! `w\nJe verdient `y$gold goud `wen `c$xp ervaring`w!';
  }

  @override
  String playerDied(Object enemy) {
    return '`4Je bent bezweken aan je verwondingen door de $enemy... Je bent DOOD! `w\nJe verliest al het goud op zak.';
  }

  @override
  String roundContinue(
    Object attackText,
    Object damageDealt,
    Object damageReceived,
    Object enemy,
  ) {
    return '`2Je valt aan en doet $damageDealt schade bij de $enemy.`w(\nDe $enemy $attackText) en doet `4$damageReceived schade`w terug!';
  }

  @override
  String fleeSuccess(Object enemy) {
    return '`gJe rent hard weg en ontsnapt veilig aan de $enemy!`w';
  }

  @override
  String fleeFailed(Object damage, Object enemy) {
    return '`4Vluchten mislukt! De $enemy blokkeert je weg en doet $damage schade tijdens je vluchtpoging!`w';
  }

  @override
  String get townSquareWelcome =>
      '`gWelkom op het Dorpsplein van `yLord of the Golden Dragon`w!\n\nDe zon schijnt over het rijk. Reizigers praten in de schazuw, en in de verte hoor je het gebrul uit het bos... Wat ga je vandaag doen?`w';

  @override
  String get btnGoToForest => 'Ga het bos in';

  @override
  String get forestSearching =>
      '`gJe sluipt voorzichtig door het dichte struikgewas op zoek naar gevaar...`w';

  @override
  String get btnAttack => 'Aanvallen';

  @override
  String get btnFlee => 'Vluchten';

  @override
  String get btnReturnTown => 'Terug naar het dorp';

  @override
  String enemyHpLabel(Object current, Object enemy, Object max) {
    return '$enemy HP: $current/$max';
  }

  @override
  String combatEncounterStart(Object enemy) {
    return '`wJe komt oog in oog te staan met een $enemy!\n\n`w';
  }

  @override
  String get forestNoTurns =>
      '`4Je hebt geen beurten meer over voor vandaag!`w';

  @override
  String get fleeFailedDeathSuffix =>
      '\n`4Je bent bezweken aan je verwondingen... Je bent DOOD!`w';

  @override
  String get authTitle => 'Toegang tot het Rijk';

  @override
  String get authEmail => 'E-mailadres';

  @override
  String get authPassword => 'Wachtwoord';

  @override
  String get authUsername => 'Karakternaam (Alleen bij registratie)';

  @override
  String get btnLogin => 'Inloggen';

  @override
  String get btnRegister => 'Karakter aanmaken';

  @override
  String get authSwitchToRegister => 'Nieuw hier? Maak een karakter aan';

  @override
  String get authSwitchToLogin => 'Heb je al een karakter? Log hier in';

  @override
  String get authGuestLogin => 'Inloggen als gast';

  @override
  String get authErrorEmpty => 'Vul alle velden in!';

  @override
  String get authSuccessRegister =>
      'Karakter succesvol aangemaakt! Je kunt nu inloggen.';

  @override
  String statXp(Object amount) {
    return 'XP: $amount';
  }

  @override
  String get profileTitle => 'Karakter Instellingen';

  @override
  String get profileChangeName => 'Karakternaam wijzigen';

  @override
  String get profileDeleteAccount => 'Karakter definitief wissen';

  @override
  String get profileDeleteWarning =>
      'Weet je het zeker? Dit wist al je goud, levels en XP permanent!';

  @override
  String get profileLogout => 'Verlaat het rijk (Uitloggen)';

  @override
  String get profileBiometricToggle =>
      'Biometrisch inloggen (Vingerafdruk/FaceID)';

  @override
  String get profileSuccessUpdate => '`2Naam succesvol gewijzigd!`w';

  @override
  String get profileChangeEmail => 'E-mailadres wijzigen';

  @override
  String get profileEmailSuccessUpdate =>
      '`2E-mailadres succesvol gewijzigd!`w';

  @override
  String get profileEmailError => '`4E-mailadres wijzigen mislukt.`w';

  @override
  String get btnSave => 'Opslaan';

  @override
  String get btnCancel => 'Annuleren';

  @override
  String get bankTitle => 'De Centrale Bank van het Rijk';

  @override
  String get bankWelcome =>
      '`gJe loopt het statige gebouw van de bank binnen. Een dwerg achter de balie kijkt je streng aan door zijn bril.`w\n\n\"Welkom reiziger. Hier kun je je goud veilig stallen voor het geval je de monsters in het bos onderschat. Wat wil je doen?\"';

  @override
  String bankInBank(Object amount) {
    return 'Goud op de bank: `y$amount goudstukken`w';
  }

  @override
  String bankOnHand(Object amount) {
    return 'Goud op zak: `y$amount goudstukken`w';
  }

  @override
  String get btnDepositAll => 'Alles storten';

  @override
  String get btnWithdrawAll => 'Alles opnemen';

  @override
  String get btnDepositCustom => 'Bedrag storten';

  @override
  String get btnWithdrawCustom => 'Bedrag opnemen';

  @override
  String bankSuccessDeposit(Object amount) {
    return '`2Je hebt $amount goudstukken op je rekening gestort.`w';
  }

  @override
  String bankSuccessWithdraw(Object amount) {
    return '`2Je hebt $amount goudstukken van je rekening opgenomen.`w';
  }

  @override
  String get bankErrorNoGoldOnHand => '`4Je hebt niet zoveel goud op zak!`w';

  @override
  String get bankErrorNoGoldInBank =>
      '`4Zoveel goud staat er niet op je bankrekening!`w';

  @override
  String get bankErrorInvalid => '`4Vul een geldig aantal in!`w';

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
    return 'Daglimiet over: `c$amount goud`w';
  }

  @override
  String get btnTalkBanker => 'Praat met de bankier';

  @override
  String get raceTitle => 'Kies je Ras';

  @override
  String get raceWelcome =>
      '`gVoordat je het rijk betreedt, moet je bepalen uit welk hout je gesneden bent. Kies zorgvuldig, reiziger...`w';

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
      'Robuust en dol op goud. Start met `y+100 extra startgoud`w.';

  @override
  String get raceOrc => 'Orc';

  @override
  String get raceOrcDesc =>
      'Brutaal en ijzersterk. Start met `r+5 maximale HP`w.';

  @override
  String get btnConfirmRace => 'Bevestig keuze en start avontuur';

  @override
  String get specialtyTitle => 'Kies je Specialisatie';

  @override
  String get specialtyWelcome =>
      '`gElke reiziger in het rijk blinkt ergens anders in uit. Kies het pad dat bij jouw vechtstijl past...`w';

  @override
  String get specMagic => 'Mystieke Krachten (Magic)';

  @override
  String get specMagicDesc =>
      'Meester van de elementen. Start met de spreuk `cRegeneratie`w om jezelf te genezen in gevechten.';

  @override
  String get specThieving => 'Diefstal (Thieving)';

  @override
  String get specThievingDesc =>
      'Snel en sluw. Start met de vaardigheid `yZakkenrollen`w om extra goud uit monsters te kloppen.';

  @override
  String get specWarrior => 'Krijger (Warrior)';

  @override
  String get specWarriorDesc =>
      'Brute kracht en staal. Start met de vaardigheid `rSchildbeuk`w voor extra zware klappen.';

  @override
  String get btnConfirmSpecialty => 'Kies klasse en betreed het Dorpsplein';

  @override
  String trainingDuelTitle(Object name) {
    return '=== DUEL MET $name ===';
  }

  @override
  String trainingMasterHp(Object current, Object max) {
    return 'MEESTER HP: `4$current / $max`w';
  }

  @override
  String get trainingMasterAttack => 'haalt uit met een houten oefenzwaard';

  @override
  String trainingPlayerAttackLog(Object damage) {
    return '`2Je raakt de Meester voor $damage schade.`w';
  }

  @override
  String trainingMasterAttackLog(Object attack, Object damage, Object name) {
    return '\n$name $attack en doet `4$damage schade`w terug!';
  }

  @override
  String trainingXpLabel(Object current, Object needed) {
    return 'Ervaring (XP): `c$current / $needed`w';
  }

  @override
  String get btnUseSkill => 'Vaardigheid';

  @override
  String get skillAlreadyUsed =>
      '`4Je hebt je speciale vaardigheid al gebruikt in dit gevecht!`w';

  @override
  String skillMagicSuccess(Object amount) {
    return '`cJe spreekt de spreuk Regeneratie uit! Een mystiek licht omringt je en geneest $amount HP.`w';
  }

  @override
  String skillThievingSuccess(Object amount, Object enemy) {
    return '`yJe gebruikt je Zakkenrollen vaardigheid tijdens de aanval en slaat $amount extra goudstukken uit de $enemy!`w';
  }

  @override
  String skillWarriorSuccess(Object amount, Object enemy) {
    return '`rJe voert een brute Schildbeuk uit! Je beukt vol in op de $enemy en doet $amount GEGARANDEERDE schade!`w(\nDe $enemy) is wankel!';
  }

  @override
  String get smithyTitle => 'De Markt van Oaktaven';

  @override
  String get smithyWelcome =>
      '`gJe loopt de levendige markt op. Aan de linkerkant zie je de rokende smidse van Pegasus, aan de rechterkant de elegante boetiek van Merilon.`w';

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
    return 'Kosten: `y$cost goudstukken`w (inruilwaarde verwerkt)';
  }

  @override
  String get btnBuyUpgrade => 'Koop Upgrade';

  @override
  String get smithyMaxLevel =>
      '`gJe hebt de allerbeste uitrusting van het rijk al in bezit!`w';

  @override
  String smithySuccessBuy(Object name) {
    return '`2Je hebt succesvol geüpgrade naar: $name!`w';
  }

  @override
  String get smithyErrorNoGold =>
      '`4De smid lacht je uit: \"Je hebt niet genoeg goudstukken op zak!\"`w';

  @override
  String get btnVisitBank => 'Bank';

  @override
  String get btnVisitSmithy => 'Winkels';

  @override
  String get smithyAmountLabel => 'Aantal goudstukken';

  @override
  String get btnVisitPegasus => 'Bezoek Pegasus Wapens';

  @override
  String get btnVisitMerilon => 'Bezoek Merilon Harnassen';

  @override
  String get btnTalkPegasus => 'Praat met Pegasus';

  @override
  String get btnTalkMerilon => 'Praat met Merilon';

  @override
  String get wep0 => 'Blote Vuisten';

  @override
  String get wep1 => 'Houten Stok';

  @override
  String get wep2 => 'Roestige Dolk';

  @override
  String get wep3 => 'Handbijl';

  @override
  String get wep4 => 'IJzeren Korte Zwaard';

  @override
  String get wep5 => 'Stalen Slagzwaard';

  @override
  String get wep6 => 'Grote Strijdhamer';

  @override
  String get wep7 => 'Gekruiste Hellebaard';

  @override
  String get wep8 => 'Elfen Kruisboog';

  @override
  String get wep9 => 'Runenzwaard';

  @override
  String get wep10 => 'Duivenseis (Mace)';

  @override
  String get wep11 => 'Glanzende Klabat';

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
  String get arm3 => 'Geklonken Leren Harnas';

  @override
  String get arm4 => 'Ringpantser';

  @override
  String get arm5 => 'Lichte Maliënkolder';

  @override
  String get arm6 => 'Zware Stalen Maliënkolder';

  @override
  String get arm7 => 'Bandenpantser';

  @override
  String get arm8 => 'Elfen Borstplaat';

  @override
  String get arm9 => 'Geciseleerd Brons Pantser';

  @override
  String get arm10 => 'Ridderlijk Platenpantser';

  @override
  String get arm11 => 'Runenbescherming';

  @override
  String get arm12 => 'Obsidiaan Schild & Pantser';

  @override
  String get arm13 => 'Schilden van Drakenhuid';

  @override
  String get arm14 => 'Paladijn Kuras';

  @override
  String get arm15 => 'Het Godenpantser';

  @override
  String get trainingTitle => 'De Trainingsruimte van de Meesters';

  @override
  String get trainingWelcome =>
      '`gJe stapt de serene, naar wierook ruikende trainingsruimte binnen. Je Meester staat met gekruiste armen in het midden van de mat.`w\n\n\"Welkom, reiziger. Ik zie dat je hebt gevochten in het bos. Maar ben je echt klaar voor de volgende stap?\"';

  @override
  String trainingStatusReq(Object currentXp, Object nextLvl, Object reqXp) {
    return 'Vereiste XP voor Level $nextLvl: `c$reqXp XP`w (Huidig: `c$currentXp XP`w)';
  }

  @override
  String get trainingReady =>
      '`2Je bent klaar om te vechten voor je volgende level!`w';

  @override
  String get trainingNotReady =>
      '`4Je hebt nog niet genoeg ervaring verdient om mij uit te dagen. Train harder in het bos!`w';

  @override
  String get btnChallengeMaster => 'Daag de Meester uit';

  @override
  String trainingVictory(Object lvl, Object maxHp) {
    return '`2Gefeliciteerd! Je hebt je Meester verslagen en stijgt naar Level $lvl! Je maximale HP is permanent verhoogd naar $maxHp.`w';
  }

  @override
  String get trainingDefeat =>
      '`4Je Meester slaat je met een houten trainingszwaard verrot op de mat: \"Je bent er nog niet klaar voor, leerling!\" Je overleeft het net, maar je HP staat op 1.`w';

  @override
  String get master0 => 'Meester Jon';

  @override
  String get master1 => 'Meester Gibson';

  @override
  String get master2 => 'Meesteres Olivia';

  @override
  String get master3 => 'Meester Drake';

  @override
  String get btnVisitTraining => 'Trainingsruimte';

  @override
  String get eventFountainTitle => 'De Oude Waterbron';

  @override
  String get eventFountainDesc =>
      '`gJe struikelt over een overgroeide, vervallen waterbron bedekt met mos. In het kristalheldere water op de bodem zie je iets glinsteren...`w\n\nWat doe je?';

  @override
  String get btnEventFountainDive => 'Duik erin';

  @override
  String get btnEventFountainLeave => 'Loop door';

  @override
  String eventFountainSuccess(Object amount) {
    return '`2Je springt in het koude water en graait op de bodem. Je komt boven met een handvol van $amount oude goudstukken!`w';
  }

  @override
  String eventFountainFail(Object amount) {
    return '`4Plons! Je springt mis, stoot je knie keihard tegen een scherpe rots en verliest $amount HP. Het glinsterende object bleek een waardeloos stuk glas te zijn...`w';
  }

  @override
  String get eventFountainLeaveLog =>
      '`wJe vertrouwt het niet en loopt voorzichtig verder door het struikgewas.`w';

  @override
  String get eventGiantTitle => 'De Slapende Reus';

  @override
  String get eventGiantDesc =>
      '`gVoor je op het pad ligt een gigantische bosreus luidruchtig te ronken. De grond trilt bij elke snurk. Om zijn nek hangt een leren buidel...`w\n\nWat doe je?';

  @override
  String get btnEventGiantSneak => 'Sluip erlangs';

  @override
  String get btnEventGiantSteal => 'Probeer te bestelen';

  @override
  String eventGiantSneakSuccess(Object amount) {
    return '`2Je houdt je adem in en sluipt op je tenen langs de reus. Deze behoedzame actie levert je $amount ervaring (XP) op!`w';
  }

  @override
  String eventGiantStealSuccess(Object amount) {
    return '`yMet fluwelen vingers snijd je de buidel los. Je steelt $amount goudstukken en 1 edelsteen (Gem) zonder dat hij wakker wordt!`w';
  }

  @override
  String eventGiantStealFail(Object amount) {
    return '`4Kraak! Je trapt op een takje. De reus opent een bloeddoorlopen oog, brult woedend en geeft je een harde klap! Je verliest $amount HP voordat je doodsbang wegrent!`w';
  }

  @override
  String get skillThievingName => 'Zakkenrollen';

  @override
  String get skillWarriorName => 'Schildbeuk';

  @override
  String get skillMagicName => 'Regeneratie';

  @override
  String get forestTitle => 'Het Donkere Bos';

  @override
  String get smithyTabWeapons => 'Wapens';

  @override
  String get smithyTabArmor => 'Pantsers';

  @override
  String get smithyErrorUnknown => '`4Er is een onbekende fout opgetreden.`w';

  @override
  String get graveyardTitle => 'De Schimmige Begraafplaats';

  @override
  String get graveyardWelcome =>
      '`4Je bent gestorven!`w\n\n`gDe ijzige mist trekt op en je staat oog in oog met Magere Hein. Zijn holle ogen staren diep in je ziel. Een zware stem galmt door de stilte:`w\n\n\"Je tijd is gekomen, sterveling. Maar ik ben in een gulle bui... Als je mij een kostbare Edelsteen schenkt of een deel van je Ervaring opoffert, geef ik je je sterfelijke lichaam direct terug. Wat kies je?\"';

  @override
  String get btnGraveyardOfferGem => 'Offer 1 Edelsteen (Gem)';

  @override
  String get btnGraveyardOfferXp => 'Offer 100 XP';

  @override
  String get btnGraveyardAcceptLot => 'Accepteer je lot (Wacht tot morgen)';

  @override
  String get graveyardSuccessResurrect =>
      '`2Magere Hein lacht angstaanjagend. Een warm licht stroomt door je aderen... Je bent herrezen en mag het Dorpsplein weer betreden!`w';

  @override
  String get graveyardErrorNoGem =>
      '`4Je hebt geen glimmende edelstenen op zak! Hein rammelt ongeduldig met zijn zeis.`w';

  @override
  String get graveyardErrorNoXp =>
      '`4Je hebt niet eens genoeg ervaring om op te offeren! Hein schudt zijn hoofd.`w';

  @override
  String get graveyardWaitMessage =>
      '`gJe dwaalt rustig rond tussen de grafstenen en wacht op de nieuwe dag...`w';

  @override
  String get newsTitle => 'Het Dagelijks Nieuws van het Rijk';

  @override
  String get newsWelcome =>
      '`gJe loopt naar het houten mededelingenbord in het midden van het plein. Er hangen een paar vers perkamenten vellen die door de wind zachtjes klapperen.`w\n\n\"Hoor en zegt het voort! Dit is wat er vandaag in ons rijk is voorgevallen:\"';

  @override
  String get newsEmpty =>
      '`wHet mededelingenbord is momenteel leeg. Het is een rustige dag in het rijk...`w';

  @override
  String newsLogDefeated(Object enemy, Object user) {
    return '$user is in het bos op brute wijze afgeslacht door een $enemy!';
  }

  @override
  String newsLogDefeatedBrutal(Object enemy, Object user) {
    return '$user dacht een held te zijn, maar werd door een $enemy als ontbijt genuttigd!';
  }

  @override
  String newsLogLevelUp(Object level, Object user) {
    return '$user is gestegen naar Level $level na een legendarisch duel in de trainingsruimte!';
  }

  @override
  String newsLogMarriage(Object partner, Object user) {
    return 'Groot feest! $user is vandaag in het huwelijksbootje gestapt met $partner!';
  }

  @override
  String get rankingsTitle => 'De Hall of Fame';

  @override
  String get rankingsWelcome => 'De machtigste krijgers van het rijk:';

  @override
  String get rankingsEmpty =>
      'Er zijn nog geen legendarische helden opgestaan...';

  @override
  String get townCrierTitle => 'De Dorpsomroeper';

  @override
  String get townCrierPrefix => '`4HOREN, ZIEN EN ZEGT HET VOORT! `w';

  @override
  String statDk(Object amount) {
    return 'DK: $amount';
  }

  @override
  String get btnVisitNews => 'Dagelijks Nieuws';

  @override
  String get newsUnknownPlayer => 'Onbekende Reiziger';

  @override
  String get newsUnknownEnemy => 'een monster';

  @override
  String get newsUnknownPartner => 'iemand';

  @override
  String get defaultUsername => 'Reiziger';

  @override
  String get devTitle => '=== GOD MODUS: DEV MENU ===';

  @override
  String get btnDevHeal => 'Volledig Genezen (Full HP)';

  @override
  String get btnDevGold => 'Geef +10.000 Goud';

  @override
  String get btnDevGems => 'Geef +5 Edelstenen';

  @override
  String get btnDevTurns => 'Geef +10 Beurten';

  @override
  String get btnDevLevelUp => 'Direct Level Up (+1 Lvl)';

  @override
  String get devSuccessMessage =>
      '`p[DEV] Stat succesvol aangepast in de cloud!`w';

  @override
  String get devScreenTitle => 'MASTER DEV CONSOLE';

  @override
  String get devSpawnMonsterTitle => '=== SPAWN MONSTER TEST ===';

  @override
  String get devSpawnMonsterDesc =>
      'Klik op een monster hieronder om direct een gevecht in het bos te forceren en de balans te controleren:';

  @override
  String get innTitle => 'Herberg \'De Dronken Draak\'';

  @override
  String get innWelcome =>
      '`gJe stapt de rumoerige herberg binnen. De geur van gebraden vlees en stevig bier komt je tegemoet. In de hoek zingt een bard een vals retro-lied, terwijl reizigers luidruchtig met dobbelstenen gooien.`w\n\n\"Welkom, vreemdeling!\" roept de herbergier terwijl hij een grote pul schoonmaakt. \"Schuif gezellig aansluiten bij de goktafel, of drink een slok!\"';

  @override
  String get innDiceTitle => '=== DE GOKTAFEL ===';

  @override
  String get innDiceDesc =>
      'Zet goud in om te dobbelen tegen de kroegbazen. Hoogste worp wint!';

  @override
  String get btnInnRoll => 'Gooi dobbelstenen';

  @override
  String get innErrorNoGold =>
      '`4De herbergier schudt zijn hoofd: \"Geen goud, geen dobbelstenen, vriend!\"`w';

  @override
  String innDiceVictory(Object eRoll, Object gold, Object pRoll) {
    return '`2Je gooit $pRoll en de kroegbaas gooit $eRoll. Je wint $gold goudstukken!`w';
  }

  @override
  String innDiceDefeat(Object eRoll, Object gold, Object pRoll) {
    return '`4Je gooit $pRoll en de kroegbaas gooit $eRoll. Je verliest $gold goudstukken...`w';
  }

  @override
  String innDiceTie(Object pRoll) {
    return '`wGelijkspel! Jullie gooien allebei $pRoll. Je krijgt je inzet terug.`w';
  }

  @override
  String get btnVisitInn => 'Herberg';

  @override
  String newsLogInnWin(Object gold, Object user) {
    return '$user heeft zojuist $gold goudstukken gewonnen met dobbelen in de Herberg!';
  }

  @override
  String newsLogInnLoss(Object gold, Object user) {
    return '$user is zojuist volledig blut gespeeld door de kroegbaas en verloor $gold goudstukken...';
  }

  @override
  String get stablesTitle => 'De Koninklijke Stallen';

  @override
  String get stablesWelcome =>
      '`gJe loopt de stallen binnen. De geur van vers hooi en leder vult de ruimte. De stalmeester loopt op je af en tikt tegen zijn hoed:`w\n\n\"Welkom reiziger! Zoek je een trouwe metgezel voor je reizen? Een goed rijdier beschermt je in de strijd en zorgt dat je elke dag sneller kunt reizen!\"';

  @override
  String stablesCurrentMount(Object mount) {
    return 'Je huidige rijdier: `c$mount`w';
  }

  @override
  String get stablesNoMount => 'Geen (Je loopt te voet)';

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
  String stablesSuccessBuy(Object mount) {
    return '`2Je hebt succesvol een $mount gekocht! De stalmeester brengt je nieuwe metgezel naar buiten.`w';
  }

  @override
  String get stablesMaxLevel =>
      '`gJe bezit al de legendarische Gouden Draak! De stalmeester kijkt vol ontzag naar je rijdier.`w';

  @override
  String get btnVisitStables => 'Stallen';

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
  String get churchTitle => 'Het Serene Klooster';

  @override
  String get churchWelcome =>
      '`gJe stapt de imposante, stille kerk binnen. Het weinige licht valt door de glas-in-loodramen op het altaar. Er hangt een geur van wierook en oude perkamenten.`w\n\n\"Kniel neer, reiziger,\" fluistert een monnik in een lange pij. \"Doe een gebed tot de Goden van het Rijk. Maar wees gewaarschuwd... de Goden zijn wispelturig!\"';

  @override
  String get btnChurchPray => 'Doe een Gebed';

  @override
  String get btnChurchConfess => 'Biechten';

  @override
  String get btnChurchCandle => 'Kaarsje aansteken (1 Gem)';

  @override
  String get churchAlreadyPrayed =>
      '`4Je hebt zojuist al gebeden! De Goden horen je niet als je blijft zeuren.`w';

  @override
  String get churchAlreadyConfessed =>
      '`4Je hebt je geweten voor vandaag al gezuiverd.`w';

  @override
  String get churchAlreadyLitCandle =>
      '`4Het altaar staat al vol met jouw kaarsen.`w';

  @override
  String churchBlessGold(Object gold) {
    return '`2De hemel opent zich en een warme lichtstraal raakt je aan! Je vindt $gold goudstukken op het altaar!`w';
  }

  @override
  String churchBlessGems(Object gems) {
    return '`2Een engel daalt neer en schenkt je een glimmende Edelsteen ($gems Gem)!`w';
  }

  @override
  String get churchBlessHeal =>
      '`2Een goddelijke kracht stroomt door je aderen. Al je wonden zijn in één klap genezen!`w';

  @override
  String get churchNeutral =>
      '`gJe bidt vurig tot de Goden... maar er gebeurt niets. De stilte in de kerk blijft onverstoord.`w';

  @override
  String churchCurseHp(Object hp) {
    return '`4De hemel betrekt en een felle bliksemstraal slaat vlak voor je voeten in! Je verliest $hp HP door de schok!`w';
  }

  @override
  String churchCurseGold(Object gold) {
    return '`4Een plotseline windvlaag raast door de kerk en blaast stiekem $gold goudstukken uit je buidel!`w';
  }

  @override
  String churchConfessResult(Object xp) {
    return '`2Je knielt neer en biecht je zonden. De monnik knikt langzaam. Je voelt je geest lichter worden. (+$xp XP)`w';
  }

  @override
  String churchCandleResult(Object favor) {
    return '`cJe steekt een kaarsje aan bij het beeld van de Oude Goden. Een vlaag van vrede trekt door de kerk. Ramius zal dit onthouden. (+$favor Gunst)`w';
  }

  @override
  String get btnVisitChurch => 'Kerk';

  @override
  String get alchemistTitle => 'De Alchemist';

  @override
  String get alchemistWelcome =>
      '`gJe stapt een donker, mystiek laboratorium binnen. Overal pruttelen glazen kolven met vreemde, dampende vloeistoffen. Een oude alchemist met een dikke bril kijkt op:`w\n\n\"Ah, een avonturier! Zoek je extra kracht voor in het bos? Mijn elixers geven je tijdelijk ongekende macht in je eerstvolgende gevechten. Kies verstandig!\"';

  @override
  String alchemistCurrentBoosts(Object atk, Object def) {
    return 'Actieve elixers: `2$atk Atk`w | `c$def Def`w';
  }

  @override
  String get btnBuyAtkPotion => 'Koop Drakebloed (+5 Atk)';

  @override
  String get btnBuyDefPotion => 'Koop IJzerhuid (+5 Def)';

  @override
  String alchemistSuccessBuy(Object boost) {
    return '`2Je drinkt het elixer op. Een intense energie stroomt direct door je lichaam! Je hebt $boost ontvangen.`w';
  }

  @override
  String get alchemistErrorAlreadyActive =>
      '`4Je hebt al een actieve boost van dit elixer! Meer drinken is puur gif voor je lichaam.`w';

  @override
  String get btnVisitAlchemist => 'Alchemist';

  @override
  String get trainingErrorNoXp =>
      '`4Je bent nog niet klaar! Je hebt niet genoeg ervaring (XP) om de Meester uit te dagen.`w';

  @override
  String trainingSuccessLevelUp(Object level) {
    return '`2Gefeliciteerd! Je hebt de Meester verslagen in een episch gevecht en bent gestegen naar Level $level!`w';
  }

  @override
  String get resetNewDayTitle => 'Een Nieuwe Dag Breekt Aan!';

  @override
  String get resetNewDayMessage =>
      '`2De zon komt op over het rijk en de vogels beginnen te fluiten. Je voelt je uitgerust en vol energie voor nieuwe avonturen!`w\n\nJe beurten zijn aangevuld en de poorten naar het Dorpsplein staan weer wijd open!';

  @override
  String get btnStartDay => 'Begin de nieuwe dag';

  @override
  String get resetNightResults => 'Resultaten van de nacht:';

  @override
  String resetInterestLog(Object amount) {
    return '• De bank heeft `y$amount goud`w aan rente bijgeschreven (2%).';
  }

  @override
  String resetTurnsLog(Object amount) {
    return '• Je beurten zijn aangevuld naar `c$amount`w.';
  }

  @override
  String get resetReadyLog =>
      '• Je voelt je uitgerust en klaar voor de strijd!';

  @override
  String get eventHermitTitle => 'De Oude Kluizenaar';

  @override
  String get eventHermitDesc =>
      '`gTussen de dichte begroeiing zie je een kleine, gecamoufleerde hut. Een stokoude kluizenaar met een lange baard zit voor de deur op een boomstam.`w\n\n\"Ah, jonge reiziger,\" spreekt hij met een krakerige stem. \"Je bent ver van het Dorpsplein. Drink een beker kruidenthee met mij. Het zal je vermoeide benen direct verkwikken!\"';

  @override
  String get eventHermitSuccess =>
      '`2Je drinkt die bittere kruidenthee op. Een golf van intense energie schiet door je benen! Je krijgt +3 extra beurten (turns) voor vandaag.`w';

  @override
  String get btnHermitDrink => 'Drink kruidenthee';

  @override
  String get btnSkillFallback => 'VAARDIGHEID';

  @override
  String get alchemistLimitReached =>
      'Ho eens even! Je hebt vandaag al 2 elixers gekocht. Meer kan je lichaam niet verdragen tot de volgende zonsopgang!';

  @override
  String alchemistTodayCounter(Object count) {
    return 'Elixers vandaag gekocht: $count/2';
  }

  @override
  String get innMenuGamble => 'Goktafel';

  @override
  String get innMenuBartender => 'Barman Cedrik';

  @override
  String get innMenuFlirt => 'Barmeid Violet';

  @override
  String get innFlirtAttempt => 'Flirt met Violet (-1 Edelsteen)';

  @override
  String get innFlirtNoGems =>
      'Je hebt geen edelstenen om haar cadeau te doen!';

  @override
  String get innFlirtSuccess =>
      'Violet bloost van je compliment en schenkt je een herstellend drankje! (+15 HP, +1 Max HP)';

  @override
  String get innFlirtFail =>
      'Violet lacht je vierkant uit. Pijnlijk... Je verliest 2 HP van schaamte.';

  @override
  String get innTalkCedrik => 'Praat met Cedrik';

  @override
  String get innCedrikRumor1 =>
      'Cedrik poetst een glas en fluistert: \'Pas op in het bos, SamHaoir. Er zwerft een oude kluizenaar rond met magische kruidenthee...\'';

  @override
  String get innCedrikRumor2 =>
      'Cedrik bromt: \'De reus in het bos slaapt diep, maar als je hem besteelt, kun je bakken met goud verdienen!\'';

  @override
  String get innMenuMain => 'De Gelagkamer';

  @override
  String get innMenuSpy => 'Mensen Bespioneren';

  @override
  String get innMenuNews => 'Krant & Geruchten Lezen';

  @override
  String get innMenuBlackjack => 'Kaarttafel: Blackjack';

  @override
  String get innSpySelect => 'Kies een doelwit om te bespioneren:';

  @override
  String get innSpyNoTargets =>
      'Er liggen momenteel geen andere reizigers te slapen in de herberg.';

  @override
  String innSpyResult(Object gold, Object lvl, Object target) {
    return 'Je sluipt naar boven en bekijkt de spullen van $target. Level: $lvl, Goud op zak: $gold.';
  }

  @override
  String get innNewsTitle => 'Herberg Geruchten & Laatste Nieuws';

  @override
  String get innBlackjackTitle => 'Blackjack (Inzet: 50 Goud)';

  @override
  String get innBlackjackHit => 'Kaart Vragen';

  @override
  String get innBlackjackStand => 'Pas';

  @override
  String innBlackjackWin(Object house, Object player) {
    return 'Gewonnen! Je hebt $player tegen $house van de bank. (+50 Goud)';
  }

  @override
  String innBlackjackLose(Object house, Object player) {
    return 'Verloren! De bank heeft $house en jij hebt $player. (-50 Goud)';
  }

  @override
  String innBlackjackBust(Object player) {
    return 'Te veel! Je bent kapot gegaan met $player punten. (-50 Goud)';
  }

  @override
  String innBlackjackTie(Object points) {
    return 'Gelijkspel! Beiden $points punten. Je behoudt je inzet.';
  }

  @override
  String get btnReturnCommon => 'Terug naar de Gelagkamer';

  @override
  String get innBlackjackStart => 'START POTJE (50 GOUD)';

  @override
  String get innBlackjackHitBtn => 'HIT (KAART)';

  @override
  String get innBlackjackStandBtn => 'STAND (PAS)';

  @override
  String get innBlackjackCommonReturn => 'TERUG NAAR DE GELAGKAMER';

  @override
  String innBlackjackScoreLog(
    Object houseHand,
    Object playerHand,
    Object playerScore,
  ) {
    return 'Jouw hand: $playerHand ($playerScore)\nBank kaarten: $houseHand';
  }

  @override
  String innSpyResultLog(Object gold, Object level, Object username) {
    return 'Je sluipt naar boven en bekijkt de spullen van $username. Level: $level, Goud op zak: $gold.';
  }

  @override
  String innBlackjackBustLog(Object score) {
    return 'Bust! Je bent kapot gegaan met $score punten. (-50 Goud)';
  }

  @override
  String innBlackjackWinLog(Object house, Object player) {
    return 'Gewonnen! Je hebt $player tegen $house van de bank! (+50 Goud)';
  }

  @override
  String innBlackjackLoseLog(Object house, Object player) {
    return 'Verloren! De bank wint met $house tegen jouw $player. (-50 Goud)';
  }

  @override
  String innBlackjackTieLog(Object score) {
    return 'Gelijkspel! Beiden $score punten. Je behoudt je inzet.';
  }

  @override
  String get profileBiometricReason =>
      'Bevestig je identiteit om snel in te loggen bij LOGD';

  @override
  String get profileBiometricDeviceError =>
      'Dit toestel ondersteunt geen biometrie.';

  @override
  String get profileDatabaseError => 'Er is een fout opgetreden.';

  @override
  String get trainingStatusTitle => '=== STATUS ===';

  @override
  String trainingCurrentLevel(Object level) {
    return 'Huidig Niveau: `yLevel $level`w';
  }

  @override
  String get btnForestWalkAway => 'LOOP DOOR';

  @override
  String get btnForestFountainDive => 'DUIK IN BRON';

  @override
  String get btnForestGiantSneak => 'SLUIP ER LANGS';

  @override
  String get btnForestGiantSteal => 'BESTEEL REUS';

  @override
  String get btnForestAttack => 'AANVALLEN';

  @override
  String get btnForestFlee => 'VLUCHTEN';

  @override
  String get btnForestLeprechaunPlay => 'Speel spel (100 G)';

  @override
  String get btnForestWizardDrink => 'Drink uit ketel';

  @override
  String get btnForestWagonSearch => 'Doorzoek grondig';

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
  String get btnForestHerbalistRed => 'Rode elixir';

  @override
  String get btnForestHerbalistBlue => 'Blauwe elixir';

  @override
  String get btnForestBadgerAnswer => 'Beantwoord vraag';

  @override
  String get btnForestBadgerHunt => 'Jaag das weg';

  @override
  String get btnForestSkeletonPlunder => 'Plunder harnas';

  @override
  String get btnForestSkeletonBow => 'Breng eerbetoon';

  @override
  String get btnForestCarnivalSpin => 'Draai aan rad';

  @override
  String get btnForestCampEat => 'Eet soep';

  @override
  String get btnForestCampSearch => 'Doorzoek tenten';

  @override
  String get btnForestWellOffer => 'Offer edelsteen';

  @override
  String get btnForestWellFish => 'Vis naar goud';

  @override
  String get btnForestHoneyClimb => 'Pak honing';

  @override
  String get btnForestHoneySmoke => 'Rook bijen uit';

  @override
  String get btnForestMushroomStep => 'Stap in cirkel';

  @override
  String get btnForestMushroomDestroy => 'Vernietig cirkel';

  @override
  String get btnForestHunterPlay => 'Schietwedstrijd';

  @override
  String get btnForestHunterDemand => 'Eis goud';

  @override
  String get btnForestStatueOffer => 'Offer goud';

  @override
  String get btnForestStatueClean => 'Maak schoon';

  @override
  String get btnForestSnareCut => 'Snijd los';

  @override
  String get btnForestSnareForce => 'Gebruik kracht';

  @override
  String get btnForestSnareWait => 'Wacht af';

  @override
  String get innBtnDrinkAle => 'Oaktaven Ale';

  @override
  String get innBtnDrinkDragon => 'Drakenbloed';

  @override
  String get innBtnBardGold => 'Trakteer Goud';

  @override
  String get innBtnBardGem => 'Geef Edelsteen';

  @override
  String get innBtnFlirt => 'Flirten (1 beurt)';

  @override
  String get innBtnGift => 'Cadeau (1 gem)';

  @override
  String get innBtnPropose => 'Doe een aanzoek!';

  @override
  String get innBtnGambleDice => 'Dobbelen';

  @override
  String get innBtnGambleShell => 'Bekerspel';

  @override
  String get innBtnGambleBlackjack => 'Blackjack';

  @override
  String get innBtnBribe => 'Omkopen (1 Gem)';

  @override
  String get innBtnBountyAction => 'PREMIE';

  @override
  String innRomanceLabel(Object points) {
    return 'Affectie: `p$points / 100`w';
  }

  @override
  String get innBtnRichest => 'Vraag wie de rijkste is (50 G)';

  @override
  String get innGambleShark => 'Kaarten-haai:';

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
  String get innBlackjackReturn => 'TERUG NAAR DE GELAGKAMER';

  @override
  String innNewsWinLog(Object user, Object val) {
    return '- $user won $val goudstukken aan de goktafel!';
  }

  @override
  String innNewsLossLog(Object user, Object val) {
    return '- $user verloor $val goudstukken aan de bank.';
  }

  @override
  String innNewsEnterLog(Object user) {
    return '- $user betreedt de herberg.';
  }

  @override
  String get innNewsUnknownPlayer => 'Een avonturier';

  @override
  String combatSkillMagicSuccess(Object hp) {
    return '`2Je spreekt een genezingsspreuk uit en herstelt `w$hp `2HP!`w';
  }

  @override
  String combatSkillThievingSuccess(Object enemy, Object gold) {
    return '`cJe sluipt achterom en rooft `y$gold goudstukken `cvantussen de spullen van de $enemy!`w';
  }

  @override
  String combatSkillWarriorSuccess(Object damage, Object enemy) {
    return '`4Je heft je wapen en brengt de $enemy een verwoestende klap toe van `w$damage `4schade!`w';
  }

  @override
  String combatSkillWarriorVictory(Object damage, Object enemy) {
    return '`4Je brengt de $enemy een genadeslag toe van `w$damage `4schade!`w';
  }

  @override
  String combatFleeSuccess(Object enemy) {
    return '\n\n`yJe gooit je wapen neer en rent in paniek het struikgewas in! Je bent succesvol ontsnapt aan de $enemy.`w\n\n';
  }

  @override
  String combatFleeFailed(Object damage, Object enemy) {
    return '\n\n`4Je probeert te vluchten, maar de $enemy haalt fel uit en raakt je in je rug voor `w$damage `4schade!`w\n\n';
  }

  @override
  String combatFleeDeath(Object enemy) {
    return '\n\n`4Je probeert te vluchten, maar de $enemy brengt je een fatale klap toe! Je bent gestorven in het bos.`w\n\n';
  }

  @override
  String get innMenuBuyDrink => 'KOOP DRANKJE (20 GOUD)';

  @override
  String get innDrinkSelectTitle => '=== CEDRIKS ASSORTIMENT ===';

  @override
  String get innDrinkSelectDesc =>
      'Cedrik poetst een glas op en kijkt je aan: \"Wat kan ik voor je inschenken, reiziger?\"';

  @override
  String get innDrink1Name => 'DWERGEN STOUT';

  @override
  String get innDrink1Desc =>
      'Een zwaar, donker bier. Geeft extra kracht maar maakt je slaperig. (+15 HP, -1 Turn)';

  @override
  String get innDrink2Name => 'ELFEN MEEDE';

  @override
  String get innDrink2Desc =>
      'Een zoete, sprankelende honingwijn. Geeft je hernieuwde energie! (+2 Turns)';

  @override
  String get innDrinkSuccess1 =>
      '`2Je drinkt het Dwergen Stout in één teug leeg. Je voelt je een stuk sterker! (+15 HP, -1 Turn)`w';

  @override
  String get innDrinkSuccess2 =>
      '`2De Elfen Meede smaakt heerlijk zoet. Je voelt de energie door je aderen stromen! (+2 Turns)`w';

  @override
  String get btnGraveyardRob => 'GRAF PLUNDEREN';

  @override
  String graveyardSuccessGold(Object gold) {
    return '`2Je pakt een schep en graaft een oud graf open... Onder het rotte hout vind je een verborgen kistje met `y$gold goudstukken`2!`w';
  }

  @override
  String graveyardSuccessGem(Object gems) {
    return '`cJe doorzoekt een statige crypte en glimmende stenen trekken je aandacht... Je vindt `w$gems edelsteen`c!`w';
  }

  @override
  String graveyardZombieEncounter(Object hp) {
    return '`4Terwijl je graaft, grijpt een rotte, koude hand plotseling je enkel! Een zombie kruipt omhoog uit de aarde en valt je aan! (-$hp HP)`w';
  }

  @override
  String get graveyardEmpty =>
      'Je struint urenlang over het mistige kerkhof, maar alle graven lijken al te zijn leeggeroofd door grafrovers.';

  @override
  String get graveyardErrorResurrection =>
      '`4Er is een fout opgetreden bij de opstanding.`w';

  @override
  String get innFlirtMaxHpBonus =>
      '`2Violet valt als een blok voor je charmes! Ze glimlacht verlegen en geeft je een permanente gezondheids-upgrade! (+1 Max HP & Volledig Genezen)`w';

  @override
  String get innFlirtTurnsBonus =>
      '`2Je openingszin is een schot in de roos! Violet vindt je gezelschap fantastisch en schenkt je hernieuwde energie. (+2 Turns)`w';

  @override
  String get innFlirtSlapDefeat =>
      '`4Je openingszin slaat de plank volledig mis! Violet is diep beledigd en geeft je een harde klap in je gezicht! (-5 HP)`w';

  @override
  String get btnVisitHealer => 'KRUIDENHEKS 🌿';

  @override
  String get dialogWoundedTitle => 'TE ZWAARGEWOND';

  @override
  String get dialogWoundedMessage =>
      '`4Je bent te zwaargewond om te vechten. Bezoek de Kruidenheks of de herberg om te herstellen!`w';

  @override
  String get btnBuyHealing => 'KOOP GENEZING';

  @override
  String labelHealCost(Object cost) {
    return 'Kosten voor volledige genezing: `y$cost goudstukken`w';
  }

  @override
  String get btnOk => 'OK';

  @override
  String get healerFallbackWelcome => 'De hut van Althea...';

  @override
  String get healerFallbackHealthy => 'Je bent al kerngezond!';

  @override
  String get btnTalkTownfolk => 'PRAAT MET DORPELINGEN 🗣️';

  @override
  String get dialogRumorTitle => 'DORPSGERUCHTEN';

  @override
  String get townSquareRumorFallback => 'De dorpelingen zijn stil vandaag...';

  @override
  String get healerSuccessFallback => 'Je bent genezen!';

  @override
  String get btnVisitBarber => 'KAPPER MET STYLING 💈';

  @override
  String get btnBuyTitle => 'KOOP TITEL (1 EDELSTEEN)';

  @override
  String get btnVisitAlley => 'SCHADUWRIJKE STEEG 🪓';

  @override
  String get btnResetReputation => 'STRAFBLAD AFKOPEN (5 EDELSTENEN)';

  @override
  String get btnVisitMightyE => 'DONATEUR MIGHTYE 💎';

  @override
  String get btnDonateGem => 'DONEER 1 EDELSTEEN';

  @override
  String get btnVisitWedding => 'TROUW KAPEL 💍';

  @override
  String get btnMarry => 'JA, IK WIL (500 GOUD)';

  @override
  String get graveyard_title => 'De Begraafplaats van Oaktaven (Onderwereld)';

  @override
  String get graveyard_status_dead => 'STATUS: DOOD (Geest)';

  @override
  String graveyard_favor_points(Object points) {
    return 'Gunst bij Ramius: $points punten';
  }

  @override
  String get graveyard_btn_fight => 'Vecht tegen Gekweld Gesternte (1 Beurt)';

  @override
  String get graveyard_btn_resurrect => 'Smeek Ramius om Genade';

  @override
  String get graveyard_btn_haunt => 'Spook in de Herberg (1 Beurt)';

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
  String get ghost_combat_btn_attack => 'VAL AAN';

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
  String get inn_section_barman => '=== De Bar van de Herberg ===';

  @override
  String get inn_section_gamble => '=== De Goktafel ===';

  @override
  String get inn_section_veteran => '=== De Oude Krijger ===';

  @override
  String get inn_section_bounty => '=== De Premiejager ===';

  @override
  String get inn_section_spy => '=== Schimmige Figuren ===';

  @override
  String get inn_section_news => '=== Het Dorpsnieuws ===';

  @override
  String get town_btn_forest => 'Ga het Bos in';

  @override
  String get town_btn_news => 'Dagelijks Nieuws';

  @override
  String get town_btn_shops => 'Winkelstraat';

  @override
  String get town_btn_mystery => 'Mysterieuze Plekken';

  @override
  String get town_btn_training => 'Krijgshof & Training';

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
  String get town_sub_healer => 'Kruidenheks';

  @override
  String get town_sub_alley => 'Schaduwrijke Steeg';

  @override
  String get town_sub_classroom => 'Training zaal';

  @override
  String get town_sub_stables => 'De Stallen';

  @override
  String get town_sub_inn => 'De Herberg';

  @override
  String get town_sub_church => 'De Kerk';

  @override
  String get town_sub_wedding => 'Trouwkapel';

  @override
  String get town_sub_townfolk => 'Dorpelingen';

  @override
  String get town_sub_mightye => 'Donateur Mightye';

  @override
  String get inn_news_empty =>
      'Er is vandaag nog niets voorgevallen in het rijk...';

  @override
  String get inn_spy_empty =>
      'Er dwalen momenteel geen andere reizigers in de herberg...';

  @override
  String get inn_btn_spy_action => 'SPIONEER (10 GOUD)';

  @override
  String get inn_title => 'De Herberg \'De Dronken Draak\'';

  @override
  String get profileBiometricAuthError => 'Verificatie mislukt.';

  @override
  String get btnStyxOnboard => 'STAP OP HET VLOT (KOST 2 TURNS)';

  @override
  String get btnStyxStay => 'BLIJF AAN DE OEVER';

  @override
  String get btnWhispersListen => 'LUISTER AANDACHTIG';

  @override
  String get btnWhispersLeave => 'ZWEEF SNEL VERDER';

  @override
  String get dragon_lair_title => 'Het Hol van de Groene Draak';

  @override
  String get btn_attack_dragon => 'Val de Groene Draak aan!';

  @override
  String get btn_sneak_away => 'Sluip stilletjes weg';

  @override
  String get btn_dragon_continue => 'Accepteer je lot';

  @override
  String news_dragon_kill(Object kills, Object user) {
    return '$user heeft de Groene Draak verslagen en redt het rijk! Dit is hun ${kills}e overwinning!';
  }

  @override
  String newsLogDragonAttack(Object user) {
    return '`4HOREN, ZIEN EN ZEGT HET VOORT!`w $user betreedt het hol van de Groene Draak! Het gebrul trilt door de bergen...';
  }

  @override
  String newsLogDragonDefeat(Object user) {
    return '`4HOREN, ZIEN EN ZEGT HET VOORT!`w $user is op brute wijze geroosterd door de Groene Draak! Oaktaven rouwt...';
  }

  @override
  String get btnDevAddGold => '+10K GOUD';

  @override
  String get btnDevAddGems => '+5 EDELSTENEN';

  @override
  String get btnDevAddTurns => '+10 BEURTEN';

  @override
  String get lblDevSelectEvent => 'Selecteer Event om te Spawnen:';

  @override
  String get lblDevSelectMonster => 'Selecteer Monster om te Spawnen:';

  @override
  String get btnDevSpawnAction => 'SPAWN RECHTSTREEKS 🚀';

  @override
  String get errorNoGems => 'Je hebt niet genoeg glimmende edelstenen!';

  @override
  String btnBuyCut(Object cost) {
    return 'Frisse Coupe ($cost Goud)';
  }

  @override
  String btnBuyShave(Object cost) {
    return 'Gladde Scheerbeurt ($cost Goud)';
  }

  @override
  String get btnBuyDye => 'Haar Verven (1 GEM)';

  @override
  String get dragonShrineTitle => 'Het Drakenheiligdom';

  @override
  String get dragonShrineWelcome =>
      '`gJe stapt een verborgen, met klimop begroeide ruïne net buiten het dorpsplein binnen. In het midden zweeft een mystiek, zacht gloeiend kristal dat pulseert met pure energie. Zodra je dichterbij komt, vormt de energie zich tot het gezicht van een oude woudgod.`w';

  @override
  String dragonShrinePoints(Object amount) {
    return 'Drakenpunten (DP): `y$amount`w';
  }

  @override
  String get dragonShrineNoPoints =>
      '`4De energie in het kristal blijft flets en dof. De stem van de woudgod klinkt koud: \"Je draagt de markering van een drakendoder niet bij je, sterveling. Je hebt hier niets te zoeken.\"`w';

  @override
  String get btnUpgradeAtk => 'PERMANENTE AANVAL (+1 ATK)';

  @override
  String get btnUpgradeDef => 'PERMANENTE VERDEDIGING (+1 DEF)';

  @override
  String get btnUpgradeHp => 'PERMANENTE LEVENSKRACHT (+5 HP)';

  @override
  String get btnUpgradeTurns => 'WOUDLOPER ZEGENING (+1 BEURT)';

  @override
  String get dragonShrineSuccess =>
      '`2De woudgod raakt je aan met een straal van licht. \"De transactie is voltooid. Ga heen en gebruik je nieuwe krachten wijs!\"`w';

  @override
  String get btnVisitDragonShrine => 'Draken Heiligdom';

  @override
  String get guestPlayerName => 'Gast Reiziger';

  @override
  String get guestWelcomeNews =>
      'Welkom in de wereld van de Gouden Draak als gast!';

  @override
  String get alleyBribeDefaultName => 'Een gure reiziger';

  @override
  String alleyBribeNews(String name) {
    return '$name heeft stiekem wat edelstenen aan Sly overhandigd en ziet er ineens een stuk braver uit.';
  }

  @override
  String get mightyEDefaultTitle => 'Donateur';

  @override
  String get defaultTravelerName => 'Reiziger';

  @override
  String get settingsSectionAccount => 'Karakter & Account';

  @override
  String get settingsSectionLanguage => 'Taal & Voorkeuren';

  @override
  String get settingsSectionCommunity => 'Over LOGD & Community';

  @override
  String get profileSaveName => 'Naam Opslaan';

  @override
  String get profileSaveEmail => 'E-mail Opslaan';

  @override
  String get profileChangePassword => 'Wachtwoord wijzigen';

  @override
  String get profileNewPasswordLabel => 'Nieuw wachtwoord';

  @override
  String get profileSavePassword => 'Wachtwoord Opslaan';

  @override
  String get profilePasswordSuccessUpdate =>
      '`2Wachtwoord succesvol gewijzigd!`w';

  @override
  String get profilePasswordErrorEmpty => '`4Vul een nieuw wachtwoord in!`w';

  @override
  String get profilePasswordError => '`4Wachtwoord wijzigen mislukt.`w';

  @override
  String get settingsLanguageTitle => 'Talenkiezer';

  @override
  String get settingsLangDutch => 'Nederlands 🇳🇱';

  @override
  String get settingsLangEnglish => 'English 🇬🇧';

  @override
  String get settingsAboutTitle => 'Over LOGD';

  @override
  String get settingsAboutSubtitle =>
      'Lees het verhaal achter Legend of the Golden Dragon.';

  @override
  String get settingsAboutStory =>
      '`gLegend of the Golden Dragon is een eerbetoon aan de klassieke BBS-tekstadventures uit de jaren \'80 en \'90.\n\nIn een wereld vol gevaar, duistere monsters en oude legenden strijden reizigers om roem, goud en het verslaan van de vreselijke Gouden Draak.\n\nBouw je karakter op, bezoek het dorpsplein, vecht in het bos en verover een plek in de ranglijsten!`w';

  @override
  String get settingsShareTitle => 'App Delen';

  @override
  String get settingsShareSubtitle =>
      'Nodig vrienden uit om het rijk te betreden.';

  @override
  String get settingsShareDialogTitle => 'Deel het Rijk';

  @override
  String get settingsShareDialogText =>
      '`gMond-tot-mondreclame reist sneller dan een draak op de wind!\n\nDeel LOGD met je vrienden en strijd samen op het dorpsplein.`w';

  @override
  String get settingsBtnShare => 'Deel nu';

  @override
  String get settingsRateTitle => 'App Raten';

  @override
  String get settingsRateSubtitle =>
      'Laat een 5-sterren review achter in de Play Store.';

  @override
  String get settingsRateDialogTitle => 'Beoordeel LOGD';

  @override
  String get settingsRateDialogText =>
      '`yGeniet je van je avonturen in het rijk?\n\nLaat een 5-sterren review achter om de makers te steunen en meer reizigers naar het dorp te trekken!`w';

  @override
  String get settingsBtnRate => 'Beoordelen';

  @override
  String get settingsFeedbackTitle => 'Feedback';

  @override
  String get settingsFeedbackSubtitle =>
      'Stuur ideeën of foutmeldingen naar de makers.';

  @override
  String get settingsFeedbackDialogTitle => 'Stuur Feedback';

  @override
  String get settingsFeedbackDialogText =>
      '`cHeb je een suggestie voor een nieuwe feature of heb je een bug gevonden?\n\nLaat het ons weten! Jouw feedback helpt het rijk te verbeteren.`w';

  @override
  String get settingsFeedbackHint => 'Typ hier je feedback...';

  @override
  String get settingsFeedbackSent => '`2Bedankt! Je feedback is ontvangen.`w';

  @override
  String get settingsBtnSend => 'Versturen';

  @override
  String get settingsPrivacyTitle => 'Privacy Policy';

  @override
  String get settingsPrivacySubtitle =>
      'Bekijk hoe wij omgaan met je spelersgegevens.';

  @override
  String get settingsPrivacyDialogTitle => 'Privacy Policy';

  @override
  String get settingsPrivacyDialogText =>
      '`wBij LOGD respecteren we de privacy van elke reiziger.\n\n• Wij verzamelen uitsluitend je e-mailadres en karakternaam voor accountbeheer.\n• Wachtwoorden worden veilig versleuteld opgeslagen via Supabase Auth.\n• We verkopen of delen nooit je gegevens met derden.\n• Je kunt op elk moment je account en gegevens definitief verwijderen.`w';

  @override
  String get btnClose => 'Sluiten';

  @override
  String get tutorialTitle => 'Hoe te Spelen';

  @override
  String tutorialStepProgress(int current, int total) {
    return 'Stap $current van $total';
  }

  @override
  String get tutorialStep1Title => '1. Het Dorpshart & Gebouwen';

  @override
  String get tutorialStep1Content =>
      '`gHet Dorpshart is het bruisende centrum van het rijk.`w\n\nHier vind je alle belangrijke gebouwen:\n\n• `yDe Bank`w: Stall je goud veilig tegen struikrovers en verdien rente.\n• `cHerberg & Genezer`w: Herstel je HP, ontmoet reizigers of neem een behandeling.\n• `pKerk & Altaar`w: Bied offers voor goddelijke zegeningen.\n• `2Winkels & Stallen`w: Koop uitrusting, elixers en rijdieren.';

  @override
  String get tutorialStep2Title => '2. Het Bos & De Gevechten';

  @override
  String get tutorialStep2Content =>
      '`gHet Bos is de plek waar je als avonturier traint!`w\n\n• Elke zoektocht of gevecht kost `c1 Dagelijkse Beurt`w.\n• Versla monsters om `yGoud`w en `cErvaring (XP)`w te verzamelen.\n• Pas op voor je HP: als je bezwijkt in de strijd, ben je `4DOOD`w en verlies je al het goud dat je op zak had!';

  @override
  String get tutorialStep3Title => '3. Smederij & Uitrusting';

  @override
  String get tutorialStep3Content =>
      '`gZonder goede spullen ben je kansloos tegen sterke monsters!`w\n\n• Bezoek de `ySmederij`w op het dorpsplein.\n• Koop krachtige `yWapens`w om meer schade uit te delen.\n• Koop stevige `cHarnassen`w om minder schade te incasseren.\n• Upgrade je spullen zodra je genoeg goud hebt gespaard.';

  @override
  String get tutorialStep4Title => '4. Krijgshof & Level-Ups';

  @override
  String get tutorialStep4Content =>
      '`gHeb je voldoende XP verzameld in het bos?`w\n\n• Ga naar het `pKrijgshof`w op het Dorpsplein.\n• Daag de Meester uit voor een test van je krachten.\n• Versla de Meester om te `2Stijgen in Level`w!\n• Je stijgt in Max HP, leert nieuwe vaardigheden en krijgt toegang tot betere uitrusting.';

  @override
  String get tutorialStep5Title => '5. Nieuwe Dag & De Draak';

  @override
  String get tutorialStep5Content =>
      '`gElke nieuwe dag brengt nieuwe kansen!`w\n\n• Elke 24 uur vindt er een `cNieuwe Dag`w reset plaats.\n• Je krijgt nieuwe bosbeurten en rente over je bankgoud.\n• Blijf vechten, sparen en trainen tot je `yLevel 15`w bereikt.\n• Maak je klaar voor het ultieme gevecht tegen de legendarische `4Gouden Draak`w!';

  @override
  String get tutorialBtnPrevious => 'Vorige';

  @override
  String get tutorialBtnNext => 'Volgende';

  @override
  String get tutorialBtnSkip => 'Overslaan';

  @override
  String get tutorialBtnFinish => 'Begrepen / Start Spel';

  @override
  String get settingsTutorialTitle => 'Hoe te spelen (Tutorial)';

  @override
  String get settingsTutorialSubtitle =>
      'Bekijk de interactieve spelhandleiding';
}
