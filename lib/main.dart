import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:eveil_enfants/extra_category_data.dart';

void main() {
  runApp(const EveilEnfantsApp());
}

class EveilEnfantsApp extends StatelessWidget {
  const EveilEnfantsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Éveil Enfants',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFBC42),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.transparent,
      ),
      builder: (context, child) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/animaux_001.jpg'),
              fit: BoxFit.cover,
              opacity: 0.28,
            ),
            color: Color(0xFFFFF8EF),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const AccueilAnimauxPage(),
    );
  }
}

class ThemeItem {
  const ThemeItem({
    required this.name,
    required this.imageAsset,
    required this.color,
    required this.soundAsset,
    this.hasDedicatedSound = true,
  });

  final String name;
  final String imageAsset;
  final Color color;
  final String soundAsset;
  final bool hasDedicatedSound;
}

enum EveilTheme { animaux, flore, objets, nourriture, transports }
enum PlayMode { libre, quiz }
enum DifficultyLevel { petit, moyen, complet }
const String _genericSuccessJingle = 'sounds/coq.mp3';
const String _genericErrorJingle = 'sounds/faux_femme_hortense_neutre.wav';

final List<ThemeItem> _foods = kFoodSeeds
    .map(
      (seed) => ThemeItem(
        name: seed.name,
        imageAsset: seed.imageAsset,
        color: Color(seed.colorHex),
        soundAsset: seed.soundAsset,
      ),
    )
    .toList(growable: false);

final List<ThemeItem> _transports = kTransportSeeds
    .map(
      (seed) => ThemeItem(
        name: seed.name,
        imageAsset: seed.imageAsset,
        color: Color(seed.colorHex),
        soundAsset: seed.soundAsset,
      ),
    )
    .toList(growable: false);

const List<ThemeItem> _animals = [
  ThemeItem(
    name: 'Lion',
    imageAsset: 'assets/images/lion.png',
    color: Color(0xFFFF8A80),
    soundAsset: 'sounds/lion.mp3',
  ),
  ThemeItem(
    name: 'Chat',
    imageAsset: 'assets/images/chat.png',
    color: Color(0xFFFFD180),
    soundAsset: 'sounds/chat.mp3',
  ),
  ThemeItem(
    name: 'Chien',
    imageAsset: 'assets/images/chien.png',
    color: Color(0xFFFFFF8D),
    soundAsset: 'sounds/chien.mp3',
  ),
  ThemeItem(
    name: 'Oiseau',
    imageAsset: 'assets/images/oiseau.png',
    color: Color(0xFFCCFF90),
    soundAsset: 'sounds/oiseau.mp3',
  ),
  ThemeItem(
    name: 'Grenouille',
    imageAsset: 'assets/images/grenouille.png',
    color: Color(0xFF80D8FF),
    soundAsset: 'sounds/grenouille.mp3',
  ),
  ThemeItem(
    name: 'Éléphant',
    imageAsset: 'assets/images/elephant.png',
    color: Color(0xFFB388FF),
    soundAsset: 'sounds/elephant.mp3',
  ),
  ThemeItem(
    name: 'Singe',
    imageAsset: 'assets/images/singe.png',
    color: Color(0xFFFFAB91),
    soundAsset: 'sounds/singe.mp3',
  ),
  ThemeItem(
    name: 'Vache',
    imageAsset: 'assets/images/vache.png',
    color: Color(0xFFA5D6A7),
    soundAsset: 'sounds/vache.mp3',
  ),
  ThemeItem(
    name: 'Canard',
    imageAsset: 'assets/images/canard.png',
    color: Color(0xFF90CAF9),
    soundAsset: 'sounds/canard.mp3',
  ),
  ThemeItem(
    name: 'Cheval',
    imageAsset: 'assets/images/cheval.png',
    color: Color(0xFFD7CCC8),
    soundAsset: 'sounds/cheval.mp3',
  ),
  ThemeItem(
    name: 'Hibou',
    imageAsset: 'assets/images/hibou.png',
    color: Color(0xFFBCAAA4),
    soundAsset: 'sounds/hibou.mp3',
  ),
  ThemeItem(
    name: 'Cochon',
    imageAsset: 'assets/images/cochon.png',
    color: Color(0xFFF8BBD0),
    soundAsset: 'sounds/cochon.mp3',
  ),
  ThemeItem(
    name: 'Raton',
    imageAsset: 'assets/images/raton.png',
    color: Color(0xFFB0BEC5),
    soundAsset: 'sounds/raton.mp3',
  ),
  ThemeItem(
    name: 'Coq',
    imageAsset: 'assets/images/coq.png',
    color: Color(0xFFFFE082),
    soundAsset: 'sounds/coq.mp3',
  ),
  ThemeItem(
    name: 'Mouton',
    imageAsset: 'assets/images/mouton.png',
    color: Color(0xFFE1F5FE),
    soundAsset: 'sounds/mouton.mp3',
  ),
  ThemeItem(
    name: 'Tigre',
    imageAsset: 'assets/images/tigre.png',
    color: Color(0xFFFFCC80),
    soundAsset: 'sounds/tigre.mp3',
  ),
  ThemeItem(
    name: 'Dinde',
    imageAsset: 'assets/images/dinde.png',
    color: Color(0xFFCE93D8),
    soundAsset: 'sounds/dinde.mp3',
  ),
  ThemeItem(
    name: 'Zèbre',
    imageAsset: 'assets/images/zebre.png',
    color: Color(0xFFCFD8DC),
    soundAsset: 'sounds/zebre.mp3',
  ),
  ThemeItem(
    name: 'Baleine',
    imageAsset: 'assets/images/baleine.png',
    color: Color(0xFF80DEEA),
    soundAsset: 'sounds/baleine.mp3',
  ),
  ThemeItem(
    name: 'Orignal',
    imageAsset: 'assets/images/orignal.png',
    color: Color(0xFFA1887F),
    soundAsset: 'sounds/orignal.mp3',
  ),
  ThemeItem(
    name: 'Lapin',
    imageAsset: 'assets/images/lapin.png',
    color: Color(0xFFF8BBD0),
    soundAsset: 'sounds/lapin.mp3',
  ),
  ThemeItem(
    name: 'Panda',
    imageAsset: 'assets/images/panda.png',
    color: Color(0xFFCFD8DC),
    soundAsset: 'sounds/panda.mp3',
  ),
  ThemeItem(
    name: 'Koala',
    imageAsset: 'assets/images/koala.png',
    color: Color(0xFFB0BEC5),
    soundAsset: 'sounds/koala.mp3',
  ),
  ThemeItem(
    name: 'Renard',
    imageAsset: 'assets/images/renard.png',
    color: Color(0xFFFFCC80),
    soundAsset: 'sounds/renard.mp3',
  ),
  ThemeItem(
    name: 'Ours',
    imageAsset: 'assets/images/ours.png',
    color: Color(0xFFD7CCC8),
    soundAsset: 'sounds/ours.mp3',
  ),
  ThemeItem(
    name: 'Souris',
    imageAsset: 'assets/images/souris.png',
    color: Color(0xFFB39DDB),
    soundAsset: 'sounds/souris.mp3',
  ),
  ThemeItem(
    name: 'Rat',
    imageAsset: 'assets/images/rat.png',
    color: Color(0xFFB0BEC5),
    soundAsset: 'sounds/rat.mp3',
  ),
  ThemeItem(
    name: 'Poule',
    imageAsset: 'assets/images/poule.png',
    color: Color(0xFFFFE082),
    soundAsset: 'sounds/poule.mp3',
  ),
  ThemeItem(
    name: 'Poisson',
    imageAsset: 'assets/images/poisson.png',
    color: Color(0xFF81D4FA),
    soundAsset: 'sounds/poisson.mp3',
  ),
  ThemeItem(
    name: 'Pieuvre',
    imageAsset: 'assets/images/pieuvre.png',
    color: Color(0xFFCE93D8),
    soundAsset: 'sounds/pieuvre.mp3',
  ),
  ThemeItem(
    name: 'Dauphin',
    imageAsset: 'assets/images/dauphin.png',
    color: Color(0xFF80DEEA),
    soundAsset: 'sounds/dauphin.mp3',
  ),
  ThemeItem(
    name: 'Requin',
    imageAsset: 'assets/images/requin.png',
    color: Color(0xFF90A4AE),
    soundAsset: 'sounds/requin.mp3',
  ),
  ThemeItem(
    name: 'Crabe',
    imageAsset: 'assets/images/crabe.png',
    color: Color(0xFFFF8A65),
    soundAsset: 'sounds/crabe.mp3',
  ),
  ThemeItem(
    name: 'Escargot',
    imageAsset: 'assets/images/escargot.png',
    color: Color(0xFFA1887F),
    soundAsset: 'sounds/escargot.mp3',
  ),
  ThemeItem(
    name: 'Coccinelle',
    imageAsset: 'assets/images/coccinelle.png',
    color: Color(0xFFE57373),
    soundAsset: 'sounds/coccinelle.mp3',
  ),
  ThemeItem(
    name: 'Papillon',
    imageAsset: 'assets/images/papillon.png',
    color: Color(0xFFBA68C8),
    soundAsset: 'sounds/papillon.mp3',
  ),
  ThemeItem(
    name: 'Abeille',
    imageAsset: 'assets/images/abeille.png',
    color: Color(0xFFFFD54F),
    soundAsset: 'sounds/abeille.mp3',
  ),
  ThemeItem(
    name: 'Serpent',
    imageAsset: 'assets/images/serpent.png',
    color: Color(0xFF81C784),
    soundAsset: 'sounds/serpent.mp3',
  ),
  ThemeItem(
    name: 'Crocodile',
    imageAsset: 'assets/images/crocodile.png',
    color: Color(0xFF66BB6A),
    soundAsset: 'sounds/crocodile.mp3',
  ),
  ThemeItem(
    name: 'Tortue',
    imageAsset: 'assets/images/tortue.png',
    color: Color(0xFFA5D6A7),
    soundAsset: 'sounds/tortue.mp3',
  ),
];

const List<ThemeItem> _flora = [
  ThemeItem(
    name: 'Fleur',
    imageAsset: 'assets/images/fleur.png',
    color: Color(0xFFF48FB1),
    soundAsset: 'sounds/fleur.mp3',
  ),
  ThemeItem(
    name: 'Arbre',
    imageAsset: 'assets/images/arbre.png',
    color: Color(0xFFA5D6A7),
    soundAsset: 'sounds/arbre.mp3',
  ),
  ThemeItem(
    name: 'Cactus',
    imageAsset: 'assets/images/cactus.png',
    color: Color(0xFF80CBC4),
    soundAsset: 'sounds/cactus.mp3',
  ),
  ThemeItem(
    name: 'Plante',
    imageAsset: 'assets/images/plante.png',
    color: Color(0xFFC5E1A5),
    soundAsset: 'sounds/plante.mp3',
  ),
  ThemeItem(
    name: 'Trèfle',
    imageAsset: 'assets/images/trefle.png',
    color: Color(0xFFB2DFDB),
    soundAsset: 'sounds/trefle.mp3',
  ),
  ThemeItem(
    name: 'Tulipe',
    imageAsset: 'assets/images/tulipe.png',
    color: Color(0xFFFFCCBC),
    soundAsset: 'sounds/tulipe.mp3',
  ),
  ThemeItem(
    name: 'Pousse',
    imageAsset: 'assets/images/pousse.png',
    color: Color(0xFFC5E1A5),
    soundAsset: 'sounds/pousse.mp3',
  ),
  ThemeItem(
    name: 'Sapin',
    imageAsset: 'assets/images/sapin.png',
    color: Color(0xFFA5D6A7),
    soundAsset: 'sounds/sapin.mp3',
  ),
  ThemeItem(
    name: 'Palmier',
    imageAsset: 'assets/images/palmier.png',
    color: Color(0xFF9CCC65),
    soundAsset: 'sounds/palmier.mp3',
  ),
  ThemeItem(
    name: 'Tournesol',
    imageAsset: 'assets/images/tournesol.png',
    color: Color(0xFFFFF176),
    soundAsset: 'sounds/tournesol.mp3',
  ),
  ThemeItem(
    name: 'Rose',
    imageAsset: 'assets/images/rose.png',
    color: Color(0xFFF48FB1),
    soundAsset: 'sounds/rose.mp3',
  ),
  ThemeItem(
    name: 'Hibiscus',
    imageAsset: 'assets/images/hibiscus.png',
    color: Color(0xFFF06292),
    soundAsset: 'sounds/hibiscus.mp3',
  ),
  ThemeItem(
    name: 'Champignon',
    imageAsset: 'assets/images/champignon.png',
    color: Color(0xFFA1887F),
    soundAsset: 'sounds/champignon.mp3',
  ),
  ThemeItem(
    name: 'Feuille',
    imageAsset: 'assets/images/feuille.png',
    color: Color(0xFF81C784),
    soundAsset: 'sounds/feuille.mp3',
  ),
  ThemeItem(
    name: 'Érable',
    imageAsset: 'assets/images/erable.png',
    color: Color(0xFFFFAB91),
    soundAsset: 'sounds/erable.mp3',
  ),
  ThemeItem(
    name: 'Bouquet',
    imageAsset: 'assets/images/bouquet.png',
    color: Color(0xFFFFCDD2),
    soundAsset: 'sounds/bouquet.mp3',
  ),
  ThemeItem(
    name: 'Épis',
    imageAsset: 'assets/images/epis.png',
    color: Color(0xFFFFE082),
    soundAsset: 'sounds/epis.mp3',
  ),
  ThemeItem(
    name: 'Feuille verte',
    imageAsset: 'assets/images/feuille_verte.png',
    color: Color(0xFFB2DFDB),
    soundAsset: 'sounds/feuille_verte.mp3',
  ),
];

const List<ThemeItem> _objects = [
  ThemeItem(
    name: 'Ballon',
    imageAsset: 'assets/images/ballon.png',
    color: Color(0xFFFFAB91),
    soundAsset: 'sounds/ballon.mp3',
  ),
  ThemeItem(
    name: 'Voiture',
    imageAsset: 'assets/images/voiture.png',
    color: Color(0xFFB39DDB),
    soundAsset: 'sounds/voiture.mp3',
  ),
  ThemeItem(
    name: 'Livre',
    imageAsset: 'assets/images/livre.png',
    color: Color(0xFF90CAF9),
    soundAsset: 'sounds/livre.mp3',
  ),
  ThemeItem(
    name: 'Réveil',
    imageAsset: 'assets/images/reveil.png',
    color: Color(0xFFFFF59D),
    soundAsset: 'sounds/reveil.mp3',
  ),
  ThemeItem(
    name: 'Nounours',
    imageAsset: 'assets/images/nounours.png',
    color: Color(0xFFA5D6A7),
    soundAsset: 'sounds/nounours.mp3',
  ),
  ThemeItem(
    name: 'Puzzle',
    imageAsset: 'assets/images/puzzle.png',
    color: Color(0xFFCE93D8),
    soundAsset: 'sounds/puzzle.mp3',
  ),
  ThemeItem(
    name: 'Téléphone',
    imageAsset: 'assets/images/telephone.png',
    color: Color(0xFFB39DDB),
    soundAsset: 'sounds/telephone.mp3',
  ),
  ThemeItem(
    name: 'Ordinateur',
    imageAsset: 'assets/images/ordinateur.png',
    color: Color(0xFF90CAF9),
    soundAsset: 'sounds/ordinateur.mp3',
  ),
  ThemeItem(
    name: 'Caméra',
    imageAsset: 'assets/images/camera.png',
    color: Color(0xFF80CBC4),
    soundAsset: 'sounds/camera.mp3',
  ),
  ThemeItem(
    name: 'Guitare',
    imageAsset: 'assets/images/guitare.png',
    color: Color(0xFFFFCC80),
    soundAsset: 'sounds/guitare.mp3',
  ),
  ThemeItem(
    name: 'Tambour',
    imageAsset: 'assets/images/tambour.png',
    color: Color(0xFFE6EE9C),
    soundAsset: 'sounds/tambour.mp3',
  ),
  ThemeItem(
    name: 'Cadeau',
    imageAsset: 'assets/images/cadeau.png',
    color: Color(0xFFF48FB1),
    soundAsset: 'sounds/cadeau.mp3',
  ),
  ThemeItem(
    name: 'Vélo',
    imageAsset: 'assets/images/velo.png',
    color: Color(0xFFA5D6A7),
    soundAsset: 'sounds/velo.mp3',
  ),
  ThemeItem(
    name: 'Bateau',
    imageAsset: 'assets/images/bateau.png',
    color: Color(0xFF81D4FA),
    soundAsset: 'sounds/bateau.mp3',
  ),
  ThemeItem(
    name: 'Clé',
    imageAsset: 'assets/images/cle.png',
    color: Color(0xFFFFE082),
    soundAsset: 'sounds/cle.mp3',
  ),
  ThemeItem(
    name: 'Ciseaux',
    imageAsset: 'assets/images/ciseaux.png',
    color: Color(0xFFB0BEC5),
    soundAsset: 'sounds/ciseaux.mp3',
  ),
  ThemeItem(
    name: 'Ampoule',
    imageAsset: 'assets/images/ampoule.png',
    color: Color(0xFFFFF59D),
    soundAsset: 'sounds/ampoule.mp3',
  ),
  ThemeItem(
    name: 'Loupe',
    imageAsset: 'assets/images/loupe.png',
    color: Color(0xFFCE93D8),
    soundAsset: 'sounds/loupe.mp3',
  ),
  ThemeItem(
    name: 'Ampoule',
    imageAsset: 'assets/images/ampoule.png',
    color: Color(0xFFFFCCBC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Carte',
    imageAsset: 'assets/images/carte.png',
    color: Color(0xFFB3E5FC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Valise',
    imageAsset: 'assets/images/valise.png',
    color: Color(0xFFC8E6C9),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Ticket',
    imageAsset: 'assets/images/ticket.png',
    color: Color(0xFFFFF9C4),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Ciseaux',
    imageAsset: 'assets/images/ciseaux.png',
    color: Color(0xFFD1C4E9),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Clé',
    imageAsset: 'assets/images/cle.png',
    color: Color(0xFFFFE0B2),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Loupe',
    imageAsset: 'assets/images/loupe.png',
    color: Color(0xFFFFCCBC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Téléphone',
    imageAsset: 'assets/images/telephone.png',
    color: Color(0xFFB3E5FC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Ordinateur',
    imageAsset: 'assets/images/ordinateur.png',
    color: Color(0xFFC8E6C9),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Caméra',
    imageAsset: 'assets/images/camera.png',
    color: Color(0xFFFFF9C4),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Guitare',
    imageAsset: 'assets/images/guitare.png',
    color: Color(0xFFD1C4E9),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Tambour',
    imageAsset: 'assets/images/tambour.png',
    color: Color(0xFFFFE0B2),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Cadeau',
    imageAsset: 'assets/images/cadeau.png',
    color: Color(0xFFFFCCBC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Ballon',
    imageAsset: 'assets/images/ballon.png',
    color: Color(0xFFB3E5FC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Livre',
    imageAsset: 'assets/images/livre.png',
    color: Color(0xFFC8E6C9),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Réveil',
    imageAsset: 'assets/images/reveil.png',
    color: Color(0xFFFFF9C4),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Nounours',
    imageAsset: 'assets/images/nounours.png',
    color: Color(0xFFD1C4E9),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Puzzle',
    imageAsset: 'assets/images/puzzle.png',
    color: Color(0xFFFFE0B2),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Patins',
    imageAsset: 'assets/images/patins.png',
    color: Color(0xFFFFCCBC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Skateboard',
    imageAsset: 'assets/images/skateboard.png',
    color: Color(0xFFB3E5FC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Trottinette',
    imageAsset: 'assets/images/trottinette.png',
    color: Color(0xFFC8E6C9),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Vélo',
    imageAsset: 'assets/images/velo.png',
    color: Color(0xFFFFF9C4),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Voiture',
    imageAsset: 'assets/images/voiture.png',
    color: Color(0xFFD1C4E9),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Taxi',
    imageAsset: 'assets/images/taxi.png',
    color: Color(0xFFFFE0B2),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Bus',
    imageAsset: 'assets/images/bus.png',
    color: Color(0xFFFFCCBC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Minibus',
    imageAsset: 'assets/images/minibus.png',
    color: Color(0xFFB3E5FC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Camion',
    imageAsset: 'assets/images/camion.png',
    color: Color(0xFFC8E6C9),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Camion de pompier',
    imageAsset: 'assets/images/camion_pompier.png',
    color: Color(0xFFFFF9C4),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Ambulance',
    imageAsset: 'assets/images/ambulance.png',
    color: Color(0xFFD1C4E9),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Avion',
    imageAsset: 'assets/images/avion.png',
    color: Color(0xFFFFE0B2),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Petit avion',
    imageAsset: 'assets/images/petit_avion.png',
    color: Color(0xFFFFCCBC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Hélicoptère',
    imageAsset: 'assets/images/helicoptere.png',
    color: Color(0xFFB3E5FC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Fusée',
    imageAsset: 'assets/images/fusee.png',
    color: Color(0xFFC8E6C9),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Bateau',
    imageAsset: 'assets/images/bateau.png',
    color: Color(0xFFFFF9C4),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Voilier',
    imageAsset: 'assets/images/voilier.png',
    color: Color(0xFFD1C4E9),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Canoë',
    imageAsset: 'assets/images/canoe.png',
    color: Color(0xFFFFE0B2),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Ferry',
    imageAsset: 'assets/images/ferry.png',
    color: Color(0xFFFFCCBC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Train',
    imageAsset: 'assets/images/train.png',
    color: Color(0xFFB3E5FC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Train rapide',
    imageAsset: 'assets/images/train_rapide.png',
    color: Color(0xFFC8E6C9),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Tram',
    imageAsset: 'assets/images/tram.png',
    color: Color(0xFFFFF9C4),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Métro',
    imageAsset: 'assets/images/metro.png',
    color: Color(0xFFD1C4E9),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Monorail',
    imageAsset: 'assets/images/monorail.png',
    color: Color(0xFFFFE0B2),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Téléphérique',
    imageAsset: 'assets/images/telepherique.png',
    color: Color(0xFFFFCCBC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Funiculaire',
    imageAsset: 'assets/images/funiculaire.png',
    color: Color(0xFFB3E5FC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Trolleybus',
    imageAsset: 'assets/images/trolleybus.png',
    color: Color(0xFFC8E6C9),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Station essence',
    imageAsset: 'assets/images/station_essence.png',
    color: Color(0xFFFFF9C4),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Panneau stop',
    imageAsset: 'assets/images/panneau_stop.png',
    color: Color(0xFFD1C4E9),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Feu horizontal',
    imageAsset: 'assets/images/feu_horizontal.png',
    color: Color(0xFFFFE0B2),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Feu vertical',
    imageAsset: 'assets/images/feu_vertical.png',
    color: Color(0xFFFFCCBC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
  ThemeItem(
    name: 'Gyrophare',
    imageAsset: 'assets/images/gyrophares.png',
    color: Color(0xFFB3E5FC),
    soundAsset: _genericSuccessJingle,
    hasDedicatedSound: false,
  ),
];

class AccueilAnimauxPage extends StatefulWidget {
  const AccueilAnimauxPage({super.key});

  @override
  State<AccueilAnimauxPage> createState() => _AccueilAnimauxPageState();
}

class _AccueilAnimauxPageState extends State<AccueilAnimauxPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final Random _random = Random();
  EveilTheme _selectedTheme = EveilTheme.animaux;
  PlayMode _playMode = PlayMode.libre;
  DifficultyLevel _difficulty = DifficultyLevel.moyen;
  ThemeItem? _quizAnswer;
  List<ThemeItem> _quizChoices = [];
  String _feedback = '';
  int _quizScore = 0;
  int _quizCorrectAnswers = 0;
  int _quizQuestionsAnswered = 0;

  List<ThemeItem> get _allItems {
    switch (_selectedTheme) {
      case EveilTheme.animaux:
        return _animals;
      case EveilTheme.flore:
        return _flora;
      case EveilTheme.objets:
        return _objects;
      case EveilTheme.nourriture:
        return _foods;
      case EveilTheme.transports:
        return _transports;
    }
  }

  List<ThemeItem> get _items {
    final all = _allItems;
    final limit = switch (_difficulty) {
      DifficultyLevel.petit => 8,
      DifficultyLevel.moyen => 16,
      DifficultyLevel.complet => all.length,
    };
    return all.take(limit).toList();
  }

  String get _themeLabel {
    switch (_selectedTheme) {
      case EveilTheme.animaux:
        return 'Animaux';
      case EveilTheme.flore:
        return 'Flore';
      case EveilTheme.objets:
        return 'Objets';
      case EveilTheme.nourriture:
        return 'Nourriture';
      case EveilTheme.transports:
        return 'Transports';
    }
  }

  @override
  void initState() {
    super.initState();
    _prepareQuizQuestion();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSound(String assetPath) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(assetPath));
  }

  Future<void> _playRemoteFrenchTts(String text) async {
    final encoded = Uri.encodeComponent(text);
    final url =
        'https://translate.google.com/translate_tts?ie=UTF-8&q=$encoded&tl=fr&client=tw-ob';
    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(url));
  }

  Future<void> _playItemSound(
    ThemeItem item, {
    required bool correctFeedback,
  }) async {
    if (!correctFeedback) {
      await _playSound(_genericErrorJingle);
      return;
    }

    if (item.name == 'Décollage' || item.name == 'Atterrissage') {
      // Always pronounce the displayed word for these labels.
      await _playRemoteFrenchTts(item.name);
      return;
    }

    if (item.name == 'Oiseau') {
      try {
        await _playSound('sounds/oiseau_gazouillis.wav');
      } catch (_) {
        await _playSound('sounds/oiseau.mp3');
      }
      return;
    }

    if (item.hasDedicatedSound) {
      await _playSound(item.soundAsset);
      return;
    }

    final derivedVoiceAsset = _deriveVoiceAssetFromImage(item.imageAsset);
    if (derivedVoiceAsset != null) {
      try {
        await _playSound(derivedVoiceAsset);
        return;
      } catch (_) {
        // Fallback if a matching voice file is missing.
      }
    }

    await _playSound(_genericSuccessJingle);
  }

  String? _deriveVoiceAssetFromImage(String imageAsset) {
    final fileName = imageAsset.split('/').last;
    final dotIndex = fileName.lastIndexOf('.');
    if (dotIndex <= 0) return null;
    final baseName = fileName.substring(0, dotIndex);
    return 'sounds/$baseName.mp3';
  }

  void _resetQuizScore() {
    _quizScore = 0;
    _quizCorrectAnswers = 0;
    _quizQuestionsAnswered = 0;
    _feedback = '';
  }

  void _prepareQuizQuestion() {
    final pool = List<ThemeItem>.from(_items);
    if (pool.length < 4) {
      _quizAnswer = null;
      _quizChoices = [];
      return;
    }

    pool.shuffle(_random);
    final answer = pool.first;
    final distractors = pool.skip(1).take(3).toList();
    final choices = [answer, ...distractors]..shuffle(_random);

    _quizAnswer = answer;
    _quizChoices = choices;
    _feedback = '';
  }

  Future<void> _onQuizChoiceTap(ThemeItem selected) async {
    if (_quizAnswer == null) return;

    if (selected == _quizAnswer) {
      setState(() {
        _feedback = 'Bravo !';
        _quizCorrectAnswers++;
        _quizQuestionsAnswered++;
        _quizScore += 10;
      });
      await _playItemSound(selected, correctFeedback: true);
      await Future<void>.delayed(const Duration(milliseconds: 450));
      if (!mounted) return;
      setState(_prepareQuizQuestion);
      return;
    }

    setState(() {
      _feedback = 'Essaie encore';
      _quizScore = max(0, _quizScore - 2);
    });
    await _playItemSound(selected, correctFeedback: false);
  }

  int _crossAxisCount(double width) {
    if (width >= 1200) return 4;
    if (width >= 800) return 3;
    return 2;
  }

  double _horizontalPadding(double width) {
    if (width >= 1200) return 48;
    if (width >= 800) return 32;
    return 16;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final isTablet = width >= 800;
            final columns = _crossAxisCount(width);
            final spacing = isTablet ? 22.0 : 14.0;
            final titleSize = isTablet ? 46.0 : 34.0;
            final horizontalPadding = _horizontalPadding(width);

            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(horizontalPadding, 18, horizontalPadding, 0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Text(
                          'Choisis un thème',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: titleSize,
                            color: const Color(0xFF303030),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _themeLabel,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF5E5E5E),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10,
                          runSpacing: 10,
                          children: PlayMode.values
                              .map(
                                (mode) => ChoiceChip(
                                  label: Text(
                                    switch (mode) {
                                      PlayMode.libre => 'Mode libre',
                                      PlayMode.quiz => 'Quiz',
                                    },
                                  ),
                                  selected: _playMode == mode,
                                  labelStyle: TextStyle(
                                    fontSize: isTablet ? 18 : 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  selectedColor: const Color(0xFFC8E6C9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  onSelected: (_) {
                                    setState(() {
                                      _playMode = mode;
                                      if (mode == PlayMode.quiz) {
                                        _resetQuizScore();
                                      }
                                      _prepareQuizQuestion();
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10,
                          runSpacing: 10,
                          children: DifficultyLevel.values
                              .map(
                                (level) => ChoiceChip(
                                  label: Text(
                                    switch (level) {
                                      DifficultyLevel.petit => 'Petit',
                                      DifficultyLevel.moyen => 'Moyen',
                                      DifficultyLevel.complet => 'Complet',
                                    },
                                  ),
                                  selected: _difficulty == level,
                                  labelStyle: TextStyle(
                                    fontSize: isTablet ? 18 : 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  selectedColor: const Color(0xFFB3E5FC),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  onSelected: (_) {
                                    setState(() {
                                      _difficulty = level;
                                      if (_playMode == PlayMode.quiz) {
                                        _resetQuizScore();
                                      }
                                      _prepareQuizQuestion();
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10,
                          runSpacing: 10,
                          children: EveilTheme.values
                              .map(
                                (theme) => ChoiceChip(
                                  label: Text(
                                    switch (theme) {
                                      EveilTheme.animaux => 'Animaux',
                                      EveilTheme.flore => 'Flore',
                                      EveilTheme.objets => 'Objets',
                                      EveilTheme.nourriture => 'Nourriture',
                                      EveilTheme.transports => 'Transports',
                                    },
                                  ),
                                  selected: _selectedTheme == theme,
                                  labelStyle: TextStyle(
                                    fontSize: isTablet ? 20 : 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  selectedColor: const Color(0xFFFFE0B2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  onSelected: (_) {
                                    setState(() {
                                      _selectedTheme = theme;
                                      if (_playMode == PlayMode.quiz) {
                                        _resetQuizScore();
                                      }
                                      _prepareQuizQuestion();
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                        if (_playMode == PlayMode.quiz && _quizAnswer != null) ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3E0),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              runSpacing: 6,
                              children: [
                                Text(
                                  'Score: $_quizScore',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF4E342E),
                                  ),
                                ),
                                Text(
                                  'Bonnes: $_quizCorrectAnswers',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2E7D32),
                                  ),
                                ),
                                Text(
                                  'Questions: $_quizQuestionsAnswered',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF37474F),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Où est ${_quizAnswer!.name} ?',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF2E2E2E),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _feedback,
                            style: TextStyle(
                              fontSize: isTablet ? 22 : 18,
                              fontWeight: FontWeight.w700,
                              color: _feedback == 'Bravo !'
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFFE65100),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 18),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = _playMode == PlayMode.quiz
                          ? _quizChoices[index]
                          : _items[index];
                      return ThemeButton(
                        item: item,
                        onTap: _playMode == PlayMode.quiz
                            ? () => _onQuizChoiceTap(item)
                            : () => _playItemSound(
                                  item,
                                  correctFeedback: true,
                                ),
                        isTablet: isTablet,
                      );
                    }, childCount: _playMode == PlayMode.quiz ? _quizChoices.length : _items.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      childAspectRatio: isTablet ? 1.02 : 0.95,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ThemeButton extends StatefulWidget {
  const ThemeButton({
    super.key,
    required this.item,
    required this.onTap,
    required this.isTablet,
  });

  final ThemeItem item;
  final VoidCallback onTap;
  final bool isTablet;

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1.16).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    widget.onTap();
    await _controller.forward();
    await _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final shortest = constraints.biggest.shortestSide;
        final basePadding = widget.isTablet ? 22.0 : 16.0;
        final padding = (shortest * 0.09).clamp(10.0, basePadding);
        final imageSize = (shortest * 0.46).clamp(58.0, widget.isTablet ? 112.0 : 86.0);
        final fontSize = (shortest * 0.13).clamp(16.0, widget.isTablet ? 28.0 : 22.0);
        final gap = (shortest * 0.06).clamp(6.0, widget.isTablet ? 16.0 : 12.0);

        return Material(
          color: widget.item.color,
          borderRadius: BorderRadius.circular(34),
          child: InkWell(
            borderRadius: BorderRadius.circular(34),
            onTap: _handleTap,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Image.asset(
                      widget.item.imageAsset,
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: gap),
                  Text(
                    widget.item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
