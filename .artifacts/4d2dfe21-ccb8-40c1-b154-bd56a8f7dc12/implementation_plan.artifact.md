# Locatie 3: De Herberg (The Leaning Post)

Implementatie van de sociale hub met drankjes, gokken, romance en spionage.

## User Review Required

> [!IMPORTANT]
> Voor de romance-verhaallijn hebben we `romance_points` nodig in de database. Ik ga ervan uit dat deze kolommen (`romance_points`, `drinks_today`, `bard_buff`) al bestaan of toegevoegd kunnen worden.
> Voor het spioneren van rivalen gebruik ik een simpele query op de `profiles` tabel.

## Proposed Changes

### [Models & Enums]

#### [MODIFY] [logd_enums.dart](file:///C:/ontwikkeling/logd/lib/services/logd_enums.dart)
Toevoegen van `InnMenuState` voor de verschillende sub-schermen in de herberg.

### [Data & Stories]

#### [NEW] [locatie_herberg.json](file:///C:/ontwikkeling/logd/assets/story/nl/locatie_herberg.json)
Alle sfeervolle teksten voor de barman, bard, veteranen en romance.

#### [MODIFY] [app_nl.arb](file:///C:/ontwikkeling/logd/lib/l10n/app_nl.arb)
Labels voor knoppen zoals "Bestel een drankje", "Gooi dobbelstenen", etc.

### [Services]

#### [NEW] [inn_controller.dart](file:///C:/ontwikkeling/logd/lib/services/inn_controller.dart)
Logica voor gokken, drankeffecten, romance-berekeningen en database-updates.

### [UI Components]

#### [NEW] [inn_screen.dart](file:///C:/ontwikkeling/logd/lib/screens/inn_screen.dart)
Het hoofdscherm van de herberg met een dynamisch paneel voor de verschillende NPC's.

## Verification Plan

### Manual Verification
- Testen of het drankmenu de limiet van 1 per dag handhaaft.
- Controleren of het gokken goud correct toevoegt/aftrekt.
- Verifiëren of de Bard-buffs correct worden toegepast op de speler-stats.
- Testen of spionage de echte data van andere spelers uit Supabase trekt.
