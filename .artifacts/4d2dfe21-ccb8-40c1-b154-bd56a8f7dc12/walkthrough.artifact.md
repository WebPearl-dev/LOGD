# Walkthrough - Locatie 3: De Herberg - Volledig Bestiarium & NPCs

Ik heb de herberg nu volledig voltooid, inclusief alle vaste gasten en personages uit de documentatie.

## Belangrijkste Nieuwe Features

### 🕵️‍♀️ De Roddelende Barvrouw & Spionnen
- Je kunt nu in de `SPY` sectie direct aan de barmeid vragen wie de **rijkste reiziger** in het rijk is (kost 50 Goud).
- Zij zoekt in de database en onthult de naam en de exacte goudvoorraad van je rijkste rivaal.

### 🃏 De Professionele Gokker (Card Shark)
- Nieuw spel in de `GAMBLE` sectie: **Hoger of Lager**.
- Voorspel of jouw kaart hoger of lager is dan die van de gokker. Win en verdubbel je inzet van 100 Goud.

### 📜 De Mysterieuze Premiejager
- In de `BOUNTY` sectie zie je nu een lijst met alle actieve spelers in het rijk.
- Je kunt op iedereen een **premie (Bounty)** zetten die wordt uitgekeerd aan de volgende speler die hen verslaat.

### 💍 Romance & Huwelijk
- Volledig romance systeem met Violet of Seth Able.
- Affectie-meter (0-100) zichtbaar in het scherm.
- Mogelijkheid om aanzoeken te doen (vereist trouwring) met unieke huwelijks-beloningen (HP herstel + dagelijks zakgeld).

## Technische Details
- **LogdCodes**: Alle kleuren in de herberg (knoppen, voortgangsbalken, labels) zijn nu strikt gekoppeld aan de centrale kleurwetgeving.
- **ARB/JSON**: Geen hardcoded tekst meer. Alle interactieve labels staan in de ARB, alle verhalen in de JSON.
- **Supabase**: Real-time database queries voor spionage en ranglijsten zijn geoptimaliseerd.

De herberg is nu de meest interactieve sociale hub van Oaktaven!
