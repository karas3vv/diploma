# Курсовая работа за 3 курс на факультете КНиИТ

Репозиторий содержит материалы курсовой работы за 3й курс, посвящённой применению
локально-чувствительного хеширования (LSH) для ускорения поиска похожих
новостных документов.

В работе сравниваются два подхода:

- точный поиск по TF-IDF-векторам с использованием косинусной меры;
- приближённый поиск с помощью LSH на случайных гиперплоскостях.

Основная идея эксперимента: сократить число документов, которые нужно
сравнивать с запросом, и оценить компромисс между скоростью поиска и
полнотой выдачи.

## Структура репозитория

```text
.
├── course_work.tex              # текст курсовой работы
├── thesis.bib                   # библиография
├── SCWorks.cls                  # шаблон оформления СГУ
├── preamble.sty                 # дополнительные настройки LaTeX
├── presentation/
│   ├── presentation.typ         # презентация к защите
│   ├── presentation.pdf         # собранная презентация
│   ├── defense_speech.typ       # текст выступления
│   ├── defense_speech.pdf       # собранный текст выступления
│   └── assets/
│       └── sgu-logo.jpeg
└── semantic_lsh_project/
    ├── main.py                  # интерактивный и одиночный запуск поиска
    ├── benchmark.py             # эксперимент для таблицы результатов
    ├── lsh_search.py            # реализация LSH-индекса
    ├── exact_search.py          # точный поиск
    ├── preprocess.py            # предобработка текстов
    ├── vectorizer.py            # TF-IDF-векторизация
    ├── data/
    │   └── News_Articles_SGU.csv
    └── requirements.txt
```

## Основные результаты

В эксперименте использовались параметры:

- `repeat-records = 20`;
- `top-k = 5`;
- `num-planes = 8`;
- `num-tables = 16`;
- `hamming = 0`.

Средние результаты по пяти запросам:

| Метрика | Значение |
|---|---:|
| Среднее время точного поиска | `0,160 с` |
| Среднее время LSH-поиска | `0,012 с` |
| Среднее ускорение | `13,19×` |
| Доля просмотренных документов | `5,68%` |
| Средний `recall@5` | `0,20` |

Полученный результат показывает, что LSH существенно ускоряет поиск, но
при строгих параметрах снижает полноту выдачи. Это демонстрирует основной
компромисс приближённого поиска: скорость растёт за счёт сокращения
набора кандидатов.

## Запуск Python-проекта

Перейдите в каталог с реализацией:

```bash
cd semantic_lsh_project
```

Создайте виртуальное окружение и установите зависимости:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Запуск одного запроса:

```bash
python3 main.py --query "научная конференция" --top-k 5
```

Запуск benchmark, использованного для результатов в курсовой:

```bash
python3 benchmark.py --repeat-records 20
```

Больше параметров запуска описано в
[semantic_lsh_project/README.md](semantic_lsh_project/README.md).

## Сборка курсовой работы

Курсовая написана на LaTeX и использует `minted`, поэтому при сборке нужен
флаг `-shell-escape`.

Пример сборки:

```bash
pdflatex -shell-escape course_work.tex
bibtex course_work
pdflatex -shell-escape course_work.tex
pdflatex -shell-escape course_work.tex
```

Итоговый файл: `course_work.pdf`.

## Сборка презентации и текста выступления

Презентация и текст выступления написаны на Typst.

```bash
cd presentation
typst compile presentation.typ presentation.pdf
typst compile defense_speech.typ defense_speech.pdf
```

Итоговые файлы:

- `presentation/presentation.pdf`;
- `presentation/defense_speech.pdf`.

## Используемые технологии

- Python;
- NumPy;
- pandas;
- scikit-learn;
- LaTeX;
- Typst.