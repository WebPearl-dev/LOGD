// lib/services/logd_enums.dart

enum PlayerSpecialty { magic, thieving, warrior }

enum ForestEventType {
  none,
  fountain,
  giant,
  forcedFountain,
  forcedGiant,
  hermit // DE FIX: Nu als legitiem onderdeel toegevoegd aan de type-keten!
}

enum CombatStatus {
  roundContinue,
  enemyDefeated,
  playerDied,
  skillMagic,
  skillThieving,
  skillWarrior,
  fleeSuccess,
  fleeFailed
}
