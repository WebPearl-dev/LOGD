# 📝 LOGD Master Todo Lijst (Audit Resultaten)

Deze lijst bevat alle onderdelen die volgens de documentatie nog ontbreken of verbeterd moeten worden. Markeer met `[x]` als een onderdeel voltooid is.

## 🐉 1. Drakenheiligdom & Dragon Points (Prioriteit)
- [ ] **Nieuw Scherm**: `dragon_shrine_screen.dart` aanmaken voor permanente upgrades.
- [ ] **UI Toegang**: Knop "Bezoek Drakenheiligdom" toevoegen aan de Mysterieuze Plekken op het Dorpsplein.
- [ ] **Permanente Atk/Def**: Logica implementeren in `CombatEngine` om de bonussen uit `dragon_points_upgrades` mee te rekenen.
- [ ] **Permanente HP**: Logica implementeren om bij een level-up (en New Day) de extra HP uit upgrades toe te voegen.
- [ ] **New Day Beurten**: `NewDayService` updaten naar basis 30 beurten + `permanent_bonus_turns`.

## 💬 2. Verhalen & NPC Dialogen
- [ ] **Winkel Quotes**: Alle 15 unieke reacties voor Pegasus (Wapens) toevoegen aan `locatie_winkels.json`.
- [ ] **Winkel Quotes**: Alle 15 unieke reacties voor Merilon (Harnassen) toevoegen aan `locatie_winkels.json`.
- [ ] **Skill Progressie**: Gevechtsteksten in `CombatEngine` dynamisch maken op basis van skill-level (zoals beschreven in `Specialty Skills.md`).
- [ ] **Bankier Quotes**: Verifiëren of alle 15 quotes uit de doc in de JSON staan (momenteel zijn er 3-5).

## ⚰️ 3. De Onderwereld (Begraafplaats)
- [ ] **Event Triggers**: Knoppen voor "Rivier de Styx" en "Muur van Gefluister" functioneel maken in de UI van het kerkhof.
- [ ] **Ghost Bestiary**: Specifieke namen en aanvalsteksten voor Onderwereld-monsters koppelen in `GhostCombatScreen`.

## 🏛️ 4. Dorpsplein & Nieuws
- [ ] **MightyE Titels**: Unieke titels (bijv. "Donateur", "Patroon") scheiden van de Kapper titels in de JSON.
- [ ] **Dragon News**: De Dorpsomroeper moet real-time roepen als een speler de Draak aanvalt of verslaat.

## 🛠️ 5. Algemene Finetuning & Bugs
- [ ] **Database Sync**: Controleren of alle benodigde kolommen (`dragon_points`, `romance_points`, etc.) in alle controllers correct worden bijgewerkt.
- [ ] **Render Fixes**: Controleren op resterende "render overflows" op kleine schermen.
