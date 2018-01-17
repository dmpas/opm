Перем Лог;

Перем ИндексДоступныхПакетов;
Перем ИндексКешаПакетов;
Перем ИндексСерверовПакетов;

Процедура ПриСозданииОбъекта()

	Инициализировать();

КонецПроцедуры

Функция ПолучитьПакет(Знач ИмяПакета, Знач ВерсияПакета, ПутьКФайлуПакета = "") Экспорт

	Если Не ПакетДоступен(ИмяПакета) Тогда
		
		ТекстИсключения = СтрШаблон("Ошибка установки пакета %1: Пакет не найден", ИмяПакета);
		ВызватьИсключение ТекстИсключения;
		
	КонецЕсли;

	ИмяПакета = НРег(ИмяПакета);
	
	Если ВерсияПакета <> Неопределено Тогда
		ФайлПакета = ИмяПакета + "-" + ВерсияПакета + ".ospx";
	Иначе
		ФайлПакета = ИмяПакета + ".ospx";
	КонецЕсли;
	
	Лог.Информация("Скачиваю файл: " + ФайлПакета);

	Если ПустаяСтрока(ПутьКФайлуПакета) Тогда
		ПутьКФайлуПакета = ВременныеФайлы.НовоеИмяФайла("ospx");
	КонецЕсли;

	ИмяРесурса = ИмяПакета + "/" + ФайлПакета;
	
	ПереченьСерверов = ИндексКешаПакетов[ИмяПакета];

	Ответ = ЗапроситьПакет(ПереченьСерверов, ИмяРесурса);
	
	Если Не Ответ = Неопределено Тогда
		Лог.Отладка("Файл получен");
		Ответ.ПолучитьТелоКакДвоичныеДанные().Записать(ПутьКФайлуПакета);
		Ответ.Закрыть();
		Лог.Отладка("Соединение закрыто");
	Иначе
		ТекстИсключения = СтрШаблон("Ошибка установки пакета %1: Нет соединения", ИмяПакета);
		ВызватьИсключение ТекстИсключения;
	КонецЕсли;

	Возврат ПутьКФайлуПакета;

КонецФункции

Функция ЗапроситьПакет(Знач ПереченьСерверов, Знач ИмяРесурса)
	
	ПакетУспешноПолучен = Ложь;

	Для каждого ДоступныйСервер Из ПереченьСерверов Цикл

		Сервер = ИндексСерверовПакетов[ДоступныйСервер.Ключ];

		Если Сервер.СерверДоступен() Тогда
		
			Ответ  = Сервер.ПолучитьРесурс(ИмяРесурса);
			Если Ответ = Неопределено Тогда
				Продолжить;
			КонецЕсли;

			Если Ответ.КодСостояния = 200 Тогда
				
				ПакетУспешноПолучен = Истина;
				Прервать;
				
			КонецЕсли;

			Ответ.Закрыть();

			Лог.Информация("Ошибка подключения к хабу %1 <%2>",
							Сервер.ПолучитьИмя(),
							Ответ.КодСостояния);

		КонецЕсли;

	КонецЦикла;

	Если ПакетУспешноПолучен Тогда
		
		Лог.Отладка("Ресурс %1 успешно получен с %2", ИмяРесурса, Сервер.ПолучитьИмя());

		Возврат Ответ;

	КонецЕсли;

	Возврат Неопределено;

КонецФункции

Процедура Инициализировать()
	
	Лог.Отладка("Менеджер получения пакетов инициализация - НАЧАЛО");
	ОбновитьИндексСерверовПакетов();
	ОбновитьИндексКешаПакетов();
	ОбновитьИндексДоступныхПакетов();
	Лог.Отладка("Менеджер получения пакетов инициализация - ЗАВЕРШЕНО");
	
КонецПроцедуры

Функция ПолучитьДоступныеПакетов() Экспорт

	Возврат ИндексДоступныхПакетов; // По хорошему надо копировать соответствие
	
КонецФункции

Функция ПакетДоступен(Знач ИмяПакета) Экспорт
	
	Лог.Отладка("Ищю пакет <%1> в кеше доступных пакетов", ИмяПакета);
	
	Возврат ИндексДоступныхПакетов[нрег(ИмяПакета)] = Истина;

КонецФункции

Процедура ОбновитьИндексСерверовПакетов() Экспорт
	
	ИндексСерверовПакетов = Новый Соответствие;

	Настройки = НастройкиOpm.ПолучитьНастройки();
	СервераПакетов = Настройки.СервераПакетов;

	Для каждого НастройкаСервера Из СервераПакетов Цикл
		
		СерверПакетов = СоздатьСерверПакетовПоНастройке(НастройкаСервера);
		ИндексСерверовПакетов.Вставить(НастройкаСервера.Имя, СерверПакетов);

	КонецЦикла;

КонецПроцедуры

Функция СоздатьСерверПакетовПоНастройке(Знач НастройкаСервера)
	
	Возврат Новый СерверПакетов(НастройкаСервера.Имя, НастройкаСервера.Сервер, НастройкаСервера.ПутьНаСервере, НастройкаСервера.Порт, НастройкаСервера.Приоритет)

КонецФункции

Процедура ОбновитьИндексДоступныхПакетов() Экспорт

	// Учесть версии пакетов
	ИндексДоступныхПакетов = Новый Соответствие;
	
	Лог.Отладка("Обновляю кеш доступных пакетов");
		
	Для каждого ПакетКеша Из ИндексКешаПакетов Цикл
	
		ИндексДоступныхПакетов.Вставить(ПакетКеша.Ключ, Истина);

	КонецЦикла;
	
	Лог.Отладка("Кеш доступных пакетов - ОБНОВЛЕН");

КонецПроцедуры

Процедура ОбновитьИндексКешаПакетов() Экспорт

	ИндексКешаПакетов = Новый Соответствие;

	Для каждого СерверПакетов Из ИндексСерверовПакетов Цикл
		
		ИмяСервера = СерверПакетов.Ключ;
		КлассСервера = СерверПакетов.Значение;

		Пакеты = КлассСервера.ПолучитьПакеты();
		
		Лог.Отладка("Добавляю в кеш пакеты <%2> сервера: %1", ИмяСервера, Пакеты.Количество());
		
		ДобавитьПакетыВИндексКеша(Пакеты, ИмяСервера);

	КонецЦикла;
	
КонецПроцедуры

Процедура ДобавитьПакетыВИндексКеша(Знач ПакетыСервера, Знач ИмяСервера)

	Для каждого Пакет Из ПакетыСервера Цикл
		
		КлючПакета = Пакет.Ключ;
		ВерсииПакета = Пакет.Значение;

		Лог.Отладка("Добавляю пакет: %1 в кеш для сервера %2", КлючПакета, ИмяСервера);
		Если ИндексКешаПакетов[КлючПакета] = Неопределено Тогда
			ИндексКешаПакетов.Вставить(КлючПакета, Новый Соответствие);
		КонецЕсли;

		ИндексКешаПакетов[КлючПакета].Вставить(ИмяСервера, ВерсииПакета)

	КонецЦикла;
	
КонецПроцедуры

Лог = Логирование.ПолучитьЛог("oscript.app.opm");