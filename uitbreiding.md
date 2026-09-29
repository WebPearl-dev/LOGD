# 🚀 LOGD - Uitbreidings- en Brainstormplan

Dit document dient als centrale verzamelplaats voor alle nieuwe ideeën, features en uitbreidingen die we bespreken voor *Legend of the Golden Dragon (LOGD)*. 

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

## ⚔️ 2. PvP & Speler Interactie (Arena & PK)
- **2A. De Arena (PvP Duels):** Een nieuwe locatie op het Dorpsplein waar spelers elkaar kunnen uitdagen voor duels om goud, eer en roem.
- **2B. Player Killing (PK) & De Herberg als Veilige Haven:**
  - Spelers kunnen elkaar buiten op straat of in het bos aanvallen en doden (vooral outlaws / bounty spelers).
  - **"Kamer huren" / Overnachten in de Herberg:** Spelers kunnen in de Herberg tegen betaling van goud een kamer huren (`is_resting_in_inn = true`) om hun karakter te beschermen tegen offline moordaanslagen als ze de app afsluiten. Log je uit in het bos of op straat, dan ben je kwetsbaar voor andere spelers!
- **Technische opzet:**
  - Supabase tabel `pvp_challenges` en bijgewerkte profielstatistieken (`pvp_wins`, `pvp_losses`, `honor`, `is_resting_in_inn`).

## 🛡️ 3. Clans / Gilden Systeem
- **Doel:** Spelers samenbrengen in teams met gezamenlijke doelen, een Clanhuis, een clan-schatkist en clan-ranglijsten.

## 📜 4. Karakter Bio bij Registratie
- **Doel:** Spelers direct bij registratie (of via instellingen) een eigen biografie/spreuk meegeven die zichtbaar is op hun profiel/ranglijst.

## 📢 5. MOTD (Message of the Day / Bericht van de Dag)
- **Doel:** Een opvallende mededeling of welkomstgroet van de ontwikkelaar tonen aan spelers zodra ze inloggen of het Dorpsplein betreden.

## 🎁 6. Uitbreidingsmodules & Premium Bundels (DLC)
- **Doel:** Extra content toevoegen zoals unieke personages, extra locaties (*De Geheime Tuin*, *De Arena*) en thematische pakketten.

## 🐉 7. Klassieke LoRD (Legend of the Red Dragon) / BBS Extra's
- Bank leningen & schulden, De Troon (Koning van het Rijk), Actieve magische spreuken, Premiejagers- en Outlaw systeem, Armworstelen & Kroegspelletjes.
