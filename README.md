# Maze_Swift

Реализация проекта Maze. (Групповой)

## About

Проект был разработан **vivastan** и **swissmer**.

Настоящий проект реализует:

* Прорисовку лабиринта
* Генерация лабиринта
* Поиск маршрута для заданных координат
* Генерация пещеры

Стек технологий:

* Xcodegen.
* SwiftLint.
* MVVM.
* XCTest.
* SwiftUI.
* Euler's algorithm.

Задание: README_RUS.md 

## How it work

> Выбирите объект отрисовки (Maze/Cave). В боковом меню есть возможность загрузить файл, сгенерировать объект. 
Для Maze: указав координаты и нажав "Search", мы находим путь. 
Для Cave: указав предел birth (рождения), death (смерти) и step (шаг во времени), мы можем запустить отрисовку либо автоматически (auto-stop), либо пошагово (next).

## Example

<div style="display: flex; justify-content: space-around;">
    <img src="../misc/images/play1.png" width="300">
    <img src="../misc/images/play2.png" width="300">
    <img src="../misc/images/play3.png" width="300">
</div>

## Install

```
xcodegen generate
make
```

## Support

tg: @swissmer