// Вынесено отдельно, чтобы не включать зависимость от gitrunner

// Ожидает контекст:
//   * КаталогРепозитория
//   * Описание

#Использовать gitrunner

Перем Гит, Параметры, Адрес, Коммит;

Гит = Новый ГитРепозиторий;
Гит.УстановитьРабочийКаталог(КаталогРепозитория);

Параметры = Новый Массив;
Параметры.Добавить("remote");
Параметры.Добавить("get-url");
Параметры.Добавить("origin");

Гит.ВыполнитьКоманду(Параметры);

Адрес = Гит.ПолучитьВыводКоманды();

Параметры = Новый Массив;
Параметры.Добавить("log");
Параметры.Добавить("-1");
Параметры.Добавить("--format='%H'");

Гит.ВыполнитьКоманду(Параметры);

Коммит = Гит.ПолучитьВыводКоманды();

Описание.ОтметкаГит(Адрес, Коммит);

