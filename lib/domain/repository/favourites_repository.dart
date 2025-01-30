
abstract class FavouritesRepository {

  Stream<List<int>> getFavourites(String uid);

  Future<void> setFavourites(String uid, List<int> favouriteFruits);
}
