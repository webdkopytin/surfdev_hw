enum Countries { brazil, russia, turkish, spain, japan }

class Territory {
  final int areaInHectare;
  final List<String> crops;
  final List<AgriculturalMachinery> machineries;

  Territory(
    this.areaInHectare,
    this.crops,
    this.machineries,
  );
}

class AgriculturalMachinery {
  final String id;
  final DateTime releaseDate;

  AgriculturalMachinery(
    this.id,
    this.releaseDate,
  );

  @override
  bool operator ==(Object? other) {
    if (other is! AgriculturalMachinery) return false;
    if (other.id == id && other.releaseDate == releaseDate) return true;

    return false;
  }

  @override
  int get hashCode => id.hashCode ^ releaseDate.hashCode;
}

final mapBefore2010 = <Countries, List<Territory>>{
  Countries.brazil: [
    Territory(
      34,
      ['Кукуруза'],
      [
        AgriculturalMachinery(
          'Трактор Степан',
          DateTime(2001),
        ),
        AgriculturalMachinery(
          'Культиватор Сережа',
          DateTime(2007),
        ),
      ],
    ),
  ],
  Countries.russia: [
    Territory(
      14,
      ['Картофель'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Гранулятор Антон',
          DateTime(2009),
        ),
      ],
    ),
    Territory(
      19,
      ['Лук'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Дробилка Маша',
          DateTime(1990),
        ),
      ],
    ),
  ],
  Countries.turkish: [
    Territory(
      43,
      ['Хмель'],
      [
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
        AgriculturalMachinery(
          'Сепаратор Марк',
          DateTime(2005),
        ),
      ],
    ),
  ],
};

final mapAfter2010 = {
  Countries.turkish: [
    Territory(
      22,
      ['Чай'],
      [
        AgriculturalMachinery(
          'Каток Кирилл',
          DateTime(2018),
        ),
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
      ],
    ),
  ],
  Countries.japan: [
    Territory(
      3,
      ['Рис'],
      [
        AgriculturalMachinery(
          'Гидравлический молот Лена',
          DateTime(2014),
        ),
      ],
    ),
  ],
  Countries.spain: [
    Territory(
      29,
      ['Арбузы'],
      [
        AgriculturalMachinery(
          'Мини-погрузчик Максим',
          DateTime(2011),
        ),
      ],
    ),
    Territory(
      11,
      ['Табак'],
      [
        AgriculturalMachinery(
          'Окучник Саша',
          DateTime(2010),
        ),
      ],
    ),
  ],
};

void main() {
  List<DateTime> allReleaseDates = [];

  // Обработка mapBefore2010
  mapBefore2010.forEach((country, territories) {
    territories.forEach((territory) {
      territory.machineries.forEach((machinery) {
        allReleaseDates.add(machinery.releaseDate);
      });
    });
  });

  // Обработка mapAfter2010
  mapAfter2010.forEach((country, territories) {
    territories.forEach((territory) {
      territory.machineries.forEach((machinery) {
        allReleaseDates.add(machinery.releaseDate);
      });
    });
  });

  // Рассчитываем средний возраст всей техники
  if (allReleaseDates.isNotEmpty) {
    DateTime currentDate = DateTime.now();
    int totalAgeInYears = 0;

    allReleaseDates.forEach((releaseDate) {
      int ageInYears = currentDate.year - releaseDate.year;
      totalAgeInYears += ageInYears;
    });

    double averageAge = totalAgeInYears / allReleaseDates.length;
    print('Средний возраст всей техники на всех угодьях: ${averageAge.toStringAsFixed(2)} лет');
  } else {
    print('На угодьях нет техники.');
  }

  // Объединяем технику из обоих карт в один список
  List<AgriculturalMachinery> allMachineries = [];

  mapBefore2010.forEach((country, territories) {
    territories.forEach((territory) {
      allMachineries.addAll(territory.machineries);
    });
  });

  mapAfter2010.forEach((country, territories) {
    territories.forEach((territory) {
      allMachineries.addAll(territory.machineries);
    });
  });

  // Сортируем технику по возрасту (от старых к новым)
  allMachineries.sort((a, b) => a.releaseDate.compareTo(b.releaseDate));

  // Находим 50% самой старой техники
  int halfIndex = (allMachineries.length / 2).ceil();
  List<AgriculturalMachinery> oldestHalfMachineries = allMachineries.sublist(0, halfIndex);

  // Рассчитываем средний возраст этой техники
  if (oldestHalfMachineries.isNotEmpty) {
    DateTime currentDate = DateTime.now();
    int totalAgeInYears = 0;

    oldestHalfMachineries.forEach((machinery) {
      int ageInYears = currentDate.year - machinery.releaseDate.year;
      totalAgeInYears += ageInYears;
    });

    double averageAge = totalAgeInYears / oldestHalfMachineries.length;
    print('Средний возраст 50% самой старой техники: ${averageAge.toStringAsFixed(2)} лет');
  } else {
    print('Не найдено достаточно техники для расчета среднего возраста.');
  }
}