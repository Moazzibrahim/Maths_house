class Categouries {
  final String catName;
  final String catUrl;
  final int catInt;
  final List<CoursesCategories> coursesCategories;

  Categouries({
    required this.catName,
    required this.catUrl,
    required this.catInt,
    required this.coursesCategories,
  });

  factory Categouries.fromJson(Map<String, dynamic> json) {
    List<CoursesCategories> coursesCategoriesList = [];
    for (var e in json['courses']) {
      coursesCategoriesList.add(CoursesCategories.fromJson(e));
    }
    return Categouries(
      catName: json['cate_name']??'no cat',
      catUrl: json['cate_url']??'no url',
      catInt: json['id']??0,
      coursesCategories: coursesCategoriesList,
    );
  }
}

class CoursesCategories {
  final String courseName;
  final String courseUrl;
  final String type;
  final int id;
  final List<CoursePrices> coursePrices;
  final List<ChapterWithPrice> chapterWithPrice;

  CoursesCategories({
    required this.courseName,
    required this.courseUrl,
    required this.type,
    required this.id,
    required this.coursePrices,
    required this.chapterWithPrice,
  });

  factory CoursesCategories.fromJson(Map<String, dynamic> json) {
    List<CoursePrices> coursesPricesList = [];
    List<ChapterWithPrice> chapterWithPriceList = [];
    for (var e in json['prices']) {
      coursesPricesList.add(CoursePrices.fromJson(e));
    }
    for (var e in json['chapter_with_price']) {
      chapterWithPriceList.add(ChapterWithPrice.fromJson(e));
    }
    return CoursesCategories(
      courseName: json['course_name']??'no course',
      courseUrl: json['course_url']??'no url',
      type: json['type']??'no type',
      id: json['id']??0,
      coursePrices: coursesPricesList,
      chapterWithPrice: chapterWithPriceList,
    );
  }
}

class CoursePrices {
  final int duration;
  final dynamic price;

  CoursePrices({
    required this.duration,
    required this.price,
  });

  factory CoursePrices.fromJson(Map<String, dynamic> json) => CoursePrices(
        duration: json['duration']??0,
        price: json['price']??0,
      );
}

class ChapterWithPrice {
  final String chapterName;
  final String chapterUrl;
  final String type;
  final int id;
  final List<ChapterPrices> chapterPrices;

  ChapterWithPrice({
    required this.chapterName,
    required this.chapterUrl,
    required this.type,
    required this.id,
    required this.chapterPrices,
  });

  factory ChapterWithPrice.fromJson(Map<String, dynamic> json) {
    List<ChapterPrices> chapterPricesList = [];
    for (var e in json['price']) {
      chapterPricesList.add(ChapterPrices.fromJson(e));
    }
    return ChapterWithPrice(
      chapterName: json['chapter_name']??'no chapter',
      chapterUrl: json['ch_url']??'no url',
      type: json['type']??'no type',
      id: json['id']??0,
      chapterPrices: chapterPricesList,
    );
  }
}

class ChapterPrices {
  final int duration;
  final dynamic price;

  ChapterPrices({required this.duration, required this.price});

  factory ChapterPrices.fromJson(Map<String, dynamic> json) => ChapterPrices(
        duration: json['duration']??'no duration',
        price: json['price']??0,
      );
}

class CategouriesList {
  final List<dynamic> categouriesList;

  CategouriesList({required this.categouriesList});

  factory CategouriesList.fromJson(Map<String, dynamic> json) =>
      CategouriesList(
        categouriesList: json['category'],
      );
}
