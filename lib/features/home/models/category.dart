class Category {
  final String title;
  final String routeName;

  Category({
    required this.title,
    required this.routeName,
  });
}

List<Category> categories = [
  Category(title: 'إعلانات الكلية', routeName: '/ads-screen'),
  Category(title: 'دليل الطالب', routeName: '/student-guid'),
  Category(title: 'مدفوعات', routeName: '/payments-screen'),
  Category(title: 'التسجيل على السنة الجديدة', routeName: '/congrats-screen'),
];
