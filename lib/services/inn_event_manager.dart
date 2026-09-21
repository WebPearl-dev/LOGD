// lib/services/inn_event_manager.dart
import 'dart:math';
import 'inn_controller.dart';
import 'logd_enums.dart';

class InnEventManager {
  final InnController controller;
  final Random _random = Random();

  List<int> playerHand = [];
  List<int> houseHand = [];
  bool isBlackjackOver = true;
  String statusMessageKey = "";

  InnEventManager({required this.controller});

  void talkToVeteran(Function(String, int, int) onFinished) {
    if (controller.goldOnHand < 20) {
      onFinished("error_no_gold", 0, 0);
      return;
    }
    controller.goldOnHand -= 20;

    final bool success = _random.nextInt(100) < 50;
    int xpGained = 0;
    int hpLost = 0;

    if (success) {
      xpGained = controller.level * 10;
      controller.experience += xpGained;
      statusMessageKey = "veteran_success";
    } else {
      hpLost = 2;
      controller.playerHp = (controller.playerHp - hpLost).clamp(0, controller.playerMaxHp);
      statusMessageKey = "veteran_fail";
    }
    controller.updateCloudStats();
    onFinished(statusMessageKey, xpGained, hpLost);
  }

  void placeBounty(String targetId, int amount, Function(String) onFinished) async {
    if (controller.goldOnHand < amount) {
      onFinished("error_no_gold");
      return;
    }
    controller.goldOnHand -= amount;
    final bool cloudSuccess = await controller.insertBounty(targetId, amount);
    if (cloudSuccess) {
      statusMessageKey = "bounty_success";
      await controller.updateCloudStats();
    } else {
      statusMessageKey = "error_bounty_failed";
    }
    onFinished(statusMessageKey);
  }

  void playDice(int wager, Function(CombatStatus, int, int) onFinished) {
    if (controller.goldOnHand < wager) {
      onFinished(CombatStatus.playerDied, 0, 0);
      return;
    }
    final int pRoll = _random.nextInt(6) + 1 + _random.nextInt(6) + 1;
    final int hRoll = _random.nextInt(6) + 1 + _random.nextInt(6) + 1;

    if (pRoll > hRoll) {
      controller.goldOnHand += wager;
      onFinished(CombatStatus.skillMagic, pRoll, hRoll);
    } else if (pRoll < hRoll) {
      controller.goldOnHand -= wager;
      onFinished(CombatStatus.playerDied, pRoll, hRoll);
    } else {
      onFinished(CombatStatus.roundContinue, pRoll, hRoll);
    }
    controller.updateCloudStats();
  }

  void buyDrink(int drinkType, Function(String) onFinished) {
    if (controller.drinksToday >= 1) {
      onFinished("barman_limit_reached");
      return;
    }

    int cost = (drinkType == 1) ? controller.level * 10 : controller.level * 100;
    if (controller.goldOnHand < cost) {
      onFinished("error_no_gold");
      return;
    }

    controller.goldOnHand -= cost;
    controller.drinksToday += 1;

    if (drinkType == 1) {
      if (_random.nextBool()) {
        controller.playerMaxHp += 1;
        controller.playerHp = controller.playerMaxHp;
        statusMessageKey = "drink_ale_success";
      } else {
        controller.turns = (controller.turns - 1).clamp(0, 999);
        statusMessageKey = "drink_ale_fail";
      }
    } else {
      controller.dragonBreathFights = 5;
      statusMessageKey = "drink_dragon_success";
    }

    controller.updateCloudStats();
    onFinished(statusMessageKey);
  }

  void listenToBard(bool useGem, Function(String) onFinished) {
    if (controller.bardBuff != "none") {
      onFinished("bard_limit_reached");
      return;
    }

    int cost = useGem ? 1 : controller.level * 50;
    if (useGem) {
      if (controller.gems < 1) { onFinished("error_no_gems"); return; }
      controller.gems -= 1;
    } else {
      if (controller.goldOnHand < cost) { onFinished("error_no_gold"); return; }
      controller.goldOnHand -= cost;
    }

    int roll = _random.nextInt(3);
    if (roll == 0) {
      controller.bardBuff = "warrior";
      statusMessageKey = "bard_song_warrior";
    } else if (roll == 1) {
      controller.bardBuff = "scavenger";
      statusMessageKey = "bard_song_scavenger";
    } else {
      controller.turns += 5;
      controller.bardBuff = "haste";
      statusMessageKey = "bard_song_haste";
    }

    controller.updateCloudStats();
    onFinished(statusMessageKey);
  }

  void flirt(Function(String, int) onFinished) {
    if (controller.turns < 1) {
      onFinished("error_no_turns", 0);
      return;
    }
    controller.turns -= 1;

    if (_random.nextInt(100) < 20) {
      controller.playerHp = (controller.playerHp - 5).clamp(0, controller.playerMaxHp);
      statusMessageKey = "romance_flirt_fail";
      onFinished(statusMessageKey, 0);
    } else {
      int points = _random.nextInt(10) + 1;
      controller.romancePoints += points;
      statusMessageKey = "romance_flirt_success";
      onFinished(statusMessageKey, points);
    }
    controller.updateCloudStats();
  }

  void giveGift(Function(String) onFinished) {
    if (controller.gems < 1) {
      onFinished("error_no_gems");
      return;
    }
    controller.gems -= 1;
    controller.romancePoints += 25;
    controller.updateCloudStats();
    onFinished("romance_gift_success");
  }

  void propose(Function(String) onFinished) {
    if (!controller.hasRing) {
      onFinished("error_no_ring");
      return;
    }
    controller.isMarried = true;
    controller.updateCloudStats();
    onFinished("romance_proposal_success");
  }

  void playHigherLower(int wager, bool chooseHigher, Function(bool, int, int) onResult) {
    if (controller.goldOnHand < wager) {
      onResult(false, 0, 0);
      return;
    }

    int pCard = _random.nextInt(13) + 1;
    int hCard = _random.nextInt(13) + 1;
    
    while (hCard == pCard) {
      hCard = _random.nextInt(13) + 1;
    }

    bool win = false;
    if (chooseHigher) {
      win = pCard > hCard;
    } else {
      win = pCard < hCard;
    }

    if (win) {
      controller.goldOnHand += wager;
    } else {
      controller.goldOnHand -= wager;
    }
    
    controller.updateCloudStats();
    onResult(win, pCard, hCard);
  }

  void playShellGame(int wager, Function(bool) onFinished) {
    if (controller.goldOnHand < wager) {
      onFinished(false);
      return;
    }
    
    if (_random.nextInt(3) == 0) {
      controller.goldOnHand += (wager * 2);
      controller.updateCloudStats();
      onFinished(true);
    } else {
      controller.goldOnHand -= wager;
      controller.updateCloudStats();
      onFinished(false);
    }
  }

  int _drawCard() => _random.nextInt(10) + 1;
  int calculateScore(List<int> hand) => hand.fold(0, (sum, card) => sum + card);

  void startBlackjack(int wager, Function(String) onFinished) {
    if (controller.goldOnHand < wager) {
      onFinished("error_no_gold");
      return;
    }
    playerHand = [_drawCard(), _drawCard()];
    houseHand = [_drawCard()];
    isBlackjackOver = false;
    onFinished("blackjack_start_log");
  }

  void blackjackHit(int wager, Function(String, int) onFinished) {
    playerHand.add(_drawCard());
    final int score = calculateScore(playerHand);
    if (score > 21) {
      controller.goldOnHand -= wager;
      isBlackjackOver = true;
      controller.updateCloudStats();
      onFinished("BUST", score);
    } else {
      onFinished("CONTINUE", score);
    }
  }

  void blackjackStand(int wager, Function(String, int, int) onResult) {
    while (calculateScore(houseHand) < 17) {
      houseHand.add(_drawCard());
    }
    int pScore = calculateScore(playerHand);
    int hScore = calculateScore(houseHand);
    isBlackjackOver = true;

    if (hScore > 21 || pScore > hScore) {
      controller.goldOnHand += wager;
      onResult("WIN", pScore, hScore);
    } else if (pScore < hScore) {
      controller.goldOnHand -= wager;
      onResult("LOSE", pScore, hScore);
    } else {
      onResult("TIE", pScore, hScore);
    }
    controller.updateCloudStats();
  }
}
