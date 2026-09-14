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
    return '`2Je valt aan en doet $damageDealt schade bij de $enemy.`w\nDe $enemy $attackText en doet `4$damageReceived schade`w terug!';
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
      '`gWelkom op het Dorpsplein van `yLord of the Golden Dragon`w!\n\nDe zon schijnt over het rijk. Reizigers praten in de schaduw, en in de verte hoor je het gebrul uit het bos... Wat ga je vandaag doen?`w';

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
    return '`rJe voert een brute Schildbeuk uit! Je beukt vol in op de $enemy en doet $amount GEGARANDEERDE schade!`w\nDe $enemy is wankel!';
  }

  @override
  String get smithyTitle => 'Smederij \'Het Hete IJzer\'';

  @override
  String get smithyWelcome =>
      '`gJe stapt de snikhete smederij binnen. Een gesublimeerde dwerg slaat met een enorme hamer op een gloeiend zwaard. Heet ijzer sist in een emmer water.`w\n\n\"Welkom in mijn smederij, reiziger! Ben je die houten stok en dat versleten shirt beu? Kijk eens rond, maar denk erom: kijken kost niks, kopen kost goud!\"';

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
  String get btnVisitSmithy => 'Smederij';

  @override
  String get smithyAmountLabel => 'Aantal goudstukken';

  @override
  String get wep0 => 'Houten Stok';

  @override
  String get wep1 => 'Roestige Dolk';

  @override
  String get wep2 => 'Groot Slagersmes';

  @override
  String get wep3 => 'Ijzeren Zwaard';

  @override
  String get wep4 => 'Glinsterend Breedzwaard';

  @override
  String get wep5 => 'Zware Strijdhamer';

  @override
  String get wep6 => 'Driestandige Speer';

  @override
  String get wep7 => 'Kristallen Sabel';

  @override
  String get wep8 => '龍 (Draken) Zwaard';

  @override
  String get arm0 => 'Versleten Shirt';

  @override
  String get arm1 => 'Leren Vest';

  @override
  String get arm2 => 'Versterkt Lederen Pantser';

  @override
  String get arm3 => 'Ijzeren Ringpantser';

  @override
  String get arm4 => 'Brons Borstplaat';

  @override
  String get arm5 => 'Stalen Harnas';

  @override
  String get arm6 => 'Mithril Maliënkolder';

  @override
  String get arm7 => 'Betoverd Schild';

  @override
  String get arm8 => 'Draken Schubben Pantser';

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
      '`4Je hebt nog niet genoeg ervaring verdiend om mij uit te dagen. Train harder in het bos!`w';

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
  String newsLogDefeated(Object enemy, Object username) {
    return '`4$username`w is in het bos op brute wijze afgeslacht door een `r$enemy`w!';
  }

  @override
  String newsLogLevelUp(Object level, Object username) {
    return '`2$username`w is gestegen naar `yLevel $level`w na een legendarisch duel in de trainingsruimte!';
  }

  @override
  String get btnVisitNews => 'Dagelijks Nieuws';

  @override
  String get newsUnknownPlayer => 'Onbekende Reiziger';

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
      '`gJe stapt de rumoerige herberg binnen. De geur van gebraden vlees en stevig bier komt je tegemoet. In de hoek zingt een bard een vals retro-lied, terwijl reizigers luidruchtig met dobbelstenen gooien.`w\n\n\"Welkom, vreemdeling!\" roept de herbergier terwijl hij een grote pul schoonmaakt. \"Schuif gezellig aan bij de goktafel, of drink een slok!\"';

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
  String newsLogInnWin(Object gold, Object username) {
    return '`2$username`w heeft zojuist `y$gold goudstukken`w gewonnen met dobbelen in de Herberg!';
  }

  @override
  String newsLogInnLoss(Object gold, Object username) {
    return '`o$username`w is zojuist volledig blut gespeeld door de kroegbaas en verloor `y$gold goudstukken`w...';
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
  String get churchAlreadyPrayed =>
      '`4Je hebt zojuist al gebeden! De Goden horen je niet als je blijft zeuren.`w';

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
    return '`4Een plotselinge windvlaag raast door de kerk en blaast stiekem $gold goudstukken uit je buidel!`w';
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
  String get eventHermitTitle => 'De Oude Kluizenaar';

  @override
  String get eventHermitDesc =>
      '`gTussen de dichte begroeiing zie je een kleine, gecamoufleerde hut. Een stokoude kluizenaar met een lange baard zit voor de deur op een boomstam.`w\n\n\"Ah, jonge reiziger,\" spreekt hij met een krakerige stem. \"Je bent ver van het Dorpsplein. Drink een beker kruidenthee met mij. Het zal je vermoeide benen direct verkwikken!\"';

  @override
  String get eventHermitSuccess =>
      '`2Je drinkt de bittere kruidenthee op. Een golf van intense energie schiet door je benen! Je krijgt +3 extra beurten (turns) voor vandaag.`w';

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
}
