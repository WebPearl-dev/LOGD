# 🚀 LOGD - Uitbreidings- en Brainstormplan

Dit document dient als centrale verzamelplaats voor alle nieuwe ideeën, features en uitbreidingen die we bespreken voor *Legend of the Golden Dragon (LOGD)*. Zodra we klaar zijn met brainstormen, gebruiken we dit als basis voor onze definitieve TODO-lijst.

---

## 💬 1. Uitgebreid Chatsysteem & Berichtenverkeer
- **1A. Dorpsplein Chat (Global Chat):** Live chat voor alle reizigers op het Dorpsplein.
- **1B. Clanhuis Chat:** Besloten chatkanaal exclusief voor leden van dezelfde clan.
- **1C. Privéberichten (DM Systeem):** Spelers kunnen elkaar onderling direct berichten sturen.
- **1D. Automatisch Scheldwoordenfilter (Profanity Trigger):** 
  - Een ingebouwd filter in Dart dat ongepaste of smerige taal automatisch detecteert en maskeert (bijv. naar `*#$!*`) in chats, privémessages en biografieën.
- **Technische opzet:**
  - Supabase tabel `global_chat` (`id`, `user_id`, `username`, `message`, `created_at`).
  - Supabase tabel `direct_messages` (`id`, `sender_id`, `receiver_id`, `message`, `is_read`, `created_at`).
  - Supabase Realtime streaming (`.stream()`) voor live updates.
  - Centrale `ProfanityFilterService` voor automatische woordfiltering.

## 🛡️ 2. Clans / Gilden Systeem
- **Doel:** Spelers samenbrengen in teams met gezamenlijke doelen, een Clanhuis, een clan-schatkist en clan-ranglijsten.
- **Technische opzet:**
  - Supabase tabel `clans` (`id`, `name`, `tag`, `leader_id`, `treasury_gold`, `created_at`).
  - Supabase tabel `clan_members` of een `clan_id` foreign key in de `profiles` tabel.
  - Clan-schatkist (goud/edelstenen doneren) en clan-ranglijst.

## 📜 3. Karakter Bio bij Registratie
- **Doel:** Spelers direct bij registratie (of via instellingen) een eigen biografie/spreuk meegeven die zichtbaar is op hun profiel/ranglijst.
- **Technische opzet:**
  - `bio` kolom toevoegen aan de `profiles` tabel in Supabase.
  - Invoerveld toevoegen in `AuthScreen` / `ProfileSettingsScreen` (voldoet aan profanity filter).
  - Weergave in profiel en ranglijsten.

## 📢 4. MOTD (Message of the Day / Bericht van de Dag)
- **Doel:** Een opvallende mededeling of welkomstgroet van de ontwikkelaar tonen aan spelers zodra ze inloggen of het Dorpsplein betreden.
- **Technische opzet:**
  - Supabase tabel `motd` (`id`, `message`, `is_active`, `updated_at`).
  - Beheer via het Developer Panel (`DeveloperPanelScreen`).
  - Popup of banner op het Dorpsplein (`TownSquareScreen`) bij binnenkomst.

## 🎁 5. Uitbreidingsmodules & Premium Bundels (DLC)
- **Doel:** Extra content toevoegen die spelers kunnen ontgrendelen of kopen (in-app of via edelstenen/premium valuta).
  - **5A. Exclusieve Personages / Rassen / Skins:** Unieke helden of uiterlijke aanpassingen.
  - **5B. Extra Locaties / Ruimtes:** Zoals *De Geheime Tuin* (voor unieke kruiden/elixirs), *De Arena* (voor PvP duels tussen spelers), of *De Toren der Magie*.
  - **5C. Bundel Systeem:** Modules aanbieden als thematische pakketten (bijv. "De Tuin & Magiër Bundel").
- **Technische opzet:**
  - Supabase tabel `unlocked_modules` (`user_id`, `module_key`, `unlocked_at`).
  - In-game winkel ("De Premium Markt" of via de Alchemist/Kapper) waar modules gekocht kunnen worden met edelstenen of in-app aankopen (`in_app_purchase`).

## 🐉 6. Klassieke LoRD (Legend of the Red Dragon) / BBS Extra's
- **6A. Bank Leningen & Schulden:** Geld lenen bij de bankiersdwarf (met rente en incasso/straf als je niet op tijd terugbetaalt).
- **6B. De Troon (Koning / Heerser van het Rijk):** De speler die de Draak verslaat (of de huidige Koning uitdaagt), wordt de Heerser van de Troon met speciale dagelijkse belastingen en privileges.
- **6C. Actieve Magische Spreuken:** Gevechtsspreuken die spelers kunnen leren en inzetten tijdens gevechten in het bos (bijv. *Fireball*, *Healing Touch*, *Shield*).
- **6D. Uitgebreid Premiejagers- & Outlaw Systeem:** Spelers kunnen elkaar officieel vogelvrij verklaren via een bounty in de steeg, waarna andere spelers op jacht kunnen gaan naar die premiejagers-doelwitten.
- **6E. Armworstelen & Kroegspelletjes:** Extra minigames in de herberg tegen NPC's of andere reizigers voor roem en goud.

---
*Voeg hieronder nieuwe ideeën toe tijdens onze verdere brainstorm...*
