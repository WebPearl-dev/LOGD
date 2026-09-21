// lib/services/logd_enums.dart

enum PlayerSpecialty { magic, thieving, warrior }

enum ForestEventType {
  none,
  fountain,
  giant,
  hermit,
  leprechaun,
  hedgeWizard,
  merchantWagon,
  whiteHart,
  cardShark,
  talkingTree,
  ruinedTemple,
  travellingHerbalist,
  scholarBadger,
  skeletonArmour,
  darkCarnival,
  abandonedCamp,
  wishingWell,
  honeyTree,
  mushroomRing,
  huntersTarget,
  warriorStatue,
  poachersSnare,
  forcedFountain,
  forcedGiant
}

enum GhostEventType {
  none,
  styx,
  whispers
}

enum CombatStatus {
  roundContinue,
  enemyDefeated,
  playerDied,
  skillMagic,
  skillThieving,
  skillWarrior,
  fleeSuccess,
  fleeFailed,
  ghostPlayerDefeated
}

enum BardBuffType { none, warrior, scavenger, haste }

enum InnSection { main, barman, gamble, veteran, bounty, spy, news, bard, romance }
