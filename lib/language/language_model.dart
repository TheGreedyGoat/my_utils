// ignore_for_file: public_member_api_docs

import 'package:my_utils/utility/enums/months.dart';
import 'package:my_utils/utility/enums/weekdays.dart';
part 'german.dart';

/// Language pack
///
/// variable names should either be the exact english phrase (for single words/ short phrases)
///
/// or describe the content distinctively
///
/// This is supposed to be a base language pack model. that can be used in any app. To extend it, create a class inheriting from this, giving it a constructor that takes
/// an instance of this class aswell as all your app's specific translations
///
/// example:
/// ```dart
///
/// class TodoAppLanguage extends Language {
///   final String todo;
///   final String done;
///   TodoAppLanguage({
///     required Language base,
///     required this.todo,
///     required this.isCompleted,
///   }) : super.from(base);
/// }
///
/// ...
///
/// final todoGerman = TodoAppLanguage(
///   base: german,
///   todo: 'zu tun',
///   done: 'getan'
///   );
/// ```
///
class Language {
  /// Language pack
  ///
  /// variable names should either be the exact english phrase (for single words/ short phrases)
  ///
  /// or describe the content distinctively
  const Language({
    required this.mr,
    required this.mrs,
    required this.generate,
    required this.salutation,
    required this.title,
    required this.prename,
    required this.surname,
    required this.street,
    required this.houseNumber,
    required this.addressAddition,
    required this.postcode,
    required this.city,
    required this.state,
    required this.country,
    required this.email,
    required this.phone,
    required this.mobile,
    required this.fax,
    required this.website,
    required this.save,
    required this.discard,
    required this.edit,
    required this.delete,
    required this.saveSuccessful,
    required this.errorOccured,
    required this.cancel,
    required this.confirm,
    required this.monthNames,
    required this.day,
    required this.daysPlural,
    required this.week,
    required this.weeksPlural,
    required this.month,
    required this.monthsPlural,
    required this.isRequired,
    required this.weekdayNames,
  });

  Language.from(Language lang)
    : this(
        mr: lang.mr,
        mrs: lang.mrs,
        generate: lang.generate,
        salutation: lang.salutation,
        title: lang.title,
        prename: lang.prename,
        surname: lang.surname,
        street: lang.street,
        houseNumber: lang.houseNumber,
        addressAddition: lang.addressAddition,
        postcode: lang.postcode,
        city: lang.city,
        state: lang.state,
        country: lang.country,
        email: lang.email,
        phone: lang.phone,
        mobile: lang.mobile,
        fax: lang.fax,
        website: lang.website,
        save: lang.save,
        discard: lang.discard,
        edit: lang.edit,
        delete: lang.delete,
        saveSuccessful: lang.saveSuccessful,
        errorOccured: lang.errorOccured,
        cancel: lang.cancel,
        confirm: lang.confirm,
        monthNames: Map.from(lang.monthNames),
        day: lang.day,
        daysPlural: lang.daysPlural,
        week: lang.week,
        weeksPlural: lang.weeksPlural,
        month: lang.month,
        monthsPlural: lang.monthsPlural,
        isRequired: lang.isRequired,
        weekdayNames: lang.weekdayNames,
      );

  // final String assignedTags;
  final String cancel, confirm;
  // final String company;
  // final String companyAddition;
  // final String customerID;
  // final Map<DataError, String> dataErrorMessages;
  final String edit;
  final String delete;
  final String discard;
  final String generate;

  final String day;
  final String daysPlural;

  final String week;
  final String weeksPlural;

  final String month;
  final String monthsPlural;
  final Map<Month, String> monthNames;
  final Map<Weekday, String> weekdayNames;
  final String mrs;
  final String mr;
  final String prename, surname;

  final String salutation;
  final String street,
      houseNumber,
      addressAddition,
      postcode,
      city,
      state,
      country;

  final String email, phone, mobile, fax, website;
  final String title;

  final String save;
  final String saveSuccessful;
  final String errorOccured;

  final String isRequired;

  // final String vatID;

  // String getDataErrorMsg(DataError error) =>
  // dataErrorMessages[error] ?? 'unassigned error message';
}
