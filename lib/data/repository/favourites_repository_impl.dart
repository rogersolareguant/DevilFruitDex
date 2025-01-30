import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devilfruitdex/domain/repository/favourites_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavouritesRepositoryImpl extends FavouritesRepository {

  FavouritesRepositoryImpl({required FirebaseAuth firebaseAuth});

  @override
  Stream<List<int>> getFavourites(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snapshot) => List<int>.from(snapshot.data() ? ['favs'] ?? []));
  }

  @override
  Future<void> setFavourites(String uid, List<int> favouriteFruits) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'favs': favouriteFruits});
  }
}
