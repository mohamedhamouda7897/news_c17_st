class CategoryModel {
  String label;
  String image;
  String id;

  CategoryModel({required this.id, required this.label, required this.image});

  static List<CategoryModel> getCategoriesList() {
    return [
      CategoryModel(
        id: "general",
        label: "General",
        image: "assets/images/general.png",
      ),
      CategoryModel(
        id: "business",
        label: "Business",
        image: "assets/images/business.png",
      ),
      CategoryModel(
        id: "sports",
        label: "Sports",
        image: "assets/images/sport.png",
      ),
      CategoryModel(
        id: "technology",
        label: "Technology",
        image: "assets/images/technology.png",
      ),
      CategoryModel(
        id: "entertainment",
        label: "Entertainment",
        image: "assets/images/entertainment.png",
      ),

      CategoryModel(
        id: "health",
        label: "Health",
        image: "assets/images/health.png",
      ),
      CategoryModel(
        id: "science",
        label: "Science",
        image: "assets/images/science.png",
      ),
    ];
  }
}
