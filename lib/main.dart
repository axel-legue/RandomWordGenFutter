// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}

/// Add a Stateful widget
/// Stateless widgets are immutable,
/// cela veut dire que leur propriétés ne peuvent pas changer
/// - toutes ses valuers sont finale.
///
/// Stateful widget maintienne l'état qui peut changer durant le cycle de vie du widget.
/// Pour implémenter un statefull widget cela recquiert deux classes au minimum:
///     classe 1 : la classe "StatefulWidget" qui créée une instance
///     classe 2 : la classe "State".
/// La classe "StatefulWidget" en elle même est immutable,
/// mais la classe "State" crée persiste au cours du temps de vie du widget.
///

/// /*1*/ le callback ItemBuilder est appelé une fois par association de mots suggérée et place
/// chaque suggestion dans une ligne de ListTile.
/// Pour les lignes paires, la fonction ajoute une ligne ListeTile pour l'appariement des mots.
/// Pour les lignes impairs, la fonction ajute un widget Divider pour séparer visuelement les entrées.
/// Notez que le séparateur peut-être difficile à voir sur les petits appareils
///
/// /*2*/ Ajoute un widget de séparation d'un pixel de haut avant chaque  ligne dans ListView
///
/// /*3*/ L'expression i ~ / 2 divise i par 2 et renvoie un résultat entier.
/// Par exemple: 1, 2, 3, 4, 5 devient 0, 1, 1, 2, 2.
/// Ceci calcule le nombre réel de paires de mots dans ListView, moins les widgets de séparation.
///
/// /*4*/ Si vous avez atteint la fin des paires de mots disponibles,
/// générez-en 10 de plus et ajoutez-les à la liste de suggestions.
//  This indicates that we’re using the generic [State][] class specialized for use with RandomWords.
//  Most of the app’s logic and state resides here—it maintains the state for the RandomWords widget
class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final _suggestions = <WordPair>[]; //Liste de WordPair
    final _biggerFont = const TextStyle(fontSize: 18.0);

    // Function build Row
    Widget _buildRow(WordPair pair) {
      return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
      );
    }

    // Function build Suggestions name
    Widget _buildSuggestions() {
      return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: /*1*/ (context, i) {
            if (i.isOdd) return Divider(); /*2*/

            final index = i ~/ 2; /*3*/
            if (index >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10)); /*4*/
            }
            return _buildRow(_suggestions[index]);
          });
    }

    return Scaffold(
      appBar: AppBar(title: Text("Startup Name Generator")),
      body: _buildSuggestions(),
    );
  }
}

// The RandomWords widget does little else beside creating its State class
class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RandomWordsState();
}
