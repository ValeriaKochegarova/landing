library dart_jsdaddy_school.src.routes.controllers;

import 'dart:async';
import 'package:angel_framework/angel_framework.dart';
import '../../middleware/currency.dart';
import '../../middleware/language_menu.dart';

@Expose("/:lang/courses", middleware: const [addLanguagesMenu, addCurrencyRate])
class CoursesController extends Controller {
  @Expose("/")
  Future getCourses(
      String lang, languages, num rate, ResponseContext res) async {
    var courses_content_array = await app.service('api/courses').index({
      "query": {'lang': lang}
    });

    if (courses_content_array.isEmpty) {
      return res.render('error');
    }

    var courses_content = courses_content_array.first;

    courses_content['languages'] = languages;

    List course_content = await app.service('api/course').index({
      "query": {'lang': lang}
    });
    //TODO try use mongo projection
    courses_content['courses']['courseItems'] = course_content.map((data) {
      num uah = rate * int.parse(data["price"]);
      return {
        'title': data['title'],
        'sub_title': data['sub_title'],
        'logo': data['logo'],
        'price':
            'Стоимость: ${uah.round()}грн (экв. ${int.parse(data["price"])}\$)',
        'start_date': data['start_date'],
        'durations': data['durations'],
        'link_text': data['link_text'],
        'link_href': '/$lang/courses/${data['link_href']}',
      };
    }).toList();

    await res.render('courses_landing', courses_content);
  }

  @Expose("/:id")
  Future getCourse(String lang, languages, int id, ResponseContext res) async {
    var course_content_arr = await app.service('api/course').index({
      "query": {'lang': lang, "link_href": id}
    });

    if (course_content_arr.isEmpty) {
      return res.render('error');
    }
    var course_content = course_content_arr.first;
    course_content['languages'] = languages;

    await res.render('course_landing', course_content);
  }
}
