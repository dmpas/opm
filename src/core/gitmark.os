// Ожидает контекст:
//   * КаталогРепозитория
//   * Описание

// TODO: Перенести в СборщикПакета

#Использовать gitrunner

Перем Гит, Параметры, Адрес, Коммит;

Гит = Новый ГитРепозиторий;
Гит.УстановитьРабочийКаталог(КаталогРепозитория);
ТаблицаВнешнихРепозиториев = Гит.ПолучитьСписокВнешнихРепозиториев();
ЧтоИщем = Новый Структура("Имя, Режим", "origin", "fetch");
НужныеСсылки = ТаблицаВнешнихРепозиториев.НайтиСтроки(ЧтоИщем);

Если НужныеСсылки.Количество() = 0 Тогда
	ВызватьИсключение "У репозитория нет ссылки на origin";
КонецЕсли;

Адрес = НужныеСсылки.Получить(0).Адрес;

// TODO: перенести это в gitrunner
Параметры = Новый Массив;
Параметры.Добавить("log");
Параметры.Добавить("-1");
Параметры.Добавить("--format='%H'");

Гит.ВыполнитьКоманду(Параметры);

Коммит = Гит.ПолучитьВыводКоманды();
Если Лев(Коммит, 1) = "'" Тогда
	
	// windows выводит 'sha', ubuntu просто sha, ибо bash отсеивает кавычки
	Коммит = Сред(Коммит, 2, СтрДлина(Коммит) - 2);

КонецЕсли;

Описание.ОтметкаГит(Адрес, Коммит);