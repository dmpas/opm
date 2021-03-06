﻿///////////////////////////////////////////////////////////////////
//
// Работа с номерами версий пакетов (сравнение, разбор и т.р.)
//
//////////////////////////////////////////////////////////////////

#Использовать logos

Перем Лог;

Функция СоздатьВерсию() Экспорт
	
	Возврат Новый Структура("СтаршийНомер,МладшийНомер,Релиз,Ревизия");
	
КонецФункции

Функция РазобратьВерсиюНаКомпоненты(Знач СтрокаВерсии) Экспорт

	Версия = СоздатьВерсию();
	
	Версия.СтаршийНомер = КомпонентСтроки(СтрокаВерсии, ".");
	Версия.МладшийНомер = КомпонентСтроки(СтрокаВерсии, ".");
	Версия.Релиз        = КомпонентСтроки(СтрокаВерсии, ".");
	Версия.Ревизия      = КомпонентСтроки(СтрокаВерсии, ".");
	
	Если Версия.СтаршийНомер = Неопределено Тогда
		ВызватьИсключение "Неверный номер версии";
	КонецЕсли;
	
	Возврат Версия;

КонецФункции

Функция ЗаписатьВерсиюВСтроку(Знач Версия) Экспорт
	
	Результат = "";
	
	Для Каждого КомпонентВерсии Из Версия Цикл
		Если КомпонентВерсии.Ключ = "СтаршийНомер" или КомпонентВерсии.Ключ = "МладшийНомер" или Не ПустаяСтрока(КомпонентВерсии.Значение) Тогда
			Результат = Результат + "." + ПредставлениеКомпонентаВерсии(КомпонентВерсии.Значение);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Сред(Результат, 2);
	
КонецФункции

Функция ЗаписатьПолнуюВерсиюВСтроку(Знач Версия) Экспорт
	
	Результат = "";
	
	Для Каждого КомпонентВерсии Из Версия Цикл
		Результат = Результат + "." + ПредставлениеКомпонентаВерсии(КомпонентВерсии.Значение);
	КонецЦикла;
	
	Возврат Сред(Результат, 2);
	
КонецФункции

// Возвращает 1, если ЭтаВерсия > БольшеЧемВерсия, -1 если ЭтаВерсия < БольшеЧемВерсия и 0, если они равны
//
Функция СравнитьВерсии(Знач ЭтаВерсия, Знач БольшеЧемВерсия) Экспорт
	Лог.Отладка(СтрШаблон("Вызываю СравнитьВерсии(ЭтаВерсия = <%1>, БольшеЧемВерсия = <%2>)", ЭтаВерсия, БольшеЧемВерсия));

	Если ЭтаВерсия = 0 Тогда
		ЭтаВерсия = "0";
	КонецЕсли;
	Если БольшеЧемВерсия = 0 Тогда
		БольшеЧемВерсия = "0";
	КонецЕсли;
	Если ТипЗнч(ЭтаВерсия) <> Тип("Строка") и ТипЗнч(ЭтаВерсия) <> ТипЗнч(СоздатьВерсию()) Тогда
		ВызватьИсключение "СравнитьВерсии: Передали неверный параметр <ЭтаВерсия>";
	КонецЕсли;
	Если ТипЗнч(БольшеЧемВерсия) <> Тип("Строка") и ТипЗнч(БольшеЧемВерсия) <> ТипЗнч(СоздатьВерсию()) Тогда
		ВызватьИсключение "СравнитьВерсии: Передали неверный параметр <БольшеЧемВерсия>";
	КонецЕсли;

	Если ТипЗнч(ЭтаВерсия) = Тип("Строка") Тогда
		ЭтаВерсия = РазобратьВерсиюНаКомпоненты(ЭтаВерсия);
	КонецЕсли;
	
	Если ТипЗнч(БольшеЧемВерсия) = Тип("Строка") Тогда
		БольшеЧемВерсия = РазобратьВерсиюНаКомпоненты(БольшеЧемВерсия);
	КонецЕсли;
	
	Для Каждого КомпонентВерсии	Из ЭтаВерсия Цикл
		
		КомпонентЭтаВерсия = КомпонентВерсии.Значение;
		КомпонентБольшеЧем = БольшеЧемВерсия[КомпонентВерсии.Ключ];
		
		Если КомпонентЭтаВерсия = Неопределено и КомпонентБольшеЧем <> Неопределено Тогда
			Возврат -1;
		КонецЕсли;
		
		Если КомпонентЭтаВерсия <> Неопределено и КомпонентБольшеЧем = Неопределено Тогда
			Возврат 1;
		КонецЕсли;

		Если КомпонентЭтаВерсия = Неопределено И КомпонентБольшеЧем = Неопределено Тогда
			Возврат 0;
		КонецЕсли;
		
		Попытка
			ЧислоЭтаВерсия = Число(КомпонентЭтаВерсия);
			ЧислоБольшеЧем = Число(КомпонентБольшеЧем);
		Исключение
			ВызватьИсключение "Ошибка в формате номера версии метаданных. Не удалось преобразовать к типу Число: " + ЭтаВерсия + "/" + БольшеЧемВерсия;
		КонецПопытки;
		
		Если ЧислоЭтаВерсия > ЧислоБольшеЧем Тогда
			Возврат 1;
		ИначеЕсли ЧислоЭтаВерсия < ЧислоБольшеЧем Тогда
			Возврат -1;
		КонецЕсли;
		
		Если ПустаяСтрока(ЭтаВерсия) или ПустаяСтрока(БольшеЧемВерсия) Тогда
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат 0;
	
КонецФункции

Функция ПредставлениеКомпонентаВерсии(Знач Компонент)
	Возврат ?(Компонент = Неопределено, "0", Компонент);
КонецФункции

Функция КомпонентСтроки(ИсходнаяСтрока, Знач Разделитель)
	
	Если ПустаяСтрока(ИсходнаяСтрока) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Поз = Найти(ИсходнаяСтрока, Разделитель);
	Если Поз = 0 Тогда
		Результат = ИсходнаяСтрока;
		ИсходнаяСтрока = "";
		Возврат Результат;
	КонецЕсли;
	
	Компонент = Лев(ИсходнаяСтрока, Поз-1);
	ИсходнаяСтрока = Сред(ИсходнаяСтрока, Поз+1);
	
	Возврат Компонент;
	
КонецФункции

Функция РазобратьИмяПакета(знач ИмяПакета) Экспорт

	Пакет = Новый Структура("ИмяПакета,Версия","",Неопределено); 
	ИмяВерсия = СтрРазделить(ИмяПакета,"@");
	Пакет.Вставить("ИмяПакета", ИмяВерсия[0]);
	Если ИмяВерсия.Количество() > 1 Тогда 
		Пакет.Вставить("Версия", ИмяВерсия[1]);
	КонецЕсли;	

	Возврат Пакет;
	
КонецФункции

Лог = Логирование.ПолучитьЛог(Константы.ИмяЛога);
