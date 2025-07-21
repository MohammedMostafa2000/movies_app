import 'package:flutter/foundation.dart';
import 'package:movies_app/authentication/data/models/user_data_model.dart';
import 'package:movies_app/mainLayout/data/api_services.dart';
import 'package:movies_app/mainLayout/data/models/movie_data_model.dart';

class ProfileViewModel extends ChangeNotifier {
  UserDataModel? user;
  bool isLoading = true;
  bool isFavoritesLoading = true;
  List<MovieDataModel> favoritesList = [];

  Future<void> getProfileDetails({required String token}) async {
    isLoading = true;
    final response = await ApiServices.getProfileDetails(token: token);
    user = response.data;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getFavoritesList({required String token}) async {
    isFavoritesLoading = true;
    final response = await ApiServices.getAllFavoriteMovies(token: token);
    favoritesList = response.data;
    isFavoritesLoading = false;
    notifyListeners();
  }
}
