﻿
#Использовать logos

Перем Лог;
Перем ЭтоWindows;

Процедура ДобавитьОписанияКоманд(Знач Парсер) Экспорт
	ДобавитьКомандуBuild(Парсер);
	ДобавитьКомандуRun(Парсер);
	ДобавитьКомандуTest(Парсер);
	ДобавитьКомандуPrepare(Парсер);
	ДобавитьКомандуInstall(Парсер);
	ДобавитьКомандуUpdate(Парсер);
	ДобавитьКомандуApp(Парсер);
	ДобавитьКомандуConfig(Парсер);
	ДобавитьКомандуHelp(Парсер);
КонецПроцедуры

/////////////////////////////////////////////////////////////////////////
// Описания команд

Процедура ДобавитьКомандуPrepare(Знач Парсер)
	Команда = Парсер.ОписаниеКоманды("prepare", "Подготовить новый каталог разрабатываемого пакета");
	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "КаталогСборкиПакета", "Каталог, в котором будет вестись разработка");
	Парсер.ДобавитьКоманду(Команда);
КонецПроцедуры

Процедура ДобавитьКомандуBuild(Знач Парсер)
	Команда = Парсер.ОписаниеКоманды("build", "Собрать пакет из исходников");
	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "КаталогИсходников", "Каталог исходников");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-mf", "Файл манифеста сборки (packagedef)");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-out", "Выходной каталог");
	Парсер.ДобавитьКоманду(Команда);
КонецПроцедуры

Процедура ДобавитьКомандуRun(Знач Парсер)
	Команда = Парсер.ОписаниеКоманды("run", "Выполнить произвольную задачу");
	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "ИмяЗадачи", "Имя выполняемой задачи.");
	Парсер.ДобавитьПараметрКоллекцияКоманды(Команда, "ПараметрыЗадачи", "Коллекция параметров, передаваемых задаче");
	Парсер.ДобавитьКоманду(Команда);
КонецПроцедуры

Процедура ДобавитьКомандуTest(Знач Парсер)
	Команда = Парсер.ОписаниеКоманды("test", "Выполнить тестирование проекта");
	Парсер.ДобавитьПараметрКоллекцияКоманды(Команда, "ПараметрыЗадачи", "Коллекция параметров, передаваемых задаче тестирования");
	Парсер.ДобавитьКоманду(Команда);
КонецПроцедуры

Процедура ДобавитьКомандуInstall(Знач Парсер)
	Команда = Парсер.ОписаниеКоманды("install", "Выполнить установку. Если указано имя пакета, происходит установка из хаба или из файла. В обратном случае устанавливаются зависимости текущего пакета по файлу packagedef.");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-f", "Указать файл из которого нужно установить пакет");
	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "ИмяПакета", "Имя пакета в хабе");
	Парсер.ДобавитьКоманду(Команда);
КонецПроцедуры

Процедура ДобавитьКомандуUpdate(Знач Парсер)
	Команда = Парсер.ОписаниеКоманды("update", "Обновить пакет");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-f", "Указать файл из которого нужно установить пакет");
	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "ИмяПакета", "Имя пакета в хабе");
	Парсер.ДобавитьКоманду(Команда);
КонецПроцедуры

Процедура ДобавитьКомандуApp(Знач Парсер)
	Команда = Парсер.ОписаниеКоманды("app", "Создать " + ?(ЭтоWindows, "bat", "sh") + "-файл для запуска скрипта в указанном каталоге");
	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "ИмяСкрипта", "Имя скрипта в текущем каталоге или полный путь скрипта");
	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "Каталог", "(необязательно) Каталог, в котором будет создан скрипт запуска. По умолчанию """ + КаталогПрограммы() + """");
	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-name", "Имя генерируемого исполняемого файла");
	Парсер.ДобавитьКоманду(Команда);
КонецПроцедуры

Процедура ДобавитьКомандуConfig(Знач Парсер)
 	Команда = Парсер.ОписаниеКоманды("config", "Задать пользовательские настройки");
 	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "-proxyusedefault","Использовать ПроксиПоУмолчанию (системные настройки)");
 	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-proxyserver", "Адрес прокси");
 	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-proxyport", "Порт прокси");
 	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-proxyuser", "Пользователь прокси ");
 	Парсер.ДобавитьИменованныйПараметрКоманды(Команда, "-proxypass", "Пароль прокси");
 	Парсер.ДобавитьКоманду(Команда);
 КонецПроцедуры


Процедура ДобавитьКомандуHelp(Знач Парсер) Экспорт
	Команда = Парсер.ОписаниеКоманды("help", "Справка по командам");
	Парсер.ДобавитьПозиционныйПараметрКоманды(Команда, "ИмяКоманды", "Имя команды по которой надо получить справку");
	Парсер.ДобавитьКоманду(Команда);
КонецПроцедуры

Процедура ВыполнитьКоманду(Знач ПараметрыКоманды) Экспорт

	ЗначенияПараметров = ПараметрыКоманды.ЗначенияПараметров;
	Если ПараметрыКоманды.Команда = "build" Тогда
		ВыполнитьСборку(ЗначенияПараметров["КаталогИсходников"], ЗначенияПараметров["-mf"], ЗначенияПараметров["-out"]);
	ИначеЕсли ПараметрыКоманды.Команда = "run" Тогда
		ВыполнитьЗадачу(ЗначенияПараметров["ИмяЗадачи"], ЗначенияПараметров["ПараметрыЗадачи"]);
	ИначеЕсли ПараметрыКоманды.Команда = "test" Тогда
		ВыполнитьЗадачу("test", ЗначенияПараметров["ПараметрыЗадачи"]);
	ИначеЕсли ПараметрыКоманды.Команда = "prepare" Тогда
		ПодготовитьКаталогПроекта(ЗначенияПараметров["КаталогСборкиПакета"]);
	ИначеЕсли ПараметрыКоманды.Команда = "install" Тогда
		УстановитьПакет(ЗначенияПараметров);
	ИначеЕсли ПараметрыКоманды.Команда = "update" Тогда
		ОбновитьПакет(ЗначенияПараметров);
	ИначеЕсли ПараметрыКоманды.Команда = "app" Тогда
		СоздатьСкриптЗапуска(ЗначенияПараметров["ИмяСкрипта"], ЗначенияПараметров["Каталог"], ЗначенияПараметров["-name"]);
	ИначеЕсли ПараметрыКоманды.Команда = "config" Тогда
 		НастройкиПриложения.СохранитьНастройки(ЗначенияПараметров);		
	ИначеЕсли ПараметрыКоманды.Команда = "help" Тогда
		ВывестиСправку(ЗначенияПараметров);
	КонецЕсли;

КонецПроцедуры

/////////////////////////////////////////////////////////////////////////
// Реализация команд

Процедура УстановитьПакет(Знач ЗначенияПараметров) Экспорт

	Установщик = Новый УстановкаПакета;
	Если ЗначенияПараметров["-f"] = Неопределено И ЗначенияПараметров["ИмяПакета"] = Неопределено Тогда
		Установщик.УстановитьПакетыПоОписаниюПакета();
	ИначеЕсли ЗначенияПараметров["-f"] <> Неопределено Тогда
		Установщик.УстановитьПакетИзАрхива(ЗначенияПараметров["-f"]);
	Иначе
		Установщик.УстановитьПакетИзОблака(ЗначенияПараметров["ИмяПакета"]);
	КонецЕсли;

КонецПроцедуры

Процедура ВыполнитьСборку(Знач КаталогИсходников, Знач ФайлМанифеста, Знач ВыходнойКаталог) Экспорт

	Сборщик = Новый СборщикПакета();
	Сборщик.СобратьПакет(КаталогИсходников, ФайлМанифеста, ВыходнойКаталог);

КонецПроцедуры

Процедура ПодготовитьКаталогПроекта(Знач ВыходнойКаталог) Экспорт

	Сборщик = Новый СборщикПакета();
	Сборщик.ПодготовитьКаталогПроекта(ВыходнойКаталог);

КонецПроцедуры

Процедура ВыполнитьЗадачу(Знач ИмяЗадачи, Знач ПараметрыЗадачи) 

	Если ПараметрыЗадачи = Неопределено Тогда
		ПараметрыЗадачи = Новый Массив;
	КонецЕсли;

	ПутьККаталогуЗадач = "";

	ПутьКМанифесту = ОбъединитьПути(ТекущийКаталог(), Константы.ИмяФайлаСпецификацииПакета);
	
	Файл_Манифест = Новый Файл(ПутьКМанифесту);
	Если Файл_Манифест.Существует() Тогда
		Описание = Новый ОписаниеПакета();
		Контекст = Новый Структура("Описание", Описание);
		ЗагрузитьСценарий(ПутьКМанифесту, Контекст);
		
		Свойства = Описание.Свойства();
		Если Свойства.Свойство("Задачи") Тогда
			ПутьККаталогуЗадач = Свойства.Задачи;
		КонецЕсли;
	КонецЕсли;

	Если НЕ ЗначениеЗаполнено(ПутьККаталогуЗадач) Тогда
		ПутьККаталогуЗадач = ОбъединитьПути(ТекущийКаталог(), "tasks");
	КонецЕсли;

	КаталогЗадач = Новый Файл(ПутьККаталогуЗадач);
	Если НЕ КаталогЗадач.Существует() Тогда
		ТекстСообщения = СтрШаблон("Не найден каталог задач: %1", КаталогЗадач.ПолноеИмя);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;

	ПутьКЗадаче = ОбъединитьПути(ПутьККаталогуЗадач, ИмяЗадачи + ".os");
	ПараметрыСценария = Новый Структура("ПараметрыЗадачи", ПараметрыЗадачи);
	ЗагрузитьСценарий(ПутьКЗадаче, ПараметрыСценария);

КонецПроцедуры

Процедура ОбновитьПакет(Знач ЗначенияПараметров) Экспорт

	Установщик = Новый УстановкаПакета;
	Если ЗначенияПараметров["-f"] <> Неопределено Тогда
		Установщик.УстановитьПакетИзАрхива(ЗначенияПараметров["-f"]);
	Иначе
		Установщик.ОбновитьПакетИзОблака(ЗначенияПараметров["ИмяПакета"]);
	КонецЕсли;

КонецПроцедуры

Процедура СоздатьСкриптЗапуска(Знач ИмяСкрипта, Знач Каталог, Знач ИмяФайлаЗапуска) Экспорт
	Если ИмяСкрипта = Неопределено Тогда
		ВызватьИсключение "Не указано имя файла скрипта";
	КонецЕсли;

	ФайлСкрипта = Новый Файл(ИмяСкрипта);
	ПолноеИмяСкрипта = ФайлСкрипта.ПолноеИмя;
	Если Не ФайлСкрипта.Существует() Тогда
		ФайлСкрипта = Новый Файл(ИмяСкрипта + ".os");
		Если Не ФайлСкрипта.Существует() Тогда
			ВызватьИсключение "Файл скрипта """ + ПолноеИмяСкрипта + """ не найден";
		Иначе
			ПолноеИмяСкрипта = ФайлСкрипта.ПолноеИмя;
		КонецЕсли;
	КонецЕсли;

	Если Не ФайлСкрипта.ЭтоФайл() Тогда
		ВызватьИсключение "Указанный скрипт """ + ПолноеИмяСкрипта + """ не является файлом";
	КонецЕсли;

	Если Каталог = Неопределено Тогда
		Каталог = КаталогПрограммы();
	КонецЕсли;

	ФайлКаталога = Новый Файл(Каталог);
	Каталог = ФайлКаталога.ПолноеИмя;
	Если ФайлКаталога.Существует() Тогда
		Если ФайлКаталога.ЭтоФайл() Тогда
			ВызватьИсключение "Указанный каталог """ + Каталог + """ является файлом";
		КонецЕсли;
	Иначе
		СоздатьКаталог(Каталог);
		Если Не ФайлКаталога.Существует() Тогда
			ВызватьИсключение "Не удалось создать каталог """ + Каталог + """";
		КонецЕсли;
	КонецЕсли;

	ИмяСкриптаЗапуска = ?(ИмяФайлаЗапуска = Неопределено, ФайлСкрипта.ИмяБезРасширения, ИмяФайлаЗапуска);
	Установщик = Новый УстановкаПакета;
	Установщик.СоздатьСкриптЗапуска(ИмяСкриптаЗапуска, ПолноеИмяСкрипта, Каталог);

КонецПроцедуры

Процедура ВывестиСправку(Знач ЗначенияПараметров)
	Если ЗначенияПараметров["ИмяКоманды"] = Неопределено Тогда
		ВывестиСправкуПоКомандам();
	Иначе
		ВывестиСправкуПоКоманде(ЗначенияПараметров["ИмяКоманды"]);
	КонецЕсли;
КонецПроцедуры

Процедура ВывестиСправкуПоКомандам() Экспорт

	Парсер = Новый ПарсерАргументовКоманднойСтроки;
	ДобавитьОписанияКоманд(Парсер);

	ВозможныеКоманды = Парсер.СправкаВозможныеКоманды();
	Сообщить("OneScript Package Manager
	|Возможные команды:");

	МаксШирина = 0;
	Поле = "               ";
	Для Каждого Команда Из ВозможныеКоманды Цикл
		ТекШирина = СтрДлина(Команда.Команда);
		Если ТекШирина > МаксШирина Тогда
			МаксШирина = ТекШирина;
		КонецЕсли;
	КонецЦикла;

	Для Каждого Команда Из ВозможныеКоманды Цикл
		Сообщить(" " + Лев(Команда.Команда + Поле, МаксШирина + 2) + "- " + Команда.Пояснение);
	КонецЦикла;

	Сообщить("Наберите opm help <команда>, чтобы вывести справку по команде");

КонецПроцедуры

Процедура ВывестиСправкуПоКоманде(Знач ИмяКоманды)

	Парсер = Новый ПарсерАргументовКоманднойСтроки;
	ДобавитьОписанияКоманд(Парсер);

	ВозможныеКоманды = Парсер.СправкаВозможныеКоманды();
	ОписаниеКоманды = ВозможныеКоманды.Найти(ИмяКоманды, "Команда");
	Если ОписаниеКоманды = Неопределено Тогда
		Сообщить("Команда отсуствует: " + ИмяКоманды);
		Возврат;
	КонецЕсли;

	Сообщить("" + ОписаниеКоманды.Команда + " - " + ОписаниеКоманды.Пояснение);
	Сообщить("Параметры:");
	Для Каждого СтрПараметр Из ОписаниеКоманды.Параметры Цикл
		Если Не СтрПараметр.ЭтоИменованныйПараметр Тогда
			Сообщить(СтрШаблон(" <%1> - %2", СтрПараметр.Имя, СтрПараметр.Пояснение));
		Иначе
			Сообщить(СтрШаблон(" %1 - %2", СтрПараметр.Имя, СтрПараметр.Пояснение));
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

/////////////////////////////////////////////////////////////////////

Лог = Логирование.ПолучитьЛог("oscript.app.opm");
СистемнаяИнформация = Новый СистемнаяИнформация;
ЭтоWindows = Найти(НРег(СистемнаяИнформация.ВерсияОС), "windows") > 0;
