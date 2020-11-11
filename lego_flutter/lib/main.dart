import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

// It maintains the state for the RandomWords widget.
// This class saves the generated word pairs.
class RandomWordsState extends State<RandomWords> {
  static const navitatorMethodChannel = const MethodChannel('flutter.channel.nav');

  // Prefixing an identifier with an underscore enforces privacy in the Dart language.
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    // Scaffold implements the basic Material Design visual layout.
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        // Some widget properties take a single widget (child), and other properties, such as action, take an array of widgets (children), as indicated by the square brackets ([]).
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.close),
              onPressed: _pop
            );
          },
        ),

      ),
      body: _buildSuggestions(),
    );
  }

  Future<void> _pop() async {
    // iOS platform ignored.
    // await SystemNavigator.pop();
    await navitatorMethodChannel.invokeMethod('dismiss');
  }

  // In Flutter, the Navigator manages a stack containing the app's routes. 
  void _pushSaved() {
    // This action changes the screen to display the new route. The content for the new page is built in MaterialPageRoute's builder property, in an anonymous function.
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
            .divideTiles(
              context: context,
              tiles: tiles,
            ).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }


  // This method builds the ListView that displays the suggested word pairing.
  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // Two parameters are passed to the function—the BuildContext, and the row iterator, i. 
      // The iterator begins at 0 and increments each time the function is called.
      // It increments twice for every suggested word pairing: once for the ListTile, and once for the Divider.
      itemBuilder: (context, i) { // Anonymous function
        // For odd rows, the function adds a Divider widget to visually separate the entries.
        if (i.isOdd) return Divider(); // Add a one-pixel-high divider widge

        // This calculates the actual number of word pairings in the ListView, minus the divider widgets.
        final index = i ~/ 2; // divides i by 2 and returns an integer result
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
      return ListTile(
        title: Text(
          pair.asPascalCase,
          style: _biggerFont
        ),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          // In Flutter's reactive style framework, calling setState() triggers a call to the build() method for the State object, resulting in an update to the UI.
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        },
      );
  }
}

// Stateless widgets are immutable, meaning that their properties can’t change—all values are final.
// Stateful widgets maintain state that might change during the lifetime of the widget.
class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RandomWordsState();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
      // You can easily change an app's theme by configuring the ThemeData class.
      theme: ThemeData(
        primaryColor: Colors.orange[50],
      ),
    );
  }
}