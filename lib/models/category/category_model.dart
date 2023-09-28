
enum CategoryType{
  income,
  expense
}

class CategoryModel
{
  final String name;
  final bool isDeleted;
  final CategoryType type;

  CategoryModel( this.name, this.isDeleted, this.type);
}