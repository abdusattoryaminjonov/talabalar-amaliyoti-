// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Практика NPUU';

  @override
  String get login => 'Войти';

  @override
  String get logout => 'Выйти';

  @override
  String get enter => 'NPUU\nInternship';

  @override
  String get loginInput => 'Введите логин';

  @override
  String get password => 'Пароль';

  @override
  String get passInput => 'Введите пароль';

  @override
  String get forgotPass => 'Забыли пароль?';

  @override
  String get empty => 'Поле ввода пустое';

  @override
  String get incorrect => 'Неверное имя пользователя или пароль.';

  @override
  String get serverError => 'Ошибка сервера.';

  @override
  String get errorPlease => 'Ошибка, пожалуйста, попробуйте позже.';

  @override
  String get notStudent => 'Вы не СТУДЕНТ.';

  @override
  String get dataIsOutdated =>
      'Пользовательские данные устарели. Пожалуйста, войдите в систему снова.';

  @override
  String get unknownError => 'Неизвестная ошибка';

  @override
  String get connectionTimeout => 'Не удалось подключиться к Интернету';

  @override
  String get logsAndMap => 'Попытки';

  @override
  String get nowInter => 'Текущий интервал';

  @override
  String get notChoseInter => 'Интервал не выбран!';

  @override
  String get interList => 'Список интервалов';

  @override
  String get interCheckIn => 'Выбрано';

  @override
  String get logOutTitle => 'Выход';

  @override
  String get logOutContent => 'Вы уверены, что хотите выйти?';

  @override
  String get noText => 'Нет';

  @override
  String get yesText => 'Да';

  @override
  String get notEnterTxt => 'НЕ ВВЕДЕНО';

  @override
  String get toComeText => 'ПРИХОДИТ';

  @override
  String get toGoText => 'ИДЕТ';

  @override
  String get taskText => 'задача';

  @override
  String get view => 'Просмотр';

  @override
  String get semesterKText => 'Осенний семестр';

  @override
  String get semesterBText => 'Весенний семестр';

  @override
  String get lostTimeText => 'Потерянные часы';

  @override
  String get moreText => 'Подробнее';

  @override
  String get tasksScoreText => 'Оценка задания';

  @override
  String get tasksText => 'Задания';

  @override
  String get attendancesCalender => 'Календарь посещаемости';

  @override
  String get choseDay => 'Выберите день';

  @override
  String get locationMessage => 'Разрешение GPS навсегда отклонено!';

  @override
  String get notData => 'Нет данных за этот день';

  @override
  String get lieLocation => 'Обнаружено ложное местоположение!';

  @override
  String get goOutAtt => 'Отсутствие прибывающих';

  @override
  String get toGoAtt => 'Отсутствие прибывающих';

  @override
  String get toComeAtt => 'Отсутствие прибывающих';

  @override
  String get logsEmpty => 'Нет записей в журнале за этот день';

  @override
  String get copyText => 'Скопировано';

  @override
  String get settings => 'Настройки';

  @override
  String get passSuccess => 'Пароль успешно обновлен';

  @override
  String get passError => 'Произошла ошибка';

  @override
  String get passConnection => 'Сетевая ошибка';

  @override
  String get passOld => 'Старый пароль';

  @override
  String get passEnterOld => 'Введите старый пароль';

  @override
  String get passNew => 'Новый пароль';

  @override
  String get passEnterNew => 'Пароль должен содержать не менее 6 символов';

  @override
  String get passCheck => 'Подтвердите новый пароль';

  @override
  String get passNotTrue => 'Пароли не совпадают';

  @override
  String get passOk => 'Обновить пароль';

  @override
  String get score => 'Рейтинг';

  @override
  String get scoreGroup => 'Группа';

  @override
  String get scoreType => 'Специализация';

  @override
  String get sortScore => 'Сортировать по оценке';

  @override
  String get sortLostTime => 'Сортировать по оставшемуся времени';

  @override
  String get attendance => 'Посещаемость';

  @override
  String get scoreA => 'Оценка';

  @override
  String get comIn => 'Входящее сообщение';

  @override
  String get comOut => 'Исходящее сообщение';

  @override
  String get optionalMessage => 'Написать сообщение (необязательно)...';

  @override
  String get cancelText => 'Отмена';

  @override
  String get submitText => 'Отправить';

  @override
  String get submitMainIdeTxt =>
      'При нажатии кнопки \"ОТПРАВИТЬ\" будет отправлена информация о прибытии/отбытии из места прохождения стажировки.';

  @override
  String get notWorking =>
      'Эта функция не работает. Она находится в процессе создания';
}
