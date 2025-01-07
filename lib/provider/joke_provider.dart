import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoritesProvider with ChangeNotifier {
  final List<String> _favoriteJokes = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final String _userId;

  List<String> get favoriteJokes => _favoriteJokes;

  FavoritesProvider() {
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        final userCredential = await FirebaseAuth.instance.signInAnonymously();
        _userId = userCredential.user!.uid;
      } else {
        _userId = user.uid;
      }
      await _loadFavorites();
    } catch (e) {
      print("Error initializing user: $e");
    }
  }

  Future<void> _loadFavorites() async {
    try {
      final snapshot = await _firestore.collection('favorites').doc(_userId).get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        _favoriteJokes.addAll(List<String>.from(data['jokes'] ?? []));
        notifyListeners();
      }
    } catch (e) {
      print("Error loading favorites: $e");
    }
  }

  void toggleFavorite(String joke) async {
    if (_favoriteJokes.contains(joke)) {
      _favoriteJokes.remove(joke);
    } else {
      _favoriteJokes.add(joke);
    }

    try {
      await _firestore.collection('favorites').doc(_userId).set({
        'jokes': _favoriteJokes,
      });
    } catch (e) {
      print("Error updating favorites: $e");
    }

    notifyListeners();
  }

  bool isFavorite(String joke) {
    return _favoriteJokes.contains(joke);
  }
}
